#include "common/shadingCommon.hlsl"
#include "deferred/shadows.hlsl"


Texture2D		TextureMap;
float4			BlendColor;

struct vsIn
{
	float3 vPosition:	POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

struct vsOutput
{
	float4 vPosition:	SV_POSITION0;
	float2 vTexCoord0:	TEXCOORD0;
};

vsOutput vsSimple(in const vsIn i)
{
	vsOutput o;
	o.vPosition  = mul(float4(i.vPosition.xyz, 1.0), matWorldViewProj);
	o.vTexCoord0 = i.vTexCoord0;
	return o;
}

float4 psTex(in vsOutput i): SV_TARGET0
{
	float4 tex   =  TextureMap.Sample(WrapSampler,i.vTexCoord0);
	float3 color =  tex.rgb * BlendColor.rgb;
	float alpha  =  tex.a * BlendColor.a;
	return float4(color, alpha);
}


VertexShader vsComp		 = CompileShader(vs_4_0, vsSimple());

technique10 tech {
	pass main {
		SetVertexShader(vsComp);
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psTex()));
		SetRasterizerState(cullNone);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
	}
}

