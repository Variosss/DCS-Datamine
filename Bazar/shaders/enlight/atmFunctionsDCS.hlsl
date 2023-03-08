#ifndef ATMOSPHERE_FUNCTIONS_DCS_HLSL
#define ATMOSPHERE_FUNCTIONS_DCS_HLSL

#include "common/context.hlsl"
#include "enlight/atmFunctions.hlsl"
#include "deferred/shadows.hlsl"

Texture2D transmittanceTex: register(t125);
Texture2D irradianceTex: register(t126);	//precomputed skylight irradiance (E table)
Texture3D inscatterTex: register(t127);		//precomputed inscattered light (S table)
Texture1D miePhaseFuncTex: register(t93);
Texture3D transmittanceTex2: register(t92);
Texture3D cloudsLightMapSPTex: register(t90);

float3 OriginSpaceToEarthSpace(float3 pos)
{
#ifdef GEOTERRAIN
	pos = (pos + gOrigin);
	return (pos + length(pos)*1) * 0.001;
#else
	/*AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);*/
	/*return float3((pos.x - gCameraPos.x) * 0.001, atmParams.bottom_radius + heightHack + (pos.y + gOrigin.y)*0.001, (pos.z - gCameraPos.z) * 0.001);*/
	return float3((pos.x - gCameraPos.x) * 0.001, gEarthRadius + heightHack + (pos.y + gOrigin.y)*0.001, (pos.z - gCameraPos.z) * 0.001);

#endif
}

float2 DirectionInWorldSpaceToSphericalCoordUV(float3 dir)
{
	const float pi = 3.14159265;
	
	// float radius = length(dir)
	float phi = atan2(dir.z, dir.x);
	float theta = acos(dir.y);
	// return float2(phi, theta);
	return float2(phi/2 - pi/2, theta) / pi;
}

SamplerState CloudLightMapSampler
{
	Filter		= MIN_MAG_MIP_LINEAR;
	AddressU	  = WRAP;
	AddressV	  = MIRROR;
	AddressW	  = CLAMP;
	MaxAnisotropy = 0;
	BorderColor   = float4(0, 0, 0, 0);
};

CloudLightMapSPSample SampleCloudLightMapSP(float3 ray, float distFromEye)
{
	const float distanceMax = 200000;

	ray.y = sign(ray.y) * sqrt(abs(ray.y));

	float2 lms = cloudsLightMapSPTex.SampleLevel(CloudLightMapSampler, float3(DirectionInWorldSpaceToSphericalCoordUV(ray), distFromEye / distanceMax), 0).xy;

	float distCorrection = max(1, distFromEye / distanceMax);

	CloudLightMapSPSample o;
	o.shadowLengthKm = lms.y * distCorrection * distanceMax * 0.001;
	o.mieFactor = saturate(lms.x);
	o.rayleighFactor = 1;
	return o;
}

void GetRMu(float3 cameraPos, float3 viewDir, out float r, out float mu)
{
	r = length(cameraPos);
	mu = dot(cameraPos, viewDir) / r;
}

void GetRMuDist(AtmosphereParameters atmParams, float3 cameraPosInMeters, float3 posInMeters, out float r, out float mu, out float d)
{
	Direction view_ray = (posInMeters - cameraPosInMeters)*0.001;
	d = length(view_ray);
	view_ray = view_ray / d;
	r = length(float3(0, atmParams.bottom_radius + (gOrigin.y + cameraPosInMeters.y)*0.001, 0));
	Length rmu = dot(cameraPosInMeters, view_ray);
	mu = rmu / r;
}

float3 GetSkyRadiance(float3 cameraPos, float3 viewDir, float shadowLength, float3 sunDir, out float3 transmittance, float dist=paramDistMax)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	CloudLightMapSPSample lms = initCloudLightMapSPSample();
	if(gUseVolumetricClouds>0)
		lms = SampleCloudLightMapSP(viewDir, dist*1000);

#ifdef SKY_RADIANCE_TEXTURE	
	return GetPrecomputedSkyRadiance(atmParams, transmittanceTex, inscatterTex, inscatterTex/*dummy*/, cameraPos, viewDir, lms, sunDir, dist, transmittance);
#else
	return GetSkyRadiance(atmParams, transmittanceTex, inscatterTex, inscatterTex/*dummy*/, cameraPos, viewDir, shadowLength, sunDir, transmittance);
#endif
}

float3 GetSkyRadiance(float3 cameraPos, float3 viewDir, float shadowLength, float3 sunDir, out float3 transmittance, out float3 singleMieScattering, float dist=paramDistMax)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	CloudLightMapSPSample lms = initCloudLightMapSPSample();
	if(gUseVolumetricClouds>0)
		lms = SampleCloudLightMapSP(viewDir, dist*1000);

#ifdef SKY_RADIANCE_TEXTURE	
	return GetPrecomputedSkyRadiance(atmParams, transmittanceTex, inscatterTex, inscatterTex/*dummy*/, cameraPos, viewDir, lms, sunDir, dist, transmittance, singleMieScattering);
#else
	return GetSkyRadiance(atmParams, transmittanceTex, inscatterTex, inscatterTex/*dummy*/, cameraPos, viewDir, shadowLength, sunDir, transmittance, singleMieScattering);
#endif
}

