#ifdef EDGE
#include "..\..\lockonshaders\common\samplers11.hlsl"
#include "..\..\lockonshaders\common\TextureSamplers.hlsl"
#else
#include "..\common\States11.hlsl"
#include "..\common\samplers11.hlsl"
#endif

Texture2D FontTexture;
float4 color;

struct VS_INPUT
{
	float4 vPos  : POSITION0;
	float2 vTexPos : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 oPos  : SV_POSITION;
	float2 oTex0 : TEXCOORD0;
};

VS_OUTPUT VerText(VS_INPUT vsInput)
{
	VS_OUTPUT vsOutput;
	vsOutput.oPos = vsInput.vPos;
	vsOutput.oPos.z = 0.5;
	vsOutput.oPos.w = 0.5;
	vsOutput.oTex0 = vsInput.vTexPos;
	return vsOutput;
}

float4 PixOut(VS_OUTPUT psInput) : SV_TARGET0
{
//return float4(1, 1, 1, 1);
 	float4 t = FontTexture.Sample(WrapLinearSampler, psInput.oTex0);
 	t.xyz *= color;
	return t;
}

#ifdef DIRECTX11
BlendState enableAlphaBlend2
{
	BlendEnable[0] = TRUE;
	SrcBlend = SRC_ALPHA;
	DestBlend = INV_SRC_ALPHA;
	BlendOp = ADD;
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
	RenderTargetWriteMask[0] = 0x0F;
};
technique10 T0
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VerText()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PixOut()));
		SetBlendState(enableAlphaBlend2, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else
technique T0
{
	pass P0
	{
	AlphaBlendEnable = True;
	SrcBlend    = SRCALPHA;
	DestBlend   = INVSRCALPHA;
	AlphaTestEnable = True;
	AlphaRef =0;
	ZEnable = False;
	StencilEnable = False;

	texture[0]   = < FontTexture >;

		VertexShader = compile vs_3_0 VerText(); 	
//    	PixelShader = compile ps_3_0 PixOut();
		PixelShader = compile ps_3_0 PixOut();
	}
 }
#endif
