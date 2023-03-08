#ifndef WATERCOMPOSE_HLSL
#define WATERCOMPOSE_HLSL

#define COMPOSING 
#include "enlight/waterCommon.hlsl"
#include "common/lighting.hlsl"

#define USE_DISTORSION 1

float4 getRefractionColor(float2 uv) {
	return g_RefractionTexture.SampleLevel(ClampLinearSampler, float3(uv, 0), 0);
}

float4 calcRefractionColor(float3 normal, float3 pos, float2 uv) {
	float4 disturbance_eyespace = mul(float4(normal.x, 0, normal.z, 0), gView);
	float2 refraction_disturbance = float2(-disturbance_eyespace.x, disturbance_eyespace.y)*0.05 / sqrt(g_Scale.x);

	float dist = distance(pos, gCameraPos);
	refraction_disturbance /= dist * 0.02;

	float2 duv = saturate(uv.xy + refraction_disturbance);
	float4 refraction_color = getRefractionColor(duv);

	float bottomNoL = g_RefractionTexture.SampleLevel(ClampLinearSampler, float3(duv, 1), 0).x;

	return float4(refraction_color.xyz, bottomNoL);
}

float4 getReflection(float2 uv) {
	return g_ReflectionTexture.SampleLevel(SamplerLinearClamp, uv, 0);
}

static int2 toffs[4] = { int2(0,-1), int2(0,1), int2(-1,0), int2(1,0) };

float4 getReflectionDistorsionColor(float2 uv, float3 normal, float distance) {
	float4 r = getReflection(uv);
#if USE_DISTORSION
	[unroll]
	for (uint i = 0; i < 4; ++i) {
		float4 r1 = g_ReflectionTexture.SampleLevel(SamplerLinearClamp, uv, 0, toffs[i]);
		r = lerp(r, r1, step(r.w, r1.w));
	}

	float f = (0.001 + distance * 0.001) * 0.5;	// gDev0.x
	float2 d = normalize(float2(normal.xz)) * r.w  * f;

	float4 rcolor = float4(r.xyz*r.w, r.w);
	[unroll]
	for (i = 1; i < 4; ++i) {
		float2 dd = d * i;
		r = getReflection(uv + dd);
		float4 r1 = getReflection(uv - dd);
		r = lerp(r, r1, step(r.w, r1.w));
		r1 = getReflection(uv + dd.yx);
		r = lerp(r, r1, step(r.w, r1.w));
		r1 = getReflection(uv - dd.yx);
		r = lerp(r, r1, step(r.w, r1.w));
		rcolor += float4(r.xyz*r.w, r.w);
	}

	return rcolor.w == 0 ? r: rcolor / rcolor.w;
#else
	return r;
#endif
}

float3 waterCompose(uint2 uvPix, float2 uvTex, float3 pos, float3 normal, float shadow, float wLevel, float foam, float deepFactor, float riverLerp) {

	float3 viewDir = normalize(gCameraPos - pos);
	float distance = length(viewDir);
	viewDir /= distance;

	float3 sunLight = getSunLight(pos);

	float3 deepColor = getDeepColor(riverLerp);
	float3 color = deepColor * sunLight;	// color deep water
	if (deepFactor > 0) {					// bottom can be seen 
		float4 rc = calcRefractionColor(normal, pos, uvTex);
		float bottomNoL = rc.w;
		float3 baseColor = GammaToLinearSpace(rc.xyz);
		float3 refraction = baseShading(pos, baseColor, sunLight, bottomNoL);
		refraction += CalculateDynamicLightingTiled(uvPix, baseColor, 0, 1, float3(0, 1, 0), viewDir, pos, 0, float2(1, 0), 0, LL_SOLID, false);
		color = lerp(color, refraction, deepFactor);
	}

	float4 underwaterTransparent = g_RefractionTexture.SampleLevel(ClampLinearSampler, float3(uvTex, 2), 0);
	color = lerp(color, underwaterTransparent.xyz, underwaterTransparent.a);

	float4 reflection_color = getReflectionDistorsionColor(uvTex, normal, distance);
	float3 scatterColor = GammaToLinearSpace(lerp(g_ScatterColor, g_RiverScatterColor, riverLerp)) * g_ScatterIntensity;

	float3 result = waterShading(pos, float4(viewDir, distance), normal, color, reflection_color.xyz, shadow, foam, sunLight, riverLerp);

	result += CalculateDynamicLightingTiled(uvPix, deepColor + scatterColor * 0.5, float3(0.25,0.25,0.25), 0.2, normal, viewDir, pos, 0, float2(1, g_SpecularIntensity), 0, LL_SOLID, true);
	return result;
}

float3 underwaterCompose(uint2 uvPix, float2 uvTex, float3 pos, float3 normal, float3 baseColor, float shadow, float aboveSurfaceNoL) {
	float waterDeep = g_Level - (pos.y + gOrigin.y);	// thickness of water
	float deepFactor = calcWaterDeepFactor(waterDeep, 0);

	float NoL = max(0, dot(normal, gSunDir));
	NoL = lerp(0, NoL, deepFactor);

	shadow = lerp(1, shadow, calcWaterDeepFactor(waterDeep*0.2, 0));
	NoL = min(NoL, shadow);
	NoL = min(NoL, aboveSurfaceNoL);

	float3 sunLight = getSunLight(float3(0, g_Level - gOrigin.y, 0));
	float3 color = GammaToLinearSpace(baseColor);
	color = baseShading(pos, color, sunLight, NoL);

	float dist = distance(pos, gCameraPos);
	float distFactor = calcWaterDeepFactor(dist, 0);

	color = lerp(getDeepColor(0)*sunLight, color, distFactor);

	float4 underwaterTransparent = g_RefractionTexture.SampleLevel(ClampLinearSampler, float3(uvTex, 2), 0);
	color = lerp(color, underwaterTransparent.xyz, underwaterTransparent.w);

	return color;
}

#endif

