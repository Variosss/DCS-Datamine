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

uint2	viewportIdx;
uint2	targetSize;
#define histogramReadId viewportIdx.y

#define USE_WEIGHTS

#define HISTOGRAM_SIZE		32
#define KERNEL_SIZE			16

#define THREADGROUP_SIZEX	KERNEL_SIZE
#define THREADGROUP_SIZEY	KERNEL_SIZE

#define DOWNSAMPLING		8

static const uint2 tileSize	= uint2(targetSize.x / THREADGROUP_SIZEX, targetSize.y / THREADGROUP_SIZEY);// / DOWNSAMPLING;

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


float LuminanceToHistogramPos(float luminance)
{
	float logLuminance = log2(luminance);
	return saturate(logLuminance * inputLuminanceScaleOffset.x + inputLuminanceScaleOffset.y);
}

float HistogramPosToLuminance(float histogramPos)
{
	return histogramPos * inputLuminanceRange + inputLuminanceMin;
}

groupshared float sharedHistogram[HISTOGRAM_SIZE][THREADGROUP_SIZEX][THREADGROUP_SIZEY];

[numthreads(THREADGROUP_SIZEX, THREADGROUP_SIZEY, 1)]
void HistogramCS(uint3 groupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex)
{
	for(uint i = 0; i < HISTOGRAM_SIZE; ++i)
		sharedHistogram[i][groupThreadID.x][groupThreadID.y] = 0.0f;

	uint2 texelOffset = groupThreadID.xy * tileSize + uint2(0,0);

	uint2 texel;
	uint2 texelNext = texelOffset + tileSize;
	[loop]
	for(texel.x = texelOffset.x; texel.x<texelNext.x; texel.x += DOWNSAMPLING)
	{
		[loop]
		for(texel.y = texelOffset.y; texel.y<texelNext.y; texel.y += DOWNSAMPLING)
		{
			float2 d = SampleLuminance(texel, DOWNSAMPLING);;
			float lum = d.x;
			if(d.y > 0){
				// uint dbgId = (y*tileSize.x + x) % HISTOGRAM_SIZE;
				// float histogramPos = float(threadId) / (HISTOGRAM_SIZE-1);
				float histogramPos = LuminanceToHistogramPos(lum);//в интервале [0;1]

				float bucket = histogramPos * (HISTOGRAM_SIZE * 0.99999f);

			#ifdef USE_WEIGHTS
				uint bucket0 = uint(bucket);
				uint bucket1 = bucket0 + 1u;

				float weight1 = frac(bucket);
				float weight0 = 1.0f - weight1;

				sharedHistogram[bucket0][groupThreadID.x][groupThreadID.y] += weight0;
				sharedHistogram[bucket1][groupThreadID.x][groupThreadID.y] += weight1;
			#else
				sharedHistogram[uint(bucket+0.5)][groupThreadID.x][groupThreadID.y] += 1.0f;
			#endif
			}
		}
	}
	GroupMemoryBarrierWithGroupSync();
	
	//собираем гистограмму в кучку
	if(threadId < HISTOGRAM_SIZE)
	{
		float sum = 0;

		[unroll]
		for(uint y = 0; y<THREADGROUP_SIZEY; ++y)
		{
			[loop]
			for(uint x = 0; x<THREADGROUP_SIZEX; ++x)
			{
				sum += sharedHistogram[threadId][x][y];
			}
		}

		uint2 histogramQuadSize = uint2(THREADGROUP_SIZEX * tileSize.x, THREADGROUP_SIZEY * tileSize.y) / DOWNSAMPLING;

		float normFactor = 1.0f / (histogramQuadSize.x * histogramQuadSize.y);

		float histogramPartCur = sum * normFactor;

	#if STAGES_COUNT>1
		float histogramAvg = histogramPartCur;
		uint partId = histogramReadId;
		[unroll]
		for(uint i=0; i<STAGES_COUNT-1; ++i)
		{
			uint id = threadId + (1 + partId) * HISTOGRAM_SIZE;
			float histogramPart = histogramInput[id];
			histogramOutput[id] = histogramPart;
			
			histogramAvg += histogramPart;
			partId = (partId + 1) % STAGES_COUNT;
		}
		histogramOutput[threadId + (1 + partId) * HISTOGRAM_SIZE] = histogramPartCur;

		histogramOutput[threadId]		= histogramAvg / STAGES_COUNT;
		sharedHistogram[threadId][0][0] = histogramAvg / STAGES_COUNT;
	#else
		histogramOutput[threadId]		= histogramPartCur;
		sharedHistogram[threadId][0][0] = histogramPartCur;
	#endif
	}
	GroupMemoryBarrierWithGroupSync();
	
	//считаем среднюю яркость
	if(threadId == 0)
	{
		float histogramSum = 0.0;
		for(uint i=0; i<HISTOGRAM_SIZE; ++i)
		{
			histogramSum += sharedHistogram[i][0][0];
		}
		float histogramMin = histogramSum * percentMin;
		float histogramMax = histogramSum * percentMax;
		
		float2 averageLuminance = 0;
		
		for(i=0; i<HISTOGRAM_SIZE; ++i)
		{
			float weight = sharedHistogram[i][0][0];
			float logLum = HistogramPosToLuminance(float(i)/(HISTOGRAM_SIZE-1));
			
			float minReductionAmount = min(weight, histogramMin);
			float weightAfterMinReduction = weight - minReductionAmount;//остаток для учета яркости
			
			histogramMin -= minReductionAmount;
			histogramMax -= minReductionAmount;
			
			float weightAfterMaxReduction = min(weightAfterMinReduction, histogramMax);
			histogramMax -= weightAfterMaxReduction;
			
			averageLuminance += float2(logLum*weightAfterMaxReduction, weightAfterMaxReduction);
		}

		luminanceResult[LUMINANCE_VIEWPORT_0 + viewportIdx.x] = float2( exp2(averageLuminance.x / max(1.0e-4, averageLuminance.y)), 0);
	}
}

