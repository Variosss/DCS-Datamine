#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/random.hlsl"
#define ATMOSPHERE_COLOR
#define PS_HALO		
#define PS_NORMAL_LIGHT
#include "ParticleSystem2/common/psCommon.hlsl"

float3 wPos;
float4 diffuseColor;
float3 scale;//scale, scaleDistFactor
float3 speed;

#define seed scale.z

Texture2D texNorm;

static const float opacityMax = 2.0;

static const float4 quad[4] = {
	float4( -0.5, -0.5, 0, 0),
	float4( -0.5,  0.5, 0, 0),
	float4(  0.5, -0.5, 0, 0),
	float4(  0.5,  0.5, 0, 0)
};

struct PS_INPUT
{
	float4 pos: SV_POSITION;
	float3 uv : TEXCOORD0;
};


PS_INPUT vsGlow(uint vertId:  SV_VertexID)
{
	PS_INPUT o;
	float rnd = frac(sin((gModelTime + 123.865132*seed)*321513.5123));
	float4 vPos = quad[vertId];

	o.pos = mul(float4(wPos,1), gView);
	float scaleFactor = 0.5*scale.x * (1 + scale.y * max(0, o.pos.z));
	o.pos += vPos * scaleFactor * (5 + rnd);
	o.pos = mul(o.pos, gProj);

	float ang = smoothNoise1(gModelTime*10+rnd*0.1)*6.2832;
	o.uv.xy = mul(vPos.xy, rotMatrix2x2(ang)) + 0.5;
	o.uv.z = opacityMax*(0.9 + 0.1*rnd);
	return o;
}


float4 psGlow(PS_INPUT i, uniform bool bClouds): SV_TARGET0
{
	float4 alpha = tex.Sample(ClampLinearSampler, i.uv.xy).rrrr;

	float4 color = diffuseColor * diffuseColor * (alpha * alpha * i.uv.z);
	color.rgb *= 0.25 + 1.75 * sqrt(max(0, gSunDir.y));

	if(bClouds)
		color.a *= getAtmosphereTransmittance(0).r;
	
	return color;
}

float luminance(float3 v){
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}


float4 psGlowFlir(PS_INPUT i, uniform bool bClouds): SV_TARGET0
{
	float4 alpha = tex.Sample(ClampLinearSampler, i.uv.xy).rrrr;

	float4 color = diffuseColor * diffuseColor * (alpha * alpha * i.uv.z);

	float l = luminance(color.rgb)*15.0;
	
	return float4(l, l, l, color.a);
}


technique10 flareGlowTech
{
	pass p0
	{
		DISABLE_CULLING;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlow(false))); 
	}
	
	pass withClouds
	{
		DISABLE_CULLING;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlow(true))); 
	}

	pass p0Flir
	{
		DISABLE_CULLING;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlowFlir(false))); 
	}
	
	pass withCloudsFlir
	{
		DISABLE_CULLING;
		ENABLE_RO_DEPTH_BUFFER;
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		
		SetVertexShader(CompileShader(vs_4_0, vsGlow()));
		SetHullShader(NULL);
		SetDomainShader(NULL);
		SetGeometryShader(NULL);
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psGlowFlir(true))); 
	}

}

