#include "common/samplers11.hlsl"
#include "common/context.hlsl"
// #define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"
#define FOG_ENABLE
#include "enlight/skyCommon.hlsl"

#include "deferred/ESM.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/deferredCommon.hlsl"

StructuredBuffer<float3> positions;
RWStructuredBuffer<AtmosphereSample> atmosphereResults;

float2 cameraHeightNorm;

AtmosphereSample SampleAtmosphereWithFogToPoint(float3 posInOriginSpace, float3 cameraPosInOriginSpace, float cameraAltitude, float cameraAltitudeNorm)
{
	float2 cloudsShadowAO = SampleShadowClouds(posInOriginSpace);
	float shadow = min(cloudsShadowAO.x, terrainShadows(float4(posInOriginSpace, 1)));
	
	AtmosphereSample o;
	ComputeFogAndAtmosphereCombinedFactors(posInOriginSpace - cameraPosInOriginSpace, 0, cameraAltitude, cameraAltitudeNorm, o.transmittance, o.inscatter);
	o.sunColor = SampleSunRadiance(posInOriginSpace, gSunDir) * (gSunIntensity * shadow);
	return o;
}

[numthreads(COMPUTE_THREADS_XY, COMPUTE_THREADS_XY, 1)]
void ComputeAtmosphereSamples(uint3 gid: SV_GroupId, uint gidx: SV_GroupIndex)
{
	uint idx = gid.x*COMPUTE_THREADS_XY*COMPUTE_THREADS_XY+gidx;

	float3 pos = positions[idx]; // относительно мировой позиции камеры

	atmosphereResults[idx] = SampleAtmosphereWithFogToPoint(pos, gCameraPos.xyz, cameraHeightNorm.x, cameraHeightNorm.y);
}

technique10 Inscatter
{
	pass P0 { SetComputeShader(CompileShader(cs_5_0, ComputeAtmosphereSamples())); }
}
