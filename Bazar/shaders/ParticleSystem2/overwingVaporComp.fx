#include "common/random.hlsl"
#include "common/samplers11.hlsl"
#define CLUSTER_NO_LOCAL_MATRIX
#define CLUSTER_NO_WORLD_MATRIX
#include "ParticleSystem2/common/clusterComputeCommon.hlsl"
#define NO_DEFAULT_UNIFORMS
#include "ParticleSystem2/common/psCommon.hlsl"

struct SpawnLocation
{
	float3	pos;
	float3	normal;
	float	rate;
};

StructuredBuffer<SpawnLocation>		sbSpawnLocations;
StructuredBuffer<PuffCluster>		sbParticlesInput;	//current state
RWStructuredBuffer<PuffCluster>		sbParticles;		//next state
RWStructuredBuffer<uint>			sbSortedIndices;

Texture2D noiseTex;

float4	emitterParams;//emitter time, phase, wind.xy
float4	emitterParams2;
uint2	emitterParamsInt;
float4	aircraftVelAndSpeed;
float4	worldOffset;
float4x4 World;

#define emitterTime			 emitterParams.x
#define dT					 emitterParams.y
#define windVel				 emitterParams.zw
#define emitterOpacity		 emitterParams2.x
#define particleSize		 emitterParams2.y
#define vaporHeight			 emitterParams2.z
#define scaleOverAgeFactor	 emitterParams2.w
#define spawnLocationsOffset emitterParamsInt.x
#define spawnLocationsCount	 emitterParamsInt.y
#define aircraftVelocity	 aircraftVelAndSpeed.xyz
#define aircraftSpeed		 aircraftVelAndSpeed.w

// #define aircraftVelocity float3(0,40,0)

static const float additionalVerticalSpeedFactor = 0.07;
static const float randomXZOffsetFactor = 0.5;//% рандомного смещения в плоскости к нормали при рождении партикла

float getParticleInitialSize(float power)
{
	return particleSize * (0.2+0.8*power);
}

PuffCluster initParticle(PuffCluster p, uint id, float ageLast)
{
	const float uniqueId = p.sizeLifeOpacityRnd.w*14.8512364917 + gModelTime;

	float3 rnd = noise3((uniqueId + float3(0, 0.612312932, 0.22378683)) * float3(1, 1.5231, 1.125231));

	SpawnLocation spawnPoint = sbSpawnLocations[spawnLocationsOffset + (spawnLocationsCount-1) * rnd.x];

	const float power = spawnPoint.rate;

	p.posRadius.w = power;
	p.posRadius.xyz = mul(spawnPoint.pos, (float3x3)World).xyz;

	p.reserved.xyz = mul(spawnPoint.normal.xyz, (float3x3)World);
	p.reserved.w = gModelTime;//birth time

	float3x3 mNormal = basis(p.reserved.xyz);
	p.posRadius.xyz += mul(float3(rnd.y-0.5, -0.2, rnd.z - 0.5), mNormal) * getParticleInitialSize(power) * randomXZOffsetFactor;

	float particleSpeed = length(aircraftVelocity + windVel - 0* World._21_22_23 * aircraftSpeed * additionalVerticalSpeedFactor);
	float lifetime = 0.5*(vaporHeight/particleSpeed) * power * (0.5 + rnd.y*rnd.y);
	p.sizeLifeOpacityRnd.y = clamp(lifetime, 0.005, 2);

	//дополнительно состариваем партикл, т.к. при низком фпс на большой скорости партиклы
	//будут массово умирать и рождаться на каждом кадре и эффект будет расподаться на полосы
	float ageCur = fmod(ageLast, p.sizeLifeOpacityRnd.y);
	p.reserved.w -= ageCur;

	p.ang = 0;

	return p;
}

