#ifndef BLUR_HLSL
#define BLUR_HLSL

#include "common/samplers11.hlsl"

float calcGaussianWeight(int sampleDist, float sigma) {
	float g = 1.0f / sqrt(2.0f * 3.14159 * sigma * sigma);
	return (g * exp(-(sampleDist * sampleDist) / (2 * sigma * sigma)));
}

float3 Blur(float2 uv, float2 off, float sigma, uniform Texture2D tex) {
    float3 result = 0;
    for (int i = -6; i < 6; i++) {
		float weight = calcGaussianWeight(i, sigma);
		result += tex.SampleLevel(gBilinearClampSampler, uv+off*sigma*i, 0).rgb * weight;
    }
    return result;
}

#endif
