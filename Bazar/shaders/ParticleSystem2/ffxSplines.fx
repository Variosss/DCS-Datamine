#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/splines.hlsl"

struct VS_WIRE_OUTPUT {
	float4 params0:	TEXCOORD0;
	float3 tangent:	TEXCOORD1;
	float nAge:		TEXCOORD2;
};

struct HS_PATCH_OUTPUT {
	float edges[2]:	SV_TessFactor;
};

struct PS_WIRE_INPUT {
	float4 pos:		SV_POSITION;
	float4 color:	COLOR0;
};

//считаем итоговую мировую позицию и относительное время жизни, остальные параметры просто передаем дальше
VS_WIRE_OUTPUT VS_wire(in float4 pos: POSITION0, uint id: sv_vertexId)
{
	VS_WIRE_OUTPUT o;
	o.params0 = pos;
	o.params0.xyz += worldOffset;
	o.nAge = 0;
	o.tangent = 0;
	return o;
}

HS_PATCH_OUTPUT HSconst_wire(InputPatch<VS_WIRE_OUTPUT, 4> ip)
{
	HS_PATCH_OUTPUT o;
	o.edges[0] = 1;
	o.edges[1] = 16;
	return o;
}
HS_PATCH_OUTPUT HSconst_tangent(InputPatch<VS_WIRE_OUTPUT, 4> ip)
{
	HS_PATCH_OUTPUT o;
	o.edges[0] = 2;
	o.edges[1] = 1;
    return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(4)]
[patchconstantfunc("HSconst_wire")]
VS_WIRE_OUTPUT HS_wire(InputPatch<VS_WIRE_OUTPUT, 4> ip, uint id: SV_OutputControlPointID)
{
	VS_WIRE_OUTPUT o;
	o = ip[id];
	return o;
}

[domain("isoline")]
[partitioning("integer")]
[outputtopology("line")]
[outputcontrolpoints(4)]
[patchconstantfunc("HSconst_tangent")]
VS_WIRE_OUTPUT HS_tangent(InputPatch<VS_WIRE_OUTPUT, 4> ip, uint id: SV_OutputControlPointID)
{
	VS_WIRE_OUTPUT o;
	o = ip[id];
	return o;
}

//через все круги ада
[domain("isoline")]
VS_WIRE_OUTPUT DS_wire(HS_PATCH_OUTPUT input, OutputPatch<VS_WIRE_OUTPUT, 4> op, float2 uv : SV_DomainLocation)
{
	VS_WIRE_OUTPUT o;
	float t = uv.x;
	float4 pos = BezierCurve4(t, op[0].params0, op[1].params0, op[2].params0, op[3].params0);
	// float4 pos = LinearInterp4(t, op[0].params0, op[1].params0, op[2].params0, op[3].params0);
	o.params0 = pos;
	o.params0.xyz = mul(float4(o.params0.xyz, 1), gView).xyz;
	o.params0.w = saturate(o.params0.w*2);
	o.nAge = t;
	o.tangent = t<=0.5 ? op[1].params0 : op[2].params0;
	o.tangent = mul(float4(o.tangent.xyz, 1), gView).xyz;
	return o;
}

[maxvertexcount(2+5)]
void GS_wire(line VS_WIRE_OUTPUT input[2], inout LineStream<PS_WIRE_INPUT> outputStream)
{
	const float pointSize = 0.1;//размер квадратика	
	const float3 color = {0.6,0.9,0.4};

	//линия
	PS_WIRE_INPUT o;
	o.color = float4(color*input[0].nAge*1.5, input[0].params0.w);
	o.pos = mul(float4(input[0].params0.xyz, 1), Proj);
	outputStream.Append(o);
	o.color = float4(color*input[1].nAge*1.5, input[1].params0.w);
	o.pos = mul(float4(input[1].params0.xyz, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();

	//квадратик
#if 0
	float3 vertexPos = input[0].params0.xyz;
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[0].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[1].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[3].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[2].xy, 0), 1), Proj);
	outputStream.Append(o);
	o.pos = mul(float4(vertexPos + pointSize * float3(staticVertexData[0].xy, 0), 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();
#endif
}

[maxvertexcount(4)]
void GS_tangent(line VS_WIRE_OUTPUT input[2], inout LineStream<PS_WIRE_INPUT> outputStream)
{
	const float pointSize = 0.1;//размер квадратика	
	// const float3 color = {0.6,0.9,0.4};
	float3 color = {1,0,0};
	float3 color2 = {0,0,1};

	//касательная 1
	PS_WIRE_INPUT o;
	o.color = float4(color, input[0].params0.w);
	o.pos = mul(float4(input[0].params0.xyz, 1), Proj);
	outputStream.Append(o);
	o.color = float4(color, input[0].params0.w);
	o.pos = mul(float4(input[0].tangent.xyz, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();
	//касательная 2
	o.color = float4(color2, input[1].params0.w);
	o.pos = mul(float4(input[1].params0.xyz, 1), Proj);
	outputStream.Append(o);
	o.color = float4(color2, input[1].params0.w);
	o.pos = mul(float4(input[1].tangent.xyz, 1), Proj);
	outputStream.Append(o);
	outputStream.RestartStrip();
}

float4  PS_black(PS_WIRE_INPUT i) : SV_TARGET0
{
	return i.color;
	//return float4(i.color.rgb, 0.8);
}

technique10 tech
{
	pass bezierTrajectory
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
		SetVertexShader(CompileShader(vs_5_0, VS_wire()));
		SetHullShader(CompileShader(hs_5_0, HS_wire()));
		SetDomainShader(CompileShader(ds_5_0, DS_wire()));
		SetGeometryShader(CompileShader(gs_5_0, GS_wire()));
		SetPixelShader(CompileShader(ps_5_0, PS_black()));
	}
	pass tangents
	{
		ENABLE_RO_DEPTH_BUFFER;
		ENABLE_ALPHA_BLEND;
		DISABLE_CULLING;
		SetVertexShader(CompileShader(vs_5_0, VS_wire()));
		SetHullShader(CompileShader(hs_5_0, HS_tangent()));
		SetDomainShader(CompileShader(ds_5_0, DS_wire()));
		SetGeometryShader(CompileShader(gs_5_0, GS_tangent()));
		SetPixelShader(CompileShader(ps_5_0, PS_black()));
	}
}