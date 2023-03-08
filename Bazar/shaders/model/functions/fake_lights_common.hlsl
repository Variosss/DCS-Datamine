#ifndef MODEL_FAKE_LIGHTS_COMMON_HLSL
#define MODEL_FAKE_LIGHTS_COMMON_HLSL

#include "functions/pixel_utils.hlsl"

#include "common/fake_lights_debug_uniforms.hlsl"

static const float SOFT_PARTICLE_RADIUS = 10;

// Pixel shader o structure
struct PS_FIKE_LIGHT_OUTPUT
{
	float4 RGBColor : SV_TARGET0;  // Pixel color
};

static const float2 vertex[4] = {
	float2(1, 1),  float2(-1, 1),
	float2(1, -1), float2(-1, -1)
};

static const float2 vertexOp[4] = {
	float2(1, 1),  float2(1, -1),
	float2(-1, 1), float2(-1, -1)
};

static const float2 coords[4] = {
	float2(1, 1),  float2(0, 1),
	float2(1, 0), float2(0, 0)
};

static const int2 tc[4] = {
	int2(2, 3),  int2(0, 3),
	int2(2, 1), int2(0, 1)
};

Texture2D haloIntensityTex;

float4 calculate_position(in float4 vPos, inout float size, in float maxDistance, float minSizeInPixels, out float sizeInPixels, out float3 worldPos)
{
	size *= FL_DBG_SIZE_MULT;
	minSizeInPixels *= FL_DBG_MIN_SIZE_IN_PIXELS_MULT;

	float4 p = mul(vPos, gView);
	const float dist = length(p.xyz / p.w) * gZoom;
	float sizeMult = 1.0 - smoothstep(maxDistance, maxDistance + maxDistance * 0.3, dist);
	const float origSizeInPixels = calc_size_in_pixels2(float4(0, 0, -1, 1), size);

	float pixelSize = minSizeInPixels;
	sizeInPixels = calc_size_in_pixels2(p, size);
	if(sizeInPixels < pixelSize){
		size *= pixelSize / sizeInPixels;
		sizeInPixels = pixelSize;
	}

	//size *= 1.0 - smoothstep(maxDistance, maxDistance + maxDistance * 0.1, dist);

	worldPos = vPos.xyz / vPos.w;

	p.xyz += shiftToCamera * p.xyz/dist;

	return p;
}

float SamplePrecomputedSingleScatteringIntensity(float pixelsInHalo, float dist)
{
	const float pixelsInHaloMin = 1.0 / 1; 	//baked in haloIntensityTex
	const float pixelsInHaloMax = 1024;		//baked in haloIntensityTex

	float sampleRadius = 0.5 / pixelsInHalo;//relative to flare radius
	float distMax = 1.0 + sampleRadius;

	// float v = sqrt((pixelsInHalo - pixelsInHaloMin) / (pixelsInHaloMax - pixelsInHaloMin));
	// float u = sqrt(dist / distMax);
	float v = pow(saturate((pixelsInHalo - pixelsInHaloMin) / (pixelsInHaloMax - pixelsInHaloMin)), 1.0/3);
	float u = pow(dist / distMax, 1.0/3);

	float intensity = haloIntensityTex.SampleLevel(gBilinearClampSampler, float2(u, v), 0).r;
	//return intensity;
	return (intensity*intensity) * (intensity*intensity);
}

float4 calculate_light_intensity(float4 color, float sizeInPixels, float2 intensityUV, float3 worldPos, float maxDistance)
{
	float4 res = color;

	const float distToCamera = distance(gCameraPos, worldPos) * gZoom;
	maxDistance *= FL_DBG_DISTANCE_MULT;

#if 0
	res *= res;
#else
	float dist = saturate(-2 * distance(intensityUV, 0.5)+1);
	float a = color.a * color.a * color.a * color.a * color.a * color.a;
	float m = lerp(1, 100, smoothstep(0, maxDistance, distToCamera));
	float sunMult = 1 + smoothstep(0, 1, gSunDir.y) * a * m;
	//sunMult = gSunDir.y > 0 ? pow(1 + gSunDir.y, 2) : 1;

	res.rgb *= SamplePrecomputedSingleScatteringIntensity(sizeInPixels, 1 - dist) * luminance * sunMult;
	res.rgb *= FL_DBG_LUMINANCE_MULT;
	res.a = 1;
#endif

	res *= 1.0 - smoothstep(maxDistance, maxDistance + maxDistance, distToCamera);
	return res;
}

#endif