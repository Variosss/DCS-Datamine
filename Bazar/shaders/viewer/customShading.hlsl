#include "common/BRDF.hlsl"
#include "common/shadingCommon.hlsl"
#include "deferred/shading.hlsl"

#define PI 3.141592653589793238462

#define envBRDF			envBRDF2
#define ShadingDefault	ShadingDefault2

static const float sunIntensity = 10.0;
static const float IBLIntensity = 1.0;

struct Light
{
	float3 pos;
	float type;
	float3 color;
	float intensity;
};

cbuffer cbLights
{
	Light lights[8];
};

// [Burley 2012, "Physically-Based Shading at Disney"]
float3 Diffuse_Burley( float3 DiffuseColor, float Roughness, float NoV, float NoL, float VoH )
{
	float FD90 = 0.5 + 2 * VoH * VoH * Roughness;
	float FdV = 1 + (FD90 - 1) * pow( 1 - NoV, 5 );
	float FdL = 1 + (FD90 - 1) * pow( 1 - NoL, 5 );
	return DiffuseColor * ( 1 / PI * FdV * FdL );
}

// [Gotanda 2012, "Beyond a Simple Physically Based Blinn-Phong Model in Real-Time"]
float3 Diffuse_OrenNayar( float3 DiffuseColor, float Roughness, float NoV, float NoL, float VoH )
{
	float VoL = 2 * VoH - 1;
	float m = Roughness * Roughness;
	float m2 = m * m;
	float C1 = 1 - 0.5 * m2 / (m2 + 0.33);
	float Cosri = VoL - NoV * NoL;
	float C2 = 0.45 * m2 / (m2 + 0.09) * Cosri * ( Cosri >= 0 ? min( 1, NoL / NoV ) : NoL );
	return DiffuseColor / PI * ( NoL * C1 + C2 );
}

float3 ShadingDefault2(float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 lightDir, float2 energyLobe = float2(1,1))
{
	float3 H = normalize(lightDir + viewDir);
	float NoH = max(0, dot(normal, H));
	float NoV = max(0, dot(normal, viewDir)) + 1e-5;
	float NoL = max(0, dot(normal, lightDir));
	float VoH = max(0, dot(viewDir, H));
	
	// float3 diffuse = Diffuse_lambert(diffuseColor);
	// float3 diffuse = Diffuse_Burley(diffuseColor, roughness, NoV, NoL, VoH);
	
	float p = dbg.w/100.0;
	float3 diffuse = 0;
	if(p<0.333)
		diffuse = Diffuse_lambert(diffuseColor);
	else if(p<0.666)
		diffuse = Diffuse_Burley(diffuseColor, roughness, NoV, NoL, VoH);
	else
		diffuse = Diffuse_OrenNayar(diffuseColor, roughness, NoV, NoL, VoH);

	// float3 brdf = D_ggx(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_smith(roughness, NoV, NoL);
	float3 brdf = Fresnel_schlick(specularColor, VoH) * ( D_ggx(roughness, NoH) * Visibility_smithJA(roughness, NoV, NoL) );
	// float3 brdf = D_ggx(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_implicit();
	// float3 brdf = D_blinn(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_smith(roughness, NoV, NoL);
	// float3 brdf =  D_blinn(roughness, NoH) * Fresnel_schlick(specularColor, VoH) * Visibility_neumann(NoV, NoL);	
	
	return diffuse*energyLobe.x + brdf*energyLobe.y;
}

float3 envBRDF2(float3 specularColor, float roughness, float metallic, float3 normal, float3 viewDir, float3 lightDir)
{
	float3 H = normalize(lightDir + viewDir);
	float NoH = max(0, dot(normal, H));
	float NoV = max(0, dot(normal, viewDir));
	float NoL = max(0, dot(normal, lightDir));
	float VoH = max(0.0001, dot(viewDir, H));

// #define CALCULATE_VISIBILITY

// #ifdef CALCULATE_VISIBILITY
	if(dbg.z<33)
	{
		float vis = Visibility_smith(roughness, NoV, NoL);
		return Fresnel_schlick(specularColor, VoH);// * ( NoL * vis * (4 * VoH / NoH) );
	}
	if(dbg.z<66)
	{
		float vis = Visibility_smith(roughness, NoV, NoL);
		return Fresnel_schlick(specularColor, VoH) * ( NoL * vis * (4 * VoH / NoH) );
	}
// #else
	else {
		// float2 GF = preintegratedGF.SampleLevel(gBilinearClampSampler, float2(NoV, roughness ), 0 ).rg;	
		float2 GF = preintegratedGF.SampleLevel(gBilinearClampSampler, float2(roughness, NoV), 0 ).rg;	
		return specularColor * GF.x + saturate(50.0 * specularColor.g) * GF.y;
	}
// #endif
}






