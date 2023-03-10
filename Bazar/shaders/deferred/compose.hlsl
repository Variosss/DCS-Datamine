#ifndef COMPOSE_HLSL
#define COMPOSE_HLSL

#include "common/context.hlsl"
#include "common/samplers11.hlsl"
#include "common/states11.hlsl"
#include "common/BRDF.hlsl"
#include "common/colorTransform.hlsl"
#include "common/lighting.hlsl"

#include "deferred/atmosphere.hlsl"
#include "deferred/shadows.hlsl"

static const float fogLG = 3.0;	// 3.0 it's LG const in Fog.inl

uint	renderMode; // 0
int2	GBufferSampleOffset;
float4	GBufferViewportScaleOffset;

Texture2D grassMaskTex;
Texture2D lightMap;

float	msaaMaskSize; // 1
float2	debugAlbedoRange;//min, max
float4	debugValue;
float4	debugValue2;

float4x4 lightMapViewProj;

float4	grassParams0;
float4	grassParams1;
float4	grassParams2;

#if 0
#define grassSurfaceNoLInfluence		grassParams0.x
#define grassTranslucency				grassParams0.y
#define grassTranslucencyToDirectLight	grassParams0.z
#define grassForwardTranslucency		grassParams0.w
#define grassAO 						grassParams1.x
#define grassAOInfluenceToNormal		grassParams1.y
#define grassAOInfluenceToDirectLight	grassParams1.z
#define grassMaskPower					grassParams1.w
#define grassSpecularPower				grassParams2.x
#define grassRoughness					grassParams2.y
#else
#define grassSurfaceNoLInfluence		1.00
#define grassTranslucency				1.00
#define grassTranslucencyToDirectLight	0.00
#define grassForwardTranslucency		0.52
#define grassAO 						0.90
#define grassAOInfluenceToNormal		0.85
#define grassAOInfluenceToDirectLight	1.00
#define grassMaskPower					0.50
#define grassSpecularPower				2.00
#define grassRoughness					0.60
#endif

#define grassForwardTranslucencyFactor 5


#ifdef ALBEDO_TUNING
float4 modelAlbedoParams;
float4 terrainAlbedoParams;
float4 foliageAlbedoParams;
#endif

void OverrideGBufferValues(inout float3 baseColorSRGB, inout float3 normal, inout float4 aorms, inout float3 emissive)
{
	baseColorSRGB = 0.5;
}

// #define DEBUG_OVERRIDE_GBUFFER OverrideGBufferValues

#define DBG_VALUE debugValue // для использования в indirectLighting.hlsl

// #define USE_DEBUG_ENV_MAP 0

#include "enlight/waterCompose.hlsl"
#include "deferred/deferredCommon.hlsl"
#include "deferred/Decoder.hlsl"
#include "deferred/GBuffer.hlsl"
#include "deferred/shading.hlsl"
#include "deferred/shadingCockpit.hlsl"
#include "deferred/shadingGrass.hlsl"
#include "deferred/shadingFoliage.hlsl"
#include "deferred/SSAO.hlsl"
#include "deferred/ComposedShadows.hlsl"

// #define ILV_WHITE_ALBEDO //считать отскоки для альбедо = 1.0

// #define DISABLE_TERRAIN_SHADING
// #define DISABLE_COCKPIT_SHADING
// #define DISABLE_MODEL_SHADING
// #define DISABLE_WATER_SHADING

#define PI	3.141592653589793238462

#ifdef MSAA
	#define SAMPLE_COUNT MSAA
#else
	#define SAMPLE_COUNT 1
#endif

struct VS_COMPOSE_OUTPUT {
	noperspective float4 pos:  SV_POSITION0;
	noperspective float4 projPos: TEXCOORD0;
};

float calcViewZ(float depth, float2 projPos) {
	float4 pos = mul(float4(projPos, depth, 1), gProjInv);
	return pos.z / pos.w;
}

float3 SampleLightMap(float3 posW)
{
	if(gCivilLightsAmount<0.5)
		return 0;

	float4 LCpos = float4(posW, 1);
	LCpos.y = -gOrigin.y;
	LCpos = mul(LCpos, lightMapViewProj);
	float2 uv = (LCpos.xy/LCpos.w)*0.5+0.5;
	uv.y = 1-uv.y;
	return lightMap.SampleLevel(LightMapSampler, uv, 0).xyz * gTerrainEmissiveIntensity;
}


