#include "common/states11.hlsl"
#include "common/samplers11.hlsl"
#include "common/context.hlsl"
#include "common/stencil.hlsl"

#include "deferred/tonemapCommon.hlsl"
#include "common/ambientCube.hlsl"
#define WRITE_LUMINANCE
#include "deferred/luminance.hlsl"
#include "deferred/Decoder.hlsl"

Buffer<float>				histogramInput;
RWBuffer<float>				histogramOutput;
RWBuffer<uint>				histogramInt;
RWBuffer<uint>				histogramIntFinal;

uint2	viewportIdx;
uint2	targetSize;
#define histogramReadId viewportIdx.y
#define offsetID viewportIdx.y
#define USE_WEIGHTS

#define KERNEL_SIZE			16

#define THREADGROUP_SIZEX	KERNEL_SIZE
#define THREADGROUP_SIZEY	KERNEL_SIZE
#define HISTOGRAM_SIZE		KERNEL_SIZE*KERNEL_SIZE

#define DOWNSAMPLING		8

static const uint2 tileSize	= uint2(targetSize.x / THREADGROUP_SIZEX, targetSize.y / THREADGROUP_SIZEY);// / DOWNSAMPLING;
static const uint2 targetSizeMSAA = targetSize*DOWNSAMPLING;
float SampleLuminance(uint2 texel, uniform int downsampling = 1)
{
	float3 color = 0;
	float weight = 1;

#if DOWNSAMPLING > 1
	#if STAGES_COUNT == 1
		static const uint2 offset[] = {{0,0}, {0,DOWNSAMPLING/2}, {DOWNSAMPLING/2, 0}, {DOWNSAMPLING/2, DOWNSAMPLING/2}};
		[unroll]
		for(uint i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
		#if DOWNSAMPLING == 4
			texel += 1;//семплируем в шахматном порядке
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			weight *= 0.125;
		#elif DOWNSAMPLING == 8
			texel.x += DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.y += DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.x -= DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.y -= DOWNSAMPLING/2;
			weight *= 1/16.0;
		#else
			weight *= 0.25;
		#endif
	#else//if stages > 1
		//patterns for each compute stage
		#if DOWNSAMPLING == 2
			#if STAGES_COUNT>2
				#error "stages count greater then 2 is not supported yet"
			#endif
			static const uint2 pattern2x2[2][2] = {{{0,0}, {1, 1}},	{{0,1}, {1, 0}}};
			[unroll] for(uint i=0; i<2; ++i)	color += SampleMap(ComposedMap, texel + pattern2x2[histogramReadId][i], 0).rgb;
			weight *= 0.5;
		#elif DOWNSAMPLING == 4
			#if STAGES_COUNT>2
				#error "stages count greater then 2 is not supported yet"
			#endif
			static const uint2 pattern4x4[2][4] = {
				{{0,2}, {1,0}, {2,3}, {1, 3}},
				{{3,0}, {1,1}, {2,2}, {0, 3}}};
			[unroll] for(uint i=0; i<4; ++i)	color += SampleMap(ComposedMap, texel + pattern4x4[histogramReadId][i], 0).rgb;
			weight *= 0.25;
		#elif DOWNSAMPLING == 8
			static const uint2 pattern8x8[3][4] = {
				{{4,1}, {0,3}, {6,5}, {2, 7}},
				{{0,0}, {6,2}, {2,4}, {4, 6}},
				{{2,1}, {4,3}, {0,5}, {6, 7}}};
			[unroll] for(uint i=0; i<4; ++i)	color += SampleMap(ComposedMap, texel + pattern8x8[histogramReadId][i], 0).rgb;
			weight *= 0.25;
		#endif
	#endif
#else
	color = SampleMap(ComposedMap, texel, 0).rgb;
#endif

	// return calcLuminance(color);
	return max(color.r, max(color.g, color.b)) * weight;
}


float2 SampleLuminanceCockpit(uint2 texel, uniform int downsampling = 1, uniform int cockpit = 0)
{
	float3 color = 0;
	float weight = 1;
	float samples = 0;
	
#if DOWNSAMPLING > 1
	#if STAGES_COUNT == 1
		static const uint2 offset[] = {{0,0}, {0,DOWNSAMPLING/2}, {DOWNSAMPLING/2, 0}, {DOWNSAMPLING/2, DOWNSAMPLING/2}};
		[unroll]
		for(uint i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
		#if DOWNSAMPLING == 4
			texel += 1;//семплируем в шахматном порядке
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			weight *= 0.125;
		#elif DOWNSAMPLING == 8
			texel.x += DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.y += DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.x -= DOWNSAMPLING/2;
			for(i=0; i<4; ++i) color += SampleMap(ComposedMap, texel + offset[i], 0).rgb;
			texel.y -= DOWNSAMPLING/2;
			weight *= 1/16.0;
		#else
			weight *= 0.25;
		#endif
	#else//if stages > 1
		//patterns for each compute stage
		#if DOWNSAMPLING == 2
			#if STAGES_COUNT>2
				#error "stages count greater then 2 is not supported yet"
			#endif
			static const uint2 pattern2x2[2][2] = {{{0,0}, {1, 1}},	{{0,1}, {1, 0}}};
			[unroll] for(uint i=0; i<2; ++i)	color += SampleMap(ComposedMap, texel + pattern2x2[histogramReadId][i], 0).rgb;
			weight *= 0.5;
		#elif DOWNSAMPLING == 4
			#if STAGES_COUNT>2
				#error "stages count greater then 2 is not supported yet"
			#endif
			static const uint2 pattern4x4[2][4] = {
				{{0,2}, {1,0}, {2,3}, {1, 3}},
				{{3,0}, {1,1}, {2,2}, {0, 3}}};
			[unroll] for(uint i=0; i<4; ++i)	color += SampleMap(ComposedMap, texel + pattern4x4[histogramReadId][i], 0).rgb;
			weight *= 0.25;
		#elif DOWNSAMPLING == 8
			static const uint2 pattern8x8[3][4] = {
				{{4,1}, {0,3}, {6,5}, {2, 7}},
				{{0,0}, {6,2}, {2,4}, {4, 6}},
				{{2,1}, {4,3}, {0,5}, {6, 7}}};
			[unroll] for(uint i=0; i<4; ++i)	{
				uint matID = SampleMap(StencilMap, texel + pattern8x8[histogramReadId][i], 0).g & STENCIL_COMPOSITION_MASK;
				float3 c = SampleMap(ComposedMap, texel + pattern8x8[histogramReadId][i], 0).rgb;
				if(matID == STENCIL_COMPOSITION_COCKPIT){
					if(cockpit == 1){
						color += c;	
						samples += 1;
					}
				}
				else{
					if(cockpit == 0){
						color += c;
						samples += 1;
					}

				}
				
				
			}
			weight *= 0.25;
		#endif
	#endif
#else
	color = SampleMap(ComposedMap, texel, 0).rgb;
#endif

	if(samples > 0){
		color /= samples;
	}
	// return calcLuminance(color);
	return float2(max(color.r, max(color.g, color.b)), samples);
}

uint colorToBin(float lum) {
  // Avoid taking the log of zero
  if (lum < 0.00001) {
    return 0;
  }

  // Calculate the log_2 luminance and express it as a value in [0.0, 1.0]
  // where 0.0 represents the minimum luminance, and 1.0 represents the max.
  float logLum = clamp(log2(lum)* inputLuminanceScaleOffset.x + inputLuminanceScaleOffset.y, 0.0, 1.0);

  // Map [0, 1] to [1, 255]. The zeroth bin is handled by the epsilon check above.
  return uint(logLum * float(HISTOGRAM_SIZE-2) + 1.0);
}

float LuminanceToHistogramPos(float luminance)
{
	if(luminance < 0.00001){
		return 0;
	}
	float logLuminance = log2(luminance);
	return saturate(logLuminance * inputLuminanceScaleOffset.x + inputLuminanceScaleOffset.y);
}

float HistogramPosToLuminance(float histogramPos)
{
	return histogramPos * inputLuminanceRange + inputLuminanceMin;
}
#define RGB_TO_LUM float3(0.2125, 0.7154, 0.0721)

groupshared uint sharedHistogram[HISTOGRAM_SIZE];
groupshared uint sharedHistogramCounters[HISTOGRAM_SIZE];

[numthreads(THREADGROUP_SIZEX, THREADGROUP_SIZEY, 1)]
void HistogramCS(uint3 groupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex, uint3 globalThreadID: SV_DispatchThreadID)
{
	uint localIndex = groupThreadID.x*THREADGROUP_SIZEY+groupThreadID.y;
	sharedHistogram[localIndex] = 0.0f;
	GroupMemoryBarrierWithGroupSync();


	if(globalThreadID.x < targetSize.x && globalThreadID.y < targetSize.y){

		uint2 p = globalThreadID.xy*4;
		static const uint2 pattern[16] = {{0,0}, {3,0}, {2,2}, {1,2}, {1,0}, {3,1}, {0,3}, {2,1}, {2, 3}, {0,2}, {2,0}, {3,2}, {0,1}, {1,1}, {3,3}, {1,3}};
		p += pattern[((globalThreadID.x/4)*4+(globalThreadID.y/4)+offsetID)%16];
		#if 0
			float lum = dot(SampleMap(ComposedMap, p, 0).rgb, RGB_TO_LUM);
		#else
			float3 c = SampleMap(ComposedMap, p, 0).rgb;
			float lum = max(c.r, max(c.g, c.b));
		#endif
		uint pos = colorToBin(lum);
		InterlockedAdd(sharedHistogram[pos], 1);
	}
	GroupMemoryBarrierWithGroupSync();

  	InterlockedAdd(histogramInt[localIndex], sharedHistogram[localIndex]);
}

#define COUNTER 0 // for inside cockpit exposure calculation

#if COUNTER
groupshared uint sharedHistogramCounters[HISTOGRAM_SIZE];
#endif


[numthreads(HISTOGRAM_SIZE, 1, 1)]
void HistogramCSAverage(uint3 groupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex	, uint3 globalThreadID: SV_DispatchThreadID)
{
	uint localIndex = groupThreadID.x;
	uint countForThisBin = histogramInt[localIndex];
	uint countForThisBinLast = histogramIntFinal[localIndex];
	float alpha = 0.1;
	countForThisBin = uint(lerp((float)countForThisBin, (float)countForThisBinLast, alpha));

	sharedHistogram[localIndex] = countForThisBin * localIndex;
	#if COUNTER
	sharedHistogramCounters[localIndex]	 = countForThisBin;
	#endif

	GroupMemoryBarrierWithGroupSync();

	// Reset the count stored in the buffer in anticipation of the next pass
	histogramInt[localIndex] = 0;
	histogramIntFinal[localIndex] = countForThisBin;

	// This loop will perform a weighted count of the luminance range
	[loop] 
	for (uint cutoff = (HISTOGRAM_SIZE >> 1); cutoff > 0; cutoff >>= 1) {
		if (uint(localIndex) < cutoff) {
			sharedHistogram[localIndex] += sharedHistogram[localIndex + cutoff];
			#if COUNTER
			sharedHistogramCounters[localIndex] += sharedHistogramCounters[localIndex + cutoff];
			#endif
		}

		GroupMemoryBarrierWithGroupSync();
	}

	// We only need to calculate this once, so only a single thread is needed.
	if (localIndex == 0) {
		
		// Here we take our weighted sum and divide it by the number of pixels
		// that had luminance greater than zero (since the index == 0, we can
		// use countForThisBin to find the number of black pixels)
		uint totalNumber;
		#if COUNTER
		totalNumber = sharedHistogramCounters[0];
		#else
		totalNumber = targetSize.x*targetSize.y/16;
		#endif
		float weightedLogAverage = (float(sharedHistogram[0]) / max(float(totalNumber-countForThisBin), 1.0)) - 1.0;
		// Map from our histogram space to actual luminance
		float weightedAvgLum = exp2(((weightedLogAverage / (float(HISTOGRAM_SIZE-2)))-inputLuminanceScaleOffset.y)/inputLuminanceScaleOffset.x);

		luminanceResult[LUMINANCE_VIEWPORT_0 + viewportIdx.x] = float2(weightedAvgLum, 0.0);
	}

	
	
}

technique10 Histogram
{
	pass computeHistogram
	{
		SetComputeShader(CompileShader(cs_5_0, HistogramCS()));
	}
	pass computeHistogramAverage
	{
		SetComputeShader(CompileShader(cs_5_0, HistogramCSAverage()));
	}
}
