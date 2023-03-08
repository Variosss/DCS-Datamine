#ifndef _NVD_COMMON_
#define _NVD_COMMON_

#include "common/context.hlsl"

#define MASK_SIZE (1.0/0.8)

float getMask(float2 c, float mul) {
	return saturate(mul*(1 - sqrt(dot(c, c))));
}

float2 calcMaskCoord(float2 projPos) {
	return float2((projPos.x - gNVDpos.x) * gNVDaspect, projPos.y - gNVDpos.y) * MASK_SIZE;
}

float getNVDMask(float2 projPos) {
	float2 uvm = calcMaskCoord(projPos);
	return getMask(uvm, 10);
}

#endif