//возвращает: оранжевый - слишком большой альбедо для указанных roughness и metallic, голубой - слишком маленький
float3 CheckMaterialError(float3 baseColorSRGB, float2 roughnessMetallic, float cavity, uniform float2 albedoRange = float2(-1.0, -1.0), float dielectricAlbedoMin = 0.04)
{
	float albedoMin = albedoRange.x<0? lerp(dielectricAlbedoMin, 0.5, (roughnessMetallic.y)) : albedoRange.x;// не должно быть темнее чем уголь (0.04)
	float albedoMax = albedoRange.y<0? lerp(0.5, 1.0, (roughnessMetallic.y)) : albedoRange.y;
	
	float3 baseColor = GammaToLinearSpace(baseColorSRGB);
	float albedo = dot(0.333333, baseColor);
	
	const float3 lowColor = float3(0,0.3,1);
	const float3 highColor = float3(1,0.3,0);
	
	float3 error = highColor * saturate((albedo - albedoMax)/(1-albedoMax)) + lowColor * saturate((albedoMin - albedo) / albedoMin);
	
	//check color clipping
	float m = min(baseColorSRGB.r, min(baseColorSRGB.g, baseColorSRGB.b));
	if(m <= 1.0/255.0 && cavity > 1.0/255.0 || m >= 253.0/255.0)
		return float3(1,0,1);
	
	return albedo*(1-min(1, max(error.r, error.b)*20))*0.5 + error*2;
}

//серым цветом рисует средний разрешенный альбедо, чем он больше - рисуется оранжевым, чем меньше - голубым
float3 CheckAlbedoBalance(float3 baseColorSRGB, float2 roughnessMetallic)
{
	float albedoMin = lerp(0.04, 0.5, (roughnessMetallic.y));
	float albedoMax = lerp(0.5, 1.0, (roughnessMetallic.y));
	float albedoMid = (albedoMin + albedoMax) * 0.5;

	float3 baseColor = GammaToLinearSpace(baseColorSRGB);
	float albedo = dot(0.3333, baseColor);
	
	float bright = saturate((albedo - albedoMid) / albedoMid);
	float dark   = saturate((albedoMid - albedo) / albedoMid);

	return lerp(lerp(0.5, float3(0,0.4,1), dark), lerp(0.5, float3(1,0.4,0), bright), albedo>albedoMid);
}

float3 CheckAlbedoRangeOuter(float3 baseColorSRGB, float2 roughnessMetallic)
{
	return CheckMaterialError(baseColorSRGB, roughnessMetallic, 1, debugAlbedoRange);
}

float3 CheckAlbedoRangeInner(float3 baseColorSRGB, float2 roughnessMetallic)
{
	const float3 color = float3(0.15, 1.0, 0);
	const float3 lowColor = float3(0,0.3,1);
	const float3 highColor = float3(1,0.3,0);
	const float minPower = 0.2;
	const float fadeFactor = 0.02;
	float albedo = dot(0.333333, GammaToLinearSpace(baseColorSRGB));
	
	float range = saturate(debugAlbedoRange.y - debugAlbedoRange.x);
	// float fadeIn  = smoothstep(debugAlbedoRange.x, debugAlbedoRange.x + range*fadeFactor, albedo);
	// float fadeOut = 1.0 - smoothstep(debugAlbedoRange.y-range*fadeFactor, debugAlbedoRange.y, albedo);
	float albedoIsInRange = albedo>=debugAlbedoRange.x && albedo<=debugAlbedoRange.y;
	
	// float mask = lerp(minPower, 1.0, saturate(fadeIn * fadeOut)) * albedoIsInRange;
	float mask = albedoIsInRange;
	
	// float3 rangeColor = color * lerp(minPower, 1.0, saturate(fadeIn * fadeOut)) * albedoIsInRange;
	float3 rangeColor = lerp(lowColor, highColor, saturate((albedo-debugAlbedoRange.x) / (range+1e-5)));
	rangeColor *= mask;
	
	return albedo * saturate(1 - 20 * max(rangeColor.r, rangeColor.b)) * 0.5 + 1 * rangeColor;
	// return albedo.xxx * saturate(1 - rangeColor) * 0.5 + rangeColor;
	// return albedo.xxx * lerp(1, 0, rangeColor) * 0.5 + 0.5*rangeColor;
}

float4 DebugLightsTiles(uint2 uv) {
	float4 ls = LightsIdxOffsets.Load(uint4(uv / 8, 0, 0));
	float4 lt = LightsIdxOffsets.Load(uint4(uv / 8, 1, 0));
	return float4(ls.y / 10, ls.w / 10, lt.y / 10, lt.w / 10);
//	return float4(ls.x % 10, ls.z % 10, 0, 0);
}

