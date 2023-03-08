#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/clusterComputeCommon.hlsl"

#define NO_DEFAULT_UNIFORMS
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

struct InitialParticle
{
	float4 vel;
	float rand1;
	float rand2;
	float param;
};

StructuredBuffer<InitialParticle>	sbParticlesInput;
RWStructuredBuffer<PuffCluster>		sbParticles;
RWStructuredBuffer<uint>			sbSortedIndices;

float4	emitterParams;//emitter time, phase, wind.xy
float4	emitterParams2;
float4	emitterParams3;
float4	emitterParams4;
float4	worldOffset; //xyz - world offset, w - dt
uint	emitterParamsInt;

#define opacityBase		worldOffset.y
#define power			worldOffset.z
#define dT				worldOffset.w
#define emitterTime		emitterParams.x
#define windDir			emitterParams.zw
#define effectLifetime	emitterParams2.x
// #define puffRadius		emitterParams2.y
#define clusterRadius	emitterParams2.z
#define particleSize	emitterParams2.w

#define surfaceNormal	emitterParams3.xyz
#define speedMax		emitterParams3.w

#define spreadMin		emitterParams4.x
#define spreadRange		emitterParams4.y
#define speedMin		emitterParams4.z
#define speedRange		emitterParams4.w

#define timeDelay		0.0

// static const float nEffectAge = emitterTime/effectLifetime;

