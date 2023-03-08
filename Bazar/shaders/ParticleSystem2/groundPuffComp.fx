#include "ParticleSystem2/groundPuffCompCommon.hlsl"
#include "ParticleSystem2/groundPuffCompCBU97.hlsl"

#define particlesCount emitterParamsInt.x

StructuredBuffer<FFXCluster>		sbFFXParticles;
StructuredBuffer<PuffCluster>		sbAuxParticles;

#define RADIX_BIT_MAX 31
#define RADIX_BIT_MIN 12
// #define RADIX_BIT_MIN 28

#define RADIX_TECH_NAME	techRadixSort
#define RADIX_OUTPUT_BUFFER sbSortedIndices
#define RADIX_THREAD_X THREAD_X
#define RADIX_THREAD_Y THREAD_Y
#define RADIX_KEY_FUNCTION_BODY(id) \
	float3 p = sbParticles[id].posRadius.xyz + worldOffset.xyz  - gCameraPos.xyz; \
	return floatToUInt(dot(p,p));
// #define RADIX_NO_LOCAL_INDICES
#define RADIX_NO_COMPUTE_SHADER
#include "ParticleSystem2/common/radixSort.hlsl"


void GetClusterInfo(uint id, out float3 pos, out float radius, out float opacity)
{
	float4 posRadius = sbParticles[id].posRadius;
	float4 sizeLifeOpacityRnd = sbParticles[id].sizeLifeOpacityRnd;
	opacity = 0;
	pos = posRadius.xyz;
	radius = posRadius.w + sizeLifeOpacityRnd.x;
}

void GetFFXShadowInfo(uint id, out float3 pos, out float radius, out float opacity)
{
	float4 posRadius = sbFFXParticles[id].posRadius;
	float4 sizeLifeOpacityRnd = sbFFXParticles[id].sizeLifeOpacityRnd;
	pos = posRadius.xyz;
	opacity = sizeLifeOpacityRnd.z;
	radius = posRadius.w + sizeLifeOpacityRnd.x;
}

void GetDoubleShadowInfo(uint id, out float3 pos, out float radius, out float opacity)
{
	float4 posRadius = sbAuxParticles[id].posRadius;
	float4 sizeLifeOpacityRnd = sbAuxParticles[id].sizeLifeOpacityRnd;
	pos = posRadius.xyz;
	opacity = sizeLifeOpacityRnd.z;
	radius = posRadius.w + sizeLifeOpacityRnd.x;
}

//стандартная техника для самозатенения
#define LIGHTING_OUTPUT(id)					sbParticles[id].clusterLightAge.x
#define LIGHTING_THREAD_X					THREAD_X
#define LIGHTING_THREAD_Y					THREAD_Y
#define LIGHTING_TECH_NAME					techLighting
#define LIGHTING_DECAY						0.5
#define LIGHTING_FLAGS						(LF_CLUSTER_OPACITY /*| LF_NEW_DECAY*/ | LF_NO_COMPUTE_SHADER /*| LF_CASCADE_SHADOW*/)
#define LIGHTING_PARTICLE_GET_FUNC			GetClusterInfo
#define LIGHTING_WORLD_OFFSET				(worldOffset.xyz)
#include "ParticleSystem2/common/clusterLighting.hlsl"

//техинка для самозатенения и получения тени от FFX эмиттера
#define LIGHTING_TECH_NAME					techLightingForFFX
#define LIGHTING_DECAY						0.5
#define LIGHTING_DECAY_SECOND				0.9
#define LIGHTING_FLAGS						(LF_CLUSTER_OPACITY | LF_NEW_DECAY | LF_ADDITIONAL_SHADOW | LF_SHADOW_OPACITY | LF_NO_COMPUTE_SHADER /*| LF_CASCADE_SHADOW*/)
#define LIGHTING_SHADOW_PARTICLES_COUNT 	particlesCount
#define LIGHTING_WORLD_OFFSET				(worldOffset.xyz)
#define LIGHTING_PARTICLE_SHADOW_GET_FUNC	GetFFXShadowInfo
#include "ParticleSystem2/common/clusterLighting.hlsl"

//техинка для самозатенения и получения тени от эффекта подобного этому
#define LIGHTING_TECH_NAME					techLightingDouble
#define LIGHTING_DECAY						0.5
#define LIGHTING_DECAY_SECOND				0.9
#define LIGHTING_FLAGS						(LF_CLUSTER_OPACITY | LF_NEW_DECAY | LF_ADDITIONAL_SHADOW | LF_SHADOW_OPACITY | LF_NO_COMPUTE_SHADER /*| LF_CASCADE_SHADOW*/)
#define LIGHTING_WORLD_OFFSET				(worldOffset.xyz)
#define LIGHTING_PARTICLE_SHADOW_GET_FUNC	GetDoubleShadowInfo
#include "ParticleSystem2/common/clusterLighting.hlsl"

#define FLAGS_DEFAULT	(LF_CLUSTER_OPACITY | LF_NEW_DECAY/*| LF_CASCADE_SHADOW*/)
#define FLAGS_SHADOW  	(LF_CLUSTER_OPACITY | LF_NEW_DECAY | LF_ADDITIONAL_SHADOW | LF_SHADOW_OPACITY /*| LF_CASCADE_SHADOW*/)

[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLight(uint GI: SV_GroupIndex)
{
	ParticleLightInfo p = GetParticleLightInfo(techLighting)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLighting)(GI, p, LIGHTING_DECAY, 0, 0, FLAGS_DEFAULT);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLightForFFX(uint GI: SV_GroupIndex)
{
	ParticleLightInfo p = GetParticleLightInfo(techLightingForFFX)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLightingForFFX)(GI, p, LIGHTING_DECAY, LIGHTING_DECAY_SECOND,	particlesCount, FLAGS_SHADOW);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLightDouble(uint GI: SV_GroupIndex)
{
	ParticleLightInfo p = GetParticleLightInfo(techLightingDouble)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLightingDouble)(GI, p, LIGHTING_DECAY, LIGHTING_DECAY_SECOND,	particlesCount, FLAGS_SHADOW);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

technique11 techSortAndLight		{	pass { SetComputeShader(CompileShader(cs_5_0, csSortAndLight()));		}	}
technique11 techSortAndLightForFFX	{	pass { SetComputeShader(CompileShader(cs_5_0, csSortAndLightForFFX()));	}	}
technique11 techSortAndLightDouble	{	pass { SetComputeShader(CompileShader(cs_5_0, csSortAndLightDouble()));	}	}
