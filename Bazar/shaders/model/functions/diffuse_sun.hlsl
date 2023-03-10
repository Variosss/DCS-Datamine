#ifndef DIFFUSE_SUN_HLSL
#define DIFFUSE_SUN_HLSL

#define INFRARED_SHADERS
#define FOG_ENABLE
#define EXTERN_UNIFORM_LIGHT_COUNT
#define EXTERN_ATMOSPHERE_SAMPLES_ID
#ifndef SHADING_MODEL
	#if defined(SELF_ILLUMINATION_ADDITIVE_MATERIAL) || defined(BANO_MATERIAL)
		#define SHADING_MODEL	SHADING_EMISSIVE
	#else
		#define SHADING_MODEL	SHADING_STANDARD
	#endif
#endif

//goes to standard tech:
// SELF_ILLUMINATION_TRANSPARENT_MATERIAL
// SELF_ILLUMINATION_COLOR_MATERIAL
// BUILDING_MATERIAL
// CHROME_MATERIAL
// COLOR_ONLY

#include "common/enums.hlsl"
#include "common/context.hlsl"

#include "functions/misc.hlsl"
#include "functions/vt_utils.hlsl"
#include "functions/vertex_shader.hlsl"

#include "functions/satellite.hlsl"
#include "functions/map.hlsl"
#include "functions/infrared.hlsl"

#include "functions/shading.hlsl"
#include "functions/deferred_def_ps.hlsl"
#include "functions/forward_def_ps.hlsl"

#if (BLEND_MODE == BM_NONE) || (BLEND_MODE == BM_ALPHA_TEST) || (BLEND_MODE == BM_DECAL) || (BLEND_MODE == BM_DECAL_DEFERRED)

GBuffer deferred_ps(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
	uniform int Flags) {

	return deferredDefaultPS(input,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		SHADING_MODEL);
}

#elif (BLEND_MODE == BM_TRANSPARENT) || (BLEND_MODE == BM_ADDITIVE) || (BLEND_MODE == BM_SHADOWED_TRANSPARENT)

GBuffer deferred_ps(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
uniform int Flags)
{
	const float4 color = float4(1,0,0,1);
	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		color, float3(0,1,0), float4(1, 0.9, 0, 1), color.rgb, float2(0,0));
}
#else
#endif

PS_OUTPUT forward_ps(VS_OUTPUT input, uniform int Flags) {
	PS_OUTPUT o;
	o.RGBColor = forwardDefaultPS(input, Flags, SHADING_MODEL);
	return o;
}


#endif
