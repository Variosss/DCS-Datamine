#ifndef MODEL_FORWARD_DEF_PS_HLSL
#define MODEL_FORWARD_DEF_PS_HLSL

#include "functions/shading.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/color_table.hlsl"
#include "common/debug_uniforms.hlsl"
#endif

float4 emissivePS(VS_OUTPUT input, uniform int Flags)
{
	MaterialParams mp = calcMaterialParams(input, MP_DIFFUSE | MP_NORMAL);

	float4 finalColor = float4(GammaToLinearSpace(mp.diffuse.rgb) * selfIlluminationValue, mp.diffuse.a*mp.diffuse.a);
#ifdef BANO_MATERIAL
	calcBANOAttenuation(mp.diffuse.a*mp.diffuse.a, mp.normal, mp.toCamera, mp.camDistance, finalColor.a);
#endif
	finalColor.rgb *= 5*finalColor.a;

	if(!(Flags & F_IN_COCKPIT))	{
		finalColor.rgb *= GetAtmosphereTransmittance(gCameraPos.xyz, mp.pos);
	}

	return finalColor;
}

float4 forwardDefaultPS(VS_OUTPUT input, uniform int Flags, uniform int shadingModel)
{
	if(shadingModel == SHADING_EMISSIVE)
		return emissivePS(input, Flags);

	MaterialParams mp = calcMaterialParams(input, MP_ALL);

#if BLEND_MODE != BM_SHADOWED_TRANSPARENT
	float shadow = 1.0;
	float2 cloudShadowAO = 1.0;
	cloudShadowAO = SampleShadowClouds(mp.pos);
	shadow = cloudShadowAO.x;
	
	if(!(Flags & F_DISABLE_SHADOWMAP))
		shadow = min(shadow, applyShadow(float4(mp.pos, input.projPos.z/input.projPos.w), mp.normal));
#else
	float shadow = 0.0;
	float2 cloudShadowAO = 1.0;
#endif
	mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, mp.aorms.x);

	AtmosphereSample atm;
#if BLEND_MODE == BM_NONE || BLEND_MODE == BM_ALPHA_TEST
	atm.sunColor =  SampleSunRadiance(mp.pos.xyz, gSunDir);
#else
	atm = SamplePrecomputedAtmosphere(0);
	atm.sunColor /= gSunIntensity;
#endif

	float4 finalColor;

#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		mp.emissive = CoarseGammaToLinearSpace(color_table[NodeId]);
	}
#endif

	if(shadingModel == SHADING_STANDARD){
#if USE_SEPARATE_AO
		float AO = mp.aorms.x;
#else
		float AO = 1;
#endif

		if(Flags & F_IN_COCKPIT){
			finalColor = float4(ShadeCockpit(input.Position.xy, (Flags & F_COCKPIT_GI), atm.sunColor, mp.diffuse.rgb, mp.normal, mp.aorms.y, mp.aorms.z, mp.emissive, shadow, AO, cloudShadowAO, mp.toCamera, mp.pos, float2(1,mp.aorms.w), true, mp.diffuse.a), mp.diffuse.a);
		}else{
		#if BLEND_MODE == BM_TRANSPARENT || (BLEND_MODE == BM_SHADOWED_TRANSPARENT)
			finalColor = float4(ShadeHDR(input.Position.xy, atm.sunColor, mp.diffuse.rgb, mp.normal, mp.aorms.y, mp.aorms.z, mp.emissive, shadow, AO, cloudShadowAO, mp.toCamera, mp.pos, float2(1, mp.aorms.w), LERP_ENV_MAP, false, float2(0, 0), LL_TRANSPARENT, false, true), mp.diffuse.a);
		#else
			finalColor = float4(ShadeHDR(input.Position.xy, atm.sunColor, mp.diffuse.rgb, mp.normal, mp.aorms.y, mp.aorms.z, mp.emissive, shadow, AO, cloudShadowAO, mp.toCamera, mp.pos, float2(1, mp.aorms.w), LERP_ENV_MAP, false, float2(0, 0), BLEND_MODE == BM_ADDITIVE ? LL_TRANSPARENT : LL_SOLID, false, true), mp.diffuse.a);
		#endif
		}
	}else{
		finalColor = float4(1, 0, 0, 1);
	}

	if(!(Flags & F_IN_COCKPIT))
	{
	#if BLEND_MODE == BM_NONE || BLEND_MODE == BM_ALPHA_TEST
		finalColor.rgb = applyAtmosphereLinear(gCameraPos.xyz, mp.pos, input.projPos, finalColor.rgb);
	#else
		finalColor.rgb = finalColor.rgb * atm.transmittance + atm.inscatter;
	#endif
	}

	return finalColor;
}

#endif