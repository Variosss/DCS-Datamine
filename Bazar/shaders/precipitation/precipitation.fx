#ifndef _PRECIPITATION_HLSL
#define _PRECIPITATION_HLSL

#define SOFT_MIST
//#define PRECIPITATION_TILED_LIGHTING 1

#include "common/AmbientCube.hlsl"
#include "common/samplers11.hlsl"
#include "common/stencil.hlsl"
#if (PRECIPITATION_TILED_LIGHTING)
#include "common/lighting.hlsl"
#endif
#include "enlight/materialParams.hlsl"
#include "precipitation_inc.hlsl"
// #include "enlight/shadows.hlsl"

#ifdef SOFT_MIST
	#include "common/softParticles.hlsl"
#endif


Texture2D particleTex;
Texture2D mistTex;

StructuredBuffer<Vert>	 particles;
StructuredBuffer<float3> cellInstance;

#if !(PRECIPITATION_TILED_LIGHTING)
struct SpotLightInfo2
{
	float4 pos;
	float4 dir;//xyz
	float4 angles;//xy
	float4 diffuse;
};

cbuffer cSpotsLocal
{
	SpotLightInfo2 spotsLocal[8];
}
#include "rain_lighting.hlsl"
#endif


struct VS_OUTPUT
{
	float4 pos: POSITION0;
	uint   vertId: TEXCOORD0;
};

struct PS_INPUT
{
	float4	pos:	SV_POSITION0;
	float4  params: TEXCOORD0;
	float4	wPos:	TEXCOORD2;
#ifdef SOFT_MIST
	float4	projPos:TEXCOORD3;
#endif
	float	shadow: TEXCOORD4;
#if (PRECIPITATION_TILED_LIGHTING)
	float3x3 billboardToWorld : TEXCOORD5;
#endif
};

struct PS_INPUT_RAIN
{
	float4	pos: SV_POSITION0;
	float4  params: TEXCOORD0; //UV
	nointerpolation float4 wPos: TEXCOORD1;
	nointerpolation float3 sunDirM: NORMAL0;
#if (PRECIPITATION_TILED_LIGHTING)
	float3x3 billboardToWorld : TEXCOORD2;
#endif
	//nointerpolation float randomSeed : TEXCOORD5;
};

float SampleCloudsDensity(float3 pos, bool bSnow = false)
{
	float3 uvw = pos * gCloudVolumeScale + gCloudVolumeOffset;
	float2 s = cloudsDensityMap.SampleLevel(gBilinearClampSampler, uvw.xzy, 0).xy;

	const float densityMin = 0.0;
	const float densityMax = 0.1;

// #if SQUARED_DENSITY
	s.y *= s.y;
	s.y = smoothstep(densityMin, densityMax, s.y);
// #endif

	float densityGrad = s.x * 2 - 1;
	float shapeSignal = saturate(densityGrad * 3 + 0.1);

	float altMin = rainCloudsAltitudeMin - 300;
	float altMax = bSnow? (altMin + 0.3*(rainCloudsAltitudeMax - altMin)) : rainCloudsAltitudeMax;

	float rainCloudGrad = 1 - saturate((pos.y + gOrigin.y - altMin) / (altMax - altMin));

	float density = (1-exp(-shapeSignal * s.y * 6000)) * rainCloudGrad * rainCloudGrad * rainCloudGrad;

	return density;
}

static const float refractionFactor = 1.0/1.4;

float3 refractVector(float3 I, float3 N, float eta) 
{
	float NdotI = dot(N, I);
	float k = 1.0 - eta * eta * (1.0 - NdotI * NdotI);
	return eta * I - (eta * NdotI + sqrt(k)) * N;
}

//xy - dir, z - length
float3 getScreenDirLength(float4 vPos, float3 velocity)
{
	float4 p1 = mul(vPos, gProj);
	float4 p2 = mul(float4(vPos.xyz + normalize(velocity), 1), gProj);
	p1 /= p1.w;
	p2 /= p2.w;

	float4 dir = float4(p2.xy-p1.xy, p1.z, 1);
	dir.x *= gProj._22 / gProj._11; //aspect
	// dir = mul(dir, gProjInv); dir.xyz /= dir.w;
	dir.z = length(dir.xy);	
	dir.xy /= dir.z;
	return dir.xyz;
}

VS_OUTPUT vsCell(uint vertId: SV_VertexID, uint instanceId: SV_InstanceID)
{
	VS_OUTPUT o;
	o.vertId = vertId;
	o.pos = particles[vertId].pos;
	o.pos.xyz += cellInstance[instanceId].xyz + origin.xyz;
	return o;
}

VS_OUTPUT vsCellMist(uint vertId: SV_VertexID, uint instanceId: SV_InstanceID)
{
	VS_OUTPUT o;
	o.vertId = vertId;
	o.pos = particles[vertId+mistParticlesOffset].pos;
	// o.pos = particles[vertId].pos;
	o.pos.xyz += cellInstance[instanceId].xyz + originMist.xyz;
	return o;
}

#include "rain.hlsl"
#include "snow.hlsl"
#include "mist.hlsl"

VertexShader	vsComp     = CompileShader(vs_5_0, vsCell());
VertexShader	vsMistComp = CompileShader(vs_5_0, vsCellMist());
// GeometryShader	gsMistComp = CompileShader(gs_5_0, gsMist());

#define PASS_BODY(vs, gs, ps) { SetComputeShader(NULL); SetVertexShader(vs); SetGeometryShader(gs); SetPixelShader(CompileShader(ps_5_0, ps)); \
	ENABLE_DEPTH_BUFFER_NO_WRITE_CLIP_COCKPIT; \
	SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF); \
	SetRasterizerState(cullNone);}

technique10 rainTech
{
	pass mistV				PASS_BODY(vsMistComp, CompileShader(gs_5_0, gsMist()), psMistRain())	
	pass mistWithLightingV	PASS_BODY(vsMistComp, CompileShader(gs_5_0, gsMist()), psMistRain(true))
	pass rainV				PASS_BODY(vsComp, CompileShader(gs_5_0, gsRain()), psRain())	
	pass rainWithLightingV	PASS_BODY(vsComp, CompileShader(gs_5_0, gsRain()), psRain(true))
}

technique10 snowTech
{
	pass mistV				PASS_BODY(vsMistComp, CompileShader(gs_5_0, gsMist()), psMistSnow())
	pass mistWithLightingV	PASS_BODY(vsMistComp, CompileShader(gs_5_0, gsMist()), psMistSnow(true))
	pass snowV				PASS_BODY(vsComp, CompileShader(gs_5_0, gsSnow()), psSnow())
	pass snowWithLightingV	PASS_BODY(vsComp, CompileShader(gs_5_0, gsSnow()), psSnow(true))
}

#endif