#ifndef SOFTPARTICLES_HLSL
#define SOFTPARTICLES_HLSL

#include "common/samplers11.hlsl"

Texture2D<float> g_DepthTexture: register(t114);

float depthAlpha(float4 projPos, uniform float factor = 1) {
	float depth = g_DepthTexture.SampleLevel(gPointClampSampler, float2(projPos.x, -projPos.y) / projPos.w*0.5 + 0.5, 0).r;
	float4 p0 = mul(projPos, gProjInv);
	float4 p1 = mul(float4(projPos.xy / projPos.w, depth, 1), gProjInv);
	return saturate((p1.z / p1.w - p0.z / p0.w) * factor);
}

float applyDepthAlpha(float alpha, float4 projPos, uniform float factor =1){
	return alpha*depthAlpha(projPos, factor);
}

#endif
