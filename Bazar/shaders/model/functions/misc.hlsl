#ifndef MISC_HLSL
#define MISC_HLSL

#include "deferred/shadows.hlsl"

// Returns value of shadow.
float applyShadow(in float4 pos, float3 normal, uniform bool usePCF = true, uniform bool useNormalBias = true, uniform bool useFirstMap = false)
{
	return SampleShadowCascade(pos.xyz, pos.w, normal, usePCF, useNormalBias, false, 32, useFirstMap); // mover from deferred/shadows.hlsl
//	return SampleShadow(pos, normal, usePCF, useNormalBias);
}

//срезает модель по уровню воды для форвард шейдинга
void clipModelBySeaLevel(in float3 pos)
{
	if(pos.y + gOrigin.y < gModelClipLevel-1.0)
		discard;
}

float3 reconstructNormal(float4 color) {
	float3 normal;
	normal.xy = (color.xy - 128.0 / 255.0) * 2;
	normal.z = sqrt(1.0 - saturate(dot(normal.xy, normal.xy)));
	return normal;
}

// calculates normal using normal map
float3 calculateNormal(float3 normal, float4 tex, float4 tangent)
{
	float3 tan=normalize(tangent.xyz);
	float3 normalMap = reconstructNormal(tex);

#if TANGENT_SIZE == 4
	float w = tangent.w > 0 ? 1 : -1;			// input.Tangent.w can be interpolated
#else
	float w = 1;
#endif

	const float3 norm = normalize(normal);
	float3x3 tangentSpace = {tan, cross(tan, norm)*w, norm};
	float3 res = mul(normalMap, tangentSpace);
	res = dot(res, res) > 0.01 ? res : norm;
	return normalize(res);
}

#endif
