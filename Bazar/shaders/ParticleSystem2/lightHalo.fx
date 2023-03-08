#include "common/States11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/AmbientCube.hlsl"
#include "common/softParticles.hlsl"
#include "ParticleEffects/SoftParticles.hlsl"

#define NO_DEFAULT_UNIFORMS
#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"

Texture2D	haloIntensityTex;

float4		worldOffset;
float3		lightDir;
float4		color;
float4		params0;

#define		particleSize	params0.x
#define		innerCos		params0.y
#define		outerCos		params0.z

static const float minSizeInPixels = 4;

struct GS_INPUT {};

struct PS_INPUT
{
	float4 pos							: SV_POSITION0;
	float2 uv							: TEXCOORD0;
	nointerpolation float3 worldPos		: TEXCOORD1;
	nointerpolation float sizeInPixels	: TEXCOORD2;
	nointerpolation float intensity		: TEXCOORD3;
};

void vsDummy() {}

//modified copy from fake_lights_common.hlsl
float3 calculate_position(in float3 vPos, inout float2 size, float minSizeInPixels, out float sizeInPixels)
{
	//move billboard towards the viewer to prevent culling by nearby geometry
	float shiftToCamera = size.x*0.5;
	const float dist = length(vPos) * gZoom;
	vPos *= (1 + shiftToCamera / dist);

	//diagonal corners in screen space
	float3 p = vPos;
	float4 p1 = mul_v3xm44(float3(p.x - size.x, p.y - size.y, p.z), gProj); p1 /= p1.w;
	float4 p2 = mul_v3xm44(float3(p.x + size.x, p.y + size.y, p.z), gProj); p2 /= p2.w;
	float3 center = (p1.xyz + p2.xyz) * 0.5;

	size = (p2.xy - p1.xy) * 0.5;
	sizeInPixels = size.y * 1200.0 * 0.5;

	if(sizeInPixels < minSizeInPixels)
	{
		size *= minSizeInPixels / sizeInPixels;
		sizeInPixels = minSizeInPixels;
	}
	return center;
}

//copy from Lights51Common.hlsl
float SamplePrecomputedSingleScatteringIntensity(float pixelsInHalo, float dist)
{
	const float pixelsInHaloMin = 1.0 / 1; 	//baked in haloIntensityTex
	const float pixelsInHaloMax = 1024;		//baked in haloIntensityTex

	float sampleRadius = 0.5 / pixelsInHalo;//relative to flare radius
	float distMax = 1.0 + sampleRadius;

	// float v = sqrt((pixelsInHalo - pixelsInHaloMin) / (pixelsInHaloMax - pixelsInHaloMin));
	// float u = sqrt(dist / distMax);
	float v = pow(saturate((pixelsInHalo - pixelsInHaloMin) / (pixelsInHaloMax - pixelsInHaloMin)), 1.0/3);
	float u = pow(dist / distMax, 1.0/3);

	float intensity = haloIntensityTex.SampleLevel(gBilinearClampSampler, float2(u, v), 0).r;
	return (intensity*intensity) * (intensity*intensity);
}

[maxvertexcount(4)]
void gsHalo(point GS_INPUT i[1], inout TriangleStream<PS_INPUT> outputStream)
{
	float2 size = particleSize;
	float3 posW = worldOffset.xyz;
	float VoL = dot(normalize(gCameraPos.xyz - posW), lightDir);	
	float transmittance = getAtmosphereTransmittance(0).r;

	PS_INPUT o;
	float3 screenPos = calculate_position(mul_v3xm44(posW, gView).xyz, size, minSizeInPixels, o.sizeInPixels);
	o.worldPos = posW;
	o.intensity = color.a * saturate((VoL - outerCos) / (innerCos - outerCos)) * transmittance;//can be optimized

	[unroll]
	for (int ii = 0; ii < 4; ++ii)
	{
		o.pos = float4(screenPos, 1);
		o.pos.xy += staticVertexData[ii].xy * size;
		o.uv.xy = staticVertexData[ii].zw;
		outputStream.Append(o);
	}
	outputStream.RestartStrip();
}

float4 psHalo(PS_INPUT i): SV_TARGET0
{
	float dist = saturate(2.0 * distance(i.uv.xy, 0.5));
	return float4(color.rgb, SamplePrecomputedSingleScatteringIntensity(i.sizeInPixels, dist) * i.intensity);
}

float luminance(float3 v)
{
	return 0.3*v.x + 0.59*v.y + 0.11*v.z;
}

float4 psHaloFlir(PS_INPUT i): SV_TARGET0
{
}

technique10 tech
{	
	pass haloVisible
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetGeometryShader(CompileShader(gs_4_0, gsHalo()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHalo()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}

	pass haloFLIR
	{
		SetVertexShader(CompileShader(vs_4_0, vsDummy()));
		SetGeometryShader(CompileShader(gs_4_0, gsHalo()));
		SetComputeShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psHalo()));
		
		SetDepthStencilState(enableDepthBufferNoWrite, 0);
		SetBlendState(additiveAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}
