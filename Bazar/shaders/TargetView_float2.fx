#include "common/States11.hlsl"
#include "common/TextureSamplers.hlsl"
#include "common/AmbientCube.hlsl"

Texture2D<float2> Target;
TEXTURE_SAMPLER_CUBE(Target, MIN_MAG_MIP_POINT, BORDER, BORDER);

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
int3 dims;
int  channel;

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
	o.vTexCoord = IN.tc;

	return o;
}

float4 psSmallShitHeightMap(VS_OUTPUT input) : SV_TARGET0
{
	float2 diff = float2(0.5 / 1024.0, 0.5 / 768.0);
	float height = max(0, TEX2D(Target, input.vTexCoord + diff).r - 1000.f);
	
	float4 color;
	color.r = saturate((height)/500.f);
	color.g = saturate((height-500.f)/500.f);
	// color.b = saturate((height-1000)/500);
	
	if(height==0)
		color.b = 1;
	else 
		color.b = 0;
	
	color.a = opacity;

	return color;
}

technique10 smallShitHeightMap
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSmallShitHeightMap()));
		
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}