#ifndef ED_MODEL_PIXEL_UTILS_HLSL
#define ED_MODEL_PIXEL_UTILS_HLSL

#include "common/softParticles.hlsl"

float calc_size_in_pixels(float4 p, float s)
{
	float4 p1 = float4(p.x - s, p.y - s, p.z, 1);
	float4 p2 = float4(p.x + s, p.y + s, p.z, 1);

	p1 = mul(p1, gProj);
	p2 = mul(p2, gProj);

	p1.xy /= p1.w;
	p2.xy /= p2.w;

	return min(abs(p2.x - p1.x), abs(p2.y - p1.y)) / 2.0;
}

float calc_size_in_pixels2(float4 p, float s)
{
	float4 p1 = float4(p.x - s, p.y - s, p.z, 1);
	float4 p2 = float4(p.x + s, p.y + s, p.z, 1);

	p1 = mul(p1, gProj);
	p2 = mul(p2, gProj);

	p1.xy /= p1.w;
	p2.xy /= p2.w;

	return abs(p2.y - p1.y) * gSreenParams.y / 2.0;
}

#endif
