#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/atmosphereSamples.hlsl"

Texture2D tex;

static const float4 quad[4] = {
	float4( -0.5, -0.5, 0, 0),
	float4( -0.5,  0.5, 0, 1),
	float4(  0.5, -0.5, 1, 0),
	float4(  0.5,  0.5, 1, 1)
};

struct VS_OUTPUT
{
	float4	pos: POSITION0;
};

struct GS_INPUT
{
	float4 pos: POSITION0;
};

struct PS_INPUT
{
	float4 pos: SV_POSITION0;
	float2 uv : TEXCOORD0;
};

GS_INPUT vsDummy(float4 pos: POSITION0, uint vertId: SV_VertexId)
{
	GS_INPUT o;
	o.pos = pos;
	return o;
}

[maxvertexcount(4)]
void gsDummy(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 gsPos = i[0].pos.xyz;
	
	float gsAngle = gModelTime * 0.2 + frac(i[0].pos.w);
	float gsScale = 10.0 + sin(gModelTime*0.5)*5;
	
	float2 sc;
	sincos(gsAngle, sc.x, sc.y);
	float2x2 M = {sc.y, sc.x, -sc.x, sc.y};

	gsPos = mul(float4(gsPos,1), gView).xyz;

	PS_INPUT o;
	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		float4 vPos = {mul(quad[ii].xy, M) * gsScale, 0, 1};
		vPos.xyz += gsPos;
		o.pos = mul(vPos, gProj);
		o.uv.xy = quad[ii].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psDummy(PS_INPUT i): SV_TARGET0
{
	float4 color = float4(i.uv.xy, 0, 1);
	return color;
}

technique10 tech
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(CompileShader(gs_4_0, gsDummy()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psDummy()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
