#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

float	time;
float3	worldOffset;

float4	param0;
float3	param1;
float4	param2;
float2	param3;
float4	param4;
float4	param5;
float4	param6;
float4	param7;
float4	param8;

Texture2D tex: register(t0);

#include "common/context.hlsl"
#include "common/ambientCube.hlsl"


struct VS_INPUT
{
	float4 pos	: 	TEXCOORD0;
	float4 speed:	TEXCOORD1;
	float4 dir:		TEXCOORD2;
};

struct VS_OUTPUT
{
    float4 pos:  SV_POSITION0;
	float2 uv: TEXCOORD0;
};

VS_OUTPUT vs(in VS_INPUT i, uint vertId:SV_VertexID)
{
	VS_OUTPUT o;
	static const float4 quad[4] = {
		float4( -0.5, -0.5, 0, 1),
		float4( -0.5,  0.5, 0, 1),
		float4(  0.5, -0.5, 0, 1),
		float4(  0.5,  0.5, 0, 1)
	};
	float4 wPos = quad[vertId]+0.000001;
	o.uv = wPos.xy;
	wPos.xyz -= worldOffset;
	// wPos += param0;
	// wPos.xyz += param1;
	// wPos += param2;
	// wPos.xy += param3;
	// wPos += param4;
	
	o.pos = mul(wPos, gViewProj);	
	
	return o;
}


float4 ps(in VS_OUTPUT i): SV_TARGET0
{
	// return 1;
	return tex.Sample(WrapLinearSampler, i.uv)*0.8;
}

technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vs()));
		SetHullShader(NULL);
		SetDomainShader(NULL);	
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}