PuffCluster updateParticle(PuffCluster p, uint id, float dt)
{
	float power			= p.posRadius.w;
	float age			= gModelTime - p.reserved.w;
	float nAge			= age / p.sizeLifeOpacityRnd.y;
	float translation	= aircraftSpeed * dt;
	float3x3 mVel		= basis(aircraftVelocity / aircraftSpeed);
	float2 sc;			sincos(p.sizeLifeOpacityRnd.w*PI2, sc.x, sc.y);	

	p.posRadius.xyz += aircraftVelocity * dt;
	p.posRadius.xyz += mul(float3(sc.x, 0, sc.y), mVel) * (translation * 0.25);//сдвиг в сторону
	p.posRadius.xyz += World._21_22_23 * (translation * additionalVerticalSpeedFactor);//компенсируем изменение размера партикла чтобы 
	p.posRadius.xz  += windVel * dt;

	//size
	float scaleFactor = 1.0 + scaleOverAgeFactor * nAge;
	p.sizeLifeOpacityRnd.x = getParticleInitialSize(power) * scaleFactor;

	//opacity
	p.sizeLifeOpacityRnd.z = saturate(nAge*5) * (0.3+0.7*power) * emitterOpacity;
	p.sizeLifeOpacityRnd.z *= rcp(scaleFactor*scaleFactor); //влияние изменения размера партикла

	p.ang += translation / particleSize;

	return p;
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csOverwingVapor(uint gi : SV_GroupIndex)
{
	PuffCluster p0 = sbParticlesInput[gi];

	float dt = dT;
	float age = gModelTime - p0.reserved.w;
	
	// [branch]
	if(age>p0.sizeLifeOpacityRnd.y)
	{
		p0 = initParticle(p0, gi, age);
		dt = gModelTime - p0.reserved.w;//прошедшее время с учетом того что партиклы могут родиться в прошлом
	}
	sbParticles[gi] = updateParticle(p0, gi, dt);
}

technique11 techOverwingVapor
{
	pass { SetComputeShader( CompileShader( cs_5_0, csOverwingVapor() ) );	}
}

#define RADIX_BIT_MAX			31
// #define RADIX_BIT_MIN		26
// #define RADIX_BIT_MIN		20
#define RADIX_BIT_MIN			15

#define RADIX_OUTPUT_BUFFER		sbSortedIndices
#define RADIX_THREAD_X			THREAD_X
#define RADIX_THREAD_Y			THREAD_Y
#define RADIX_TECH_NAME			techRadixSort
#define RADIX_KEY_FUNCTION_BODY(id) \
	float3 p = sbParticles[id].posRadius.xyz + worldOffset.xyz  - gCameraPos.xyz; \
	return floatToUInt(dot(p,p));
#define RADIX_NO_COMPUTE_SHADER
#include "ParticleSystem2/common/radixSort.hlsl"

void GetClusterInfo(uint id, out float3 pos, out float radius, out float opacity)
{
	float4 posRadius = sbParticles[id].posRadius;
	float4 sizeLifeOpacityRnd = sbParticles[id].sizeLifeOpacityRnd;

	pos     = posRadius.xyz;
	radius  = sizeLifeOpacityRnd.x * 0.5;
	opacity = saturate(sizeLifeOpacityRnd.z * 1.0);
}

#define LIGHTING_OUTPUT(id)				sbParticles[id].clusterLightAge.x
#define LIGHTING_THREAD_X				THREAD_X
#define LIGHTING_THREAD_Y				THREAD_Y
#define LIGHTING_TECH_NAME				techLighting
#define LIGHTING_PARTICLE_GET_FUNC		GetClusterInfo
// #define LIGHTING_FLAGS					(LF_CLUSTER_OPACITY | LF_NO_COMPUTE_SHADER | LF_NEW_DECAY)
#define LIGHTING_FLAGS					(LF_CLUSTER_OPACITY | LF_NO_COMPUTE_SHADER)
#define LIGHTING_WORLD_OFFSET			(worldOffset.xyz)
#include "ParticleSystem2/common/clusterLighting.hlsl"

[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLight(uint GI: SV_GroupIndex, uniform bool bApplyShadowMap)
{
	ParticleLightInfo p = GetParticleLightInfo(techLighting)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	uint flags = bApplyShadowMap? (LIGHTING_FLAGS | LF_CASCADE_SHADOW) : (LIGHTING_FLAGS);
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLighting)(GI, p, 0.9, 0, 0, flags);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));	
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

technique11 techSortAndLight
{
	pass onlySelfShadow		{ SetComputeShader(CompileShader(cs_5_0, csSortAndLight(false)));	}
	pass selfShadowNCascade	{ SetComputeShader(CompileShader(cs_5_0, csSortAndLight(true)));	}
}
