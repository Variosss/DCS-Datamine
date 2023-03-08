#ifndef GBUFFER_HLSL
#define GBUFFER_HLSL

#include "common/context.hlsl"
#include "deferred/packNormal.hlsl"
#include "deferred/packColor.hlsl"
#include "deferred/packFloat.hlsl"
#include "deferred/deferredCommon.hlsl"


#define USE_SV_SAMPLEINDEX	0
#define USE_MASK_IC			1
#define USE_SEPARATE_AO		1

#define VELOCITY_MAP_SCALE 0.1


#if defined(MSAA) && USE_SV_SAMPLEINDEX
	#undef USE_MASK_IC
	#define USE_MASK_IC 0
#endif

struct GBuffer {
	float4 target0 : SV_TARGET0;
	float4 target1 : SV_TARGET1;
	float4 target2 : SV_TARGET2;
	float4 target3 : SV_TARGET3;
#if USE_SEPARATE_AO
	float4 target4 : SV_TARGET4;
#endif
#if USE_VELOCITY_MAP
	float4 target5 : SV_TARGET5;
#endif
};

static const float4 MAX_SPECULAR = float4(100.0, 3.0, 1, 1);
static const float emissiveValueMax = 0.1;
static const float emissiveLumMin = 0.1 / 255.0;

float2 speculamapToRoughnessMetallic(float4 specularMap) {
	specularMap /= MAX_SPECULAR;//нормализуем обратно к 1 
	// float roughness = clamp(1-specularMap.x, 0.01, 0.99); // factor
	// float roughness = clamp(1-specularMap.y, 0.01, 0.99)*0.85; // power
//	float roughness = clamp((1-specularMap.y*2.3)*0.4, 0.02, 0.99); // power
	float roughness = clamp((1-specularMap.y*2.3), 0.02, 0.99); // power
	float metallic = specularMap.z; // reflection power
//	float metallic = specularMap.w; // reflection blur
//	float metallic = min(1, (0.5*specularMap.z + 0.5*specularMap.w) * 1.4);
	// return roughness;
	// return metallic;
	return float2(roughness, metallic);
}

float2 packInterlaced(uint2 pidx, float2 v1, float2 v2) {
	uint idx = (pidx.x ^ pidx.y) & 1;
	return idx ? v2 : v1;
}

#if USE_VELOCITY_MAP
float2 calcVelocityMap(float4 projPos, float4 prevProjPos) {
	return (projPos.xy / projPos.w - prevProjPos.xy / prevProjPos.w)*(VELOCITY_MAP_SCALE / gPrevFrameTimeDelta)*0.5 + 127.0 / 255.0;
}

float2 calcVelocityMapStatic(float4 projPos) {
	return calcVelocityMap(projPos, mul(projPos, gPrevFrameTransform));
}
#endif

/*
color: in sRGB space
aorms: [AO, roughness, metallic, cavity]
emissive: in LINEAR space
*/
GBuffer BuildGBuffer(float2 sv_pos_xy, 
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex, 
#endif
	float4 color, float3 normal, float4 aorms, float3 emissive, 
#if USE_VELOCITY_MAP
	float2 velocityMap, 
#endif	
	float normalBlendTreshold = 0.5) {
	GBuffer o;

#if USE_SV_SAMPLEINDEX
	uint2 idx = uint2(uint(sv_pos_xy.x)*GetRenderTargetSampleCount()+sv_sampleIndex, sv_pos_xy.y);
#else
	uint2 idx = uint2(uint(sv_pos_xy.x), sv_pos_xy.y);
#endif

	emissive = sqrt( saturate(emissive * (1.0 / emissiveValueMax)) );

	float3 ec = encodeColorYCC(color.xyz);
	float3 ic = encodeColorYCC(emissive);

	bool bValidEmissive = ic.x >= emissiveLumMin;

	float normalAlpha = step(normalBlendTreshold, color.a);

	o.target0 = float4(packNormal(float3(normal.xz, -abs(normal.y)))*0.5+0.5, 0, normalAlpha);
	o.target1 = float4(ec.x, ic.x, 0, color.a);

	float2 c = packInterlaced(idx, ec.yz, ic.yz);
#if USE_MASK_IC
	o.target2 = float4(bValidEmissive ? c : ec.yz, 0, color.a);
#else
	o.target2 = float4(c, 0, color.a);
#endif

	aorms.y = packFloat1Bit(aorms.y, normal.y>0);
	o.target3 = float4(aorms.yz, 0, color.a);
//	o.target3 = float4(aorms.yz, 0, normalAlpha);
#if USE_SEPARATE_AO
	o.target4 = float4(aorms.xw, 0, color.a);
#endif
#if USE_VELOCITY_MAP
	o.target5 = float4(velocityMap, 0, color.a);
#endif
	return o;
}
 
struct GBufferWater {
	float4 target0 : SV_TARGET0;
	float4 target1 : SV_TARGET1;
	float4 target2 : SV_TARGET2;
};

GBufferWater BuildGBufferWater(float3 normal, float wLevel, float foam, float deepFactor, float4 projPos, float riverLerp, float alpha) {
	GBufferWater o;
	o.target0 = float4(packNormal(float3(normal.xz, -abs(normal.y)))*0.5+0.5, 0, alpha);
	o.target1 = float4(wLevel, foam, 0, alpha);
	o.target2 = float4(deepFactor, riverLerp, 0, alpha);
	return o;
}

#endif
