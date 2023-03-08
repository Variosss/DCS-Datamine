#include "ParticleSystem2/common/motion.hlsl"
#include "ParticleSystem2/common/perlin.hlsl"
#include "ParticleSystem2/common/clusterComputeCommon.hlsl"

RWStructuredBuffer<PuffCluster>	sbParticles;
RWStructuredBuffer<uint>		sbSortedIndices;

float4	emitterParams;//emitter time, phase, wind.xy
float4	emitterParams2;
float4	emitterParams3;
uint	emitterParamsInt;
float4	worldOffset; //xyz - world offset, w - dt

#define front			worldOffset.xyz
#define dT				worldOffset.w
#define emitterTime		emitterParams.x
#define windDir			emitterParams.zw
#define effectLifetime	emitterParams2.x
#define puffRadius		emitterParams2.y
#define clusterRadius	emitterParams2.z
#define particleSize	emitterParams2.w
#define surfaceNormal	emitterParams3.xyz
#define effectOpacity	emitterParams3.w

static const float distMin = 0.01;
static const float nEffectAge = emitterTime/effectLifetime;

float4 noise4(float4 x)
{
	return frac(sin(x*4.2337) * 3758.5453);
}

float3 noise3(float3 x)
{
	return frac(sin(x*5.23937) * 3758.5453);
}

float noise1(float param, float factor = 13758.937545312382)
{
	return frac(sin(param) * factor);
}

float3 localToWorldSpace(float3 pos)
{
#ifdef USE_TRANSFORM_MATRIX
	float3x3 M = {front, up, side};
	float3x3 world = basis(surfaceNormal);
	return mul(pos, M);
#else
	//simple rotation around Y axis for explosions
	float2x2 mRotY = {front.x, front.z, -front.z, front.x};
	float3x3 world = basis(surfaceNormal);
	float3 p = float3(mul(pos.xz, mRotY), pos.y);
	return mul(p.xzy, world);
#endif
}

void initParticle(uint gi, in float3 pos, in float size, in float life, in float angleY)
{
	sbParticles[gi].posRadius.xyz = pos;
	sbParticles[gi].sizeLifeOpacityRnd.x = size;
	sbParticles[gi].sizeLifeOpacityRnd.y = life;
	sbParticles[gi].sizeLifeOpacityRnd.z = 0;
	sbParticles[gi].clusterLightAge.z = 0;
	float2 sc;
	sincos(angleY, sc.x, sc.y);
	sbParticles[gi].mLocalToWorld = makeRotY(sc);
	sbParticles[gi].ang = 0;
}

void simulateGroundPuffReal(uint gi, uniform float waveVelocity, uniform float delay = 0.0)
{
	float uniqId = sbParticles[gi].sizeLifeOpacityRnd.w;
	float4 rnd = noise4(uniqId.xxxx + float4(0, 1.272136, 1.642332, 0.6812683));
	
	float2 dir;
	sincos(uniqId*6.28, dir.x, dir.y);	

	float dist = distMin + max(0, puffRadius-distMin) * rnd.w;
	float nDist = dist / puffRadius;

	float particelStartDelay = dist / waveVelocity;
	
	float age = max(0, emitterTime - delay - particelStartDelay);
	float nAge = age / (effectLifetime - delay - particelStartDelay);
	float nEffectAge = max(0,emitterTime - delay) / effectLifetime;
	
	float energyFactor = pow((1 - 0.7*rnd.w), 2); //падение энергии с квадратом расстояния до пуфика от центра взрыва
	float sizeFactor = 1 - exp(-age*0.8);
	float popupFactor = saturate(10*(age-0.2*nDist));
	float opacityFactor = saturate(20*age) * (1 - 0.1*sizeFactor) * saturate(1.1 - 1.1*nAge) * energyFactor * 0.5;
	float size = particleSize * (0.625 + 0.375*(1-0.5*rnd.w) + 0.5*sizeFactor);

	float3 pos = float3(dir.x*dist, (particleSize*0.5 + clusterRadius)*0.6, dir.y*dist);
	pos.xz += dir * (1-exp(-age*7)) * min(0.7, energyFactor*energyFactor) * (puffRadius/5);
	pos.xyz = localToWorldSpace(pos.xyz);
	
	//спорно!!! эффект кладется по нормали к поверхности, и при ветре поидее должен скользить по поверхности, а не просто по мировому вектору
	float3 velAddWind = noise3(uniqId.xxx + float3(1.272136, 1.642332, 0.6812683));
	//velAddWind.y /= 5.0;
	float my_noise1 = noise1(uniqId*gi+1.804);
	float my_noise2 = noise1(gi+4.562);
	pos.xz += windDir * age*1.1*abs(my_noise1*my_noise2);
	// + velAddWind.xy*age;

	initParticle( gi,
		pos,
		size,
		effectLifetime,//lifetime
		0*rnd.w*45.125481//angle
		);
	
	// sbParticles[gi].posRadius.y = 1 + (popupFactor + age*pow(sbParticles[gi].sizeLifeOpacityRnd.w,4)*0.7) * (1-0.5*nDist);
	// sbParticles[gi].posRadius.y += 3*opacityFactor;
	
	sbParticles[gi].posRadius.w = clusterRadius;
	sbParticles[gi].sizeLifeOpacityRnd.z = saturate(opacityFactor * (abs(my_noise1* my_noise2)+0.3) * effectOpacity*(1.0-1.5*nAge)); //saturate(nEffectAge2*2);
	if (nAge > 0.7) {
		sbParticles[gi].sizeLifeOpacityRnd.z  = 0.0;
	}
	sbParticles[gi].clusterLightAge.z = emitterTime-delay;
}

