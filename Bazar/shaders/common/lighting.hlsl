#ifndef LIGHTING_HLSL
#define LIGHTING_HLSL

#include "common/lightsCommon.hlsl"
#include "common/lightsData.hlsl"
#include "deferred/ESM.hlsl"

float3 calcOmniIdx(uint idx, float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 pos, float insideCockpit, float2 energyLobe, float translucency, uniform bool useSpecular) {
	OmniLightInfo o = omnis[idx];
	roughness = lerp(roughness, 1, o.amount.w); // apply light softness
	return calcOmni(diffuseColor, specularColor, roughness, normal, viewDir, pos, o.pos, o.diffuse * lerp(o.amount.x, o.amount.y, insideCockpit), energyLobe, translucency, o.amount.z, useSpecular);
}

float3 calcSpotIdx(uint idx, float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 pos, float insideCockpit, float2 energyLobe, float translucency, uniform bool useSpecular) {
	SpotLightInfo s = spots[idx];
	roughness = lerp(roughness, 1, s.amount.w); // apply light softness
	return calcSpot(diffuseColor, specularColor, roughness, normal, viewDir, pos, s.pos, s.dir, s.angles.xy, s.diffuse * lerp(s.amount.x, s.amount.y, insideCockpit), energyLobe, translucency, s.amount.z, useSpecular);
}

float3 CalculateDynamicLightingTiled(uint2 uv, float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 pos, float insideCockpit = 0, float2 energyLobe = float2(1, 1), float translucency = 0, uniform uint LightsList = LL_SOLID, uniform bool useSpecular = true, uniform bool useSecondaryShadowmap = false) {

	if (LightsList == LL_NONE)
		return 0;

	uint4 v = LightsIdxOffsets.Load(uint4(uv / 8, LightsList, 0));

	float sm[MAX_SHADOWMAP_COUNT + 1];
	if (useSecondaryShadowmap) {
		uint4 shii = LightsIdxOffsets.Load(uint4(uv / 8, 2, 0));
		uint2 shi = LightsList == LL_SOLID ? shii.xy : shii.zw;
		sm[0] = 1;
		[loop]
		for (uint j = 0; j < shi.y; ++j) {
			uint idx = LightsIdx[shi.x + j];
			sm[idx + 1] = secondarySSM(float4(pos, 1), idx);
		}
	}

	float3 sumColor = 0;

	[loop]
	for (uint i = 0; i < v.y; ++i) {
		uint idx = LightsIdx[v.x + i];
		sumColor.rgb += calcOmniIdx(idx, diffuseColor, specularColor, roughness, normal, viewDir, pos, insideCockpit, energyLobe, translucency, useSpecular);
	}

	[loop]
	for (i = 0; i < v.w; ++i) {
		uint idx = LightsIdx[v.z + i];
		float3 c = calcSpotIdx(idx, diffuseColor, specularColor, roughness, normal, viewDir, pos, insideCockpit, energyLobe, translucency, useSpecular);
		if (useSecondaryShadowmap)
			c *= sm[spots[idx].shadowmapIdx + 1];
		sumColor.rgb += c;
	}

	return sumColor;
}

#endif
