#ifndef LIGHTINGFLIR_HLSL
#define LIGHTINGFLIR_HLSL

#include "common/lightsCommon.hlsl"
#include "common/lightsData.hlsl"

#define PI 3.1415926535897932384626433832795

float superGaussian(float x, float sigma, float e) {
	return exp(-pow(abs(x), e) / (2 * pow(sigma, e))) / (2 * PI * sigma);
}

float superGaussian2(float x, float sigma, float e) {
	return exp(-pow(abs(x), e) / (2 * pow(sigma, e)));
}

float distAttenuationFLIR(float range, float dist, float falloff) {
	float e = lerp(4.0, 1.0, falloff);
	float sigma = lerp(0.57, 0.07, falloff);
	return max(superGaussian2(dist / range, sigma, e) - 0.01, 0.0);
}

float calcOmniFLIR(float3 pos, float4 omniPos, float amount, float falloff) {
	float3 dir = omniPos.xyz - pos;
	float dist = length(dir);
	float att = distAttenuationFLIR(omniPos.w, dist, falloff);
	return amount * att;
}

float calcSpotFLIR(float3 pos, float4 spotPos, float3 spotDir, float2 spotAngles, float amount, float falloff) {
	float3 dir = spotPos.xyz - pos;
	float dist = length(dir);
	dir /= dist;
	float att = angleAttenuation(spotDir.xyz, spotAngles.x, spotAngles.y, dir) * distAttenuationFLIR(spotPos.w, dist, falloff);
	return amount * att;
}

float CalculateDynamicLightingFLIR(uint2 sv_pos_xy, float3 pos, uniform uint LightsList = LL_SOLID) {

	uint4 v = LightsIdxOffsets.Load(uint4(sv_pos_xy / 8, LightsList, 0));

	float sumFLIR = 0;

	[loop]
	for (uint i = 0; i < v.y; ++i) {
		uint idx = LightsIdx[v.x + i];
		OmniLightInfo o = omnis[idx];
		sumFLIR += calcOmniFLIR(pos, o.pos, o.amount.x, o.amount.w);
	}
	[loop]
	for (i = 0; i < v.w; ++i) {
		uint idx = LightsIdx[v.z + i];
		SpotLightInfo s = spots[idx];
		sumFLIR += calcSpotFLIR(pos, s.pos, s.dir.xyz, s.angles.xy, s.amount.x, s.amount.w);
	}

	return sumFLIR;
}

#endif
