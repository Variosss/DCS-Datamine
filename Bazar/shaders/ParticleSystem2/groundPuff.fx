float  effectParams;
float3 smokeColor;
float4 effectParams2;//emitter time, phase, wind.xy
#define EMITTER_TIME_NORM       effectParams2.x

#ifdef PUFF_SOFT_PARTICLES
	#define SOFT_PARTICLES		effectParams.x
#endif
#include "ParticleSystem2/common/clusterCommon.hlsl"

// #define CLUSTER_COLOR dbg.xyz
#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_DETAIL_SPEED	0.02
#define CLUSTER_DETAIL_TILE		0.2
#define ANIMATION_SPEED			20
#include "ParticleSystem2/common/clusterShading.hlsl"
