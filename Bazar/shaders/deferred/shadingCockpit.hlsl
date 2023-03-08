#ifndef SHADING_COCKPIT_HLSL
#define SHADING_COCKPIT_HLSL

#include "deferred/shading.hlsl"
#include "indirectLighting/indirectLighting.hlsl"

float3 SampleCockpitEnvironmentMap(float3 normal, float roughness, float mip, uniform bool bSpecularSample = false)
{
	const float3 cockpitFloorNormal = cockpitTransform._12_22_32;

	float NoF = dot(normal, cockpitFloorNormal);

	float cockpitAO = (bSpecularSample? 0.4 : 1.0) * saturate((NoF*0.5+0.5)*1.3 + 0.2);

	float3 incomingLight = SampleEnvironmentMapDetailed(cockpitFloorNormal, mip + 0.5);

	float3 envColor = SampleEnvironmentMapDetailed(normal, mip);
	float3 averageSecondaryLight = dot(incomingLight, 0.3333*cockpitAO);

	roughness = pow(roughness, 0.20);
	
	float mask = 0.95 - 0.95 * (bSpecularSample? saturate(0.2 + 0.55 * roughness + (3.0 - 2.2 * roughness) * NoF) : //blur env cube mask by roughness
									  saturate(0.2 + 0.8 * NoF));									  

	envColor = lerp(envColor, averageSecondaryLight, mask);

	return envColor;
}

float3 getEnvLightColor(float3 normal, float roughness, uniform bool useSSLR, float2 uvSSLR) {
	float roughnessMip = getMipFromRoughness(roughness, environmentMipsCount);
	float3 envLightColor = SampleCockpitEnvironmentMap(normal, roughness, roughnessMip, true);
	if (useSSLR) {
		float4 sslr = SSLRMap.SampleLevel(ClampLinearSampler, uvSSLR, roughnessMip / 2);
		envLightColor = lerp(envLightColor, sslr.rgb, sslr.a);
	}
	return envLightColor;
}

float3 ShadeSolidCockpitGI(uniform bool bTransparent, float3 sunColor, float3 diffuseColor, float3 specularColor, float3 normal, float roughness, float metallic, float shadow, float cloudShadow, float AO, float3 viewDir, float3 pos, float2 energyLobe = float2(1,1), uniform bool useSSLR = false, float2 uvSSLR = float2(0, 0))
{
	float roughnessSun = modifyRoughnessByCloudShadow(roughness, cloudShadow);
	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = sunColor * (gSunIntensity * NoL * shadow);
	float3 finalColor = ShadingDefault(diffuseColor, specularColor, roughnessSun, normal, viewDir, gSunDir, energyLobe) * lightAmount;

	//sun IBL
	//todo: умножение на sunColor унести в предрасчет
	float4 indirectSunLightAO = CalculateIndirectSunLight(pos, normal);
	finalColor += diffuseColor * indirectSunLightAO.rgb * sunColor;

	//diffuse IBL
#if 0 // USE_COCKPIT_CUBEMAP
	float3 envLightDiffuse = SampleCockpitCubeMapMip(pos, normal, environmentMipsCount) * gCockpitIBL.x;
#else
	float3 envLightDiffuse = SampleCockpitEnvironmentMap(normal, roughness, environmentMipsCount) * gCockpitIBL.z;
#endif
	finalColor += diffuseColor * envLightDiffuse * (indirectSunLightAO.a * (bTransparent? 1.0 : AO));

	//specular IBL
	float NoV = max(0, dot(normal, viewDir));
	float a = roughness * roughness;
	float3 R = normal*NoV*2 - viewDir;
	R = normalize( lerp( normal, R, (1 - a) * ( sqrt(1 - a) + a ) ) );
	// float4 specularAO = cockpitAOMap.SampleLevel(ClampLinearSampler, -R, 6);
	
#if 0
	// float3 viewDir = pos - CamPos;
	float3 rdir = -reflect(viewDir, normal);
	//BPCEM
	float3 nrdir = normalize(rdir);
	float3 rbmax = (ILVBBmax - pos)/nrdir;
	float3 rbmin = (ILVBBmin - pos)/nrdir;
	float3 rbminmax = (nrdir>0.0f)? rbmax : rbmin;
	float fa = min(min(rbminmax.x, rbminmax.y), rbminmax.z);
	float3 posonbox = pos + nrdir*fa;
	rdir = posonbox - float3(0,0,0);
	//PBCEM end
	// float3 env = texCUBE(envMap, rdir);
	float3 envLightSpecular = cockpitEnvironmentMap.SampleLevel(ClampLinearSampler, rdir, getMipFromRoughness(roughness, environmentMipsCount)).rgb;
	// float3 envLightColor = cockpitEnvironmentMap.SampleLevel(ClampLinearSampler, R, getMipFromRoughness(roughness, environmentMipsCount)).rgb;
#else
	#if USE_COCKPIT_CUBEMAP
		float3 envLightSpecular = SampleCockpitCubeMap(pos, R, roughness) * gCockpitIBL.y;
	#else
		float3 envLightSpecular = getEnvLightColor(R, roughness, useSSLR, uvSSLR);
	#endif
#endif
	
#if	USE_BRDF_K
		float3 specColor = EnvBRDFApproxK(specularColor, roughness, NoV, gDev1.w);
#else
		float3 specColor = EnvBRDFApprox(specularColor, roughness, NoV);
#endif
	finalColor += envLightSpecular * specColor * (energyLobe.y * indirectSunLightAO.a * AO);
	// finalColor += envLightSpecular * EnvBRDF(specularColor, roughness, metallic, normal, viewDir, R) * (energyLobe.y * indirectSunLightAO.a * AO);

	return finalColor;
}

