#include "common/samplers11.hlsl"
#include "common/BRDF.hlsl"

TextureCube envCube;
RWTexture2D<float4> destTexture0;
RWTexture2D<float4> destTexture1;
RWTexture2D<float4> destTexture2;
RWTexture2D<float4> destTexture3;
RWTexture2D<float4> destTexture4;
RWTexture2D<float4> destTexture5;

struct SHKnot
{
	float4 walls[6];
};
RWStructuredBuffer<SHKnot> resolvedKnots;

float	mip;
uint2	destId;//pixel
uint3	knotId;

static const float3 normals[] = {
	{1,  0,  0},
	{-1, 0,  0},
	{0,  1,  0},
	{0, -1,  0},
	{0,  0,  1},
	{0,  0, -1},
};

[numthreads(6,1,1)]
void csCopyCubeMipToSHSource(uint3 dId: SV_DispatchThreadID)
{
	const uint wall = dId.x;
	float4 source = envCube.SampleLevel(gPointClampSampler, normals[wall], mip);
	
#if 0 
	float4 colors[] = {
		{1,0,0,1},
		{0,1,0,1},
		{0,0,1,1},
		{1,1,0,1},
		{1,0,1,1},
		{0,1,1,1},
	};	
	switch(wall)
	{
	case 0: destTexture0[destId] = colors[0];break;
	case 1: destTexture1[destId] = colors[1];break;
	case 2: destTexture2[destId] = colors[2];break;
	case 3: destTexture3[destId] = colors[3];break;
	case 4: destTexture4[destId] = colors[4];break;
	case 5: destTexture5[destId] = colors[5];break;
	}
#endif

	switch(wall)
	{
	case 0: destTexture0[destId] = source;break;
	case 1: destTexture1[destId] = source;break;
	case 2: destTexture2[destId] = source;break;
	case 3: destTexture3[destId] = source;break;
	case 4: destTexture4[destId] = source;break;
	case 5: destTexture5[destId] = source;break;
	}
	
#if 0
	if(dId.z<2)
		destTexture[dId] = float4(1,0,0, 1);
	else if(dId.z<4)
		destTexture[dId] = float4(0,1,0, 1);
	else
		destTexture[dId] = float4(0,0,1, 1);
#endif
}

technique10 tech
{
	pass CopyCubeMipToTextureArray
	{
		SetComputeShader(CompileShader(cs_5_0, csCopyCubeMipToSHSource()));
	}
	pass CopyCubeMipToStructuredBuffer
	{
		SetComputeShader(CompileShader(cs_5_0, csCopyCubeMipToSHSource()));
	}
}
