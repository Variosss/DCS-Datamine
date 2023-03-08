#ifndef ESM_HLSL
#define ESM_HLSL

#include "enlight/materialParams.hlsl"

static const float esm_factor = 0.8;

float linstep(float a, float b, float v) {
	return saturate((v - a) / (b - a));
}

float ESM(float depth) {
	return (exp(esm_factor * depth) - 1) / (exp(esm_factor) - 1);
}

float ESM_Shadow(float moment, float depth) {
	float occluder = moment * (exp(esm_factor) - 1) + 1;
	float receiver = exp(-esm_factor * depth);
	float esm = saturate(occluder * receiver);
	return linstep(0.99, 1.0, esm);
}

float VSM(float depth) {
	return depth*depth;
}

float VSM_Shadow(float2 moments, float depth) {
	const float k0 = 0.00001;
	const float k1 = 0.9;	// 0.2 .. 0.8 to supress light bleeding
	float variance = moments.y - (moments.x*moments.x);
	variance = max(variance, k0);

	float d = moments.x - depth;
	float pMax = variance / (variance + d * d);
	pMax = linstep(k1, 1.0, pMax); 

	return depth <= moments.x ? 1.0 : pMax;
};

float terrainShadowsSSM(float4 pos) {
	float4 shadowPos = mul(pos, gTerrainShadowMatrix);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	float bias = 0.0001;
	return terrainShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, shadowCoord.xy, saturate(shadowCoord.z) + bias);
}

float terrainShadows(float4 pos) {
	float4 shadowPos = mul(pos, gTerrainShadowMatrix);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;

	float val = terrainESM.SampleLevel(gTrilinearWhiteBorderSampler, shadowCoord.xy, 0).x;
	float z = 1 - shadowCoord.z;
	float sMax = linstep(0.95, 1.0, z);
	return max(sMax, ESM_Shadow(val, z));
}

float secondarySSM(float4 pos, uniform uint idx) {
	float4 shadowPos = mul(pos, gSecondaryShadowmapMatrix[idx]);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	float bias = 0.00015;
	float sh = secondaryShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, idx), saturate(shadowCoord.z) + bias);

	float2 sp = saturate(shadowCoord.xy) * 2.0 - 1.0;
	float lf = dot(sp, sp);
	return lerp(sh, 1.0, lf * lf * lf);
}

#endif