float3 GetDebugColor(float3 baseColorSRGB, float3 normal, float2 rm, float shadow, float3 emissive, float AO, float cavity, float3 wPos, uint2 uv)
{
	[branch]
	switch(renderMode)
	{
	case 1: return baseColorSRGB.rgb;
	case 2: return normal.xyz*0.5+0.5;
	case 3: return rm.xxx;
	case 4: return rm.yyy;
	case 5: return shadow.xxx;
	case 6: return sqrt(emissive.rgb / emissiveValueMax);
	case 7: return CheckMaterialError(baseColorSRGB, rm, cavity, float2(-1,-1), 0.04);
	case 8: return CheckMaterialError(baseColorSRGB, rm, cavity, float2(-1,-1), 0.02);
	case 9: return CheckAlbedoRangeOuter(baseColorSRGB, rm);
	case 10: return CheckAlbedoRangeInner(baseColorSRGB, rm);
	case 11: return CheckAlbedoBalance(baseColorSRGB, rm);
	case 12: return AO.xxx;
	case 13: return cavity.xxx;
	case 14://specular contribution
	{
		float3 viewDir = normalize(gCameraPos.xyz - wPos);
		float3 baseColor = GammaToLinearSpace(baseColorSRGB);
		float3 diffuseColor = 0;
		float3 specularColor = lerp(0.04, baseColor, rm.y);
		rm.x = clamp(rm.x, 0.02, 0.99);
		return ShadeSolid(wPos, gSunDiffuse.rgb, diffuseColor, specularColor, normal, rm.x, rm.y, shadow, AO, 1, viewDir);
	}
	case 15: return 0;//material ID - обрабатывается до попадания сюда
	case 16: return 0;//terrain stencil - обрабатывается до попадания сюда
	case 17: return float3(SampleMapArray(GBufferMap, uv, 5, 0).xy, 0);//veolcity map
	case 18://cockpit GI
	{
		float4 indirectSunLightAO = CalculateIndirectSunLight(wPos, normal);
		float3 sunColor = SampleSunRadiance(wPos.xyz, gSunDir);
		return (CalculateDirectSunLight(1, normal, 0.8, 0, shadow, wPos, false)*gSunIntensity + indirectSunLightAO.rgb) * sunColor / PI;
	}
	case 19: return saturate(dot(normal, gSunDir)*0.5+0.5).xxx;
	case 20: return DebugLightsTiles(uv).xyz;
	case 21: return 0; // selected objects
	case 22: //lighting without sun for constant albedo=sqrt(0.5) and metallic=0
	{
		baseColorSRGB = 0.5;
		rm.y = 0;
		float3 viewDir = normalize(gCameraPos.xyz - wPos);
		float3 sunColor = SampleSunRadiance(wPos, gSunDir);
		float2 cloudShadowAO = SampleShadowClouds(wPos);
		return ShadeHDR(uv, sunColor, baseColorSRGB, normal, rm.x, rm.y, emissive, shadow.x, AO, cloudShadowAO, viewDir, wPos, float2(1, cavity), LERP_ENV_MAP, false, false);
	}

	// для расчета вторички кабины:
	case 23: return pow(baseColorSRGB.rgb, 1.0);
#ifndef ILV_WHITE_ALBEDO
	case 24: return CalculateDirectSunLight(baseColorSRGB, normal, rm.x, rm.y, shadow, wPos);//для расчета первого отскока
	case 25: return CalculateDirectSunLight(baseColorSRGB, normal, rm.x, rm.y, shadow, wPos) + CalculateIndirectSunLight(wPos, normal).rgb * GammaToLinearSpace(baseColorSRGB.rgb);//для N+1 отскока
#else
	case 24: return shadow.xxx*max(0, dot(normal, gSunDir))/PI;//для расчета первого отскока
	case 25: return shadow.xxx*max(0, dot(normal, gSunDir))/PI + CalculateIndirectSunLight(wPos, normal).rgb;//для N+1 отскока
#endif
	}
	return 0;
}

float3 GetCustomColor(float3 baseColorSRGB, float3 normal, float2 rm, float shadow, float3 emissive, float AO)
{
	[branch]
	switch(renderMode)
	{
	case 0: return baseColorSRGB;
	case 1: return dot(0.33333, GammaToLinearSpace(baseColorSRGB)).xxx;
	case 2: return float3(rm.xy, 0);
	}
	return 0;
}

