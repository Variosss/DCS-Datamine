#include "common/samplers11.hlsl"
#include "common/states11.hlsl"

Texture2D s;

float4x4 matWorldViewProj;
float4x4 matWorld;

float gamma;

struct VertexInput{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct VertexOutput{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

VertexOutput vsSimple(const VertexInput i)
{
	VertexOutput o;

	o.vPosition = mul(float4(i.vPosition, 1.0), matWorldViewProj);	
	o.vTexCoord0 = float3(i.vTexCoord0.xy, i.vPosition.x);
	
	return o;
}

float4 gp(const VertexOutput i)
{
	float4 pxc = s.Sample(WrapLinearSampler, i.vTexCoord0);
	
	pxc.rgb = pow(pxc.rgb, gamma);
	
	return pxc;
}

float4 ps1(const VertexOutput i): SV_TARGET0
{
	float4 pxc = gp(i);
	
	return pxc;
}

technique10 T0
{	
    pass P0
    {
		SetVertexShader(CompileShader(vs_4_0, vsSimple()));
		SetPixelShader(CompileShader(ps_4_0, ps1()));
		SetGeometryShader(NULL);
		SetRasterizerState(cullNone);
    }
}
