#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"

TextureCube cubeTexture;
float4x4 VP;
float4 color;
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

float4 PSTex(VS_OUTPUT i, uniform bool bExplicitMipLevel = false) : SV_TARGET0
{
	if(bExplicitMipLevel)
		return float4(cubeTexture.SampleLevel(ClampLinearSampler, normalize(i.wPos), mipLevel).rgb, 1);
	else
		return float4(cubeTexture.Sample(ClampLinearSampler, normalize(i.wPos)).rgb, 1);
}

float4 PSColor(VS_OUTPUT i) : SV_TARGET0
{
	return color;
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
		SetPixelShader(CompileShader(ps_4_0, PSTex(false)));
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}
	
	pass explicitMipLevel
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PSTex(true)));
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}

	pass solidColorOpaque
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PSColor()));
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}

	pass solidColorTransparent
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PSColor()));
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetRasterizerState(skyboxRS);
	}
}
