#define CLUSTER_CUSTOM_VS_NAME	vsCluster
#define CLUSTER_STRUCT ClusterStruct

#ifdef FFX_SOFT_PARTICLES
	#define SOFT_PARTICLES		smokeColor.w
#endif

float4 effectParams;//emitter time, phase, wind.xy
float4 effectParams2;//emitter time, phase, wind.xy
float4 smokeColor; //rgb - color, w - blastwave lifetime
float3 glowColor;
float3 glowColorCold;
float effectSize;
float windInf;

#include "ParticleSystem2/common/clusterCommon.hlsl"

struct CLUSTER_STRUCT
{
	float4 posRadius;
	float4 sizeLifeOpacityRnd;
	float3 clusterLight;
	uint   chunkId;
	float3x3 mToWorld;
};
StructuredBuffer<CLUSTER_STRUCT>	sbParticles;
StructuredBuffer<uint>				sbSortedIndices;

VS_OUTPUT CLUSTER_CUSTOM_VS_NAME(in uint vertId: SV_VertexId)
{
	VS_OUTPUT o;
	o.vertId = sbSortedIndices[vertId];
	const CLUSTER_STRUCT i = sbParticles[o.vertId];
	o.posRadius = i.posRadius*effectSize;
	o.posRadius.xyz += worldOffset;
	o.posRadius.xz += windInf*15.0*(0.35+i.sizeLifeOpacityRnd.w*0.65)*effectParams2.x*effectParams2.zw;

	o.sizeLifeOpacityRnd = i.sizeLifeOpacityRnd;
	//o.sizeLifeOpacityRnd.z *= (1.0-effectParams2.x);
	o.sizeLifeOpacityRnd.x *= (1.0+effectParams2.x/2.0);
	o.clusterLight.xyz = i.clusterLight;

#if PARTICLES_IN_CLUSTER>1
	const float verticalGradientFactor = 0.5;//имитация эмбиентного затения к низу кластера в тени
	o.clusterLight.y = 0.5;
	o.clusterLight.y *= o.clusterLight.y * verticalGradientFactor;
#endif
	return o;
}

#define CLUSTER_COLOR			smokeColor.xyz
#define CLUSTER_GLOW_COLOR		glowColor.xyz
#define CLUSTER_GLOW_COLOR_COLD glowColorCold.xyz
#define CLUSTER_TRANSLUCENCY	effectParams.x
#define CLUSTER_GLOW_BRIGHTNESS effectParams.y
#define EMITTER_TIME_NORM       effectParams2.x
#define CLUSTER_GLOW_ADDITIVENESS effectParams.z
#include "ParticleSystem2/common/clusterShading.hlsl"
