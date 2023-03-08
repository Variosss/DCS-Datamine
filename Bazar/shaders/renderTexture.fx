#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

// shader can define custom SAMPLER_FILTER
#ifndef SAMPLER_FILTER
#define SAMPLER_FILTER MIN_MAG_MIP_LINEAR
#endif
Texture2D Texture;
TEXTURE_SAMPLER(Texture, SAMPLER_FILTER, CLAMP, CLAMP);

matrix WVP;
matrix UVrotation;
float fRotate;
float4 f4Color;

struct VS_INPUT
{
	float4 vPos : POSITION;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float2 oTex0 : TEXCOORD0;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
		
	vs_out.oPos = mul(IN.vPos, WVP);
	
	// rotate UV
	float4 UV = float4(IN.vPos.xy, 0, 0);
	UV-=float4(0.5, 0.5, 0, 0);
	UV = mul(UV, UVrotation); 
	UV+=float4(0.5, 0.5, 0, 0);
	
	// UV
	vs_out.oTex0 = UV.xy;
	vs_out.oTex0.y = vs_out.oTex0.y;
	return vs_out;
}

float4 ps_main(VS_OUT IN, uniform bool bAlpha) : SV_TARGET0
{
	float4 t = TEX2D(Texture, IN.oTex0)*f4Color;
	if( !bAlpha)
		t.a = 1;
	return t;
}

#ifdef DIRECTX11
technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main(true)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
technique10 StandartOneA
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main(false)));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else
technique Standart
{
	pass P0
	{
		AlphaBlendEnable = True;
		SrcBlend    = SRCALPHA;
		DestBlend   = INVSRCALPHA;
		AlphaTestEnable =  false;
		ZEnable = False;
		StencilEnable = False;
		CULLMODE = NONE;

		VertexShader = compile vs_3_0 vs_main(); 	
		PixelShader = compile ps_3_0 ps_main(true);
	}
}

#endif
