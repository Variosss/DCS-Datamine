#ifndef LIGHTSDATA_H
#define LIGHTSDATA_H

struct OmniLightInfo {
	float4	pos;
	float4	amount;
	float3	diffuse;
	int	shadowmapIdx;
};

struct SpotLightInfo {
	float4	pos;
	float4	dir;	//xyz
	float4	angles;	//xy
	float4	amount;
	float3	diffuse;
	int	shadowmapIdx;
};

#if defined(LIGHTS_PREPASS)
	StructuredBuffer<OmniLightInfo> omnis;
	StructuredBuffer<SpotLightInfo> spots;
	RWStructuredBuffer<uint> LightsIdx;
	RWTexture2DArray<uint4> LightsIdxOffsets; // xy - offset/count omnis, zw - offset/count spots
#elif defined(LIGHTS_PREPASS_MERGE)
	RWStructuredBuffer<OmniLightInfo> omnis;
	RWStructuredBuffer<SpotLightInfo> spots;
#else
	StructuredBuffer<OmniLightInfo> omnis :register(t97);
	StructuredBuffer<SpotLightInfo> spots :register(t96);
	StructuredBuffer<uint> LightsIdx: register(t95);
	Texture2DArray<uint4> LightsIdxOffsets: register(t94); // xy - offset/count omnis, zw - offset/count spots
#endif

#define LL_NONE (-1)
#define LL_SOLID 0
#define LL_TRANSPARENT 1

#endif
