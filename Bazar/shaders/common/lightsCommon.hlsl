#ifndef LIGHTS_COMMON_H
#define LIGHTS_COMMON_H

#include "common/shadingCommon.hlsl"

static const float MIN_LIGHT_AMOUNT = 0.01;

float distAttenuation(float range, float dist) {
	dist = max(dist, 0.01);
	float amount = MIN_LIGHT_AMOUNT * range * range;
	return clamp(amount/(dist*dist)-MIN_LIGHT_AMOUNT, 0, 10);
}

float angleAttenuation(float3 spotDir, float phi, float theta, float3 dir) {
	float a = dot(spotDir, -dir);
	return smoothstep(phi, theta, a);
}

float3 calcOmni(float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 pos, float4 omniPos, float3 omniDiffuse, float2 energyLobe, float translucency, float specularAmount, uniform bool useSpecular = true) {
	float3 dir = omniPos.xyz - pos;
	float dist = length(dir);
	dir /= dist;
	float NoL = max(0, dot(normal, dir));
	float att = distAttenuation(omniPos.w, dist);
	float3 lightAmount = omniDiffuse * att;

	float3 result = Diffuse_lambert(diffuseColor) * (max(translucency, NoL) * energyLobe.x); //diffuse
	if (useSpecular)
		result += ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir, dir, float2(0, energyLobe.y)) * (NoL * specularAmount); //specular
	return result * lightAmount;
}

float3 calcSpot(float3 diffuseColor, float3 specularColor, float roughness, float3 normal, float3 viewDir, float3 pos, float4 spotPos, float4 spotDir, float2 spotAngles, float3 spotDiffuse, float2 energyLobe, float translucency, float specularAmount, uniform bool useSpecular = true) {
	float3 dir = spotPos.xyz - pos;
	float clipNear = max(0, sign(dot(-dir, spotDir.xyz) - spotDir.w));
	float dist = length(dir);
	dir /= dist;
	float NoL = max(0, dot(normal, dir)) * clipNear;
	float att = angleAttenuation(spotDir.xyz, spotAngles.x, spotAngles.y, dir) * distAttenuation(spotPos.w, dist);
	float3 lightAmount = spotDiffuse * att;
	
	float3 result = Diffuse_lambert(diffuseColor) * (max(translucency, NoL) * energyLobe.x); //diffuse
	if (useSpecular)
		result += ShadingDefault(diffuseColor, specularColor, roughness, normal, viewDir, dir, float2(0, energyLobe.y)) * (NoL * specularAmount); //specular
	return	result * lightAmount;
}

#endif
