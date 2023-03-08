#ifndef DEFERRED_ATMOSPHERE_HLSL
#define DEFERRED_ATMOSPHERE_HLSL

#include "common/AmbientCube.hlsl"
#include "deferred/deferredCommon.hlsl"

#define FOG_ENABLE
#include "enlight/skyCommon.hlsl"

#ifdef GEOTERRAIN
float3 SampleSunRadiance(float3 posInOriginSpace, float3 dir)
{
	return GetSunRadiance((posInOriginSpace+gOrigin)*0.001,dir);
}
#else
float3 SampleSunRadiance(float3 posInOriginSpace, float3 dir)
{
	float altitude = posInOriginSpace.y + gOrigin.y;

	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	float r = atmParams.bottom_radius + max(0, altitude*0.001 + heightHack); //'max' to prevent NaN in GetSunRadiance math
	float muS = dir.y;

	return GetSunRadiance(r, muS) * getFogTransparency(altitude, muS, 120000.0);
}
#endif

struct EnvironmentIrradianceSample
{
	float3 skyIrradiance;
	float3 surfaceIrradiance;
};

EnvironmentIrradianceSample SampleEnvironmentIrradianceApprox(float3 pos, float shadow = 1, float cloudsAO = 1)
{
	const float3 surfaceDiffuseAlbedo = 0.2;	// in linear space
	float NoL = gSurfaceNdotL;

#ifdef GEOTERRAIN
	float3 sunIrradiance = SampleSunRadiance(pos, gSunDir) * (NoL * shadow * (gSunIntensity / atmPI)); // at altitude 50m	
#else
	float3 sunIrradiance = SampleSunRadiance(float3(0, 50 - gOrigin.y, 0), gSunDir) * (NoL * shadow * (gSunIntensity / atmPI)); // at altitude 50m	
#endif

	EnvironmentIrradianceSample o;
	o.skyIrradiance	= GetSkyIrradiance(OriginSpaceToEarthSpace(pos), gSunDir) * (cloudsAO * (gSunIntensity / atmPI));//at pos altitude
	o.skyIrradiance = lerp(o.skyIrradiance, dot(o.skyIrradiance, 0.33333), saturate(3.5 - 3.5*(cloudsAO*cloudsAO)));//desaturate sky to take clouds irradiance into account
	o.surfaceIrradiance = surfaceDiffuseAlbedo * (sunIrradiance + o.skyIrradiance);
	return o;
}

float3 SampleEnvironmentMapApprox(EnvironmentIrradianceSample eis, float3 normal, float roughness = 1.0)
{
	roughness = 1 - roughness;
	float ny = normal.y;
	normal.y *= 10 - 9 * (1 - roughness * roughness);
	return lerp(eis.surfaceIrradiance, eis.skyIrradiance, saturate(normal.y*0.5+0.5)) + float3(1e-3, 1e-4, 1e-5)*ny;
}

float3 SampleEnvironmentMapApprox(float3 pos, float3 normal, float roughness = 1.0)
{
	float2 cloudShadowAO = SampleShadowClouds(pos);

	EnvironmentIrradianceSample eis = SampleEnvironmentIrradianceApprox(pos, cloudShadowAO.x, cloudShadowAO.y);
	return SampleEnvironmentMapApprox(eis, normal, roughness);
}

float3 atmApplyLinear(float3 v, float distance, float3 color)
{
	float3 transmittance;
#ifdef GEOTERRAIN	
	float3 cameraPos = gEarthCenter + 0.01*normalize(gEarthCenter);// float3(0, heightHack, 0);
#else
	float3 cameraPos = gEarthCenter + float3(0, heightHack, 0);
#endif	
	float3 inscatterColor = GetSkyRadianceToPoint(cameraPos, cameraPos + v*distance, 0.0/*shadow*/, gSunDir, transmittance);
	return color*transmittance + inscatterColor * gAtmIntensity;
}

float3 applyAtmosphereLinearInternal(float3 camera, float3 pos, float3 color, float3 skyColor)
{
	float3 cpos = (pos-camera)*0.001;	// in km
	float d = length(cpos);
	float3 view = cpos/d;
#ifdef GEOTERRAIN
	float skyLerpFactor = 0;//smoothstep(atmNearDistance, atmFarDistance, d);
#else
	float skyLerpFactor = smoothstep(atmNearDistance, atmFarDistance, d);
#endif

	color = atmApplyLinear(view, d, color);
	color = applyFog(color, view, d * 1000.0);
	return lerp(color, skyColor, skyLerpFactor);
}

float3 applyAtmosphereLinear(float3 camera, float3 pos, float4 projPos, float3 color) {

#ifdef NO_ATMOSPHERE
	return color;
#endif

	float2 tc = float2(0.5f *projPos.x/projPos.w + 0.5, -0.5f * projPos.y/projPos.w + 0.5);	
	float3 skyColor = skyTex.SampleLevel(gBilinearClampSampler, tc.xy, 0).rgb;

	return applyAtmosphereLinearInternal(camera, pos, color, skyColor);
}

float3 applyAtmosphereLinear(float3 camera, float3 pos, float4 projPos, float3 color, float3 skyColor)
{
#ifdef NO_ATMOSPHERE
	return color;
#endif
	return applyAtmosphereLinearInternal(camera, pos, color, skyColor);
}

float3 sampleSkyCS(float2 c) {
	uint2 c1 = floor(c);
	uint2 c2 = ceil(c);
	return lerp(lerp(skyTex.Load(uint3(c1, 0)).rgb, skyTex.Load(uint3(c2.x, c1.y, 0)).rgb, frac(c.x)),
			    lerp(skyTex.Load(uint3(c1.x, c2.y, 0)).rgb, skyTex.Load(uint3(c2, 0)).rgb, frac(c.x)), frac(c.y));
}

#endif