#define DEBUG_OUTPUT(diffuse, norm, rm, shadow, emissive, AO, cavity, wpos, uv) \
	if(mode==1)		 return GetDebugColor(diffuse.rgb, norm, rm, shadow.x, emissive, AO, cavity, wpos.xyz, uv.xy); \
	else if(mode==2) return GetCustomColor(diffuse.rgb, norm, rm, shadow.x, emissive, AO)


float3 ModifyAlbedo(float3 diffuseColorSRGB, float level, float contrast)
{
	float3 encodedColor = encodeColorYCC(diffuseColorSRGB);
	encodedColor.r = level + encodedColor.r * contrast;
	return saturate(decodeColorYCC(encodedColor));
}

float3 ColorTuning(float3 color, float level, float contrast, float hueShift, float saturationShift)
{
	float3 colorHSV = rgb2hsv(color);
	float saturation = colorHSV.x;
	colorHSV.x = frac(colorHSV.x + hueShift);//hue
	colorHSV.y = saturate(colorHSV.y + saturationShift);//saturation
	return ModifyAlbedo(hsv2rgb(colorHSV), level, contrast);
}

////////////////////////////////////////

float fastExp(float x) {	// exp(-x) approximation
	return rcp((x*x + 1)*(x + 1));
}

float SoftenTerrainShadow(float shadow, float3 wPos)
{
	const float minShadowFactor = 0.1;//когда камера у земли
	const float maxShadowFactor = 0.22; //когда на высоте
	const float maxDistInv = 1.0 / 1000.0;
	
	wPos.xz *= 0.3;
	float d = saturate(distance(gCameraPos, wPos)  * maxDistInv);
	return lerp(shadow, 1, saturate((minShadowFactor + (maxShadowFactor - minShadowFactor) * d) * (1.15-1.15*exp(-gSunDir.y*2.0)))/* * debugValue.w*/);
}

struct ShadowBuffer
{
	float cascade;
	float terrain;
	float2 clouds;
	float finalShadow;
};

ShadowBuffer initShadowBuffer()
{
	ShadowBuffer o;
	o.cascade = 1;
	o.terrain = 1;
	o.clouds = 1;
	o.finalShadow = 1;
	return o;
}

#define SHADOW_FLAGS				uint
#define SF_FADE_CASCADE				(1 << 1)
#define SF_NORMAL_BIAS				(1 << 2)
#define SF_TREE_SHADOW				(1 << 3)
#define SF_SUPPRESS_DOUBLE_SHADOW	(1 << 4)
#define SF_FIRST_MIP_ONLY			(1 << 5)
#define SF_SOFTEN_TERRAIN_SHADOW	(1 << 6)
#define SF_BLUR_FLAT_SHADOW			(1 << 7)
#define SF_IS_TERRAIN_SURFACE		(1 << 8)

ShadowBuffer SampleShadowBuffer(uint2 pixPos, float2 uv, uint sampleIdx, float3 wPos, float depth, float3 normal,
	uniform bool bSampleFrequency,
	uniform bool usePCF,
	uniform SHADOW_FLAGS flags = SF_NORMAL_BIAS)
{
	float shadow = SampleShadowCascade(wPos, depth, normal, usePCF, flags & SF_NORMAL_BIAS, flags & SF_TREE_SHADOW, bSampleFrequency? (32/SAMPLE_COUNT) : 32, flags & SF_FIRST_MIP_ONLY);

	if(flags & SF_FADE_CASCADE)
	{
		float dist = distance(wPos, gCameraPos);
		shadow = lerp(shadow, 0.25, exp(-gSunDir.y * 5) * (1 - exp(-dist * 0.002)));
	}
	if(flags & SF_SUPPRESS_DOUBLE_SHADOW)
		shadow = 1 - (1 - shadow) * saturate(FlatShadowDistance[0]);

	ShadowBuffer o;
	o.cascade = shadow;

	if(flags & SF_BLUR_FLAT_SHADOW)
		o.terrain = getShadowComposed(pixPos, flags & SF_IS_TERRAIN_SURFACE);
	else
		o.terrain = SampleShadowComposed(pixPos, sampleIdx);

	o.clouds = SampleShadowClouds(wPos);
	if(flags & SF_SOFTEN_TERRAIN_SHADOW)
		o.finalShadow =  min(SoftenTerrainShadow(min(o.cascade, o.terrain), wPos), o.clouds.x);
	else
		o.finalShadow =  min(min(o.cascade, o.terrain), o.clouds.x);
	
	return o;
}

