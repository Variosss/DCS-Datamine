/*
Расчет самозатенения кластеров.
Использование: задефайнить параметры и заинклудить clusterLighting.hlsl:

Обязательные параметры:
LIGHTING_OUTPUT(id)				- куда будет записана итоговая освещенность для id кластера
LIGHTING_THREAD_X				- количество потоков в группе по X
LIGHTING_THREAD_Y				- количество потоков в группе по Y
LIGHTING_TECH_NAME				- название техники освещения которая будет создана
LIGHTING_CLUSTER_POS(id)		- отсюда будет браться позиция id кластера
LIGHTING_CLUSTER_RADIUS(id) 	- отсюда будет браться радиус id кластера

Необязательные параметры:
LIGHTING_DECAY					- скорость затухания света от 0 до 1
LIGHTING_DECAY_SECOND			- скорость затухания света от второго эмиттера от 0 до 1
LIGHTING_CLUSTER_OPACITY(id)	- отсюда будет браться прозрачность id кластера
LIGHTING_CASCADE_SHADOWMAP		- 0/1 - включает вычисление каскадной тени, нужно определить также LIGHTING_WORLD_OFFSET
LIGHTING_WORLD_OFFSET			- сдвиг локальной СК эмиттера в мировую СК от origin для вычисления каскадной тени
*/

#ifndef LIGHTING_OUTPUT
#error LIGHTING_OUTPUT should be defined
#endif

#ifndef LIGHTING_THREAD_X
#error LIGHTING_THREAD_X should be defined
#endif

#ifndef LIGHTING_THREAD_Y
#error LIGHTING_THREAD_Y should be defined
#endif

#ifndef LIGHTING_TECH_NAME
#error LIGHTING_TECH_NAME should be defined
#endif

#if !defined(LIGHTING_PARTICLE_GET_FUNC)

	#ifndef LIGHTING_CLUSTER_POS
	#error LIGHTING_CLUSTER_POS should be defined
	#endif

	#ifndef LIGHTING_CLUSTER_RADIUS
	#error LIGHTING_CLUSTER_RADIUS should be defined
	#endif

#endif

#if defined(LIGHTING_SHADOW_POS) || defined(LIGHTING_PARTICLE_SHADOW_GET_FUNC)
	#ifndef LIGHTING_SHADOW_PARTICLES_COUNT
		#error LIGHTING_SHADOW_PARTICLES_COUNT should be defined
	#endif
#endif

#ifndef LIGHTING_SHADOW_PARTICLES_COUNT
	#define LIGHTING_SHADOW_PARTICLES_COUNT 0
#endif

#ifndef LIGHTING_FLAGS
#define LIGHTING_FLAGS				0
#endif

#include "deferred/shadows.hlsl"

#ifndef LIGHTING_WORLD_OFFSET
	#define LIGHTING_WORLD_OFFSET	0
#endif

#ifndef CONCAT
#define CONCAT(a, b) a ## b
#endif
#ifndef GEN_NAME
#define GEN_NAME(a, b) CONCAT(a, b)
#endif

#define csShaderName(suffix)				GEN_NAME(cs,	 suffix)
#define ComputeLighting(prefix)				GEN_NAME(prefix, LightFunc)
#define ComputeLightingInternal(prefix)		GEN_NAME(prefix, LightFuncInternal)
#define GetParticleLightInfo(prefix)		GEN_NAME(prefix, ParticleInfoFunc)
#define GetShadowParticleLightInfo(prefix)	GEN_NAME(prefix, ShadowParticleInfoFunc)

#ifndef LIGHTING_DECAY
#define LIGHTING_DECAY	0.9
#endif

#ifndef LIGHTING_DECAY_SECOND
#define LIGHTING_DECAY_SECOND 0.9
#endif

#ifndef LIGHTING_NEW_DECAY
#define LIGHTING_NEW_DECAY 0
#endif

#define LIGHTING_GROUP_THREADS (LIGHTING_THREAD_X * LIGHTING_THREAD_Y)

