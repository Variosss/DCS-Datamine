#include "../common/constants.hlsl"
#include "functions/vt_utils.hlsl"

#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "../terrain/functions/math.hlsl"

Texture2D LightMask;

// xyz - color of light, w - distance of light.
float4 LightProperties;
float4x4 ProjViewPosMatrix;
float4x4 PosMatrix;
float3 SpotLightSize;

float4x4 LightProjViewPosMatrix;
float3 LightPos;

static const float LIGHT_ATT = 0.3;

// Vertex shader o structure
struct VS_OUTPUT
{
	float4 Position		: SV_POSITION0;		// vertex position in projection space
	float2 uv		: TEXCOORD0;	// texture coordinates
	float4 wPos		: TEXCOORD1;
	float4 lightPos		: TEXCOORD2;
};

// Pixel shader o structure
struct PS_OUTPUT
{
	float4 RGBColor : SV_TARGET0;  // Pixel color	
};

VS_OUTPUT omni2texture_vs(float2 pos : POSITION0, float2 uv : TEXCOORD0)
{
	VS_OUTPUT o;

	o.Position = mul(float4(pos.x * LightProperties.w, 0.0, pos.y * LightProperties.w, 1.0), ProjViewPosMatrix);

	o.uv = uv;

	return o;
}

PS_OUTPUT omni2texture_ps(VS_OUTPUT input)
{
	PS_OUTPUT o;

	o.RGBColor = float4(LightProperties.rgb, LightMask.Sample(ClampLinearSampler, input.uv).a);
	return o;
}

VS_OUTPUT spot2texture_vs(float2 pos : POSITION0, float2 uv : TEXCOORD0)
{
	VS_OUTPUT o;
	
	float x = pos.x * lerp(SpotLightSize.x, SpotLightSize.y, pos.y);
	float y = pos.y * SpotLightSize.z;

	o.wPos =  mul(float4(x, 0.0, y, 1.0), PosMatrix);
	o.Position = mul(float4(x, 0.0, y, 1.0), ProjViewPosMatrix);
	o.lightPos = mul(float4(x, 0.0, y, 1.0), LightProjViewPosMatrix);
	o.uv = uv;
	return o;
}

PS_OUTPUT spot2texture_ps(VS_OUTPUT input)
{
	PS_OUTPUT o;

	float d = distance(LightPos.xyz, input.wPos.xyz);

	if(d > LightProperties.w) discard;

	float att = saturate(1.0 - max(0.0, (d - LightProperties.w * LIGHT_ATT) / (LightProperties.w * (1.0 - LIGHT_ATT))));
	
	float2 uv = clamp(input.lightPos.xy / input.lightPos.w, -1.0, 1.0);
	uv = NDCtoUV(uv);

	float4 res = TEX2D(LightMask, uv);
	o.RGBColor = float4(LightProperties.rgb, res.a * att);
//	o.RGBColor = float4(input.uv,0,1);
	return o;
}

TECHNIQUE omni
{
	pass P0
	{
		DISABLE_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		VERTEX_SHADER(omni2texture_vs())
		PIXEL_SHADER(omni2texture_ps())
		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE spot
{
	pass P0
	{
		DISABLE_CULLING;

		ADDITIVE_ALPHA_BLEND;

		ENABLE_RO_DEPTH_BUFFER;

		VERTEX_SHADER(spot2texture_vs())
		PIXEL_SHADER(spot2texture_ps())
		GEOMETRY_SHADER_PLUG
	}
}
