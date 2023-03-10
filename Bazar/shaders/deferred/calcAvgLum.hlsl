#ifndef CALCAVGLUM_HLSL
#define CALCAVGLUM_HLSL

#define LUMINANCE_PASS_0	0
#define LUMINANCE_PASS_1	1
#define LUMINANCE_ONE_PASS	2
#define LUMINANCE_PASS_1_WITHOUT_ADAPTATION	3

#define USE_EXP_AVG			1

#define NUM_HISTOGRAM_BINS	(32)

#include "common/ambientCube.hlsl"
#include "deferred/tonemapCommon.hlsl"
#define WRITE_LUMINANCE
#include "deferred/luminance.hlsl"

Texture2D<float2>			InputTexture;
RWTexture2D<float2>			OutputTexture;

RWTexture2D<float>	feedbackExposure;

static const float expOffset = 1.0;

uint	viewportIdx;
uint	viewportCount;
float	timeDelta;
uint	viewportsMask;

#define LUM_TARGET_SIZE			32
#define LUM_TARGET_HALF_SIZE	(LUM_TARGET_SIZE >> 1)
#define TG_SIZE					16

// Constants
static const uint TotalNumThreads = TG_SIZE * TG_SIZE;

// Shared memory
groupshared float3	SharedMem[TotalNumThreads];

static const float2 invLumSize = float2(1.0/1024, 1.0/1024);

// Approximates luminance from an RGB value
float calcLuminance(float3 color) {
    return max(dot(color, float3(0.2126f, 0.7152f, 0.0722f)), 0.0001f);
}

float luminanceMapInternal(float2 uv) {
	uint2 pixel = viewportTransform(uv);
	float3 color = SampleMap(ComposedMap, pixel, 0).xyz;
	// calculate the luminance using a weighted average
	float result = calcLuminance(color);
#if USE_EXP_AVG
	result = log2(result+expOffset);
#endif
	return result;
}

float luminanceMap(uint2 idx) {
	return luminanceMapInternal(idx*invLumSize);
}

float luminanceMapOnePass(uint2 idx) {
	return max(luminanceMapInternal(idx*float2(1.0/LUM_TARGET_SIZE, 1.0/LUM_TARGET_SIZE)), 0);
}

void SampleAverageLuminance(uniform int lumPass, uint2 samplePos, out float avgLuminance, out float avgLuminanceSq, out float weightSum)
{
	const uint2 offset[4] = {{0,0}, {1,0}, {0,1}, {1,1}};
	float4 sample = 0.0;
	float4 sample2 = 0.0;
	float4 weight = 1.0;
	uint i;
	switch(lumPass) {
	case LUMINANCE_PASS_0:
		[unroll] for(i=0; i<4; ++i) sample[i] = luminanceMap(samplePos + offset[i]);
		sample2 = sample * sample;
		break;
	case LUMINANCE_ONE_PASS:
		[unroll] for(i=0; i<4; ++i) sample[i] = luminanceMapOnePass(samplePos + offset[i]);
		sample2 = sample * sample;
		break;
	case LUMINANCE_PASS_1:
	case LUMINANCE_PASS_1_WITHOUT_ADAPTATION:
		{
			float2 t[4];
			[unroll] for(i=0; i<4; ++i) t[i] = InputTexture[samplePos + offset[i]];
			sample  = float4(t[0].x, t[1].x, t[2].x, t[3].x);
			sample2 = float4(t[0].y, t[1].y, t[2].y, t[3].y);
		}
		break;
	}

	avgLuminance = (sample.x+sample.y+sample.z+sample.w) * 0.25;
	avgLuminanceSq = (sample2.x+sample2.y+sample2.z+sample2.w) * 0.25;
	weightSum = 1.0; //weight.x + weight.y + weight.z + weight.w;
}

