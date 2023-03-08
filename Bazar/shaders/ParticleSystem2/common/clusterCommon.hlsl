#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/shadowStates.hlsl"
#include "common/context.hlsl"
#include "common/ambientCube.hlsl"

#define ATMOSPHERE_COLOR
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

#ifndef PARTICLES_IN_CLUSTER //для прекомпиляции
	#define PARTICLES_IN_CLUSTER 1
#endif

//-------------------------------------------------------------------------------------
#if PARTICLES_IN_CLUSTER > 1
cbuffer cbClusterParticles
{
	float4	particlePos[PARTICLES_IN_CLUSTER];//xyz - pos, w - rnd
	uint4	indices[PARTICLES_IN_CLUSTER*8/4];
}

static uint particleIndices[PARTICLES_IN_CLUSTER*8] = (uint[PARTICLES_IN_CLUSTER*8])indices; // 8 octants

//pos - относительно origin камеры
uint getNearestOctant(in float3 pos)
{
	float3 view = pos-gCameraPos.xyz;
	return (view[0] < 0) | ((view[1] < 0) << 1) | ((view[2] < 0) << 2);
}

//pos - относительно origin камеры для повернутого базиса
uint getNearestOctant(in float3 pos, in float3x3 basis)
{
	// float3 view = mul(pos-gCameraPos.xyz, basis);
	float3 view = mul(basis, pos-gCameraPos.xyz);
	return (view[0] < 0) | ((view[1] < 0) << 1) | ((view[2] < 0) << 2);
}

uint getParticleSortedIndex(uint octantId, float particlesCount, float t)
{
	// TODO: сравнить быстродействие
	// int id = octantId*particlesCount + t*(particlesCount-1.0)+0.5;
	// return indices[id/4][id%4];
	return particleIndices[octantId * particlesCount + t * (particlesCount-1.0) + 0.5];
}
#endif

//-------------------------------------------------------------------------------------

#ifndef CLUSTER_CUSTOM_VS_NAME
	#ifdef USE_VERTEX_BUFFER
		struct VS_INPUT{
			float4	posRadius:			POSITION0;
			float4	sizeLifeOpacityRnd:	TEXCOORD0;
			float3	clusterLight:		TEXCOORD1;
		};
	#else
		#ifndef CLUSTER_STRUCT
			#define CLUSTER_STRUCT ClusterParticleStruct
		#endif
		struct CLUSTER_STRUCT
		{
			float4	posRadius;
			float4	sizeLifeOpacityRnd;
			float3	clusterLight;
			float 	ang;
			float4	reserved;

		#ifndef CLUSTER_NO_LOCAL_MATRIX
			float3x3	mLocalToWorld;
		#endif
		#ifndef CLUSTER_NO_WORLD_MATRIX //можно не таскать mLocalToWorld если в кластере всегда только 1 партикл
			float3x3	mToWorld;
		#endif
		};
		StructuredBuffer<CLUSTER_STRUCT>	sbParticles;
		StructuredBuffer<uint>				sbSortedIndices;
	#endif
#endif

struct VS_OUTPUT {
	float4 posRadius:			POSITION0;
	float4 sizeLifeOpacityRnd:	TEXCOORD0;
	float3 clusterLight: 		TEXCOORD1;
	uint   vertId:				TEXCOORD2;
#ifdef CLUSTER_WORLD_NORMAL
	float3 worldNormal:			TEXCOORD3;
#endif
};

#if PARTICLES_IN_CLUSTER>1
struct HS_CONST_OUTPUT {
	float edges[2]:				SV_TessFactor;
	uint  octantId:				TEXCOORD5;
};

struct HS_OUTPUT {
	float4 posRadius: 			POSITION0;
	float4 sizeLifeOpacityRnd:	TEXCOORD0;
	float3 clusterLight: 		TEXCOORD1;
	uint   vertId: 				TEXCOORD2;
#ifdef CLUSTER_WORLD_NORMAL
	float3 worldNormal:			TEXCOORD3;
#endif
};
#else
#define HS_OUTPUT VS_OUTPUT
#endif

struct GS_OUTPUT {
	float4 pos:					SV_POSITION0;
#ifdef SOFT_PARTICLES
	float4 projPos:				TEXCOORD0;
#endif	
	float4 params:				TEXCOORD1;// UV, detail UV
	nointerpolation float4 clusterLight: TEXCOORD2;
	nointerpolation float4 sunDirM: NORMAL0;
	float params2:              TEXCOORD3;
};

struct GS_SHADOW_OUTPUT {
	float4 pos:			SV_POSITION0;
	float3 params:		TEXCOORD0;
	float4 projPos: 	TEXCOORD1;
};
