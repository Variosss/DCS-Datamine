#ifndef WATERCOMMON_HLSL
#define WATERCOMMON_HLSL

#define USE_FFT 1
#define USE_TERRAIN_FLIR_FACTOR 0

#include "common/context.hlsl"
#include "common/stencil.hlsl"
#include "common/samplers11.hlsl"
#include "common/BRDF.hlsl"
#include "common/ambientCube.hlsl"
#include "common/shadingCommon.hlsl"

#include "deferred/Decoder.hlsl"
#include "deferred/deferredCommon.hlsl"
#include "deferred/shadows.hlsl"
#include "deferred/atmosphere.hlsl"

#include "enlight/waterParams.hlsl"
#include "enlight/stochasticSampler.hlsl"

#include "enlight/FLIRparams.hlsl"
#if USE_TERRAIN_FLIR_FACTOR
	#include "metashaders/terrain/inc/TerrainContext.hlsl"
#endif

#if defined(METASHADER)
	#define REGISTER(reg) :register(reg)
#else
	#define REGISTER(reg)
#endif

Texture2D g_FoamFFT;
Texture2DArray g_NormalTexture: register(t113);

Texture2D<float> g_DepthTexture: register(t114);
Texture2D g_ReflectionTexture: register(t115);
Texture2DArray g_RefractionTexture: register(t116);

float LoadDepthBuffer(uint2 uv) { return g_DepthTexture.Load(uint3(uv, 0)).r; }
float3 LoadColorBuffer(float2 uv) { return DecodeGBufferRefraction(uint2(uv)); }
float3 LoadNormal(uint2 uv) { return DecodeNormal(uv, 0); }

#define SamplerLinearClamp gTrilinearClampSampler
#define SamplerPointClamp gPointClampSampler

float sigmoid(float x, float factor) { return x / (abs(x) + factor); }

float pow2(float value) { return value * value; }

float3 restoreNormal(float2 n) {
	return normalize(float3(n.x, sqrt(max(0, 1 - dot(n, n))), n.y));
}

float getRefractionDepth(float2 uv) {
	return LoadDepthBuffer(transformColorBufferUV(uv));
}

static const uint2 refrOffs[] = { 
	{-1, -1}, {1, -1}, {-1, -1}, {1, 1},
	{-1, 0}, {1, 0}, {0, -1}, {0, 1}
};

float3 getSunLight(float3 wpos) {
	return SampleSunRadiance(wpos, gSunDir) * gSunIntensity * g_SunMultiplier;
}

float4 combineWaterNormal(float3 world_position, float texScale, uniform bool calcNormal, uniform bool useFoamFFT) {
	float2 wp = world_position.xz;
	float2 uv = (wp * g_TexScale.x + g_TexOffset) * texScale;
	StochasticUV s = stochasicUV(uv);

	if (calcNormal) {
		float2 _ddx = ddx(uv);
		float2 _ddy = ddy(uv);
		float4 n = stochasticSampleGradArr(g_NormalTexture, 0, gAnisotropicWrapSampler, s, _ddx, _ddy);
		float f = 0;
		if (useFoamFFT)
			f = n.w - 0.025;
		return float4(n.xyz, f);
	} else {
		float4 r = stochasticSampleLevelArr(g_NormalTexture, 1, gTrilinearWrapSampler, s, 0);
		float f = 0.5 / texScale;	// displace multiplier
		r.xyz *= f * g_TexScale.y;
		return r;
	}
}

float SunSpec(float3 pos) {
	float3 cpos = (pos-gCameraPos)*0.001;	// in km
	float3 v = gSunDir;
    float r = length(atmEarthCenter - cpos);
    float mu = dot(atmEarthCenter, v) / r;
	const float Rg = gEarthRadius;
	const float lim = -sqrt(1 - (Rg / r) * (Rg / r));

	return max(mu - lim+0.001, 0);
}

float calcWaterDepth(float3 wPos, float2 uv) {
	float refraction_depth = getRefractionDepth(uv.xy);
	float4 d = mul(float4(uv.xy, refraction_depth, 1), gProjInv);
	refraction_depth = d.z / d.w;	// in view space
	float4 vertex_in_viewspace = mul(float4(wPos, 1), gView);
	return max(0, refraction_depth - vertex_in_viewspace.z);
}

float3 getDeepColor(float riverLerp) {
	return GammaToLinearSpace(lerp(g_DeepColor, g_RiverDeepColor, riverLerp) * g_ColorIntensity);
}

float3 baseShading(float3 wpos, float3 baseColor, float3 sunLight, float NoL) {
	//	return ShadeTerrain(float3 sunColor, baseColor, float3(0, 1, 0), float roughness, float4 illumination, float shadow, float AO, float3 viewDir, float3 pos, float2 energyLobe = { 1,1 })
	//	return ShadeSolid(1, baseColor, 0, normal, /*roughness*/ 1, 1, 1, 1, 1, viewDir, float2(1, 0));
	float3 lightAmount = sunLight * NoL;
	float3 result = Diffuse_lambert(baseColor) * lightAmount;
	result += baseColor * SampleEnvironmentMapApprox(wpos, float3(0, 1, 0), 1.0).xyz * gIBLIntensity; // necessary IBL ??
	return result;
}

