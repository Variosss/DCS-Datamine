#ifndef SHADING_HLSL
#define SHADING_HLSL

#define USE_DEBUG_ROUGHNESS_METALLIC 0

#define VERSION_NEWER_2_5_6 // used in dots.fx

#ifndef PLUGIN_3DSMAX
	#include "common/shadingCommon.hlsl"
	#include "common/lighting.hlsl"
	#include "deferred/atmosphere.hlsl"
#endif

#include "deferred/environmentCube.hlsl"

float modifyRoughnessByCloudShadow(float roughness, float cloudShadow)
{
	cloudShadow = 1 - cloudShadow;
	return lerp(roughness, 0.99, cloudShadow * cloudShadow * 0.4);
}

float3 ShadeSolid(EnvironmentIrradianceSample eis, float3 sunColor, float3 diffuseColor, float3 specularColor, float3 normal, float roughness, float metallic, float shadow, float cloudShadow, float AO, float3 viewDir, float3 pos, float2 energyLobe = float2(1, 1), uniform uint selectEnvCube = LERP_ENV_MAP, float lerpEnvCubeFactor = 0, uniform bool useSSLR = false, float2 uvSSLR = float2(0, 0), uniform bool insideCockpit = false)
{
	float roughnessSun = modifyRoughnessByCloudShadow(roughness, cloudShadow);
	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = sunColor * (gSunIntensity * NoL * shadow);
	float3 finalColor = ShadingDefault(diffuseColor, specularColor, roughnessSun, normal, viewDir, gSunDir, energyLobe) * lightAmount;

	//diffuse IBL
	float3 envLightDiffuse;
#if USE_COCKPIT_CUBEMAP
	if (insideCockpit) {
		
		envLightDiffuse = SampleCockpitCubeMapMip(pos, normal, environmentMipsCount) * gCockpitIBL.x;

		#if USE_DEBUG_COCKPIT_CUBEMAP 
			float3 oldLightDiffuse = SampleEnvironmentMap(eis, normal, 1.0, environmentMipsCount, selectEnvCube, lerpEnvCubeFactor);
			envLightDiffuse = gDev0.x > 0.5 ? oldLightDiffuse : envLightDiffuse;
		#endif
	} else
#endif
	{
		envLightDiffuse = SampleEnvironmentMap(eis, normal, 1.0, environmentMipsCount, selectEnvCube, lerpEnvCubeFactor);
	}
	finalColor += diffuseColor * envLightDiffuse * (gIBLIntensity * AO * energyLobe.x);

	//specular IBL
	float NoV = max(0, dot(normal, viewDir));
	float a = roughness * roughness;
	float3 R = normal * NoV * 2 - viewDir;
	// float3 R = -reflect(viewDir, normal);
	R = normalize(lerp(normal, R, (1 - a) * (sqrt(1 - a) + a)));

	float roughnessMip = getMipFromRoughness(roughness, environmentMipsCount);

	float3 envLightSpecular;
#if USE_COCKPIT_CUBEMAP
	if (insideCockpit) {

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		if (gDev1.y > 0.5)
			roughness = 0;
	#endif
	
#if defined(GLASS_MATERIAL) && !defined(GLASS_INSTRUMENTAL)
		float mip = getMipFromRoughness(roughness, environmentMipsCount);
		envLightSpecular = SampleCockpitCubeMapMip(pos, R, mip, true) * gCockpitIBL.y;
#else
		envLightSpecular = SampleCockpitCubeMap(pos, R, roughness) * gCockpitIBL.y;
#endif

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		if (gDev1.x > 0.5)
			return envLightSpecular;
		float3 oldLightSpecular = SampleEnvironmentMap(eis, R, roughness, roughnessMip, selectEnvCube, lerpEnvCubeFactor);
		envLightSpecular = gDev0.y > 0.5 ? oldLightSpecular : envLightSpecular;
	#endif
	} else
#endif
	{
		envLightSpecular = SampleEnvironmentMap(eis, R, roughness, roughnessMip, selectEnvCube, lerpEnvCubeFactor);
		if (useSSLR) {
			float4 sslr = SSLRMap.SampleLevel(ClampLinearSampler, uvSSLR, max(1, roughnessMip / 2));
			envLightSpecular = lerp(envLightSpecular, sslr.rgb, sslr.a);
		}
	}

#if	USE_BRDF_K
	float3 specColor = EnvBRDFApproxK(specularColor, roughness, NoV, gDev1.w);
#else
	float3 specColor = EnvBRDFApprox(specularColor, roughness, NoV);
#endif
	finalColor += envLightSpecular * specColor * (AO * energyLobe.y);

	return finalColor;
}