float3 ComposeCockpitSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool useSSAO, uniform bool useCockpitGI, uniform bool bSampleFrequency, uniform int mode = 0, uniform bool useSSLR = false)
{
#ifndef DISABLE_COCKPIT_SHADING
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 diffuse, normal, emissive;
	float4 aorms;
	DecodeGBuffer(i.gbuffer, uv, idx, diffuse, normal, aorms, emissive);

	float cascadeShadow = 1;
	float terranAndCloudsShadow = 1;
	ShadowBuffer shadow = initShadowBuffer();
	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	if(useShadows)
	{
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, normal, bSampleFrequency, true, SF_NORMAL_BIAS | SF_FIRST_MIP_ONLY | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));
		terranAndCloudsShadow = min(shadow.terrain, shadow.clouds.x);
		cascadeShadow = shadow.cascade;
	}
	float AO = aorms.x;
	if (useSSAO) {
		float vz = calcViewZ(i.depth, i.projPos.xy);
		AO = min(AO, getSSAO(texCoord, vz));
	}

	float2 uvSSLR = float2(0, 0);
	if (useSSLR)
		uvSSLR = texCoord;

	DEBUG_OUTPUT(diffuse, normal, aorms.yz, min(cascadeShadow, terranAndCloudsShadow), emissive, AO, aorms.w, wPos, uv);

	float3 viewDir = normalize(gCameraPos.xyz - wPos);
	float3 sunColor = SampleSunRadiance(wPos, gSunDir) * terranAndCloudsShadow;
	float3 finalColor = ShadeCockpit(uv, useCockpitGI, sunColor, diffuse, normal, aorms.y, aorms.z, emissive, cascadeShadow, AO, shadow.clouds, viewDir, wPos, float2(1, aorms.w), false, 1, useSSLR, uvSSLR);

	return finalColor;
#endif
	return 0;
}

float3 ComposeSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool useSSAO, uniform bool bSampleFrequency, uniform int mode = 0, uniform uint selectEnvCube = LERP_ENV_MAP, uniform bool useSSLR = false)
{
#ifndef DISABLE_MODEL_SHADING
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 diffuse, normal, emissive;
	float4 aorms;
	DecodeGBuffer(i.gbuffer, uv, idx, diffuse, normal, aorms, emissive);

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	ShadowBuffer shadow = initShadowBuffer();
	if (useShadows)
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, normal, bSampleFrequency, true, SF_FADE_CASCADE | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	float AO = aorms.x;
	if (useSSAO) {
		float vz = calcViewZ(i.depth, i.projPos.xy);
		AO = min(AO, getSSAO(texCoord, vz));
	}

	float2 uvSSLR = float2(0, 0);
	if (useSSLR)
		uvSSLR = texCoord;

#ifdef ALBEDO_TUNING
	diffuse = ColorTuning(diffuse, modelAlbedoParams.x, modelAlbedoParams.y, modelAlbedoParams.z, modelAlbedoParams.w);
#endif

	DEBUG_OUTPUT(diffuse, normal, aorms.yz, shadow.finalShadow, emissive, AO, aorms.w, wPos, uv);

	float3 viewDir = normalize(gCameraPos.xyz - wPos);
	float3 sunColor = SampleSunRadiance(wPos, gSunDir);
	float3 finalColor = ShadeHDR(uv, sunColor, diffuse, normal, aorms.y, aorms.z, emissive, shadow.finalShadow, AO, shadow.clouds, viewDir, wPos, float2(1, aorms.w), LERP_ENV_MAP, useSSLR, uvSSLR, LL_SOLID, false, true);

	return finalColor;
#endif
	return 0;
}

bool DiscardEdgeInsideFog(float depth, float3 wPos) {
	float fogHeight = fogLG / gFogCoeffs.z;
	//TODO is this code corrent why distance is multiplied by 0.001
	return (depth < DEPTH_COVERAGE_TEST) && (fogHeight + distance(gCameraPos, wPos)*0.001 > wPos.y + gOrigin.y);
	/*return (depth < DEPTH_COVERAGE_TEST) && (fogHeight + distance(gCameraPos, wPos) > length(wPos + gOrigin)-gEarthRadius);*/
}

