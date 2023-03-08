#define LIGHTS_PREPASS_MERGE
#include "common/lightsData.hlsl"

#define GROUPSIZE 64

StructuredBuffer<OmniLightInfo> mergeLightsOmni;
StructuredBuffer<SpotLightInfo> mergeLightsSpot;
Buffer<uint> mergeLightsCount;

// Write to omnis, spots in lightsData.hlsl
RWBuffer<uint> lightsCount;


[numthreads(1, 1, 1)]
void CS_Cleanup()
{
	lightsCount[0] = 0;
	lightsCount[1] = 0;
}

technique10 CleanupTech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_Cleanup()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}


[numthreads(GROUPSIZE, 1, 1)]
void CS_MergeLights(uint3 groupId : SV_GroupID, uint3 groupThreadID : SV_GroupThreadID)
{
	uint index = groupId.x * GROUPSIZE + groupThreadID.x;
	uint totalLights = mergeLightsCount[0] + mergeLightsCount[1];
	if (index >= totalLights)
		return;

	if (index < mergeLightsCount[0])
	{
		uint srcIndex = index;
		uint dstIndex;
		InterlockedAdd(lightsCount[0], 1, dstIndex);
		omnis[dstIndex] = mergeLightsOmni[srcIndex];
	}
	else
	{
		uint srcIndex = index - mergeLightsCount[0];
		uint dstIndex;
		InterlockedAdd(lightsCount[1], 1, dstIndex);
		spots[dstIndex] = mergeLightsSpot[srcIndex];
	}
}

technique10 MergeLightsTech {
	pass P0 {
		SetComputeShader(CompileShader(cs_5_0, CS_MergeLights()));
		SetVertexShader(NULL);
		SetGeometryShader(NULL);
		SetPixelShader(NULL);
	}
}
