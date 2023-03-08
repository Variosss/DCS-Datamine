#ifndef BLUR_COMPUTE_HLSL
#define BLUR_COMPUTE_HLSL

#include "common/samplers11.hlsl"

Texture2D<float4>	InputMap;
RWTexture2D<float4>	OutputMap;

#define FILTER_OFFSET (FILTER_SIZE / 2)
 
static const float filter[FILTER_SIZE] = {
	FILTER_KERNEL0
	FILTER_KERNEL1
	FILTER_KERNEL2
	FILTER_KERNEL3
	FILTER_KERNEL4
};

groupshared float4 sharedPixels[SHARED_PIXELS_COUNT];

[numthreads(SIZE_X, 1, 1)]
void csBlurSeparableH(uint3 DispatchThreadID: SV_DispatchThreadID) 
{
	[unroll]
	for(uint pixel=0; pixel<PIXELS_PER_THREAD_X; ++pixel)
	{
		uint id = DispatchThreadID.x * PIXELS_PER_THREAD_X + pixel;
		sharedPixels[id] = InputMap.Load(uint3(id, DispatchThreadID.yz));
	}
	GroupMemoryBarrierWithGroupSync();

	[unroll]
	for(pixel=0; pixel<PIXELS_PER_THREAD_X; ++pixel)
	{
		uint id = DispatchThreadID.x*PIXELS_PER_THREAD_X + pixel;
		int  idMin = (int)id - FILTER_OFFSET;
		float4 color = 0;
		for(int i=0; i<FILTER_SIZE; ++i)
			color += sharedPixels[ max(0, min(idMin + i, (SIZE_X * PIXELS_PER_THREAD_X)-1) ) ] * filter[i];
		
		OutputMap[uint2(id, DispatchThreadID.y)] = color;
	}
}

[numthreads(1, SIZE_Y, 1)]
void csBlurSeparableV(uint3 DispatchThreadID: SV_DispatchThreadID) 
{
	[unroll]
	for(uint pixel=0; pixel<PIXELS_PER_THREAD_Y; ++pixel)
	{
		uint id = DispatchThreadID.y * PIXELS_PER_THREAD_Y + pixel;
		sharedPixels[id] = InputMap.Load(uint3(DispatchThreadID.x, id, DispatchThreadID.z));
	}
	GroupMemoryBarrierWithGroupSync();

	[unroll]
	for(pixel=0; pixel<PIXELS_PER_THREAD_Y; ++pixel)
	{
		uint id = DispatchThreadID.y*PIXELS_PER_THREAD_Y + pixel;
		int  idMin = (int)id - FILTER_OFFSET;
		float4 color = 0;
		for(int i=0; i<FILTER_SIZE; ++i)
			color += sharedPixels[ max(0, min(idMin + i, (SIZE_Y * PIXELS_PER_THREAD_Y)-1)) ] * filter[i];

		OutputMap[uint2(DispatchThreadID.x, id)] = color;
	}
}

technique10 BlurComputeTech
{
	pass Horizontal
	{
		SetComputeShader(CompileShader(cs_5_0, csBlurSeparableH()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
	pass Vertical
	{
		SetComputeShader(CompileShader(cs_5_0, csBlurSeparableV()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}

#endif
