#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/stencil.hlsl"
#include "deferred/Decoder.hlsl"

float4	g_ColorBufferViewport;
float2	g_ColorBufferSize;

float LoadDepth(float2 uv) {
	return SampleMap(DepthMap, uv, 0).r;
}

uint LoadStencil(float2 uv) {
	return SampleMap(StencilMap, uv, 0).g;
}

float2 transformColorBufferUV(float2 uv) {
	return (uv*g_ColorBufferViewport.zw + g_ColorBufferViewport.xy)*g_ColorBufferSize;
}

bool isWater(uint materialID) {
	return (materialID & STENCIL_COMPOSITION_MASK) == STENCIL_COMPOSITION_WATER;
}

#define SSR_Depth DepthMap
#include "enlight/ssr.hlsl"

static const float2 quad[4] = {
	float2(-1, -1), float2(1, -1),
	float2(-1, 1),	float2(1, 1),
};

struct VS_OUTPUT {
	float4 sv_pos:		SV_POSITION;
	float2 projPos:		TEXCOORD0;
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.sv_pos = float4(quad[vid], 0, 1);
	o.projPos = o.sv_pos.xy;
	return o;
}

float4 PS_REFLECTION(VS_OUTPUT i) : SV_TARGET0 {

	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	float2 tuv = transformColorBufferUV(uv) + 0.5;	// center of pixel

	uint matID = LoadStencil(tuv) & (STENCIL_COMPOSITION_MASK | 7);	// stencil lean in G only on ATI video card
	if (matID != (STENCIL_COMPOSITION_MODEL | 1)
#if !USE_COCKPIT_CUBEMAP
		&& matID != STENCIL_COMPOSITION_COCKPIT
#endif
		)
		return float4(0, 0, 0, 0);
	float depth = LoadDepth(tuv);
	float4 NDC = float4(i.projPos.xy, depth, 1);

	float3 wsNormal = DecodeNormal(tuv, 0);
	float4 ssr = getSSR(NDC, wsNormal, 0.5);
	return ssr;
}

technique10 Reflection {
    pass P0	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, PS_REFLECTION()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
    }
}

/////////////////////// filter mips

Texture2D sourceTex;
RWTexture2D<float4> targetTex;
float2 dims;

float4 filterMip(float2 uv, float radius, uniform uint count) {

	static const float incr = 3.1415926535897932384626433832795 *(3.0 - sqrt(5.0));

	float offs = 1.0 / count;
	float angle = 0, offset = 0;;

	float4 acc = 0;

	[unroll(count)]
	for (uint i = 0; i < count; ++i) {
		offset += offs;
		angle += incr;
		float s, c;
		sincos(angle, s, c);
		float2 delta = float2(c, s) * (offset * offset * radius);
		float4 col = sourceTex.SampleLevel(ClampLinearSampler, uv + delta, 0);
		acc += float4(col.rgb*col.a, col.a);
	}

	return float4(acc.rgb / max(acc.a, 0.0001), acc.a / count);

}

float4 psFilterMipBack(VS_OUTPUT i): SV_TARGET0 {
	float2 uv = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	return sourceTex.SampleLevel(ClampLinearSampler, uv, 0);
}

[numthreads(16, 16, 1)]
void csFilterMip(uint3 id: SV_DispatchThreadID, uniform uint count) {
	const uint2 pixel = id.xy;
	targetTex[pixel] = filterMip((pixel + 0.5)/dims, 0.025, count);
}

technique10 FilterMipComp {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, csFilterMip(64)));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

BlendState mipAlphaBlend {
	BlendEnable[0] = TRUE;
	SrcBlend = INV_DEST_ALPHA;
	DestBlend = DEST_ALPHA;
	BlendOp = ADD;

//	SrcBlendAlpha = SRC_ALPHA;
//	DestBlendAlpha = INV_SRC_ALPHA;
//	BlendOpAlpha = ADD;

//	SrcBlendAlpha = INV_DEST_ALPHA;
//	DestBlendAlpha = DEST_ALPHA;
//	BlendOpAlpha = ADD;

	SrcBlendAlpha = ONE;
	DestBlendAlpha = ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f;
};


technique10 FilterMipBack {
	pass P0	{
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetPixelShader(CompileShader(ps_5_0, psFilterMipBack()));
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(mipAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