float3 ShadeSolid(float3 pos, float3 sunColor, float3 diffuseColor, float3 specularColor, float3 normal, float roughness, float metallic, float shadow, float AO, float2 cloudShadowAO, float3 viewDir, float2 energyLobe = float2(1,1), uniform uint selectEnvCube = LERP_ENV_MAP, float lerpEnvCubeFactor = 0, uniform bool useSSLR = false, float2 uvSSLR =  float2(0,0), uniform bool insideCockpit = false)
{
#if	USE_DEBUG_ROUGHNESS_METALLIC
	roughness = clamp(roughness + gDev0.z, 0.02, 0.99);
	metallic = saturate(metallic + gDev0.w);
#endif

	EnvironmentIrradianceSample eis = (EnvironmentIrradianceSample)0;
	if(selectEnvCube != NEAR_ENV_MAP)
		eis = SampleEnvironmentIrradianceApprox(pos, cloudShadowAO.x, cloudShadowAO.y);

	return ShadeSolid(eis, sunColor, diffuseColor, specularColor, normal, roughness, metallic, shadow, cloudShadowAO.x, AO, viewDir, pos, energyLobe, selectEnvCube, lerpEnvCubeFactor, useSSLR, uvSSLR, insideCockpit);
}

float3 ShadeHDR(uint2 sv_pos_xy, float3 sunColor, float3 diffuse, float3 normal, float roughness, float metallic, float3 emissive, float shadow, float AO, float2 cloudShadowAO, float3 viewDir, float3 pos, float2 energyLobe = {1,1}, uniform uint selectEnvCube = LERP_ENV_MAP, uniform bool useSSLR = false, float2 uvSSLR = float2(0, 0), uniform uint LightsList = LL_SOLID, uniform bool insideCockpit = false, uniform bool useSecondaryShadowmap = false)
{
	float3 baseColor = GammaToLinearSpace(diffuse);

	float3 diffuseColor = baseColor * (1.0 - metallic);
	float3 specularColor = lerp(0.04, baseColor, metallic);

	roughness = clamp(roughness, 0.02, 0.99);

	float lerpEnvCubeFactor = selectEnvCube == LERP_ENV_MAP ? exp(-distance(pos, gCameraPos)*(1.0 / 500.0)) : 0;

	float3 finalColor = ShadeSolid(pos, sunColor, diffuseColor, specularColor, normal, roughness, metallic, shadow, AO, cloudShadowAO, viewDir, energyLobe, selectEnvCube, lerpEnvCubeFactor, useSSLR, uvSSLR, insideCockpit);

	finalColor += CalculateDynamicLightingTiled(sv_pos_xy, diffuseColor, specularColor, roughness, normal, viewDir, pos, insideCockpit, energyLobe, 0, LightsList, true, useSecondaryShadowmap);

	finalColor += emissive;

	return finalColor;
}

float3 ShadeTransparent(uint2 sv_pos_xy, float3 sunColor, float3 diffuse, float alpha, float3 normal, float roughness, float metallic, float3 emissive, float shadow, float2 cloudShadowAO, float3 viewDir, float3 pos,
	uniform bool bPremultipliedAlpha = false, uniform bool insideCockpit = false)
{
	//альфа-блендинг не должен влиять на силу спекулярного света, если srcСolor умножается на srcAlpha - компенсируем спекулярный вклад
	//иначе альфу применяем только к диффузной части освещения
	float2 energyLobe;
	energyLobe.x = bPremultipliedAlpha? alpha : 1.0;
	energyLobe.y = bPremultipliedAlpha? 1.0 : rcp(max(1.0 / 255.0, alpha));
	
	return ShadeHDR(sv_pos_xy, sunColor, diffuse, normal, roughness, metallic, emissive, shadow, 1, cloudShadowAO, viewDir, pos, energyLobe, LERP_ENV_MAP, false, float2(0, 0), LL_TRANSPARENT, insideCockpit, true);
}

#endif