[numthreads(TG_SIZE, TG_SIZE, 1)]
void CS_Lum(uint3 GroupID: SV_GroupID, uint3 GroupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex,	uniform int lumPass)
{
	const uint2 sampleId = (GroupID.xy * TG_SIZE + GroupThreadID.xy) * 2;
	
	float avgLuminance, avgLuminanceSq, weightSum;
	SampleAverageLuminance(lumPass, sampleId, avgLuminance, avgLuminanceSq, weightSum);

	// Store in shared memory
	SharedMem[threadId] = float3(avgLuminance, avgLuminanceSq, weightSum);
	GroupMemoryBarrierWithGroupSync();

	// Parallel reduction
	[unroll(uint(ceil(log2(TotalNumThreads))))]
	for(uint s = TotalNumThreads / 2; s > 0; s >>= 1) {
		if(threadId < s) {
			SharedMem[threadId] += SharedMem[threadId + s];
		}
		GroupMemoryBarrierWithGroupSync();
	}

	// Have the first thread write out to the output texture
	if(threadId == 0) {
		float2 m = SharedMem[0].xy / SharedMem[0].zz;
		switch(lumPass) {
			case LUMINANCE_PASS_0:
				OutputTexture[GroupID.xy] = m;
				break;
			case LUMINANCE_PASS_1:
				luminanceResult[LUMINANCE_VIEWPORT_0 + viewportIdx] = m;
				break;
			case LUMINANCE_PASS_1_WITHOUT_ADAPTATION:
				luminanceResult[LUMINANCE_AVERAGE] = m;
				break;
			case LUMINANCE_ONE_PASS:
				m.y = sqrt(m.y-m.x*m.x);
				m.x += m.y*dcSigmaKey;
			#if USE_EXP_AVG
				m.x = exp2(m.x)-expOffset;
			#endif
				luminanceResult[LUMINANCE_AVERAGE] = m; // instantaneous adaptation
				break;
		}
	}
}


#define AF_AVERAGE_LUMINACE			1
#define AF_INSTANT_ADAPTATION		2
#define AF_USE_AMBIENT_CUBE			4
#define AF_USE_FEEDBACK_EXPOSURE	8

#define MID_GRAY 0.18

// Slowly adjusts the scene luminance based on the previous scene luminance
[numthreads(1, 1, 1)]
void CS_Adaptation(uint3 GroupID : SV_GroupID, uint3 GroupThreadID : SV_GroupThreadID, uniform uint Flags) {

	float2 m = 0;
	if(Flags & AF_AVERAGE_LUMINACE)
	{
		uint count = 0;
		[loop]
		for(uint i=0; i<viewportCount; ++i)
		{
			if((viewportsMask >> i) & 1)
			{
				m += luminanceResult[LUMINANCE_VIEWPORT_0 + i];
				++count;
			}
		}
		m /= count;
	}
	else
	{
		m = luminanceResult[LUMINANCE_VIEWPORT_0 + viewportIdx];
	}
//	m.y = sqrt(max(0, m.y - m.x*m.x));
	m.y = max(0, m.y - m.x*m.x);

	float currentLum = m.x + m.y*dcSigmaKey;

	if (Flags & AF_USE_AMBIENT_CUBE) {
		float3 lum = AmbientAverageHorizon * 0.7 + 0.3 * AmbientTop;
		float averageCubeLum = max(lum.r, max(lum.g, lum.b));
		currentLum = currentLum * (1 - cubeAverageLumAmount) + cubeAverageLumAmount * averageCubeLum;
	}

	if(!(Flags & AF_INSTANT_ADAPTATION))	{
		// Adapt the luminance using Pattanaik's technique
		float lastLum = max(0, luminanceResult[LUMINANCE_AVERAGE].x);
		currentLum = lastLum + (currentLum - lastLum) * (1 - exp(-timeDelta * dcTau));
	}

	if (Flags & AF_USE_FEEDBACK_EXPOSURE) {
		feedbackExposure[uint2(0, 0)] = MID_GRAY / (currentLum * (1.0 - MID_GRAY));
	}

	luminanceResult[LUMINANCE_AVERAGE].x = currentLum;
}

#endif
