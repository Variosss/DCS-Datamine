#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"
#include "common/context.hlsl"

#ifdef USE_DCS_DEFERRED
#include "deferred/GBuffer.hlsl"
#endif

matrix WVP;
float4 Color;
float Template[32];

struct VS_INPUT
{
	float4 vPos : POSITION;
	float1 vTemplateCoord : TEXCOORD0;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float oTemplateCoord : TEXCOORD0;
    float4 wPos: TEXCOORD1;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.vPos, WVP);
	vs_out.oTemplateCoord = IN.vTemplateCoord;
    vs_out.wPos = mul(IN.vPos, WVP);
	return vs_out;
}

/*
#ifdef USE_DCS_DEFERRED
GBuffer ps_main(VS_OUT IN)
{
	return BuildGBuffer(
        IN.oPos.xy, 
#if USE_SV_SAMPLEINDEX
		0,         
#endif
        Color,
        float3(0, 1, 0), 
        float4(1, 1, 0, 1), 
        float4(0, 0, 0, 0), 
        IN.wPos, 
        false);
}
#else
*/
float4 ps_main(VS_OUT IN): SV_TARGET0
{
	float4 t = Color;
	float x = frac(IN.oTemplateCoord)*32;
	float a = Template[x];
	t.a *= a;
	return t;    
}
//#endif

technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps_main()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
