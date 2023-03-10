#ifndef MODEL_DEFERRED_DEF_PS_HLSL
#define MODEL_DEFERRED_DEF_PS_HLSL

#include "functions/shading.hlsl"
#include "functions/aorms.hlsl"

#ifdef ENABLE_DEBUG_UNIFORMS
#include "common/color_table.hlsl"
#include "common/debug_uniforms.hlsl"
#endif

GBuffer deferredDefaultPS(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex,
#endif
	uniform int shadingModel)
{
	MaterialParams mp = calcMaterialParams(input, MP_ALL);
	mp.diffuse.rgb = modifyAlbedo(mp.diffuse.rgb, albedoLevel, albedoContrast, mp.aorms.x);

	float2 motion = calcMotionVector(input.projPos, input.prevFrameProjPos);

	float3 normal = normalDithering(input.Normal, mp.normal);

#ifdef ENABLE_DEBUG_UNIFORMS
	if(PaintNodes == 1){
		mp.emissive = CoarseGammaToLinearSpace(color_table[NodeId]);
	}
#endif

	switch(shadingModel){
		case SHADING_STANDARD:
			return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
						sv_sampleIndex,
#endif
						mp.diffuse, normal, mp.aorms.xyzw, mp.emissive, motion);
		case SHADING_EMISSIVE:
			return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
						sv_sampleIndex,
#endif
						mp.diffuse, normal, mp.aorms.xyzw, mp.emissive * mp.diffuse.a, motion);
	}
	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		float4(1,0,0,1), normal, mp.aorms.xyzw, float4(1,0,0,1), float2(0,0));
}

#endif