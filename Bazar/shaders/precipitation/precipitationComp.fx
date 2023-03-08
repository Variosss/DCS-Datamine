#ifndef _PRECIPITATION_COMPUTE_HLSL
#define _PRECIPITATION_COMPUTE_HLSL

#include "precipitation_inc.hlsl"

RWStructuredBuffer<Vert> particles;

float time;	//время жизни эффекта

float3 tile(float3 pos, float t)
{
	return pos - floor(pos/t)*t;
}

//отсечение по сфере перед камерой
[numthreads(MAX_THREAD_XY, MAX_THREAD_XY, MAX_THREAD_Z)]
void csParticles( uint groupIndex : SV_GroupIndex, uint3 groupId : SV_GroupId, uint3 dtId: SV_DispatchThreadID,
				  uniform uint	 idOffset,
				  uniform float  cellSize,
				  uniform float3 particleVelocity,
				  uniform float  jitterFrequency,
				  uniform float  jitterVelocity)
{
	uint id = groupId.x*MAX_THREAD_XY*MAX_THREAD_XY*MAX_THREAD_Z + groupIndex + idOffset;
	
	float4 pos = particles[id].pos;
	pos.xyz += particleVelocity * dT;
	
	//имитации турбулентности
	float2 sc;
	sincos(smoothNoise1(pos.w * 10.412 + gModelTime*jitterFrequency, 13758.5453123) * PI2, sc.x, sc.y);
	pos.xz  += sc * jitterVelocity * dT;

	float halfSize = cellSize * 0.5;
	particles[id].pos.xyz = tile(pos.xyz-halfSize, halfSize*2) - halfSize;
}

technique11 particlesCompute
{
	pass particles
	{
		SetComputeShader(CompileShader(cs_5_0, csParticles(0, particlesCellSize, rainVel, particleJitterFreq, particleJitterVelocity)));
	}
	pass mist
	{
		SetComputeShader(CompileShader(cs_5_0, csParticles(mistParticlesOffset, mistCellSize, mistVel, mistJitterFreq, mistJitterVelocity)));
	}
}

#endif