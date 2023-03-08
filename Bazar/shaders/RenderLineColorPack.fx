#include "common/States11.hlsl"
#include "common/context.hlsl"

#ifdef USE_DCS_DEFERRED
#include "deferred/GBuffer.hlsl"
#endif

#define USE_GS 1

uint2 targetDims;

struct VS_INPUT
{
	uint4 vPos : POSITION;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float4 oColor : COLOR;
};

/////////////////////////////////
//unpack uint color
float4 UnpackColor(uint color)
{
	uint a = color & 255;
	uint b = (color >> 8) & 255;
	uint g = (color >> 16) & 255;
	uint r = (color >> 24) & 255;

	return float4(r / 255.0, g / 255.0, b / 255.0, a);
}

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	float4 f4LocPos = float4(asfloat(IN.vPos.x),
		asfloat(IN.vPos.y),
		asfloat(IN.vPos.z), 1);

	vs_out.oPos = mul(f4LocPos, gViewProj);
	vs_out.oColor = UnpackColor(IN.vPos.w);
	return vs_out;
}

[maxvertexcount(6)]
void GS(line VS_OUT points[2], inout TriangleStream<VS_OUT> output)
{
	float4 p0 = points[0].oPos;
	float4 p1 = points[1].oPos;
	float4 oColor = float4(points[0].oColor.rgb, 1);
	float lwidth = points[0].oColor.a;

	float4 vp0 = mul(points[0].oPos, gProjInv);
	float4 vp1 = mul(points[1].oPos, gProjInv);
	vp0.xyz /= vp0.w;
	vp1.xyz /= vp1.w;
	float3 d = normalize(vp1.xyz - vp0.xyz);
	if (vp0.z < 0) {
		vp0.xyz -= d * (vp0.z / d.z + 0.01);
		p0 = mul(float4(vp0.xyz, 1), gProj);
	}
	if (vp1.z < 0) {
		vp1.xyz -= d * (vp1.z / d.z + 0.01);
		p1 = mul(float4(vp1.xyz, 1), gProj);
	}
	p0.xyz /= abs(p0.w);
	p1.xyz /= abs(p1.w);

	float2 lineScreenForward = normalize(p0.xy - p1.xy);
	float2 lineScreenRight = float2(-lineScreenForward.y, lineScreenForward.x);
	float2 lineScreenOffset = (float2(lwidth, lwidth) / targetDims) * lineScreenRight;

	VS_OUT v[4];
	v[0].oPos = float4(p0.xy + lineScreenOffset, p0.z, 1);
	v[1].oPos = float4(p0.xy - lineScreenOffset, p0.z, 1);
	v[2].oPos = float4(p1.xy - lineScreenOffset, p1.z, 1);
	v[3].oPos = float4(p1.xy + lineScreenOffset, p1.z, 1);

	v[0].oColor = v[1].oColor = v[2].oColor = v[3].oColor = oColor;

	output.Append(v[2]);
	output.Append(v[1]);
	output.Append(v[0]);

	output.RestartStrip();

	output.Append(v[3]);
	output.Append(v[2]);
	output.Append(v[0]);

	output.RestartStrip();
}

float4 ps_main(VS_OUT IN): SV_TARGET0
{
	return IN.oColor;
}

technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0, vs_main()));
#if USE_GS
		SetGeometryShader(CompileShader(gs_5_0, GS()));
#else
		SetGeometryShader(NULL);
#endif
		SetPixelShader(CompileShader(ps_5_0, ps_main()));

		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
