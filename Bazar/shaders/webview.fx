#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

Texture2D tex;

struct VS_OUTPUT {
	float4 pos:			SV_POSITION;
	float2 texcoord:	TEXCOORD0;
};

static const float2 quad[4] = {
	{ -1, -1 },{ 1, -1 },
	{ -1,  1 },{ 1,  1 }
};

VS_OUTPUT VS(uint vid: SV_VertexID) {
	VS_OUTPUT o;
	o.pos = float4(quad[vid], 0, 1);
	o.texcoord = o.pos.xy*0.5 + 0.5;
	o.texcoord.y = 1.0 - o.texcoord.y;
	return o;
}

float4 PS(const VS_OUTPUT i) : SV_TARGET0
{
	float4 diffuse = tex.Sample(ClampLinearSampler, i.texcoord.xy);
	return float4(diffuse.bgra);	
}

BlendState webAlphaBlend
{
	BlendEnable[0] = TRUE;
	BlendEnable[1] = TRUE;
	SrcBlend = ONE;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;//ZERO;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

technique10 tech {
	pass P0 {
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(webAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