void simulateGroundPuff(uint gi, uniform float delay = 0.0)
{
	if(sbParticles[gi].clusterLightAge.z < sbParticles[gi].sizeLifeOpacityRnd.y)
	{
		// sbParticles[gi].posRadius.y += (1+4*sbParticles[gi].sizeLifeOpacityRnd.z)*dt;
		float age = max(0, sbParticles[gi].clusterLightAge.z - delay);
		float nAge = age / sbParticles[gi].sizeLifeOpacityRnd.y;
		float nEffectAge2 = max(0,emitterTime-delay) / effectLifetime;
		float effectOpacityFactor =  1 - max(0, nEffectAge2-0.5)*2;
		float nDist = length(sbParticles[gi].posRadius.xz) / puffRadius;
		float2 dir = normalize(sbParticles[gi].posRadius.xz);

		float popupFactor = saturate(10*(age-0.2*nDist));
		float opacityFactor = saturate(2*age)*(1-nDist*0.5);

		sbParticles[gi].posRadius.y = 1 + (popupFactor + age*pow(sbParticles[gi].sizeLifeOpacityRnd.w,4)*0.7) * (1-0.5*nDist);

		float3 velAddWind = noise3((gModelTime + gi*0.7927153927).xxx+ float3(1.272136, 1.642332, 0.6812683));
		velAddWind.y /= 5.0;
		sbParticles[gi].posRadius.xz += dir * (dT * 0.45 * sbParticles[gi].sizeLifeOpacityRnd.w)
									  + windDir * (dT * sbParticles[gi].posRadius.y * mad(sbParticles[gi].sizeLifeOpacityRnd.w, 0.8, 0.2)) + velAddWind.xy*dT;


	//pos.xz += windDir * age + velAddWind.xz*age;

		sbParticles[gi].sizeLifeOpacityRnd.x += dT*0.225;	// scale
		sbParticles[gi].sizeLifeOpacityRnd.z = saturate(opacityFactor * saturate((1-nAge)*1.5) * 0.8 * effectOpacityFactor); // opacity
		
		sbParticles[gi].mToWorld = getCircleVortexRotation(sbParticles[gi].mLocalToWorld, sbParticles[gi].posRadius.xyz, sqrt(sbParticles[gi].ang));
		sbParticles[gi].ang += dT*3 / (1 + 0.25*sbParticles[gi].clusterLightAge.z);
	}
	else if(emitterTime < effectLifetime*0.5)
	{	//new
		
		float uniqueKey = gModelTime + gi*0.7927153927;
		float4 rnd = noise4(uniqueKey.xxxx + float4(0, 1.272136, 1.642332, 0.6812683));
		float2 sc;
		sincos(rnd.y*6.28, sc.x, sc.y);
		
		initParticle( gi,
			float3(sc.x, rnd.z*0.4*(1-0.9*rnd.w), sc.y)*(1+(puffRadius-1)*rnd.w),//position
			5 * (1 - 0.3*rnd.w),//size
			0.5*effectLifetime*(1 + rnd.x*0.9),//lifetime
			rnd.w*45.125481//angle
			);
	}



	
}

//клубление дыма и пыли у земли с раздуванием по ветру
[numthreads(THREAD_X, THREAD_Y, 1)]
void csUpdate(uint gi : SV_GroupIndex)
{
	sbParticles[gi].clusterLightAge.z += dT;
	simulateGroundPuff(gi);
}

[numthreads(THREAD_X, THREAD_Y, 1)]
void csUpdateReal(uint gi : SV_GroupIndex)
{
	const float waveVelocity = 340.29 * 0.5;//уменьшим ка скорость звука в 2 раза для художественности появления эффекта
	const float timeDelay = 0.05;//пусть пыхает не сразу
	
	simulateGroundPuffReal(gi, waveVelocity, timeDelay);
}

technique11 techUpdateDefault
{
	pass { SetComputeShader( CompileShader( cs_5_0, csUpdate() ) );	}
}

technique11 techUpdateReal
{
	pass { SetComputeShader( CompileShader( cs_5_0, csUpdateReal() ) );	}
}