float subsurfaceScattering(float3 normal, float3 view, float3 light, float intensity) {
	float VoL = saturate(dot(view, -light));
	float NoL = saturate(dot(normal, light));
	float v = saturate((VoL + 1.0f) / 2.0f);
	float vg = pow(saturate(1.0f - pow(1.0f - v, intensity)), 3.0f);
	float subsurface = pow((NoL + 1.0f) / 2.0f, 3.0f);
	return (subsurface * vg);
}

float waterFresnel(float NoV) {
	float ior = 1.2;
#if 1
	float g = sqrt(ior * ior + NoV * NoV - 1);
	float fresnel = 0.5 * pow2(g - NoV) / pow2(g + NoV) * (1 + pow2(NoV * (g + NoV) - 1) / pow2(NoV * (g - NoV) + 1));
	return saturate(fresnel * (NoV + 0.5));
#else
	const float r = (ior - 1.0) / (ior + 1.0);
	return saturate(r + (1.0 - r) * pow(1.0 - NoV, 5));
#endif
}

//// brdf related

static const float invPI = 1.0 / 3.14159265359;

float specTrowbridgeReitz(float NoH, float a, float aP) {
	float a2 = a * a;
	float aP2 = aP * aP;
	float d = NoH * NoH * (a2 - 1) + 1;
	return (a2 * aP2) / (d * d);
}

float D_GGX(float NoH, float roughness) {
	float a = NoH * roughness;
	float k = roughness / (1.0 - NoH * NoH + a * a);
	return k * k * invPI;
}

float V_SmithGGXCorrelated(float roughness, float NoV, float NoL) {
	float a2 = roughness * roughness;
	float GGXV = NoL * sqrt(NoV * NoV * (1.0 - a2) + a2);
	float GGXL = NoV * sqrt(NoL * NoL * (1.0 - a2) + a2);
	return 0.5 / (GGXV + GGXL);
}

//// anisotropic

float D_GGX_Anisotropic(float NoH, float3 h, float3 t, float3 b, float at, float ab) {
	float ToH = dot(t, h);
	float BoH = dot(b, h);
	float a2 = at * ab;
	float3 v = float3(ab * ToH, at * BoH, a2 * NoH);
	float v2 = dot(v, v);
	float w2 = a2 / v2;
	return a2 * w2 * w2 * invPI;
}

float V_SmithGGXCorrelated_Anisotropic(float at, float ab, float ToV, float BoV, float ToL, float BoL, float NoV, float NoL) {
	float lambdaV = NoL * length(float3(at * ToV, ab * BoV, NoV));
	float lambdaL = NoV * length(float3(at * ToL, ab * BoL, NoL));
	float v = 0.5 / (lambdaV + lambdaL);
	return v;
}


