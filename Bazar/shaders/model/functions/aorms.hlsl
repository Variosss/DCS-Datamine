#ifndef MODEL_AORMS_HLSL
#define MODEL_AORMS_HLSL

#include "functions/ambient_occlusion.hlsl"

#ifdef METROUGH_MAP
// hack for new shading
// TODO: remove after removing t3.
Texture2D MetRoughMap;
#endif

float4 getAORMS(in VS_OUTPUT input)
{
	float4 aorms = float4(1, 0.75, 0, 1);
#ifdef METROUGH_MAP
#ifdef METROUGH_MAP_UV
	aorms = MetRoughMap.Sample(gAnisotropicWrapSampler, input.METROUGH_MAP_UV.xy + diffuseShift);
#elif defined(DIFFUSE_UV)
	aorms = MetRoughMap.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
#endif
#endif

	aorms.x = min(aorms.x, getAmbientOcclusion(input));
	return aorms;
}

float4 specToAORMS(in VS_OUTPUT input, float4 specularMap)
{
	float roughness = clamp(specAdd + specularMap[(int)specSelect]*specMult, 0.02, 0.99);
	float metallic = clamp(reflAdd + specularMap.z * reflMult, 0.0, 1.0);
	float4 aorms = float4(getAmbientOcclusion(input), roughness, metallic, 1);
	return aorms;
}

#endif