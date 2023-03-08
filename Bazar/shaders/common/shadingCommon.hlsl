#ifndef SHADING_COMMON_HLSL
#define SHADING_COMMON_HLSL

#ifndef PLUGIN_3DSMAX
	#include "common/context.hlsl"
	#include "common/BRDF.hlsl"
	#include "common/samplers11.hlsl"
	#include "deferred/deferredCommon.hlsl"

	Texture2D<float2> preintegratedGF: register(t117);
#endif

#ifndef CALCULATE_ENV_BRDF
	#define CALCULATE_ENV_BRDF 0
#endif

float3 ShadingSimple(float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 lightDir, float2 energyLobe = float2(1,1))
{
	float3 H = normalize(lightDir + viewDir);
	float NoH = max(0, dot(normal, H));
	float VoH = max(0, dot(viewDir, H));
	float3 diffuse = Diffuse_lambert(diffuseColor);
	float3 brdf = Fresnel_schlick(specularColor, VoH) * ( D_ggx(roughness, NoH) * Visibility_implicit() );
	return diffuse * energyLobe.x + brdf * energyLobe.y;
}

float3 ShadingDefault(float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 lightDir, float2 energyLobe = float2(1,1))
{
	float3 H = normalize(lightDir + viewDir);
	float NoH = max(0, dot(normal, H));
	float NoV = max(0, dot(normal, viewDir)) + 1e-5;
	float NoL = max(0, dot(normal, lightDir));
	float VoH = max(0, dot(viewDir, H));

	float3 diffuse = Diffuse_lambert(diffuseColor);

	float3 brdf = Fresnel_schlick(specularColor, VoH) * ( D_ggx(roughness, NoH) * Visibility_smithJA(roughness, NoV, NoL) );
	// float brdf = D_ggx(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_implicit();
	//float3 brdf = D_blinn(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_smith(roughness, NoV, NoL);
	// float brdf =  D_blinn(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_neumann(NoV, NoL);	

	return diffuse * energyLobe.x + brdf * energyLobe.y;
}

float3 EnvBRDF(float3 specularColor, float roughness, float metallic, float3 normal, float3 viewDir, float3 lightDir)
{
	float3 H = normalize(lightDir + viewDir);
	float NoH = max(0, dot(normal, H));
	float NoV = max(0, dot(normal, viewDir));
	float NoL = max(0, dot(normal, lightDir));
	float VoH = max(0.0001, dot(viewDir, H));

#if CALCULATE_ENV_BRDF
	float vis = Visibility_smith(roughness, NoV, NoL);
	return Fresnel_schlick(specularColor, VoH) * ( NoL * vis * (4 * VoH / NoH) );
#else
	float2 GF = preintegratedGF.SampleLevel(gBilinearClampSampler, float2(roughness, NoV), 0);
	return specularColor * GF.x + saturate(50.0 * specularColor.g) * GF.y;
#endif
}

float3 EnvBRDFApprox(float3 specularColor, float roughness, float NoV) {
	const float4 c0 = { -1, -0.0275, -0.572, 0.022 };
	const float4 c1 = { 1, 0.0425, 1.04, -0.04 };
	float4 r = roughness * c0 + c1;
	float a004 = min(r.x * r.x, exp2(-9.28 * NoV)) * r.x + r.y;
	float2 GF = float2(-1.04, 1.04) * a004 + r.zw;
	return specularColor * GF.x + saturate(50.0 * specularColor.g) * GF.y;
}

float3 EnvBRDFApprox(float3 specularColor, float roughness, float3 normal, float3 viewDir) {
	float NoV = max(0, dot(normal, viewDir));
	return EnvBRDFApprox(specularColor, roughness, NoV);
}

#endif
