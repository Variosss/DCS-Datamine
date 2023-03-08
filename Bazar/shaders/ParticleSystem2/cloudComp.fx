#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/clusterComputeCommon.hlsl"

#define NO_DEFAULT_UNIFORMS
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/noiseSimplex.hlsl"

#define SPHERE 0

RWStructuredBuffer<PuffCluster>		sbParticles;
RWStructuredBuffer<uint>			sbSortedIndices;

uint	emitterParamsInt;
float4	worldOffset; //xyz - world offset

float4	emitterParams;
#define rndSeed			emitterParams.x
#define effectScale		emitterParams.y
#define opacityMax		emitterParams.z

float4	emitterParams2;

#define HASHSCALE3 float3(443.897, 441.423, 437.195)
#define HASHSCALE4 float4(443.897, 441.423, 437.195, 444.129)

float3 hash31(float p) {
	float3 p3 = frac(float3(p,p,p) * HASHSCALE3);
	p3 += dot(p3, p3.yzx + 19.19);
	return frac((p3.xxy + p3.yzz)*p3.zyx);
}

float4 hash43(float3 p) {
	float4 p4 = frac(float4(p.xyzx)  * HASHSCALE4);
	p4 += dot(p4, p4.wzxy + 19.19);
	return frac((p4.xxyz + p4.yzzw)*p4.zywx);
}


[numthreads(THREAD_X, THREAD_Y, 1)]
void csCloud(uint gi : SV_GroupIndex)
{
	float3 basePos = (float3((gi % 10), (gi % 100) / 10, gi / 100) - 4.5) * 0.1;

	float4 rnd = hash43(basePos);

	float d = sqrt(rnd.w);
	float3 pos = normalize(rnd.xyz-0.5)*d;

#if SPHERE
	float v = 1;
#else
	float3 scale = hash31(rndSeed);
	pos *= scale*0.5 + 0.7;

	const float yScale = 0.7;

	d = 1 - d;
	float sn = snoise(float4(pos, rndSeed * 10));

	pos.y *= pos.y > 0 ? yScale : yScale*0.1;

	float v = saturate(sn + d*d);
	v = v > 0 ? v*0.75 + 0.25 : 0;
#endif

	sbParticles[gi].posRadius.xyz = pos * effectScale;
	sbParticles[gi].posRadius.w = effectScale;
	sbParticles[gi].sizeLifeOpacityRnd.x = effectScale*v*1.2; // particle size

	sbParticles[gi].sizeLifeOpacityRnd.z = 0.5*v*opacityMax; // opacity
	sbParticles[gi].clusterLightAge.z = 0;
	sbParticles[gi].sizeLifeOpacityRnd.y = 1;
	sbParticles[gi].sizeLifeOpacityRnd.w = rnd.w + rnd.x + rnd.y + rnd.z;
	sbParticles[gi].ang = 0;

}

technique11 techCloud
{
	pass { SetComputeShader( CompileShader( cs_5_0, csCloud() ) );	}
}


#define RADIX_BIT_MAX 31
// #define RADIX_BIT_MIN 26
#define RADIX_BIT_MIN 16
// #define RADIX_BIT_MIN 12

#define RADIX_OUTPUT_BUFFER		sbSortedIndices
#define RADIX_THREAD_X			THREAD_X
#define RADIX_THREAD_Y			THREAD_Y
#define RADIX_TECH_NAME			techRadixSort
#define RADIX_KEY_FUNCTION_BODY(id) \
	float3 p = sbParticles[id].posRadius.xyz + worldOffset.xyz  - gCameraPos.xyz; \
	return floatToUInt(dot(p,p));
// #define RADIX_NO_LOCAL_INDICES
#include "ParticleSystem2/common/radixSort.hlsl"


#define LIGHTING_OUTPUT(id)				sbParticles[id].clusterLightAge.x
#define LIGHTING_THREAD_X				THREAD_X
#define LIGHTING_THREAD_Y				THREAD_Y
#define LIGHTING_TECH_NAME				techLighting
#define LIGHTING_FLAGS					(LF_CLUSTER_OPACITY)
#define LIGHTING_CLUSTER_POS(id)		(sbParticles[id].posRadius.xyz)
// #define LIGHTING_CLUSTER_RADIUS(id)	(sbParticles[id].posRadius.w + sbParticles[id].sizeLifeOpacityRnd.x)
#define LIGHTING_CLUSTER_RADIUS(id)		(sbParticles[id].sizeLifeOpacityRnd.x*emitterParams2.x)
#define LIGHTING_CLUSTER_OPACITY(id)	(sbParticles[id].sizeLifeOpacityRnd.z*emitterParams2.y)
#define LIGHTING_DECAY					(emitterParams2.z)
#include "ParticleSystem2/common/clusterLighting.hlsl"