float3 ShadeTerrain(EnvironmentIrradianceSample eis, float3 sunColor, float3 diffuseColor, float3 normal, float roughness, float shadow, float cloudShadow, float AO, float3 viewDir, float3 pos, float2 energyLobe = {1,1})
{
	const float3 specularColor = 0.04;
	const float metallic = 0.0;

	return ShadeSolid(eis, sunColor, diffuseColor, specularColor, normal, roughness, metallic, shadow, cloudShadow, AO, viewDir, pos, energyLobe);
}

float3 ShadeVegetation(EnvironmentIrradianceSample eis, float3 sunColor, float3 diffuseColor, float3 normal, float roughness, float shadow, float cloudShadow, float AO, float3 viewDir, float3 pos, float2 energyLobe)
{
	const float3 specularColor = 0.04;
	const float vegetationTranslucency = 0.05;

	float NoL = max(0, dot(normal, gSunDir));
	float roughnessSun = modifyRoughnessByCloudShadow(roughness, cloudShadow);

	// translucent specular sun light
	float  lightAmountSpec = gSunIntensity * shadow * NoL;//max(0, -NoL);
	float3 finalColor = (ShadingSimple(diffuseColor, specularColor, roughnessSun, normal, viewDir, gSunDir, energyLobe) * sunColor) * lightAmountSpec;

	//diffuse IBL
	finalColor += diffuseColor * SampleEnvironmentMapApprox(eis, normal, 1.0) * (gIBLIntensity * AO * energyLobe.x);

	//forward diffuse translucensy
	float transLightAmount = GetForwardTranslucencyFactor(gSunDir, viewDir, grassForwardTranslucencyFactor) * gSunIntensity * shadow;
	finalColor += (diffuseColor * sunColor) * transLightAmount * vegetationTranslucency;

	//forward diffuse translucensy
	transLightAmount = GetForwardTranslucencyFactor(float3(-gSunDir.x, gSunDir.y, -gSunDir.z), viewDir, 0.5*grassForwardTranslucencyFactor) * gSunIntensity * shadow;
	finalColor += (diffuseColor / PI * sunColor) * transLightAmount * vegetationTranslucency;
	
	return finalColor;
}

float3 ComposeTerrainSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool useSSAO, uniform bool discardInsideFog = false, uniform bool bSampleFrequency=false, uniform int mode = 0)
{
#if !defined(DISABLE_TERRAIN_SHADING) && 1
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 diffuse, normal, emissive;
	float4 aorms;
	DecodeGBuffer(i.gbuffer, uv, idx, diffuse, normal, aorms, emissive);

	if (discardInsideFog) {
		if(DiscardEdgeInsideFog(i.depth, wPos)) {
			discard;
			return 0;
		}
	}

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	ShadowBuffer shadow = initShadowBuffer();
	if (useShadows)
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, normal, bSampleFrequency, true, SF_NORMAL_BIAS | SF_SOFTEN_TERRAIN_SHADOW | SF_IS_TERRAIN_SURFACE | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	float AO = aorms.x;
	if (useSSAO) {
		float vz = calcViewZ(i.depth, i.projPos.xy);
		AO = min(AO, getSSAO(texCoord, vz));
	}
	float3 dir = gCameraPos.xyz - wPos;
	float  dist = length(dir);
	float3 viewDir = dir / dist;
	float  grassDistFactor = min(1, (dist - 15) / 60);//затухание АО под геометрической травой
	float  specDistFactor = exp(-dist/2000);//затухание спекуляра всей земли

#ifdef ALBEDO_TUNING
	diffuse = ColorTuning(diffuse, terrainAlbedoParams.x, terrainAlbedoParams.y, terrainAlbedoParams.z, terrainAlbedoParams.w);
#endif

	float3 sunColor = SampleSunRadiance(wPos, gSunDir);

	float vegetationMask = aorms.z;
	float vegetationRoughness = 0.8;
	float vegetationSpecular = 0.2;

	float lightDecay = lerp(1.0 - 0.5 * vegetationMask, 1, grassDistFactor);//затухание света под травой
	lightDecay *= lightDecay;

	AO = min(AO, lightDecay);

	aorms.y = clamp(aorms.y, 0.02, 0.99);
	float specular = aorms.w;
	specular *= 0.2 + 0.8 * specDistFactor;

	DEBUG_OUTPUT(diffuse, normal, aorms.yz, shadow.finalShadow, emissive, AO, specular, wPos.xyz, uv.xy);

	EnvironmentIrradianceSample eis = SampleEnvironmentIrradianceApprox(wPos, shadow.clouds.x, shadow.clouds.y);

	float3 baseColor	   = GammaToLinearSpace(diffuse);

	float3 surfaceColor	   = ShadeTerrain(eis, sunColor * lightDecay, baseColor, normal, aorms.y, shadow.finalShadow, shadow.clouds.x, AO, viewDir, wPos, float2(1, specular));

	float3 vegetationColor = ShadeVegetation(eis, sunColor, baseColor, normal, vegetationRoughness, shadow.finalShadow, shadow.clouds.x, AO, viewDir, wPos, float2(1, vegetationSpecular));

	float3 finalColor = lerp(surfaceColor, vegetationColor, vegetationMask);

	finalColor += CalculateDynamicLightingTiled(uv, baseColor, 0.04, lerp(aorms.y, vegetationRoughness, vegetationMask), normal, viewDir, wPos, 0, float2(1, lerp(specular, 0, vegetationMask)));

	finalColor += baseColor * SampleLightMap(wPos);
	finalColor += emissive.rgb;
	return finalColor;

#else
	float2 uv2 = float2(i.projPos.x, -i.projPos.y)*0.5+0.5;
	return skyTex.SampleLevel(gBilinearClampSampler, uv2, 0).rgb;
#endif
}

