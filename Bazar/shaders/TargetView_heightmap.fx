#include "common/States11.hlsl"
#include "common/TextureSamplers.hlsl"

Texture2D Target;

TEXTURE_SAMPLER(Target, MIN_MAG_MIP_POINT, BORDER, BORDER);

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
int3 dims;
int  channel;
float value_pow;

struct VS_INPUT
{
	float4 pos : POSITION;
	float2 tc  : TEXCOORD0;
};


struct VS_OUTPUT
{
	float4 vPosition : SV_POSITION;
	float2 vTexCoord : TEXCOORD0;
};

VS_OUTPUT vsMain(VS_INPUT IN)
{
	VS_OUTPUT o;

	o.vPosition = mul(float4(IN.pos.xyz,1.0), ViewProjectionMatrix);
	o.vTexCoord = (IN.tc-float2(0.5, 0.5))*zoominv + float2(0.5, 0.5);

	return o;
}

float4 psHeightTech(VS_OUTPUT input) : SV_TARGET0
{
	float4 targetcolor = float4(TEX2D(Target, input.vTexCoord).rgb, opacity);
	if(targetcolor.r<=0)
		return float4(0, 0, 0, opacity);
	float height = targetcolor.r-1000;

	float factor1 = frac( height/20.0f);
	if(factor1>0.5) factor1 = 1-factor1;
	factor1 *= 2;

	float factor2 = frac( height/1000.0f);
	if(factor2>0.5) factor2 = 1-factor2;
	factor2 *= 2;

	float3 color = float3( factor1, 1, factor2);

	return float4(color, opacity);
}
static const float M_PI = 3.1452;
float4 psSurfaceTypeTech(VS_OUTPUT input) : SV_TARGET0
{
	float4 targetcolor = float4(TEX2D(Target, input.vTexCoord).rgb, opacity);
	float type = targetcolor.g;
	if(type<0)
		return float4(0, 0, 0, opacity);

	float3 color = float3(
		sin(2*M_PI*type/3),
		sin(2*M_PI*(type+1)/5),
		sin(2*M_PI*(type+2)/7)
		);
	color = (color*0.4)+0.6;

	return float4(color, opacity);
}


#ifdef DIRECTX11
technique10 solid
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHeightTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
technique10 height
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHeightTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
technique10 surfacetype
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSurfaceTypeTech()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
#else
technique solid
{
	pass P0
	{
		CullMode = None;
		AlphaBlendEnable = 0x1;
		AlphaTestEnable = 0x1;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;
		
		VertexShader = compile vs_3_0 vsMain();
		PixelShader  = compile ps_3_0 psHeightTech();
	}
}
technique height
{
	pass P0
	{
		CullMode = None;
		AlphaBlendEnable = 0x1;
		AlphaTestEnable = 0x1;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;
		
		VertexShader = compile vs_3_0 vsMain();
		PixelShader  = compile ps_3_0 psHeightTech();
	}
}
technique surfacetype
{
	pass P0
	{
		CullMode = None;
		AlphaBlendEnable = 0x1;
		AlphaTestEnable = 0x1;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;
		
		VertexShader = compile vs_3_0 vsMain();
		PixelShader  = compile ps_3_0 psSurfaceTypeTech();
	}
}
#endif