//для заданных r, mu
float3 GetSkyRadiance(float r, float mu, float3 cameraPos, float3 viewDir, float shadowLength, float3 sunDir, out float3 transmittance, float dist=paramDistMax)
{
	Number mu_s = dot(cameraPos, sunDir) / r;
	Number nu = dot(viewDir, sunDir);
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	CloudLightMapSPSample lms = initCloudLightMapSPSample();
	if(gUseVolumetricClouds>0)
		lms = SampleCloudLightMapSP(viewDir, dist*1000);

#ifdef SKY_RADIANCE_TEXTURE
	return GetPrecomputedSkyRadianceInternal(atmParams, transmittanceTex, inscatterTex, inscatterTex, viewDir, r, mu, mu_s, nu, lms, sunDir, dist, transmittance);
#else
	return GetSkyRadianceInternal(atmParams, transmittanceTex, inscatterTex, inscatterTex, r, mu, mu_s, nu, shadowLength, sunDir, transmittance);
#endif
}

//для заданных r, mu, также возвращает singleMieScattering компоненту
float3 GetSkyRadiance(float r, float mu, float3 cameraPos, float3 viewDir, float shadowLength, float3 sunDir, out float3 transmittance, out float3 singleMieScattering, float dist=paramDistMax)
{
	Number mu_s = dot(cameraPos, sunDir) / r;
	Number nu = dot(viewDir, sunDir);
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	CloudLightMapSPSample lms = initCloudLightMapSPSample();
	if(gUseVolumetricClouds>0)
		lms = SampleCloudLightMapSP(viewDir, dist*1000);

#ifdef SKY_RADIANCE_TEXTURE
	return GetPrecomputedSkyRadianceInternal(atmParams, transmittanceTex, inscatterTex, inscatterTex, viewDir, r, mu, mu_s, nu, lms, sunDir, dist, transmittance, singleMieScattering);
#else
	return GetSkyRadianceInternal(atmParams, transmittanceTex, inscatterTex, inscatterTex, r, mu, mu_s, nu, shadowLength, sunDir, transmittance, singleMieScattering);
#endif
}

float3 GetSunRadiance(float r, float muS)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetSunRadiance(atmParams, transmittanceTex, r, muS);
}

float3 GetSunRadiance(float3 pos, float3 sunDir)
{
	Length r = length(pos);
	Number mu_s = dot(pos, sunDir) / r;
#ifdef GEOTERRAIN	
	r = max(gEarthRadius, r);
#endif	
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetSunRadiance(atmParams, transmittanceTex, r, mu_s);
}

float3 GetSunAndSkyIrradiance(float3 pos, float3 normal, float3 sunDir, out float3 skyIrradiance)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetSunAndSkyIrradiance(atmParams, transmittanceTex, irradianceTex, pos, normal, sunDir, skyIrradiance);
}

float3 GetSkyIrradiance(float3 pos, float3 sunDir)
{
	Length r = length(pos);
	Number mu_s = dot(pos, sunDir) / r;
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetIrradiance(atmParams, irradianceTex, r, mu_s);
}

float3 GetSkyRadianceToPoint(float3 cameraPos, float3 pos, float shadowLength, float3 sunDir, out float3 transmittance)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);

	Direction viewDir = pos - cameraPos;
	Length dist = length(viewDir);
	viewDir /= dist;

	CloudLightMapSPSample lms = initCloudLightMapSPSample();
	if(gUseVolumetricClouds>0)
		lms = SampleCloudLightMapSP(viewDir, dist*1000);

#ifdef SKY_RADIANCE_TEXTURE
	return GetPrecomputedSkyRadianceToPoint(atmParams, transmittanceTex, inscatterTex, inscatterTex, cameraPos, pos, lms, sunDir, transmittance);
#else
	#ifdef TRANSMITTANCE_VOLUME_TEXTURE
		return GetSkyRadianceToPoint3D(atmParams, transmittanceTex2, inscatterTex, inscatterTex, cameraPos, pos, shadowLength, sunDir, transmittance);
	#else
		return GetSkyRadianceToPoint(atmParams, transmittanceTex, inscatterTex, inscatterTex, cameraPos, pos, shadowLength, sunDir, transmittance);
	#endif
#endif
}

float3 GetTransmittanceToTopAtmosphereBoundary(float r, float mu)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetTransmittanceToTopAtmosphereBoundary(atmParams, transmittanceTex, r, mu);
}

//camera and pos in meters
float3 GetSkyTransmittance(float3 camera, float3 pos)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	Length r, d;
	Number mu;
	GetRMuDist(atmParams, camera, pos, r, mu, d);

	bool ray_r_mu_intersects_ground = RayIntersectsGround(atmParams, r, mu);
	
	return GetTransmittance(atmParams, transmittanceTex, r, mu, d, ray_r_mu_intersects_ground);
	// return GetTransmittance(atmosphere, transmittanceTex, r, mu, d, mu<0);
}

#ifdef TRANSMITTANCE_VOLUME_TEXTURE
float3 GetSkyRadianceToPoint3D(float3 cameraPos, float3 pos, float shadowLength, float3 sunDir, out float3 transmittance)
{
	AtmosphereParameters atmParams; initAtmosphereParameters(atmParams);
	return GetSkyRadianceToPoint3D(atmParams, transmittanceTex2, inscatterTex, inscatterTex, cameraPos, pos, shadowLength, sunDir, transmittance);	
}
#endif

#endif
