#ifndef DEFERRED_SHADOWS_HLSL
#define DEFERRED_SHADOWS_HLSL

#include "common/samplers11.hlsl"
#include "enlight/materialParams.hlsl"

#define USE_ROTATE_PCF 1
#define BASE_SHADOWMAP_SIZE 4096
#define BASE_SHADOWMAP_BIAS 0.0004

#if USE_ROTATE_PCF
float rnd(float2 xy) {
	return frac(sin(dot(xy, float2(12.9898, 78.233))) * 43758.5453);
}
#endif

float SampleShadowMap(float3 wPos, float NoL, uniform uint idx, uniform bool usePCF, uniform uint samplesMax, uniform bool useTreeShadow, uniform float r = 3.0)
{
	float bias = BASE_SHADOWMAP_BIAS * BASE_SHADOWMAP_SIZE / ShadowMapSize;

	float4 shadowPos = mul(float4(wPos, 1.0), ShadowMatrix[idx]);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	float acc = cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) + bias);

	if (useTreeShadow) {
		float4 projPos = mul(float4(wPos, 1.0), gViewProj);
		float dp = cascadeShadowMap.SampleLevel(gPointClampSampler, float3(shadowCoord.xy, 3 - idx), 0).x;
		float4 p = mul(float4(shadowPos.xy, dp, 1.0), ShadowMatrixInv[idx]);
		float d = dot(p.xyz / p.w - wPos, gSunDir);
		return max(exp(-d * 0.5), acc);
	}

	if (usePCF) {
		static const float incr = 3.1415926535897932384626433832795 *(3.0 - sqrt(5.0));
		const uint count = min(16, samplesMax);

		const float radius = r / ShadowMapSize;

		float offs = 1.0 / count; 
		float angle = 0, offset = 0;;
#if USE_ROTATE_PCF
		float4 projPos = mul(float4(wPos, 1.0), gViewProj);
		angle += rnd(projPos.xy/ projPos.w);
#endif
		[unroll(count)]
		for (uint i = 1; i < count; ++i) {
			offset += offs;
			angle += incr;
			float s, c;
			sincos(angle, s, c);
			float2 delta = float2(c, s) * (offset * radius);
			acc += cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy + delta, 3 - idx), saturate(shadowCoord.z) + bias * (1 + r * offset));
		}
		acc /= count;
	} 
	return saturate( min(NoL * 10, acc) );
}

//return shadow + AO
float2 SampleShadowClouds(float3 pos)
{
	if(gUseVolumetricCloudsShadow>0)
	{
		float3 uvw = pos * gCloudVolumeScale + gCloudVolumeOffset;
		float2 s = cloudsShadowTex3D.SampleLevel(gBilinearClampSampler, uvw.xzy, 0).yx;
		if(uvw.y>1) s = 1;
		return float2(s.x*s.x, s.y);
	}
	else
	{
		float4 cldShadowPos = mul(float4(pos + gOrigin.xyz, 1.0), gCloudShadowsProj);
		float shadow = cloudsShadowTex.SampleLevel(gCloudsShadowSampler, cldShadowPos.xy / cldShadowPos.w, 0).r;
		shadow = lerp(shadow, 1.0, smoothstep(gCloudsLow, gCloudsHigh, pos.y));
		return float2(shadow, 1);
	}
}

float SampleShadowCascade(float3 wPos, float depth, float3 normal, uniform bool usePCF, uniform bool useNormalBias, uniform bool useTreeShadow=false, uniform uint samplesMax=32, uniform bool useOnlyFirstMap = false) {	// normal in world space

	float NoL = 1;
	if (useNormalBias) {
		NoL = dot(normal, gSunDir.xyz);
		if (NoL < 0)
			return 0;
	}

	if (useOnlyFirstMap) {
		return SampleShadowMap(wPos, NoL, ShadowFirstMap, usePCF, samplesMax, false);
	} else {
		if (depth > ShadowDistance[0])
			return SampleShadowMap(wPos, NoL, 0, usePCF, samplesMax, useTreeShadow);

		if (depth > ShadowDistance[1])
			return SampleShadowMap(wPos, NoL, 1, usePCF, samplesMax, useTreeShadow);

		if (depth > ShadowDistance[2])
			return SampleShadowMap(wPos, NoL, 2, usePCF, samplesMax, useTreeShadow, 2.5);

		if (depth > ShadowDistance[3]) {
			if (useTreeShadow)
				return max(SampleShadowMap(wPos, NoL, 3, usePCF, samplesMax, true, 2), smoothstep(ShadowDistance[2], ShadowDistance[3], depth));
			else
				return max(SampleShadowMap(wPos, NoL, 3, usePCF, samplesMax, false, 2), smoothstep(ShadowCascadeFadeDepth, ShadowDistance[3], depth));
		}
		return 1;
	}
}	

float SampleShadowMapVertex(float3 wPos, uniform uint idx) {

	float bias = 0.0025;

	float4 shadowPos = mul(float4(wPos, 1.0), ShadowMatrix[idx]);
	float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	return cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) + bias);
}

float SampleShadowCascadeVertex(float3 wPos, float depth) {

	[unroll]
	for (uint i = 0; i < 4; ++i) 
		if (depth > ShadowDistance[i])
			return SampleShadowMapVertex(wPos, i);

	return 1;
}

float SampleShadow(float4 ippos, float3 normal, uniform bool bPCF = true, uniform bool useNormalBias = true) {
	return SampleShadowCascade(ippos.xyz, ippos.w, normal, bPCF, useNormalBias);
}

float SampleShadowTerrain(float4 ippos, float3 normal, uniform bool bPCF = true, uniform bool useNormalBias = true) {
	return 1 - ((1 - SampleShadow(ippos, normal, bPCF, useNormalBias)) * saturate(FlatShadowDistance[0]));
}

#endif
