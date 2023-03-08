#ifndef LIGHTINGFLIR_HLSL
#define LIGHTINGFLIR_HLSL

#include "common/lightsCommon.hlsl"
#include "common/lightsData.hlsl"

float calcOmniFLIR(float3 pos, float4 omniPos, float amount) {
	float3 dir = omniPos.xyz - pos;
	float dist = length(dir);
	float att = distAttenuation(omniPos.w, dist);
	return amount * att;
}

float calcSpotFLIR(float3 pos, float4 spotPos, float3 spotDir, float2 spotAngles, float amount) {
	float3 dir = spotPos.xyz - pos;
	float dist = length(dir);
	dir /= dist;
	float att = angleAttenuation(spotDir.xyz, spotAngles.x, spotAngles.y, dir) * distAttenuation(spotPos.w, dist);
	return amount * att;
}

float CalculateDynamicLightingFLIR(uint2 sv_pos_xy, float3 pos, uniform uint LightsList = LL_SOLID) {

	uint4 v = LightsIdxOffsets.Load(uint4(sv_pos_xy / 8, LightsList, 0));

	float sumFLIR = 0;

	[loop]
	for (uint i = 0; i < v.y; ++i) {
		uint idx = LightsIdx[v.x + i];
		OmniLightInfo o = omnis[idx];
		sumFLIR += calcOmniFLIR(pos, o.pos, o.amount.x);
	}
	[loop]
	for (i = 0; i < v.w; ++i) {
		uint idx = LightsIdx[v.z + i];
		SpotLightInfo s = spots[idx];
		sumFLIR += calcSpotFLIR(pos, s.pos, s.dir.xyz, s.angles.xy, s.amount.x);
	}

	return sumFLIR;
}

#endif
