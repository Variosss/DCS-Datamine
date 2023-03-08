#include "common/stencil.hlsl"

#define TEX_SIZE 256
#define THREAD_COUNT 24
#define THREAD_SIZE (TEX_SIZE / THREAD_COUNT)
#define TotalNumThreads (THREAD_COUNT * THREAD_COUNT)

Texture2D<float4> colorTex;
Texture2D<float>  depthTex;
Texture2D<uint2>  stencilTex;

struct Stats {
	float3	modelAvg, modelVar;
	float3	envAvg, envVar;
	float	modelCoverage;
};

RWStructuredBuffer<Stats>	result;

struct StatsCalc {
	float3	modelAvg, modelAvg2;
	float	modelCount;
	float3	envAvg, envAvg2;
	float	envCount;
};

// Shared memory
groupshared StatsCalc	SharedMem[TotalNumThreads];

void SampleAverage(uint2 samplePos, inout StatsCalc stats) {

	[unroll] 
	for (uint y = 0; y < THREAD_SIZE; ++y) {
		[unroll]
		for (uint x = 0; x < THREAD_SIZE; ++x) {
			uint3 uv = uint3(samplePos + uint2(x, y), 0);
			float3 color = colorTex.Load(uv).xyz;
			uint materialID = stencilTex.Load(uv).g;
			if ((materialID & STENCIL_COMPOSITION_MASK) == STENCIL_COMPOSITION_MODEL) {
				stats.modelAvg += color;
				stats.modelAvg2 += color*color;
				stats.modelCount++;
			} else {
				stats.envAvg += color;
				stats.envAvg2 += color*color;
				stats.envCount++;
			}
		}
	}
}

[numthreads(THREAD_COUNT, THREAD_COUNT, 1)]
void CS_Stats(uint3 GroupID: SV_GroupID, uint3 GroupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex)
{
	const uint2 sampleId = GroupThreadID.xy * THREAD_SIZE;
	
	StatsCalc stats;
	stats.modelAvg = stats.modelAvg2 = stats.envAvg = stats.envAvg2 = 0;
	stats.modelCount = stats.envCount = 0;

	SampleAverage(sampleId, stats);

	// Store in shared memory
	SharedMem[threadId] = stats;
	GroupMemoryBarrierWithGroupSync();

	// Parallel reduction
	[unroll(uint(ceil(log2(TotalNumThreads))))]
	for(uint s = TotalNumThreads / 2; s > 0; s >>= 1) {
		if(threadId < s) {
			SharedMem[threadId].modelAvg += SharedMem[threadId + s].modelAvg;
			SharedMem[threadId].modelAvg2 += SharedMem[threadId + s].modelAvg2;
			SharedMem[threadId].modelCount += SharedMem[threadId + s].modelCount;
			SharedMem[threadId].envAvg += SharedMem[threadId + s].envAvg;
			SharedMem[threadId].envAvg2 += SharedMem[threadId + s].envAvg2;
			SharedMem[threadId].envCount += SharedMem[threadId + s].envCount;
		}
		GroupMemoryBarrierWithGroupSync();
	}

	// Have the first thread write out to the output
	if (threadId == 0) {
		result[0].modelAvg = result[0].modelVar = result[0].envAvg = result[0].envVar = 0;
		if (SharedMem[0].modelCount > 0) {
			result[0].modelAvg = SharedMem[0].modelAvg / SharedMem[0].modelCount;
			result[0].modelVar = sqrt(SharedMem[0].modelAvg2 / SharedMem[0].modelCount - result[0].modelAvg*result[0].modelAvg);
		}
		if (SharedMem[0].envCount > 0) {
			result[0].envAvg = SharedMem[0].envAvg / SharedMem[0].envCount;
			result[0].envVar = sqrt(SharedMem[0].envAvg2 / SharedMem[0].envCount - result[0].envAvg*result[0].envAvg);
		}
		result[0].modelCoverage = SharedMem[0].modelCount / (SharedMem[0].modelCount + SharedMem[0].envCount);
	}

}

technique10 tech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_Stats()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

