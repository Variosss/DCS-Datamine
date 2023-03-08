#include "common/States11.hlsl"
#include "common/TextureSamplers.hlsl"

Texture2DArray TargetArray;
TEXTURE_SAMPLER(TargetArray, MIN_MAG_MIP_POINT, BORDER, BORDER);

float4x4 ViewProjectionMatrix;
float opacity;
float zoominv;
float textureArrayIndex;

int3 dims;
int  channel;

struct VS_OUTPUT
{
	float4 vPosition		: SV_POSITION;
	float2 vTexCoord		: TEXCOORD0;
};

VS_OUTPUT vsMain(float3 pos : POSITION0, float2 tc : TEXCOORD0)
{
	VS_OUTPUT o;

	o.vPosition = mul(float4(pos,1.0), ViewProjectionMatrix);
	o.vTexCoord = (tc-float2(0.5, 0.5))*zoominv + float2(0.5, 0.5);

	return o;
}

float4 psSolidTechTextureArray(VS_OUTPUT input) : SV_TARGET0
{
	int Width, Height, Elements;
	TargetArray.GetDimensions(Width, Height, Elements);
	float4 color = TargetArray.Sample(TargetArraySampler, float3(input.vTexCoord, floor(textureArrayIndex)));
	color.a = opacity;

	color.g = step(floor(12.75f * color.r), textureArrayIndex);
	color.r = 1.0f - color.g;
	color.b = 0.0f;

	if( textureArrayIndex>=Elements)
		return float4(0, 0, 0, 0);
	return color;
}

technique10 solidTextureArray
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, vsMain()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psSolidTechTextureArray()));

		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
		SetDepthStencilState(disableDepthBuffer, 0);
	}
}
