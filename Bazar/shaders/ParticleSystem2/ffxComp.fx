#include "common/random.hlsl"
#include "ParticleSystem2/common/clusterComputeCommon.hlsl"
#include "ParticleSystem2/common/splines.hlsl"
#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

RWStructuredBuffer<FFXCluster>		sbParticles;
RWStructuredBuffer<uint>			sbSortedIndices;
StructuredBuffer<SplineChunk>		sbSplines;

float4	worldOffset; //xyz - world offset, w - dt
float4	emitterParams;//emitter time, phase, wind.xy
float4	emitterParams2;
float4	emitterParams3;
uint	frames;
float4	emitterParams4;
float4	emitterParams5;
float4	emitterParams6;
float4	dbg;
float effectSize;
float windInf;

#define emitterTime		worldOffset.w

#define emitterTimeNorm	emitterParams.x
#define emitterId		emitterParams.y
#define windDir			emitterParams.zw

#define clusterRadius	emitterParams2.x
#define particleSize	emitterParams2.y
#define opacityFactor	emitterParams2.z
#define angVelFactor	emitterParams2.w

#define tempMin			emitterParams3.w
#define front			emitterParams3.xyz
#define up				emitterParams4.xyz
#define side			emitterParams5.xyz

#define lightingDecay			emitterParams6.x
#define lightingParticleScale	emitterParams6.y
#define lightingParticleOpacity	emitterParams6.z

float3 localToWorldSpace(float3 pos)
{
#ifdef USE_TRANSFORM_MATRIX
	float3x3 M = {front, up, side};	
	return mul(pos, M);
#else
	//simple rotation around Y axis for explosions
	float2x2 mRotY = {front.x, front.z, -front.z, front.x};
	float3 p = float3(mul(pos.xz, mRotY), pos.y);
	return p.xzy;
#endif
}

void simulateParticle(uint gi)
{
	SplineChunk sp;
	uint	chunkId;
	float	lifetime, nAge;
	chunkId = sbParticles[gi].chunkId;
	bool bSelectNextChunk = false;
	//прокручиваем все чанки на случай если их набралась куча - низкий фпс, либо эффект долго не попадал в кадр
	do{
		sp = sbSplines[chunkId];
		lifetime = sp.end-sp.start;
		nAge = saturate( (emitterTimeNorm - sp.start) / lifetime );
		
		bSelectNextChunk = nAge>=1.0 && sp.nextChunkId>=(THREAD_X*THREAD_Y);
		chunkId = bSelectNextChunk ? sp.nextChunkId : chunkId;
	}
	while(bSelectNextChunk);

	const bool isDummy = (sp.p0.x == sp.p1.x && sp.p0.x == 0);//TODO: придумать как лучше
	
	if(isDummy)
	{
		sbParticles[gi].posRadius.w = 0;
		sbParticles[gi].sizeLifeOpacityRnd.xz = 0;
		return;
	}

	float3 giRnd = noise3(float3(0.17232312549, 0.214928365, 0.048662916635) * (5.23937 * (1.0 + gi + emitterId * 0.938471542)), 3759.1453);
	float3 rndDir = normalize(giRnd);
	float2 wind = windDir * (1 + 0.1 * rndDir.xz);//слегка рандомайзим ветер

	float4 p = BezierCurve4(nAge, sp.p0, sp.p1, sp.p2, sp.p3);
	// float4 p = LinearInterp4(nAge, sp.p0, sp.p1, sp.p2, sp.p3);

	p.x *= 2.0*(1.0-windInf/2.0);
	p.xyz = localToWorldSpace(p.xyz);

	float temp = LinearInterp(nAge, sp.temp.x, sp.temp.y, sp.temp.z, sp.temp.w);
	temp = pow(saturate((temp-tempMin)/(1-tempMin)), 4);
	float tempOpacityFactor = 0.35 * temp * saturate(3 * nAge * (3-3*nAge));

	sbParticles[gi].posRadius = float4(p.xyz, clusterRadius);
	sbParticles[gi].sizeLifeOpacityRnd.x = particleSize*effectSize;
	sbParticles[gi].sizeLifeOpacityRnd.y = lifetime;
	sbParticles[gi].sizeLifeOpacityRnd.z = max(saturate(p.w*opacityFactor), tempOpacityFactor);
	sbParticles[gi].clusterLightTemp.z = temp;
	
#ifdef USE_AXIS
	float3x3 mRandRot = axisAngleToMatrix(rndDir, frac(giRnd.x*24.54385643) * 3.14159 * 2.0);
	float4 axis = BezierCurve4(nAge, sp.axis0, sp.axis1, sp.axis2, sp.axis3);
	axis.xyz = localToWorldSpace(axis.xyz);
	sbParticles[gi].mToWorld = mul(mRandRot, axisAngleToMatrix(normalize(axis.xyz), -axis.w*angVelFactor));
#endif
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csUpdate(uint gi : SV_GroupIndex, uniform bool multipleFrames = false)
{
	// if(multipleFrames)
	// {
		// [loop]
		// for(uint i=0; i<frames; ++i)
			// simulateParticle(gi);
	// }
	// else
		simulateParticle(gi);
}

technique11 techUpdateDefault
{
	pass normal { SetComputeShader( CompileShader( cs_5_0, csUpdate() ) );	}
	pass scrolling { SetComputeShader( CompileShader( cs_5_0, csUpdate(true) ) );	}
}

#define RADIX_TECH_NAME			techRadixSort
#define RADIX_OUTPUT_BUFFER 	sbSortedIndices
#define RADIX_THREAD_X			THREAD_X
#define RADIX_THREAD_Y			THREAD_Y
#define RADIX_BIT_MAX			31
#define RADIX_BIT_MIN			12
// #define RADIX_BIT_MIN		20
// #define RADIX_BIT_MIN		28
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
	radius  = (posRadius.w + sizeLifeOpacityRnd.x) * lightingParticleScale;
	opacity = sizeLifeOpacityRnd.z * lightingParticleOpacity;
}

