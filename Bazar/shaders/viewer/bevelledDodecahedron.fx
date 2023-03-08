#include "common/Samplers11.hlsl"
#include "common/States11.hlsl"

float4x4 WVP;

struct VS_INPUT
{
	float3 pos : POSITION0;
	float3 normal : NORMAL0;
	float2 uv0 : TEXCOORD0;
	float2 uv1 : TEXCOORD1;
	float2 uv2 : TEXCOORD2;
	float3 color: TEXCOORD3;
};

struct VS_OUT
{
	float4 pos: SV_POSITION0;
	float3 color: TEXCOORD0;
};

VS_OUT vs(VS_INPUT i)
{
	VS_OUT o;
	o.pos = mul(float4(i.pos, 1), WVP);
	o.color = i.color;
	return o;
}

float4 ps(VS_OUT i) : SV_TARGET0
{
	return float4(i.color, 1);
}

technique10 tech
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
