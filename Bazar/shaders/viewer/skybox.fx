#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"

TextureCube cubeTexture;
float4x4 VP;

float mipLevel;// = 1.5;

struct VS_OUTPUT
{
	float4	pos: SV_POSITION0;
	float3	wPos: TEXCOORD0;
};

VS_OUTPUT VS(float3 pos: POSITION0)
{
	VS_OUTPUT o;
	o.wPos = pos;
	o.pos.xyz = mul(pos, (float3x3)gView).xyz;
	o.pos.w = 1;
	o.pos = mul(float4(o.pos), gProj);
	return o;
}

float4 PS(VS_OUTPUT i, uniform bool bExplicitMipLevel = false) : SV_TARGET0
{
	if(bExplicitMipLevel)
		return float4(cubeTexture.SampleLevel(ClampLinearSampler, normalize(i.wPos), mipLevel).rgb, 1);
	else
		return float4(cubeTexture.Sample(ClampLinearSampler, normalize(i.wPos)).rgb, 1);
}

RasterizerState skyboxRS
{
	CullMode = None;
	MultisampleEnable = false;
	DepthClipEnable = false;
};

technique10 skybox
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(false)));
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}
	
	pass explicitMipLevel
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS(true)));
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}
}