float3 waterShading(float3 pos, float4 viewDir, float3 normal, float3 color, float3 reflection_color, float shadow, float foam, float3 sunLight, float riverLerp) {

	float2 cloudShadowAO = SampleShadowClouds(pos);
	float roughness = lerp(0.5, 0.1, max(cloudShadowAO.x, cloudShadowAO.y));
	shadow = min(shadow, cloudShadowAO.x);

	color *= lerp(shadow, 1, calcWaterDeepFactor(0.25, riverLerp));

	//// calc scatter color
	float scatter_factor = subsurfaceScattering(normal, viewDir.xyz, gSunDir, g_ScatterIntensity);
	float3 scatterColor = shadow * scatter_factor * GammaToLinearSpace(lerp(g_ScatterColor, g_RiverScatterColor, riverLerp)) * sunLight * (1 - gCloudiness);
	color += scatterColor;

	float NoV = saturate(dot(normal, viewDir.xyz)) + 1e-9;
	float2 nuv = (pos.xz + gOrigin.xz) * 0.00005;
	float windMap = g_NormalTexture.SampleLevel(gTrilinearWrapSampler, float3(nuv, 1), 0).a;

	//// apply reflection
	float fresnelMult = lerp(1, abs(windMap), 0.2); // gDev0.x;

	float fresnel = waterFresnel(NoV);
	color = lerp(color, reflection_color, fresnel * fresnelMult * lerp(1, shadow, 0.5));

	//// calc specular
	static const float sunAngularRadius = 0.54 * 3.14159265358 / 180.0 * 0.5;
	float distL = gSunDir.y + 0.5;
	float3 L = gSunDir * distL;
	float3 R = normal * NoV * 2 - viewDir.xyz;
	float3 centerToRay = dot(L, R) * R - L;
	float3 closestPoint = L + centerToRay * saturate(sunAngularRadius / length(centerToRay));
	L /= length(closestPoint) + 1e-9;

	float3 H = normalize(L + viewDir.xyz);
	float NoH = saturate(dot(normal, H));
	float NoL = saturate(dot(normal, gSunDir));

#if 1	// use anisotropy
	static float anisotropy = 0.2; // gDev0.y;

	float s, c, a = windMap * 0.314;
	sincos(a, s, c);
	float2x2 mr = { c, -s, s, c};
	float2 v = mul(g_WindDir, mr);

	//// tangent & binormal 
	float3 T = normalize(cross(float3(v.x, 0, v.y), normal));
	float3 B = cross(T, normal);

	float at = max(roughness * (1.0 + anisotropy), 0.001);
	float ab = max(roughness * (1.0 - anisotropy), 0.001);

	float D = D_GGX_Anisotropic(NoH, H, T, B, at, ab);
	float ToV = dot(T, viewDir.xyz);
	float BoV = dot(B, viewDir.xyz);
	float ToL = dot(T, gSunDir);
	float BoL = dot(B, gSunDir);
	float G = V_SmithGGXCorrelated_Anisotropic(at, ab, ToV, BoV, ToL, BoL, NoV, NoL);
#else
//	float alpha = roughness * roughness;
//	float alphaPrime = saturate(sunAngularRadius / (distL * 2.0) + alpha);
//	float D = specTrowbridgeReitz(NoH, alpha, alphaPrime);
	float D =  D_GGX(NoH, roughness);
	float G = V_SmithGGXCorrelated(roughness, NoV, NoL);
#endif

	// specular
	float brdf = fresnel * D * G;
	color += sunLight * (brdf * NoL * shadow * g_SpecularIntensity * (1 - foam));

	//// calc foam
	float3 foamColor = AmbientTop + sunLight * shadow*gSunDir.y * 0.5;
	color += foamColor * pow(foam, 2);

	return color;
}

// forward HDR/LDR for mirrors
float3 waterColorDraft(float3 normal, float3 pos) {

	float3 viewDir = gCameraPos - pos;
	float distance = length(viewDir);
	viewDir /= distance;

	float3 v = reflect(-viewDir, normal);
	v.y = abs(v.y);
	float3 reflection_color = SampleEnvironmentMapApprox(pos, v, 0);

	float3 sunLight = getSunLight(pos);
	float3 color = getDeepColor(0)*sunLight;

	return waterShading(pos, float4(viewDir, distance), normal, color, reflection_color, 1, 0, sunLight, 0);
}

float3 waterColorFLIR(float3 normal, float3 pos) {

	float3 viewDir = gCameraPos - pos;
	float distance = length(viewDir);
	viewDir /= distance;

	float3 v = reflect(-viewDir, normal);
	v.y = abs(v.y);
	float3 n = normalize(lerp(normal, v, 0.1));
#if USE_TERRAIN_FLIR_FACTOR
	float reflection_color = adjustFLIR(n.y, TerrainContext_flirFactor[TERRAIN_FLIR_WATER]);
#else
	float reflection_color = adjustFLIR(n.y, FLIR_WATER);
#endif
	return reflection_color.xxx;
}

DepthStencilState Water_DepthStencilState {
	DepthEnable        = TRUE;
	DepthWriteMask     = ALL;
	DepthFunc          = DEPTH_FUNC;
	WRITE_COMPOSITION_TYPE_TO_STENCIL;
};

float3 getReflectionSkyColor(float3 v) {
	const float Rg = gEarthRadius;
	float r = Rg + max(g_Level, 1)*0.001;
	float mu = max(v.y, -sqrt(1.0 - (Rg / r) * (Rg / r)) + 0.01);

	float3 transmittance;
	float3 inscatterColor = GetSkyRadiance(r, mu, float3(0, r, 0), v, 0, gSunDir, transmittance);

	float3 sunColor = sun(float3(0, r, 0), v, gSunDir, r, v.y); //L0
	return sunColor + inscatterColor; // Eq (16)
}

float3 waterColorForAmbientCube(float3 viewDir, float3 normal) {
	float3 wpos = float3(gCameraPos.x, g_Level - gOrigin.y, gCameraPos.y);
	float3 sunLight = getSunLight(wpos);
	float3 color = getDeepColor(0)*sunLight;
	return color * 4.5;
}

float _waterDeep(float wPosY)			{ return -(wPosY + gOrigin.y - g_Level); }
float _deepWaterMask(float waterDeep)	{ return waterDeep * (1.0 / 20.0) + 127.0 / 255; }

float deepWaterMask(float wPosY)		{ return _deepWaterMask(_waterDeep(wPosY)); }

float2 riverWaterMask(float wPosY) {
	float water_deep = _waterDeep(wPosY);
	return float2(1.0 - water_deep * 0.25, _deepWaterMask(water_deep - 1.0/20.0));
}


#endif