[numthreads(THREADGROUP_SIZEX, THREADGROUP_SIZEY, 1)]
void HistogramCSCockpit(uint3 groupThreadID: SV_GroupThreadID, uint threadId: SV_GroupIndex, uniform int cockpit = 0)
{
	for(uint i = 0; i < HISTOGRAM_SIZE; ++i)
		sharedHistogram[i][groupThreadID.x][groupThreadID.y] = 0.0f;

	uint2 texelOffset = groupThreadID.xy * tileSize + uint2(0,0);

	uint2 texel;
	uint2 texelNext = texelOffset + tileSize;
	[loop]
	for(texel.x = texelOffset.x; texel.x<texelNext.x; texel.x += DOWNSAMPLING)
	{
		[loop]
		for(texel.y = texelOffset.y; texel.y<texelNext.y; texel.y += DOWNSAMPLING)
		{
			float2 d = SampleLuminanceCockpit(texel, DOWNSAMPLING, cockpit);;
			float lum = d.x;
			if(d.y > 0){
				// uint dbgId = (y*tileSize.x + x) % HISTOGRAM_SIZE;
				// float histogramPos = float(threadId) / (HISTOGRAM_SIZE-1);
				float histogramPos = LuminanceToHistogramPos(lum);//в интервале [0;1]

				float bucket = histogramPos * (HISTOGRAM_SIZE * 0.99999f);

			#ifdef USE_WEIGHTS
				uint bucket0 = uint(bucket);
				uint bucket1 = bucket0 + 1u;

				float weight1 = frac(bucket);
				float weight0 = 1.0f - weight1;

				sharedHistogram[bucket0][groupThreadID.x][groupThreadID.y] += weight0;
				sharedHistogram[bucket1][groupThreadID.x][groupThreadID.y] += weight1;
			#else
				sharedHistogram[uint(bucket+0.5)][groupThreadID.x][groupThreadID.y] += 1.0f;
			#endif
			}
		}
	}
	GroupMemoryBarrierWithGroupSync();
	
	//собираем гистограмму в кучку
	if(threadId < HISTOGRAM_SIZE)
	{
		float sum = 0;

		[unroll]
		for(uint y = 0; y<THREADGROUP_SIZEY; ++y)
		{
			[loop]
			for(uint x = 0; x<THREADGROUP_SIZEX; ++x)
			{
				sum += sharedHistogram[threadId][x][y];
			}
		}

		uint2 histogramQuadSize = uint2(THREADGROUP_SIZEX * tileSize.x, THREADGROUP_SIZEY * tileSize.y) / DOWNSAMPLING;

		float normFactor = 1.0f / (histogramQuadSize.x * histogramQuadSize.y);

		float histogramPartCur = sum * normFactor;

	#if STAGES_COUNT>1
		float histogramAvg = histogramPartCur;
		uint partId = histogramReadId;
		[unroll]
		for(uint i=0; i<STAGES_COUNT-1; ++i)
		{
			uint id = threadId + (1 + partId) * HISTOGRAM_SIZE;
			float histogramPart = histogramInput[id];
			histogramOutput[id] = histogramPart;
			
			histogramAvg += histogramPart;
			partId = (partId + 1) % STAGES_COUNT;
		}
		histogramOutput[threadId + (1 + partId) * HISTOGRAM_SIZE] = histogramPartCur;

		histogramOutput[threadId]		= histogramAvg / STAGES_COUNT;
		sharedHistogram[threadId][0][0] = histogramAvg / STAGES_COUNT;
	#else
		histogramOutput[threadId]		= histogramPartCur;
		sharedHistogram[threadId][0][0] = histogramPartCur;
	#endif
	}
	GroupMemoryBarrierWithGroupSync();
	
	//считаем среднюю яркость
	if(threadId == 0)
	{
		float histogramSum = 0.0;
		for(uint i=0; i<HISTOGRAM_SIZE; ++i)
		{
			histogramSum += sharedHistogram[i][0][0];
		}
		float histogramMin = histogramSum * percentMin;
		float histogramMax = histogramSum * percentMax;
		
		float2 averageLuminance = 0;
		
		for(i=0; i<HISTOGRAM_SIZE; ++i)
		{
			float weight = sharedHistogram[i][0][0];
			float logLum = HistogramPosToLuminance(float(i)/(HISTOGRAM_SIZE-1));
			
			float minReductionAmount = min(weight, histogramMin);
			float weightAfterMinReduction = weight - minReductionAmount;//остаток для учета яркости
			
			histogramMin -= minReductionAmount;
			histogramMax -= minReductionAmount;
			
			float weightAfterMaxReduction = min(weightAfterMinReduction, histogramMax);
			histogramMax -= weightAfterMaxReduction;
			
			averageLuminance += float2(logLum*weightAfterMaxReduction, weightAfterMaxReduction);
		}

		luminanceResult[LUMINANCE_VIEWPORT_0 + viewportIdx.x] = float2( exp2(averageLuminance.x / max(1.0e-4, averageLuminance.y)), 0);
	}
}

technique10 Histogram
{
	pass computeHistogram
	{
		SetComputeShader(CompileShader(cs_5_0, HistogramCS()));
	}
	pass computeHistogramCockpitInside
	{
		SetComputeShader(CompileShader(cs_5_0, HistogramCSCockpit(1)));
	}
	pass computeHistogramCockpitOutside
	{
		SetComputeShader(CompileShader(cs_5_0, HistogramCSCockpit(0)));
	}
}
