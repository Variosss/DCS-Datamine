#include "common/context.hlsl"
#include "ParticleSystem2/common/clusterFuncs.hlsl"
#include "ParticleSystem2/common/basis.hlsl"

#ifndef THREAD_X
	#define THREAD_X 1
#endif

#ifndef THREAD_Y
	#define THREAD_Y 1
#endif

#define GROUP_THREADS (THREAD_X * THREAD_Y)

struct PuffCluster
{
	float4		posRadius;
	float4		sizeLifeOpacityRnd;
	float3		clusterLightAge;
	float		ang;

	float4		reserved;

#ifndef CLUSTER_NO_LOCAL_MATRIX
	float3x3	mLocalToWorld;
#endif
#ifndef CLUSTER_NO_WORLD_MATRIX //можно не таскать mLocalToWorld если в кластере всегда только 1 партикл
	float3x3	mToWorld;
#endif
};

struct FFXCluster
{
	float4		posRadius;
	float4		sizeLifeOpacityRnd;
	float3		clusterLightTemp;
	uint		chunkId;
	float3x3	mToWorld;
};

struct SplineChunk
{
	uint		nextChunkId;
	float		start;
	float		end;
	float4		p0; //pos, opacity
	float4		p1; //pos, opacity
	float4		p2; //pos, opacity
	float4		p3; //pos, opacity

#ifdef USE_AXIS
	float4		axis0;
	float4		axis1;
	float4		axis2;
	float4		axis3;
#endif

	float4		temp;
};