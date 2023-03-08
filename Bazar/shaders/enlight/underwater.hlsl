#ifndef UNDERWATER_HLSL
#define UNDERWATER_HLSL

#include "enlight/waterParams.hlsl"

float underwaterDistance(float3 wpos) {
	float3 v = wpos - gCameraPos;
	float sLevel = gSeaLevel - gOrigin.y;
	float3 sLevelPos = gCameraPos + v * (max(0, gCameraPos.y - sLevel) / -v.y);
	return distance(sLevelPos, wpos);
}

float underwaterVisible(float3 wpos) {
	float uwd = underwaterDistance(wpos);
	return calcWaterDeepFactor(uwd, 0);
}


#endif
