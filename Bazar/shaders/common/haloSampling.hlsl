#ifndef HALO_SAMPLING_HLSL
#define HALO_SAMPLING_HLSL

// -----------------------
// Halo texture sampling
// -----------------------

#include "common/context.hlsl"
#include "common/paraboloidMapping.hlsl"
#include "common/haloCommon.hlsl"

Texture2D iceHaloTexture : register(t88);

float3 sampleHaloTexture(Texture2D tex, SamplerState samp, float3 viewDir, float3 sunDir)
{
	float3 dir = getDirInHaloStorage(viewDir, sunDir);
	float2 uv = spmDirToUV(dir, pmScale);
	return tex.SampleLevel(samp, uv, dpmComputeLod(dir, pmScale)).rgb;
}

float3 sampleHaloTexture(Texture2D tex, SamplerState samp, float lod, float3 viewDir, float3 sunDir)
{
	float3 dir = getDirInHaloStorage(viewDir, sunDir);
	float2 uv = spmDirToUV(dir, pmScale);
	return tex.SampleLevel(samp, uv, lod).rgb;
}

float3 applySunMoonFactors(float3 iceHaloSample)
{
	// Similar to ContextBase.cpp logic
	float moonFactor = max(0.0f, gIceHaloParams.sunMoonFactor - 0.5f) * 2.0f;
	float sunFactor = 1.0f - min(1.0f, gIceHaloParams.sunMoonFactor * 2.0f);

	//return iceHaloSample * (sunFactor + moonFactor);
	return iceHaloSample * (sunFactor); // currently only use sun light
}

float3 sampleHalo(SamplerState samp, float3 viewDir, float3 sunDir)
{
	float3 iceHaloSample = sampleHaloTexture(iceHaloTexture, samp, viewDir, sunDir).xyz;
	return applySunMoonFactors(iceHaloSample);
}

float3 sampleHaloLod(SamplerState samp, float lod, float3 viewDir, float3 sunDir)
{
	float3 iceHaloSample = sampleHaloTexture(iceHaloTexture, samp, lod, viewDir, sunDir).xyz;
	return applySunMoonFactors(iceHaloSample);
}

#endif // HALO_SAMPLING_HLSL