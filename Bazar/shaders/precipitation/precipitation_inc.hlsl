#include "common/states11.hlsl"
#include "common/context.hlsl"
#include "common/random.hlsl"
#define CLOUDS_SHADOW
#include "ParticleSystem2/common/psCommon.hlsl"
#include "ParticleSystem2/common/psShading.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"

struct Vert
{
	float4 pos;
};

cbuffer cEffectParams
{
	float3	rainVel;			float	rainPower;
	float3  mistVel;			float	particlesMax;
	float3	cameraVel;			float	dT;
	float3	origin;				uint	mistParticlesOffset;
	float3	originMist;			float	mistParticlesMax;
	float4	clipSphere;	//x - радиус сферы, в которой барахтаются партиклы
						//y - 1/x
						//z - x^2
						//w - на сколько метров вперед сдвинута сфера от камеры вдоль вектора взгляда
	float4	clipSphereMist;

	float	particlesCellSize;
	float	mistCellSize;
	float	particleJitterVelocity;
	float	mistJitterVelocity;

	float	particleJitterFreq; float	mistJitterFreq;
	uint2	lightCount;

	float	rainCloudsAltitudeMin;
	float	rainCloudsAltitudeMax;
	float2	epDummy2;
};

#define clipRadius				clipSphere.x
#define clipRadiusInv			clipSphere.y
#define clipRadiusSq			clipSphere.z
#define clipSphereOffset		clipSphere.w

#define clipRadiusMist			clipSphereMist.x
#define clipRadiusMistInv		clipSphereMist.y
#define clipRadiusMistSq		clipSphereMist.z
#define clipSphereOffsetMist	clipSphereMist.w
