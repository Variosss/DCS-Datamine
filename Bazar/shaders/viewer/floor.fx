#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/shadingCommon.hlsl"
#include "common/lightsCommon.hlsl"
#include "deferred/shading.hlsl"

float3		color;
float3		worldOffset;
uint		lightsCount;
float4x4	World;

struct OmniLight
{
	float4	pos;//xyz - pos, w - radius
	float4	diffuse;// w - intensity
};

cbuffer cbLights
{
	OmniLight omnis_[8];
};

struct VS_OUTPUT
{
	float4 pos		: SV_POSITION0;
	float3 wPos		: TEXCOORD0;
	float3 normal	: TEXCOORD1;
};

VS_OUTPUT VS(uint vid : SV_VertexID)
{
	static const float2 quad[4] =
	{
		{ -1, -1 },{ 1, -1 },
		{ -1,  1 },{ 1,  1 }
	};

	VS_OUTPUT o;
	o.pos = float4(quad[vid].x, 0, quad[vid].y, 1);
	o.pos = mul(o.pos, World);
	o.pos.xyz += worldOffset;
	o.wPos = o.pos.xyz;
	o.pos = mul(o.pos, gViewProj);
	o.normal = normalize(mul(float3(0,1,0), (float3x3)World));
	return o;
}

float3 PS(VS_OUTPUT i): SV_TARGET0
{
	float3 diffuseColor = color;
	float3 specularColor = 0.04;
	float roughness = 0.9;
	float metallic = 0;
	float AO = 1;
	float shadow = 1.0;
	float cloudShadowAO = 1.0;

	float3 viewDir = normalize(gCameraPos - i.wPos.xyz);
	float3 lightColor = gSunDiffuse;

	float3 finalColor = ShadeSolid(i.wPos,	lightColor, diffuseColor, specularColor, i.normal, roughness, metallic, shadow, AO, cloudShadowAO, viewDir);

	float3 lightPos = float3(0,5,0) - gOrigin;
	[loop]
	for(uint ii=0; ii<lightsCount; ++ii)
		finalColor += calcOmni(diffuseColor, specularColor, roughness, i.normal, viewDir, i.wPos, omnis_[ii].pos, omnis_[ii].diffuse, 
			/*energyLobe*/float2(1.0, 1.0), /*translucency=*/0.0, /*specularAmount=*/0.0, /*useSpecular*/false);

	return  finalColor;
}

technique10 tech
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0, VS()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, PS()));

		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetRasterizerState(cullBack);
	}
}