#define LIGHTING_OUTPUT(id)				sbParticles[id].clusterLightTemp.x
#define LIGHTING_THREAD_X				THREAD_X
#define LIGHTING_THREAD_Y				THREAD_Y
#define LIGHTING_TECH_NAME				techLighting
#define LIGHTING_FLAGS					(LF_CLUSTER_OPACITY | LF_NEW_DECAY | LF_NO_COMPUTE_SHADER /*| LF_CASCADE_SHADOW*/)
#define LIGHTING_PARTICLE_GET_FUNC		GetClusterInfo
#define LIGHTING_DECAY					lightingDecay
#define LIGHTING_WORLD_OFFSET			(worldOffset.xyz) //для каскада
#include "ParticleSystem2/common/clusterLighting.hlsl"

[numthreads(THREAD_X, THREAD_Y, 1)]
void csSortAndLight(uint GI: SV_GroupIndex)
{
	ParticleLightInfo p = GetParticleLightInfo(techLighting)(GI);

	//шейдер выполняется чутка быстрее если сначала идет освещенка и потом сортировка
	LIGHTING_OUTPUT(GI) = ComputeLightingInternal(techLighting)(GI, p, lightingDecay, 0, 0, LIGHTING_FLAGS);
	// LIGHTING_OUTPUT(GI) = LIGHTING_OUTPUT(GI)*0.5 + 0.5*ComputeLightingInternal(techLighting)(GI, p, lightingDecay, 0, 0, LIGHTING_FLAGS);

	float3 s = p.pos.xyz + worldOffset.xyz - gCameraPos.xyz;
	float sortKey = floatToUInt(dot(s, s));
	ComputeRadixSortInternal(RADIX_TECH_NAME)(GI, sortKey);
}

technique11 techSortAndLight
{
	pass { SetComputeShader(CompileShader(cs_5_0, csSortAndLight()));	}
}