float3 ShadeSolidCockpit(float3 sunColor, float3 diffuseColor, float3 specularColor, float3 normal, float roughness, float metallic, float shadow, float cloudShadow, float AO, float3 viewDir, float3 pos, float2 energyLobe = float2(1, 1), uniform bool useSSLR = false, float2 uvSSLR = float2(0, 0)) {

	float roughnessSun = modifyRoughnessByCloudShadow(roughness, cloudShadow);
	float NoL = max(0, dot(normal, gSunDir));
	float3 lightAmount = sunColor * (gSunIntensity * NoL * shadow);
	float3 finalColor = ShadingDefault(diffuseColor, specularColor, roughnessSun, normal, viewDir, gSunDir, energyLobe) * lightAmount;

	float NoV = max(0, dot(normal, viewDir));
	float a = roughness * roughness;
	float3 R = normal * NoV * 2 - viewDir;
	R = normalize(lerp(normal, R, (1 - a) * (sqrt(1 - a) + a)));

	//diffuse IBL
#if USE_COCKPIT_CUBEMAP
	float3 envLightDiffuse = SampleCockpitCubeMapMip(pos, normal, environmentMipsCount) * gCockpitIBL.x;

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		float3 oldLightDiffuse = SampleCockpitEnvironmentMap(normal, roughness, environmentMipsCount);
		envLightDiffuse = gDev0.x > 0.5 ? oldLightDiffuse : envLightDiffuse;
	#endif
#else
	float3 envLightDiffuse = SampleCockpitEnvironmentMap(normal, roughness, environmentMipsCount);
#endif
	finalColor += diffuseColor * envLightDiffuse * (gIBLIntensity * AO);

	//specular IBL
#if USE_COCKPIT_CUBEMAP

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		if (gDev1.y > 0.5)
			roughness = 0;
	#endif

	float3 envLightSpecular = SampleCockpitCubeMap(pos, R, roughness) * gCockpitIBL.y;

	#if USE_DEBUG_COCKPIT_CUBEMAP 
		if (gDev1.x > 0.5)
			return envLightSpecular;
		float3 oldLightSpecular = SampleCockpitEnvironmentMap(normal, roughness, getMipFromRoughness(roughness, environmentMipsCount), true);
		envLightSpecular = gDev0.y > 0.5 ? oldLightSpecular : envLightSpecular;
	#endif
#else
	float3 envLightSpecular = getEnvLightColor(R, roughness, useSSLR, uvSSLR);
#endif

#if	USE_BRDF_K
	float3 specColor = EnvBRDFApproxK(specularColor, roughness, NoV, gDev1.w);
#else
	float3 specColor = EnvBRDFApprox(specularColor, roughness, NoV);
#endif
	finalColor += envLightSpecular * specColor * (energyLobe.y * AO);

	return finalColor;
}

// #define USE_VS_GI

float3 ShadeCockpit(uint2 uv, uniform bool bApplyGI, float3 sunColor, float3 diffuse, float3 normal, float roughness, float metallic, float3 emissive, float shadow, float AO, float2 cloudShadowAO, float3 viewDir, float3 pos,
					float2 energyLobe = float2(1,1), uniform bool bTransparent = false, float alpha = 1.0, uniform bool useSSLR = false, float2 uvSSLR = float2(0, 0))
{
#if	USE_DEBUG_ROUGHNESS_METALLIC
	roughness = clamp(roughness + gDev0.z, 0.02, 0.99);
	metallic = saturate(metallic + gDev0.w);
#endif

	float3 baseColor = GammaToLinearSpace(diffuse);

	float3 diffuseColor = baseColor * (1.0 - metallic);
	float3 specularColor = lerp(bApplyGI ? 0.03 : 0.02, baseColor, metallic);

	roughness = clamp(roughness, 0.02, 0.99);

	if(bTransparent) //альфа-блендинг не должен влиять на силу спекулярного света, компенсируем
		energyLobe.y *= rcp(max(1.0 / 255.0, alpha));

	float3 finalColor;

#ifndef USE_VS_GI
	if(bApplyGI)
		finalColor = ShadeSolidCockpitGI(bTransparent, sunColor, diffuseColor, specularColor, normal, roughness, metallic, shadow, cloudShadowAO.x, AO, viewDir, pos, energyLobe, useSSLR, uvSSLR);
	else
#endif
		finalColor = ShadeSolidCockpit(sunColor, diffuseColor, specularColor, normal, roughness, metallic, shadow, cloudShadowAO.x, AO, viewDir, pos, energyLobe, useSSLR, uvSSLR);

	finalColor += CalculateDynamicLightingTiled(uv, diffuseColor, specularColor, roughness, normal, viewDir, pos, 1);

#ifndef USE_VS_GI
	finalColor += emissive;
#else
	finalColor += emissive * diffuseColor * sunColor;//* (gSunIntensity * gILVSunFactor);
#endif

	return finalColor;
}

#endif
