#include "common/States11.hlsl"

float4 Color;

matrix WVP;

struct VS_INPUT
{
	float4 vPos : POSITION;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
};

void vs_main(in float4 vPos : POSITION, out float4 oPos : SV_POSITION)
{
	oPos = mul(vPos, WVP);
}

float4 ps_main(in float4 oPos : SV_POSITION) : SV_TARGET0
{
	return Color;
}

technique10 Solid
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(wireframe);
	}
}