float3 ComposeWaterSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool discardInsideFog = false, uniform bool bSampleFrequency=false, uniform int mode = 0)
{
#if !defined(DISABLE_WATER_SHADING) && 1
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 normal;
	float foam, wLevel;
	float deepFactor, riverLerp;
	DecodeGBufferWater(i.gbuffer, uv, idx, normal, wLevel, foam, deepFactor, riverLerp);

	if (discardInsideFog) {
		if (DiscardEdgeInsideFog(i.depth, wPos)) {
			discard;
			return 0;
		}
	}

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	ShadowBuffer shadow = initShadowBuffer();
	if (useShadows)
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, normal, bSampleFrequency, true, SF_SUPPRESS_DOUBLE_SHADOW | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	DEBUG_OUTPUT(float3(0,0,1), normal, float2(0,0), shadow.finalShadow, float3(0,0,0), 1, 1, wPos, uv);

	float3 finalColor = waterCompose(uv, texCoord, wPos, normal, shadow.finalShadow, wLevel, foam, deepFactor, riverLerp);

	return finalColor;
#endif
	return 0;
}

float3 ComposeUnderWaterSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool bSampleFrequency = false, uniform int mode = 0)
{
#if !defined(DISABLE_WATER_SHADING)
	float3 diffuse, normal;
	float NoL = 1;

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;

	normal = normalize(unpackNormal(i.gbuffer.t0.xy * 2 - 1).xzy);
	normal.y = -normal.y;

	bool isWaterSurface = i.gbuffer.t4.y == 0;  // ugly hack
	if (isWaterSurface) {
		float4 c = calcRefractionColor(normal, i.wPos, texCoord);
		diffuse = c.xyz;
		NoL = c.w;
	} else {
		diffuse = decodeColorYCC(float3(i.gbuffer.t1.x, i.gbuffer.t2.x, i.gbuffer.t2.y));
	}

	ShadowBuffer shadow = initShadowBuffer();
	if (useShadows)
		shadow = SampleShadowBuffer(i.uv, texCoord, idx, i.wPos, i.depth, normal, bSampleFrequency, true, SF_SUPPRESS_DOUBLE_SHADOW | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	DEBUG_OUTPUT(diffuse, normal, float2(0, 0), shadow.finalShadow, float4(0, 0, 0, 0), 1, 1, i.wPos, i.uv);

	return underwaterCompose(i.uv, texCoord, i.wPos, normal, diffuse, shadow.finalShadow, NoL);

#endif
	return 0;
}


#define SUB_TEXTURE_SIZE		512.0
#define SUB_TEXTURE_MIPCOUNT	10.0

float MipLevel(float dist)
{
	return SUB_TEXTURE_MIPCOUNT * (1-exp(-dist/150.0));
}


float3 ComposeGrassSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool bSampleFrequency, uniform int mode = 0)
{
#if !defined(DISABLE_TERRAIN_SHADING) && 1
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 diffuse, normal;
	float AO, surfaceNoL;
	DecodeGBufferGrass(i.gbuffer, uv, idx, diffuse, normal, AO, surfaceNoL);

	float translucency		= grassTranslucency;
	float roughness			= grassRoughness;
	float AO2NormalFactor	= grassAOInfluenceToNormal;
	float2 energyLobe		= float2(1 - grassTranslucency*grassTranslucencyToDirectLight, grassSpecularPower);
	surfaceNoL				= lerp(1, surfaceNoL, grassSurfaceNoLInfluence);
	AO						= lerp(1, AO, grassAO);

	//mask
	const float tile = 20.0;
	float2 maskUV = fmod((fmod(gOrigin.xz, tile) + wPos.xz)/tile, 1.0);
	float grassMask = grassMaskTex.SampleLevel(gBilinearWrapSampler, maskUV, 0).x;//todo: compute mip level?
	grassMask = lerp(1.0, grassMask, grassMaskPower);

	//normal
	float3 viewDir = gCameraPos.xyz - wPos;
	float dist = length(viewDir);
	viewDir /= dist;
	float nDist = min(1, (dist-15) / 90);//todo: bind max distance to terrain config
	normal.xz = normal.xz*2.0 - 254.0/255.0;
	normal = faceforward(normal, -viewDir, normal);

	//fade out shading at distance
	AO = lerp(AO, 1.0, nDist);
	energyLobe.x = lerp(energyLobe.x, 1, nDist);

	normal = normalize(lerp(normal, float3(0,1,0), max(nDist, grassMask * AO2NormalFactor * AO) ));

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	ShadowBuffer shadow = initShadowBuffer();
	if(useShadows)
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, float3(0,1,0), bSampleFrequency, false, SF_SOFTEN_TERRAIN_SHADOW | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	AO *= AO;
	shadow.finalShadow = min(shadow.finalShadow, lerp(1, AO, grassAOInfluenceToDirectLight));

	DEBUG_OUTPUT(diffuse, normal, float2(0,0), shadow.finalShadow, float4(0,0,0,0), AO, 1, wPos, uv);

	float3 sunColor = SampleSunRadiance(wPos, gSunDir);

	float3 finalColor = ShadeGrass(uv, sunColor, diffuse, normal, roughness, translucency, shadow.finalShadow, shadow.clouds, surfaceNoL, AO, viewDir, wPos, energyLobe);

	float3 lightmapColor = SampleLightMap(wPos);
	// return float4(lightmapColor, 0);
	finalColor += Diffuse_lambert(GammaToLinearSpace(diffuse)) * lightmapColor * AO;

	return finalColor;
#endif
	return 0;
}


