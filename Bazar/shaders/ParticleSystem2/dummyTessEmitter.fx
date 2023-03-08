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
	float4 pos: POSITION0;
};

struct HS_PATCH_OUTPUT
{
	float edges[2] : SV_TessFactor;
	// float4 p1	: TEXCOORD5;
	// float4 p2	: TEXCOORD6;
	float3 orderOffset: TEXCOORD7;
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

HS_PATCH_OUTPUT hsConstDummy(InputPatch<GS_INPUT, 2> ip)
{
	#define POS_MSK(id) ip[id].pos.xyz
	HS_PATCH_OUTPUT o;
	o.edges[0] = 1; // detail factor
	o.edges[1] = 5; // particles

	//x - сортировка, y - отстут параметра для его отзеркаливания
	o.orderOffset.x = step( length(POS_MSK(0) - gViewInv._41_42_43), length(POS_MSK(1) - gViewInv._41_42_43) );	
	o.orderOffset.y = 0;//o.orderOffset.x / floor(o.edges[1]);

	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("point")]
[outputcontrolpoints(2)]
[patchconstantfunc("hsConstDummy")]
GS_INPUT hsDummy(InputPatch<GS_INPUT, 2> ip, uint id : SV_OutputControlPointID)
{
    GS_INPUT o;
    o = ip[id];
    return o;
}

[domain("isoline")]
GS_INPUT dsDummy(HS_PATCH_OUTPUT input, OutputPatch<GS_INPUT, 2> op, float2 uv : SV_DomainLocation)
{	
	GS_INPUT o;
	//сортируем
	float t = lerp(uv.x, 1 - uv.x - input.orderOffset.y, input.orderOffset.x);
	// t = uv.x;

	o.pos = lerp(op[0].pos, op[1].pos, t);

    return o;	
}

[maxvertexcount(4)]
void gsDummy(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float3 gsPos = i[0].pos.xyz;	
	
	float gsAngle = gModelTime * 0.2 + frac(i[0].pos.w);
	float gsScale = 5.0 + sin(gModelTime*0.5)*2.5;
	
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
		DISABLE_CULLING;
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_5_0, vsDummy()));
		SetHullShader(CompileShader(hs_5_0, hsDummy()));
		SetDomainShader(CompileShader(ds_5_0, dsDummy()));
		SetGeometryShader(CompileShader(gs_5_0, gsDummy()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, psDummy())); 
	}
}

