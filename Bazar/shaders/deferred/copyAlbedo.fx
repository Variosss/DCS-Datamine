#include "common/states11.hlsl"
#include "common/samplers11.hlsl"

#include "GBuffer.hlsl"

Texture2D<float4> AlbedoTex;

static const float2 quad[4] = {
	{-1, -1}, {1, -1},
	{-1,  1}, {1,  1}
};

struct VS_out
{
	float4 pos : SV_POSITION;
	float2 uv  : COLOR0;
	float2 posNDC : COLOR1;
};

VS_out VS(uint vid: SV_VertexID)
{
	VS_out vout;
	vout.pos = float4(quad[vid], 0, 1);
	vout.uv = (quad[vid] + 1.0)*0.5;
	vout.uv.y = 1.0 - vout.uv.y;
	
	vout.posNDC = quad[vid];

	return vout;
}

GBuffer PS(VS_out vout)
{
	float2 uv = vout.uv;
	float2 posNDC = vout.posNDC.xy;
	float4 color = AlbedoTex.SampleLevel(WrapPointSampler, uv, 0);

	return BuildGBuffer(posNDC, 
#if USE_SV_SAMPLEINDEX
		0, 
#endif
		float4(color.rgb, 1.0), float3(0, 1, 0), float4(1, 0.98, 0.0, 1), float3(0, 0, 0));
}

BlendState WriteMaskBlendState
{
	BlendEnable[0] = FALSE;
	BlendEnable[1] = FALSE;
	BlendEnable[2] = FALSE;
	BlendEnable[3] = FALSE;
	RenderTargetWriteMask[0] = 0x0;
	RenderTargetWriteMask[1] = 0x0f;
	RenderTargetWriteMask[2] = 0x0f;
	RenderTargetWriteMask[3] = 0x0;
};

DepthStencilState albedoCopyDS {
	DepthEnable = FALSE;
	DepthWriteMask = ALL;
	DepthFunc = NEVER;

	StencilEnable = FALSE;
	StencilReadMask = 1;
	StencilWriteMask = 1;

	FrontFaceStencilFunc = ALWAYS;
	FrontFaceStencilPass = REPLACE;
	FrontFaceStencilFail = KEEP;

	BackFaceStencilFunc = ALWAYS;
	BackFaceStencilPass = REPLACE;
	BackFaceStencilFail = KEEP;
};

technique10 CopyAlbedo {
	pass P0 {
		SetVertexShader(CompileShader(vs_5_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, PS()));
		SetDepthStencilState(albedoCopyDS, 0);
		SetBlendState(WriteMaskBlendState, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