float3 ComposeFoliageSample(ComposerInput i, uint idx, uniform bool useShadows, uniform bool useBlurFlatShadows, uniform bool useSSAO, uniform bool bSampleFrequency, uniform int mode = 0)
{
#if !defined(DISABLE_TERRAIN_SHADING) && 1
	uint2 uv = i.uv;
	float3 wPos = i.wPos;
	float3 diffuse, normal, emissive;
	float4 aorms;
	DecodeGBuffer(i.gbuffer, uv, idx, diffuse, normal, aorms, emissive);

	const float roughness = 0.9;
	const float translucency = 0.03;	// 0.125
//	const float translucency = debugValue.x;

	float2 texCoord = float2(i.projPos.x, -i.projPos.y)*0.5 + 0.5;
	ShadowBuffer shadow = initShadowBuffer();
	if (useShadows)
		shadow = SampleShadowBuffer(uv, texCoord, idx, wPos, i.depth, gSunDir.xyz, bSampleFrequency, false, SF_FADE_CASCADE | SF_TREE_SHADOW | (useBlurFlatShadows ? SF_BLUR_FLAT_SHADOW : 0));

	float AO = aorms.x;
	if (useSSAO) {
		float vz = calcViewZ(i.depth, i.projPos.xy);
		AO = min(AO, getSSAO(texCoord, vz));
	}

#ifdef ALBEDO_TUNING
	diffuse = ColorTuning(diffuse, foliageAlbedoParams.x, foliageAlbedoParams.y, foliageAlbedoParams.z, foliageAlbedoParams.w);
#endif

	DEBUG_OUTPUT(diffuse, normal, float2(roughness, 0), shadow.finalShadow, emissive, AO, aorms.w, wPos, uv);
	float3 viewDir = normalize(gCameraPos.xyz - wPos);

	float3 sunColor = SampleSunRadiance(wPos, gSunDir);
	float3 finalColor = ShadeFoliage(uv, sunColor, diffuse, normal, roughness, translucency, shadow.finalShadow, AO, shadow.clouds, viewDir, wPos);

	finalColor += emissive.rgb;

	return finalColor;
#endif
	return 0;
}

#endif
