#ifndef MODEL_SHADING_HLSL
#define MODEL_SHADING_HLSL

#include "deferred/GBuffer.hlsl"
#include "deferred/shading.hlsl"
#include "deferred/atmosphere.hlsl"
#include "deferred/shadingCockpit.hlsl"

#define USE_NORMAL_DITHERING 1

float3 modifyAlbedo(float3 diffuseColorSRGB, float level, float contrast, float ao)
{
#if USE_SEPARATE_AO	// ignore AO there
	ao = 1;
#endif
	float3 encodedColor = encodeColorYCC(diffuseColorSRGB * ao);
    encodedColor.r = level + encodedColor.r * contrast;
    return saturate(decodeColorYCC(encodedColor));
}

// oroginalNormal is input.Normal
float3 normalDithering(float3 originalNormal, float3 normal) {
#if USE_NORMAL_DITHERING
	float k = dot(max(abs(ddx(originalNormal)), abs(ddy(originalNormal))), 0.33);
	k = saturate(5000 * k);
	float noise = frac(sin(dot(normal.zx, float2(12.9898, 78.233))) * 43758.5453);
	noise = k*0.005*(noise*2-1);
	return float3(normal.x + noise*2, normal.y, normal.z + noise);
#else
	return normal;
#endif
}

#endif
