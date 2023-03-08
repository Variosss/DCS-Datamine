#include "common/TextureSamplers.hlsl"
#include "common/States11.hlsl"

matrix WVP;
float4 Color;

struct VS_INPUT
{
	float4 vPos : POSITION;
};

struct VS_OUT
{
	float4 oPos : SV_POSITION;
};

VS_OUT vs_main(VS_INPUT IN)
{
	VS_OUT vs_out;
	vs_out.oPos = mul(IN.vPos, WVP);
	return vs_out;
}

float4 ps_main(VS_OUT IN) : SV_TARGET0
{
	float4 t = Color;
	return t;
}

#ifdef DIRECTX11
technique10 Standart
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vs_main()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, ps_main()));
		
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullNone);
	}
}
#else
technique Standart
{
	pass P0
	{
		AlphaBlendEnable = False;
		SrcBlend    = SRCALPHA;
		DestBlend   = INVSRCALPHA;
		AlphaTestEnable =  false;
		ZEnable = False;
		StencilEnable = False;
		CULLMODE = NONE;

		VertexShader = compile vs_3_0 vs_main(); 	
		PixelShader = compile ps_3_0 ps_main();
	}
}
#endif
