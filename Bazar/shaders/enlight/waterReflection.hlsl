
#define SSR_Depth g_DepthTexture
#include "enlight/ssr.hlsl"

#define USE_REFLECTION_TEST 0

Texture2D prevReflection;

struct VS_REFLECTION_OUTPUT {
	float4 sv_pos:		SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_REFLECTION_OUTPUT VS_REFLECTION(uint vid: SV_VertexID) {
	VS_REFLECTION_OUTPUT o;
	o.sv_pos = float4(quad[vid], 0, 1);
	o.projPos = o.sv_pos.xy;
	return o;
}

float3 getReflectionSkyColorLDR(float3 v) {
	return environmentMap.SampleLevel(ClampLinearSampler, v, 2).rgb; // I think it looks better overall, personally (c) Cato Bye
}

float3 reflectionSky(float3 wsPos, float3 wsNormal) {
	float3 wsRay = reflect(wsPos - gCameraPos, wsNormal);
	wsRay.y *= sign(wsRay.y);	// prevent green bottom in reflection 
	return getReflectionSkyColorLDR(wsRay);
}

float3 reflectionSky(float4 NDC, float2 tuv) {
	float4 wsPos = mul(NDC, gViewProjInv);
	wsPos.xyz /= wsPos.w;
	float3 wsNormal = DecodeWaterNormal(tuv, 0);
	float3 r0 = reflectionSky(wsPos.xyz, wsNormal);
	wsNormal = lerp(wsNormal, float3(0, 1, 0), 0.33);
	float3 r1 = reflectionSky(wsPos.xyz, wsNormal);
	return lerp(r0, r1, 0.5);
}

float3 mixPrevFrame(float3 refl, float4 NDC) {
	float4 prevNDC = mul(NDC, gPrevFrameTransform);
	prevNDC.xy /= prevNDC.w;
	float2 puv = float2(prevNDC.x, -prevNDC.y) * 0.5 + 0.5;
	float4 prevRefl = prevReflection.SampleLevel(gTrilinearBlackBorderSampler, puv, 0);
	float factor = saturate(1 - distance(prevNDC.xy, NDC.xy/NDC.w) * 10);
	float w = 0.9 * saturate(prevRefl.w * factor * g_PrevFrameWeight);
	return max(0, lerp(refl, prevRefl.xyz, w));
}

float4 PS_REFLECTION_WATER(VS_REFLECTION_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	float2 tuv = transformColorBufferUV(uv) + 0.5;	// center of pixel

	// calculate sky reflection
	float depth = LoadDepth(tuv);
	float4 NDC = float4(i.projPos.xy, depth, 1);
	float3 sky = reflectionSky(NDC, tuv);

	// check water material
	if (!isWater(LoadStencil(tuv)))
#if USE_REFLECTION_TEST 
		return float4(1, 1, 0, 1);
#else
		return float4(sky, 0);
#endif

	float3 wsNormal = DecodeWaterNormal(tuv, 0);
	// SSR
	float4 refl = getSSR(NDC, wsNormal, 20);

	/// fill missed pixels to sky reflection
	refl.xyz = lerp(sky, refl.xyz, refl.w*0.97);

	return float4(mixPrevFrame(refl.xyz, NDC), 1);
}

float4 PS_REFLECTION_SKY(VS_REFLECTION_OUTPUT i, uniform bool useMixPrevFrame = true) : SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	float2 tuv = transformColorBufferUV(uv);		// coords in pixels

	float depth = LoadDepth(tuv + 0.5);
	float4 NDC = float4(i.projPos.xy, depth, 1);

	float3 refl = reflectionSky(NDC, tuv);

	if (!isWater(LoadStencil(tuv)))
		return float4(refl, 0);

	if (useMixPrevFrame)
		return float4(mixPrevFrame(refl, NDC), 1);
	else
		return float4(refl, 1);
}

#undef COMMON_PART
#define COMMON_PART 		SetHullShader(NULL);			\
							SetDomainShader(NULL);			\
							SetGeometryShader(NULL);		\
							SetComputeShader(NULL);			\
							SetDepthStencilState(disableDepthBuffer, 0);									\
							SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);	\
							SetRasterizerState(cullNone);

technique10 Reflection {
    pass P0	{
		SetVertexShader(CompileShader(vs_5_0, VS_REFLECTION()));
		SetPixelShader(CompileShader(ps_5_0, PS_REFLECTION_SKY()));
		COMMON_PART
	}
	pass P1	{
		SetVertexShader(CompileShader(vs_5_0, VS_REFLECTION()));
		SetPixelShader(CompileShader(ps_5_0, PS_REFLECTION_WATER()));
		COMMON_PART
	}
	pass P2 {
		SetVertexShader(CompileShader(vs_5_0, VS_REFLECTION()));
		SetPixelShader(CompileShader(ps_5_0, PS_REFLECTION_SKY(false)));
		COMMON_PART
	}
}