#ifndef SHAREDMEMORY_FOR_FIRST_EMITTER
#define SHAREDMEMORY_FOR_FIRST_EMITTER

#define LF_CLUSTER_OPACITY			1
#define LF_SHADOW_OPACITY			2
#define LF_ADDITIONAL_SHADOW		4
#define LF_CASCADE_SHADOW			8
#define LF_NEW_DECAY				16
#define LF_NO_COMPUTE_SHADER		32

struct ParticleLightInfo
{
	float3	pos;
	float	opacity;
	float	radius;
};

groupshared float4 sharedPos[LIGHTING_GROUP_THREADS];// xyz - pos, w - transparency

#endif

ParticleLightInfo GetParticleLightInfo(LIGHTING_TECH_NAME)(uint id)
{
#ifdef LIGHTING_PARTICLE_GET_FUNC
	ParticleLightInfo p;
	LIGHTING_PARTICLE_GET_FUNC(id, p.pos, p.radius, p.opacity);
	return p;
#else
	ParticleLightInfo p;
	p.pos = LIGHTING_CLUSTER_POS(id);
	p.radius = LIGHTING_CLUSTER_RADIUS(id);
	#ifdef LIGHTING_CLUSTER_OPACITY
		p.opacity = LIGHTING_CLUSTER_OPACITY(id);
	#else
		p.opacity = 0;
	#endif
	return p;
#endif
}

ParticleLightInfo GetShadowParticleLightInfo(LIGHTING_TECH_NAME)(uint id)
{

#ifdef LIGHTING_PARTICLE_SHADOW_GET_FUNC

	ParticleLightInfo p;
	LIGHTING_PARTICLE_SHADOW_GET_FUNC(id, p.pos, p.radius, p.opacity);
	return p;

#else
	ParticleLightInfo p = (ParticleLightInfo)0;
	#ifdef LIGHTING_SHADOW_POS
		p.pos = LIGHTING_SHADOW_POS(id);
		p.radius = LIGHTING_SHADOW_RADIUS(id);
		#ifdef LIGHTING_SHADOW_OPACITY
			p.opacity = LIGHTING_SHADOW_OPACITY(id);
		#else
			p.opacity = 0;
		#endif
	#endif
	return p;
#endif
}

#ifndef CLUSTER_LIGHTING_ONETIME
#define CLUSTER_LIGHTING_ONETIME
void AttenuateLight(inout float light, float3 pos, float decay, uniform bool bOpacity, uniform bool bNewDecay)
{
	float k = 1 - pos.z;
	float decayReversed = 1 - decay;
	float decayCur;
	for(uint j=0; j<LIGHTING_GROUP_THREADS; ++j)
	{
		if(bOpacity)
		{
			float4 sp = sharedPos[j];
			if(sp.z < pos.z)
			{
				if(bNewDecay)
					decayCur = min(decay, distance(sp.xyz, pos.xyz));
				else
				{
					float2 projDist = sp.xy - pos.xy;
					decayCur = min(decay, length(projDist) + max(0, sp.z + k));
				}
				light *= sp.w + (1-sp.w) * (decayCur + decayReversed);
			}
		}
		else
		{
			float3 sp = sharedPos[j].xyz;
			if(sp.z < pos.z)
			{
				if(bNewDecay)
					decayCur = min(decay, distance(sp.xyz, pos.xyz));
				else
				{
					float2 projDist = sp.xy - pos.xy;
					decayCur = min(decay, length(projDist) + max(0, sp.z + k));
				}
				light *= decayCur + decayReversed;
			}
		}
	}
}
#endif

