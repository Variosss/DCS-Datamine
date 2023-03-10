#ifndef MODEL_DECK_PS_HLSL
#define MODEL_DECK_PS_HLSL

#define INFRARED_SHADERS
#define FOG_ENABLE
#define EXTERN_UNIFORM_LIGHT_COUNT
#define EXTERN_ATMOSPHERE_SAMPLES_ID
#define SHADING_MODEL	SHADING_STANDARD

#include "common/samplers11.hlsl"
#include "common/enums.hlsl"
#include "common/context.hlsl"
#include "deferred/GBuffer.hlsl"

#include "functions/vt_utils.hlsl"
#include "functions/shading.hlsl"
#include "functions/misc.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/color_table.hlsl"
#include "common/debug_uniforms.hlsl"
#endif

#include "common/lightingFLIR.hlsl"

static const float4 NORMAL_MAP_COLOR_PLUG = float4(1.0, 0.5, 0.5, 0);

Texture2D BaseColorTiledMap;
Texture2D NormalTiledMap;
Texture2D RoughnessMetallicTiledMap;

Texture2D BaseColorMap;
Texture2D RoughnessMetallicMap;

Texture2D RainMask;

Texture2D FLIRMap;

#define diffuseShift float2(0, 0)
#include "functions/damage.hlsl"
#include "common/constants.hlsl"

// Returns rain mask.
float calcBaseColor(in float2 tiledUV, in float2 uv, out float4 baseColorOut, out float4 aormsOut){
	float4 baseColorTiled = BaseColorTiledMap.Sample(gAnisotropicWrapSampler, tiledUV);
	float4 baseColor = BaseColorMap.Sample(gAnisotropicWrapSampler, uv);

	float4 aormsTiled = RoughnessMetallicTiledMap.Sample(gAnisotropicWrapSampler, tiledUV);
	float4 aorms = RoughnessMetallicMap.Sample(gAnisotropicWrapSampler, uv);

	float a = baseColor.a;
	baseColor = lerp(baseColorTiled, baseColor, a);
	aorms = lerp(aormsTiled, aorms, a);

	float wetness = smoothstep(0.1, 0.3, Rain);
	const float3 wetnessCoeffs = float3(0.7, 0.6, 0.6);
	baseColor = lerp(baseColor, baseColor * wetnessCoeffs.x, wetness);
	aorms.yz = lerp(aorms.yz, aorms.yz * wetnessCoeffs.yz, wetness);

	float wetSurfaceHeightMask = RainMask.Sample(gAnisotropicWrapSampler, uv).r;
	wetSurfaceHeightMask = lerp(0, wetSurfaceHeightMask, smoothstep(0.3, 1.0, Rain));

	aorms.yz = lerp(aorms.yz, aorms.yz * 0.1, wetSurfaceHeightMask);

	baseColorOut.rgb = modifyAlbedo(baseColor.rgb, 0, 1, aorms.x);
	baseColorOut.a = a;

	aormsOut = aorms;

	return smoothstep(0.01, 0.4, wetSurfaceHeightMask);
}

GBuffer deck_deferred_ps(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
	uniform int Flags) {

	float4 baseColor, aormsOut;
	float rainMask = calcBaseColor(input.tc0.xy, input.tc1.xy, baseColor, aormsOut);
	float4 normalTiledMap = NormalTiledMap.Sample(gAnisotropicWrapSampler, input.tc0.xy);

	float3 normal = calculateNormal(input.Normal, normalTiledMap, input.Tangent);
	normal = lerp(normal, input.Normal, rainMask);
	normal = normalDithering(input.Normal, normal);

	float3 pos = input.Pos.xyz / input.Pos.w;
	float3 toCamera = gCameraPos.xyz - pos;
	float distanceToCam = length(toCamera) * gNearFarFovZoom.w;
	addDamageNew(input, distanceToCam, baseColor, normal, aormsOut);

	float2 motion = calcMotionVector(input.projPos, input.prevFrameProjPos);

	float3 emissive = 0;

#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		emissive.rgb = color_table[NodeId];
	}
#endif

	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
						sv_sampleIndex,
#endif
						baseColor, normal, aormsOut.xyzw, emissive, motion);
}

PS_OUTPUT deck_forward_ps(VS_OUTPUT input, uniform int Flags) {
	PS_OUTPUT o;

	float4 baseColor, aormsOut;
	float rainMask = calcBaseColor(input.tc0.xy, input.tc1.xy, baseColor, aormsOut);
	float4 normalTiledMap = NormalTiledMap.Sample(gAnisotropicWrapSampler, input.tc0.xy);

	float3 normal = calculateNormal(input.Normal, normalTiledMap, input.Tangent);
	normal = lerp(input.Normal, normal, rainMask);

	float3 pos = input.Pos.xyz / input.Pos.w;
	float3 toCamera = gCameraPos.xyz - pos;
	float distanceToCam = length(toCamera) * gNearFarFovZoom.w;
	addDamageNew(input, distanceToCam, baseColor, normal, aormsOut);

	float shadow = 1.0;
	float2 cloudShadowAO = 1.0;
	cloudShadowAO = SampleShadowClouds(pos);
	shadow = cloudShadowAO.x;
	
	if(!(Flags & F_DISABLE_SHADOWMAP)){
		shadow = min(shadow, applyShadow(float4(pos, input.projPos.z/input.projPos.w), normal));
	}

	//todo: спустить предрасчитанное солнце для целой модели?
	float3 sunColor = SampleSunRadiance(pos, gSunDir);

	float3 emissive = 0;
#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		emissive.rgb = color_table[NodeId];
	}
#endif

	float4 finalColor = float4(ShadeHDR(input.Position.xy, sunColor, baseColor.rgb, normal, aormsOut.y, aormsOut.z, emissive, shadow, 1, cloudShadowAO, normalize(toCamera), pos, float2(1,aormsOut.w)), baseColor.a);

	finalColor.rgb = applyAtmosphereLinear(gCameraPos.xyz, pos, input.projPos, finalColor.rgb);

	o.RGBColor = finalColor;
	return o;
}

PS_OUTPUT deck_ps_ir(VS_OUTPUT input)
{
	clipModelBySeaLevel(input.Pos.xyz / input.Pos.w);
	float4 flir = FLIRMap.Sample(gAnisotropicWrapSampler, input.tc1.xy);
	float v = flir[0] * flirCoeff[0] + flir[1] * flirCoeff[1] + flir[2] * flirCoeff[2] + flir[3] * flirCoeff[3];
	float4 c = float4(v, v, v, 1);
	c.xyz += CalculateDynamicLightingFLIR(input.Position.xy, input.Pos.xyz / input.Pos.w, LL_SOLID).xxx;

	PS_OUTPUT o;
	o.RGBColor = c;
	return o;
}

PS_OUTPUT deck_ps_sat(VS_OUTPUT input)
{
	PS_OUTPUT o;

	float4 baseColor, aormsOut;
	calcBaseColor(input.tc0.xy, input.tc1.xy, baseColor, aormsOut);
	baseColor *= SURFACECOLORGAIN;

	o.RGBColor = baseColor;
	return o;
}

PS_OUTPUT deck_ps_map(VS_OUTPUT input)
{
	PS_OUTPUT o;
	o.RGBColor = float4(0.0, 0.0, 0.0, 1.0);
	return o;
}

#endif