void simulateHedgehogExplosion(uint gi, uniform float delay = 0.0)
{
	InitialParticle init = sbParticlesInput[gi];

	float age = max(0, emitterTime - delay);
	float nAge = age / (effectLifetime - delay);

	float3x3 world = basis(surfaceNormal);

	float2 sc;
	sincos(init.rand2*PI2*14.32, sc.x, sc.y);
	float3 startPos = mul(float3(sc.x, 0, sc.y)*init.rand2*power, world);

	float snoise = init.vel.w;
	init.vel.y = spreadMin + spreadRange * init.vel.y;
	init.vel.xyz = normalize(init.vel.xyz);

	float3 velDir	= mul(init.vel.xyz, world);
	float  speed	= speedMin + speedRange * snoise * (init.vel.y*0.1 + 0.9);
	float  Rand		= init.rand1;

	float param = sqrt(init.param);

	float uniqRand = noise1D(init.rand1+param);
	float uniqRand2 = noise1D(init.rand1+8.249234);
	float uniqAge = min(1, nAge*(1+0.3*step(0.5, uniqRand)));

	float airResistance = 2 + 0.2 * (1-param);

	float3 startVel = velDir * speed;
	float2 speeds =  float2( length(startVel.xz), startVel.y ) * (0.5 + 0.5*param);
	//speeds.y *= 0.5*(1.0+uniqRand);

	float ttt = 1.0 - smoothstep(0.5, 1.5, age);
	//speeds.y *= 0.5*(1.0+(1.0-ttt)*uniqRand)+0.5*ttt;
	//float2 trans = calcTranslationWithAirResistance(speeds, (0.9+0.1*power), airResistance, max(0, age));//увеличиваем коэффициент сопротивления для центральной части
	float2 trans = calcTranslationWithAirResistance(speeds, (0.9+0.1*power), airResistance, max(0, age));
	float timeOnGround = max(0, -trans.y);//увеличивается когда партикл оказался на земле

	float3 offset = velDir;
	offset.xz *= trans.x;
	offset.y = trans.y>0? trans.y : trans.y*0.1;

	//offset.y = abs(trans.y)*10.0;
	offset.xz += float2(uniqRand-0.5, noise1D(Rand*param+5.3218325)-0.5)*age*param*0.3*power;
	offset.xz += velDir.xz*pow(saturate(1-offset.y/4), 1)*nAge*(1-speed/speedMax) * 5 * (0.8+0.2*power);//сдвигаем от центра
	//offset.y = 100.0;
	float scale = 0.9*(1+3*pow(abs(nAge),2)) + (1-param) * 4 +  param * pow(nAge, 2) * 5;
	scale *= (0.3+0.7*power);

	float3 particlePos = startPos + offset;

	float opacity = saturate( opacityBase * (1-pow(uniqAge, 2-power/2.5f)) * (1 - timeOnGround/10.0) );

	//float opacity = saturate( opacityBase * (1-pow(uniqAge, 2-power/2.5f))* (1 - timeOnGround/10.0));
	//opacity = 0.5;

	float t1, t2;
	t1 = 0.7 + 0.3*ttt;
	t2 = 0.3 - 0.3*ttt;
	sbParticles[gi].posRadius.xyz = particlePos;
	sbParticles[gi].posRadius.xz += 0.9*(t1+t2*uniqRand2)*windDir * age;

	//sbParticles[gi].posRadius.xz += (0.7+0.3*uniqRand2)*windDir * age;
	sbParticles[gi].posRadius.w = clusterRadius;
	sbParticles[gi].sizeLifeOpacityRnd.x = opacity>1e-3 ? scale : 0.0;
	sbParticles[gi].sizeLifeOpacityRnd.z = opacity;
	sbParticles[gi].clusterLightAge.z = 1 / (1+length(particlePos)*0.6 ) * saturate(1.1 - (emitterTime-delay) / (0.5-0.3*param)); //температура
	sbParticles[gi].sizeLifeOpacityRnd.y = effectLifetime;
	// sbParticles[gi].mLocalToWorld = makeRotY(sc);
	sbParticles[gi].ang = 0;
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csHedgehog(uint gi : SV_GroupIndex)
{
	simulateHedgehogExplosion(gi, timeDelay);
}

technique11 techHedgehog
{
	pass { SetComputeShader( CompileShader( cs_5_0, csHedgehog() ) );	}
}

#if 0
#include "deferred/shadows.hlsl"

float SampleShadowMapVertex2(float3 ppos, uniform uint idx) {

	float bias = ShadowBias[idx] * 10;

	// float4 shadowPos = mul(float4(ppos, 1.0), ShadowMatrix[idx]);
	// float3 shadowCoord = shadowPos.xyz / shadowPos.w;
	// return cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) - bias);

	float dist = distance(ppos, gCameraPos);

	// float3x3 lm = vecToMatrix2(normal);
	float3x3 lm = vecToMatrix(gSunDir);

	float distFactor = exp(-dist*0.002 - 0.75);

	uint count = 1 + 32 * distFactor;

	float radius = clamp(ShadowBlurFactor[1]*dist*0.02, ShadowBlurFactor[0], ShadowBlurFactor[1]) * 100;

	float acc = 0;
	float offs = 1.0 / count;
	static const float incr = 3.1415926535897932384626433832795 *(3.0 - sqrt(5.0))*0.5;

	for (uint i = 0; i < count; ++i) {
		float z = 0;//1-i*offs;
		float r = 1;//sqrt(1.0 - z*z);
		float s, c;
		sincos(i*incr, s, c);
		float3 delta = mul(float3(c * r, s * r, z), lm) * radius;

		float4 shadowPos = mul(float4(ppos + delta, 1.0), ShadowMatrix[idx]);
		float3 shadowCoord = shadowPos.xyz / shadowPos.w;
		acc += cascadeShadowMap.SampleCmpLevelZero(gCascadeShadowSampler, float3(shadowCoord.xy, 3 - idx), saturate(shadowCoord.z) - bias);

	}
	return acc / count;
}

float SampleShadowCascadeVertex2(float3 ppos, float depth) {

	[unroll]
	for (uint i = 0; i < 4; ++i) 
		if (depth > ShadowDistance[i])
			return SampleShadowMapVertex2(ppos, i);

	return 1;
}

#define SampleShadowCascadeVertex SampleShadowCascadeVertex2
#endif

#define RADIX_BIT_MAX			31
// #define RADIX_BIT_MIN		26
// #define RADIX_BIT_MIN		20
#define RADIX_BIT_MIN			12

#define RADIX_OUTPUT_BUFFER		sbSortedIndices
#define RADIX_THREAD_X			THREAD_X
#define RADIX_THREAD_Y			THREAD_Y
#define RADIX_TECH_NAME			techRadixSort
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

	pos     = posRadius.xyz;
	radius  = sizeLifeOpacityRnd.x;// + posRadius.w;
	opacity = sizeLifeOpacityRnd.z * sbParticles[id].sizeLifeOpacityRnd.z * 0.4;
}

#define LIGHTING_OUTPUT(id)				sbParticles[id].clusterLightAge.x
#define LIGHTING_THREAD_X				THREAD_X
#define LIGHTING_THREAD_Y				THREAD_Y
#define LIGHTING_TECH_NAME				techLighting
#define LIGHTING_PARTICLE_GET_FUNC		GetClusterInfo
#define LIGHTING_FLAGS					(LF_CLUSTER_OPACITY /*| LF_NEW_DECAY */ | LF_NO_COMPUTE_SHADER /*| LF_CASCADE_SHADOW*/)
#define LIGHTING_WORLD_OFFSET			(worldOffset.xyz)
#include "ParticleSystem2/common/clusterLighting.hlsl"

//функция
[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLight(uint GI: SV_GroupIndex)
{
	ParticleLightInfo p = GetParticleLightInfo(techLighting)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLighting)(GI, p, 0.9, 0, 0, LIGHTING_FLAGS);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));	
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

technique11 techSortAndLight
{
	pass { SetComputeShader(CompileShader(cs_5_0, csSortAndLight()));	}
}