float ComputeLightingInternal(LIGHTING_TECH_NAME)(uint GI, ParticleLightInfo pInfo, float clusterDecay, float shadowDecay, uint shadowParticlesCount = 0, uniform uint flags = 0)
{
	float3 Z = -gSunDir.xyz;
	float3 X =  normalize( abs(gSunDir.y)>0.95 ? cross(Z, float3(0, 0, 1)) : cross(float3(0, 1, 0), Z) );
	float3 Y = cross(Z, X);
	float3x3 sunView = {
		X.x, Y.x, Z.x,
		X.y, Y.y, Z.y,
		X.z, Y.z, Z.z};

	float radiusInvHalf = 0.5 / pInfo.radius;

	float3 pos = mul(pInfo.pos, sunView) * radiusInvHalf;

	if(flags & LF_CLUSTER_OPACITY)
		sharedPos[GI] = float4(pos, 1.0 - pInfo.opacity);
	else
		sharedPos[GI].xyz = pos;

	float light = 1.0;

	if(flags & LF_CASCADE_SHADOW)//тень от каскада
	{
		float4 wPos = float4(pInfo.pos + LIGHTING_WORLD_OFFSET, 1);
		float2 projPos = mul(wPos, gViewProj).zw;
		light *= SampleShadowCascadeVertex(wPos.xyz, projPos.x/projPos.y);
	}

	GroupMemoryBarrierWithGroupSync();
	
	//считаем самозатенение
	AttenuateLight(light, pos, clusterDecay, (flags & LF_CLUSTER_OPACITY), (flags & LF_NEW_DECAY));

	if(flags & LF_ADDITIONAL_SHADOW)//тень от внешней системы партиклов
	{
		const uint particlesPerThread = (shadowParticlesCount / LIGHTING_GROUP_THREADS) + ((shadowParticlesCount % LIGHTING_GROUP_THREADS)>0 ? 1 : 0);

		//позиции затеняющих кластеров
		for(uint n=0; n<particlesPerThread; ++n)
		if(GI * particlesPerThread + n < shadowParticlesCount)
		{
			uint id = GI * particlesPerThread + n;
			ParticleLightInfo shadowParticle = GetShadowParticleLightInfo(LIGHTING_TECH_NAME)(id);

			if(flags & LF_SHADOW_OPACITY)
				sharedPos[id] = float4(mul(shadowParticle.pos, sunView) * radiusInvHalf, 1 - shadowParticle.opacity);
			else
				sharedPos[id].xyz = mul(shadowParticle.pos, sunView) * radiusInvHalf;
		}
		
		AttenuateLight(light, pos, shadowDecay, (flags & LF_SHADOW_OPACITY), (flags & LF_NEW_DECAY));
	}

	return light;
}

void ComputeLighting(LIGHTING_TECH_NAME)(uint GI, uniform bool bApplyShadowMap)
{
	ParticleLightInfo p = GetParticleLightInfo(LIGHTING_TECH_NAME)(GI);
	uint flags = bApplyShadowMap? ((LIGHTING_FLAGS) | LF_CASCADE_SHADOW) : (LIGHTING_FLAGS);
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(LIGHTING_TECH_NAME)(GI, p, LIGHTING_DECAY, LIGHTING_DECAY_SECOND, LIGHTING_SHADOW_PARTICLES_COUNT, flags);
}

#if !(LIGHTING_FLAGS & LF_NO_COMPUTE_SHADER)

[numthreads(LIGHTING_THREAD_X, LIGHTING_THREAD_Y, 1)]
void csShaderName(LIGHTING_TECH_NAME)(uint GI: SV_GroupIndex, uniform bool bApplyShadowMap = false)
{
	ComputeLighting(LIGHTING_TECH_NAME)(GI, bApplyShadowMap);
}

technique11 LIGHTING_TECH_NAME
{
	pass onlySelfShadowing	{ SetComputeShader(CompileShader(cs_5_0, csShaderName(LIGHTING_TECH_NAME)(false)));	}
	pass selfShadowNCascade { SetComputeShader(CompileShader(cs_5_0, csShaderName(LIGHTING_TECH_NAME)(true )));	}
}

#endif

#undef csShaderName
#undef LIGHTING_GROUP_THREADS
// #undef LIGHTING_DECAY
// #undef LIGHTING_DECAY_SECOND
#undef LIGHTING_TECH_NAME
#undef LIGHTING_SHADOW_POS
#undef LIGHTING_SHADOW_OPACITY
#undef LIGHTING_SHADOW_RADIUS
