#ifndef WATERRIVER_HLSL
#define WATERRIVER_HLSL

#define METASHADER

#include "enlight/waterCommon.hlsl"
#include "deferred/GBuffer.hlsl"

static const float texTiling = 2.5;

GBufferWater riverWaterColorDS(float2 sv_pos_xy, float3 wPos, float3 projPos, float water_depth) {
	float2 uv = float2(projPos.x, -projPos.y)*0.5 + 0.5;
	float3 n = combineWaterNormal(wPos, texTiling, true, false).xyz;

	float wLevel = n.z;
	float3 normal = normalize(float3(n.x, sqrt(max(1 - dot(n.xy, n.xy), 0)), n.y));

	float deepFactor = calcWaterDeepFactor(water_depth, 1);

	return BuildGBufferWater(normal, wLevel, 0, deepFactor, float4(projPos, 1), 1, 1);
}

GBufferWater riverWaterColorDS(float2 sv_pos_xy, float3 wPos, float3 projPos) {
	float2 uv = float2(projPos.x, -projPos.y)*0.5 + 0.5;
	float water_depth = calcWaterDepth(wPos, uv);	// calculate water depth by depth buffer
	return riverWaterColorDS(sv_pos_xy, wPos, projPos, water_depth);
}

float3 riverWaterColorDraft(float2 sv_pos_xy, float3 wPos, float3 projPos) {
	float2 n = combineWaterNormal(wPos, texTiling, true, false).xy;
	float3 normal = normalize(float3(n.x, sqrt(max(1 - dot(n.xy, n.xy), 0)), n.y));

	float3 color = waterColorDraft(normal, wPos);

	return applyAtmosphereLinear(gCameraPos.xyz, wPos, float4(projPos, 1), color);
}

float3 riverWaterColorFLIR(float2 sv_pos_xy, float3 wPos, float3 projPos) {
	float2 n = combineWaterNormal(wPos, texTiling, true, false).xy;
	float3 normal = normalize(float3(n.x, sqrt(max(1 - dot(n.xy, n.xy), 0)), n.y));

	return waterColorFLIR(normal, wPos);
}


#endif
