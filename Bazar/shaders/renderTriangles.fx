#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

#ifdef USE_DCS_DEFERRED
#include "deferred/GBuffer.hlsl"
#endif

TEXTURE_SAMPLER(tex, MIN_MAG_MIP_LINEAR, WRAP, WRAP);

float4x4 WVP;
float4 Color;
Texture2D tex;

struct VS_INPUT
{
	float4 vPos : POSITION;
	float4 vTex0 : TEXCOORD0;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
	float4 oTex0 : TEXCOORD0;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.vPos, WVP);
	vs_out.oTex0 = IN.vTex0;
	return vs_out;
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{
	return Color;
}

float4 ps_main_textured(VS_OUT IN) : SV_TARGET0
{
	float4   t = TEX2D(tex, IN.oTex0.xy);
	float    a = t.a * Color.a;
	float3 res = Color.rgb * t.rgb;
	return float4(res,a);
}

technique10 Standart
{
	pass opaque
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
	
	pass transparent
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}

technique10 StandartWareframe
{
	pass opaque
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));

		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(wireframe);
	}

	pass transparent
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(wireframe);
	}
}

technique10 Textured
{
	pass opaque
	{
		SetVertexShader(CompileShader(vs_5_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps_main_textured()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}

	pass transparent
	{
		SetVertexShader(CompileShader(vs_5_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_5_0, ps_main_textured()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(cullNone);
	}
}
