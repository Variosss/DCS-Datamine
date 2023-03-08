#ifndef SHADING_FOLIAGE_HLSL
#define SHADING_FOLIAGE_HLSL

#include "common/ambientCube.hlsl"

float3 ShadeFoliage(uint2 uv, float3 sunColor, float3 diffuse, float3 normal, float roughness, float translucency, float shadow, float AO, float2 cloudsShadowAO, float3 viewDir, float3 pos)
{
	float3 diffuseColor = GammaToLinearSpace(diffuse);
	float3 specularColor = 0.018;

	float2 energyLobe = AO;//hack to reduce direct lighting that is close to a trunk

	float NoL = dot(normal, gSunDir);

	float3 lightAmount = sunColor * (gSunIntensity * min(max(translucency, NoL * shadow), 1-translucency) * 0.9);
	
	float3 finalColor = ShadingSimple(diffuseColor, specularColor, roughness, normal, viewDir, gSunDir, energyLobe) * lightAmount;
	
	// float3 translucentLightAmount = pow(max(0, dot(-gSunDir, viewDir)), 60/*exp(5)*/) * sunColor * gSunIntensity * translucency;
	// finalColor += Diffuse_lambert(diffuseColor) * translucentLightAmount * debugValue.y;

	// diffuse IBL
	EnvironmentIrradianceSample eis = SampleEnvironmentIrradianceApprox(pos, cloudsShadowAO.x, cloudsShadowAO.y);
	finalColor += diffuseColor * SampleEnvironmentMapApprox(eis, normal, roughness) * (AO * gIBLIntensity);

	//additional lighting
	finalColor += CalculateDynamicLightingTiled(uv, diffuseColor, specularColor, roughness, normal, viewDir, pos, 0, energyLobe);

	return finalColor;
}

#endif