float3 ShadeCustom(float3 normal, float3 baseColor, float roughness, float metallic, float cavity, float AO, float3 emissive, float3 wPos, float2 energyLobe = float2(1,1))
{	
	float3 diffuseColor = baseColor.xyz * (1 - metallic);
	float3 specularColor = lerp(0.04, baseColor.xyz, metallic);
	
	float3 viewDir = normalize(gCameraPos - wPos.xyz);
	
	float NoV = max(0, dot(normal, viewDir.xyz));
	float3 sunDir = gSunDir; //lights[0].pos.xyz;
	
	float3 finalColor = emissive;
	
#if 0
	//-----------------------------------------------
	float3 D = sunDir;
	float sunAngularRadius = 0.54 * 3.14159265358 / 180.0 * 2;
	float r = sin( sunAngularRadius ); // Disk radius
	float d = cos( sunAngularRadius ); // Distance to disk
	float3 R2 = normal*NoV*2 - viewDir.xyz;
	// Closest point to a disk ( since the radius is small, this is
	// a good approximation
	float DdotR = dot(D,R2);
	float3 S = R2 - DdotR * D;
	float3 L = DdotR < d ? normalize (d * D + normalize (S) * r) : R2;
	//------------------------------------------------		
	float NoL = max(0, dot(normal, sunDir));
	float3 lightAmount = lights[0].color * sunIntensity * NoL;
	
	finalColor += ShadingDefault(diffuseColor,	0, roughness, normal, viewDir.xyz, sunDir, energyLobe) * lightAmount;
	finalColor += ShadingDefault(0,	specularColor, roughness, normal, viewDir.xyz, L, energyLobe) * lightAmount;
#else
	float NoL = max(0, dot(normal, sunDir));
	// float3 lightAmount = lights[0].color * sunIntensity * NoL;
	float3 lightAmount = gSunDiffuse * sunIntensity * NoL;	
	finalColor += ShadingDefault(diffuseColor, specularColor*cavity, roughness, normal, viewDir.xyz, sunDir, energyLobe) * lightAmount;
#endif
	
	//analitic lighting
	// for(uint i=1; i<lightsCount; ++i)
	for(uint i=1; i<0; ++i)
	{
		float3 lightDir = lights[i].pos.xyz - wPos.xyz - gOrigin.xyz;
		float d = length(lightDir);
		lightDir /= d;
		float lightAttenuation =  min(1, 1 / (d*d + 1));
		if(lights[i].type == 1.f)
		{
			lightDir = lights[i].pos.xyz;
			lightAttenuation = 1.0;
		}

		float NoL = max(0, dot(normal, lightDir));
		float3 lightAmount = lights[i].color * (lights[i].intensity * lightAttenuation * NoL * 0.5);
		
		finalColor += ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir.xyz, lightDir, energyLobe) * lightAmount;
	}
		
	const float mipsCount = 8.0;
	
#if 1
	float3 H = normalize(sunDir.xyz + viewDir.xyz);
	float VoH = max(0, dot(viewDir, H));
	
	float p = dbg.w/100.0;
	if(p<0.333)
		finalColor += Diffuse_lambert(diffuseColor) * envMap.SampleLevel(gBilinearClampSampler, normal, mipsCount).rgb * IBLIntensity * energyLobe.x;
	else if(p<0.666)
		finalColor += Diffuse_Burley(diffuseColor, roughness, NoV, NoL, VoH) * envMap.SampleLevel(gBilinearClampSampler, normal, mipsCount).rgb * IBLIntensity * energyLobe.x;
	else
		finalColor += Diffuse_OrenNayar(diffuseColor, roughness, NoV, NoL, VoH) * envMap.SampleLevel(gBilinearClampSampler, normal, mipsCount).rgb * IBLIntensity * energyLobe.x;
	
	//diffuse IBL
	// finalColor += Diffuse_lambert(diffuseColor) * envMap.SampleLevel(gBilinearClampSampler, normal, mipsCount).rgb * IBLIntensity;
	// finalColor += Diffuse_Burley(diffuseColor, roughness, NoV, NoL, VoH) * envMap.SampleLevel(gBilinearClampSampler, normal, mipsCount).rgb * IBLIntensity;
	
	//specular IBL
	float a = roughness * roughness;
	float3 R = normal*NoV*2 - viewDir;
	// float3 R = -reflect(viewDir, normal);
	R = normalize( lerp( normal, R, (1 - a) * ( sqrt(1 - a) + a ) ) );
	float3 envLightColor = envMap.SampleLevel(ClampLinearSampler, R, getMipFromRoughness(roughness, mipsCount)).rgb;
	finalColor += envLightColor * envBRDF(specularColor, roughness, metallic, normal, viewDir.xyz, R) * cavity * energyLobe.y;
#endif
	
#if 0
	float3 spec = float3(0.08,0.08,0.08);
	roughness = 0.15;
	float coatOpacity = 1.0;
	finalColor += ShadingDefault(0.0, spec, roughness, normal, viewDir.xyz, sunDir, energyLobe) * lightAmount * coatOpacity;
	
	//specular IBL
	a = roughness * roughness;
	R = normal*NoV*2 - viewDir;
	R = normalize( lerp( normal, R, (1 - a) * ( sqrt(1 - a) + a ) ) );
	envLightColor = envMap.SampleLevel(ClampLinearSampler, R, getMipFromRoughness(roughness, mipsCount)).rgb;
	finalColor += envLightColor * envBRDF(spec, roughness, metallic, normal, viewDir.xyz, R)*cavity * coatOpacity * energyLobe.y;
#endif
	
	return finalColor;
}
