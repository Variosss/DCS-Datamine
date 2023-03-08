#define CLUSTER_NO_LOCAL_MATRIX
#define CLUSTER_NO_WORLD_MATRIX
#define CLUSTER_WORLD_NORMAL
#define PARTICLES_IN_CLUSTER	1
#define SOFT_PARTICLES			(1/0.3)
#define CLUSTER_CUSTOM_VS_NAME	vsOverwingVapor
#define CLUSTER_STRUCT			ClusterStruct
#include "ParticleSystem2/common/clusterCommon.hlsl"

struct CLUSTER_STRUCT
{
	float4	posRadius;
	float4	sizeLifeOpacityRnd;
	float3	clusterLight;
	float 	ang;
	float4	reserved;
};
StructuredBuffer<CLUSTER_STRUCT>	sbParticles;
StructuredBuffer<uint>				sbSortedIndices;

VS_OUTPUT CLUSTER_CUSTOM_VS_NAME(uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.vertId = sbSortedIndices[vertId];
	const CLUSTER_STRUCT i = sbParticles[o.vertId];
	o.posRadius = i.posRadius;
	o.posRadius.xyz += worldOffset;
	o.sizeLifeOpacityRnd = i.sizeLifeOpacityRnd;
	o.clusterLight.xyz = i.clusterLight;

	float transition = i.ang;
	float lerpFactor = saturate(0.1 + transition);
	float3 viewDir = -normalize(gCameraPos - o.posRadius.xyz);
	float NoV = abs(dot(i.reserved.xyz, viewDir));
	NoV = (1 - NoV);
	NoV *= NoV;
	o.worldNormal = normalize(lerp(i.reserved.xyz, viewDir, (1-NoV) + lerpFactor*NoV));	
	return o;
}


float3 effectParams;
float3 smokeColor;

#define ANIMATION_SPEED			35
#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_TRANSLUCENCY 	effectParams.x
#define CLUSTER_DETAIL_TILE		effectParams.y
#define CLUSTER_DETAIL_SPEED	effectParams.z
// #define NO_DETAIL_TEX
#define CLUSTER_GLOW_COLOR		float3(1.000000, 0.694118, 0.262745)
#define CLIP_COCKPIT

#define getTextureFrameUV		getTextureFrameUV6x6

#include "ParticleSystem2/common/clusterShading.hlsl"
