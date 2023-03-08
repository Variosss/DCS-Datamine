#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

float4x4 WVP;
float4 color4;

struct VS_INPUT
{
	float3 vPos : POSITION0;
	float4 vColor : TEXCOORD0;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float4 oColor : TEXCOORD0;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(float4(IN.vPos,1), WVP);
	vs_out.oColor = IN.vColor;
	return vs_out;
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{
	return IN.oColor;
}

float4 ps_main2(VS_OUT IN) : SV_TARGET0
{
	return color4;
}

technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
technique10 StandartColor
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main2()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
