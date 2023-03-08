#define CLUSTER_NO_LOCAL_MATRIX
#define CLUSTER_NO_WORLD_MATRIX
#define PARTICLES_IN_CLUSTER	1
#define SOFT_PARTICLES			(1/5.0)
#include "ParticleSystem2/common/clusterCommon.hlsl"

float4 effectParams;//emitter time, phase, wind.xy
float3 effectParams2;//translusency
float3 smokeColor;

#define ANIMATION_SPEED			35
#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_TRANSLUCENCY 	effectParams2.x
#define CLUSTER_DETAIL_TILE		effectParams2.y
#define CLUSTER_DETAIL_SPEED	effectParams2.z
// #define NO_DETAIL_TEX
#define CLUSTER_GLOW_COLOR		float3(1.000000, 0.694118, 0.262745)
#define CLIP_COCKPIT

#include "ParticleSystem2/common/clusterShading.hlsl"
