#include "common/shader_macroses.hlsl"
#include "../common/constants.hlsl"
#include "common/uniforms.hlsl"
#define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"
#include "functions/diffuse_sun.hlsl"
#include "functions/lk_shadow.hlsl"
#include "common/ShadowStates.hlsl"

#define FOG_ENABLE
#include "common/fog.hlsl"

#include "common/States11.hlsl"

#ifndef SHADING_MODEL
	#if defined(SELF_ILLUMINATION_ADDITIVE_MATERIAL) || defined(BANO_MATERIAL)
		#define SHADING_MODEL	SHADING_EMISSIVE
	#else
		#define SHADING_MODEL	SHADING_STANDARD
	#endif
#endif

GBuffer lines_ps(VS_OUTPUT input,
#if USE_SV_SAMPLEINDEX
	uint sv_sampleIndex: SV_SampleIndex,
#endif
	uniform int Flags) {
	float2 motion = calcMotionVector(input.projPos, input.prevFrameProjPos);
	return BuildGBuffer(input.Position.xy,
#if USE_SV_SAMPLEINDEX
		sv_sampleIndex,
#endif
		float4(color, 1), float3(0, 1, 0), float4(0, 1, 0, 0), float4(0,0,0,1), motion);
}

PS_OUTPUT lines_forward_ps(VS_OUTPUT input, uniform int Flags) {
	PS_OUTPUT o;
	o.RGBColor = float4(1, 0, 0, 1);
	return o;
}


PS_OUTPUT lines_ps_map(VS_OUTPUT input)
{
	PS_OUTPUT o;
	o.RGBColor = float4(0.0, 0.0, 0.0, 1.0);
	return o;
}

PS_OUTPUT lines_ps_sat(VS_OUTPUT input)
{
	PS_OUTPUT o;

	o.RGBColor = float4(color, MeltFactor.x);

	// self illumination
	o.RGBColor = lerp(o.RGBColor, float4(color, MeltFactor.x), selfIlluminationValue);

	return o;
}

PS_OUTPUT lines_ps_ir(VS_OUTPUT input)
{
	PS_OUTPUT o;

	o.RGBColor = float4(color, MeltFactor.x);

	// self illumination
	o.RGBColor = lerp(o.RGBColor, float4(color, MeltFactor.x), selfIlluminationValue);

	fogApply(gCameraPos.xyz, input.Pos.xyz, input.projPos, o.RGBColor.rgb);

	o.RGBColor.rgb = dot(o.RGBColor.rgb, IR_MULT);

	return o;
}

VertexShader_t model_vs_c = COMPILE_VERTEX_SHADER(model_vs());

VertexShader_t lk_shadow_vs_c = COMPILE_VERTEX_SHADER(lk_shadow_vs());
PixelShader_t lk_shadow_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_ps());
PixelShader_t lk_shadow_transparent_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_transparent_ps());

PixelShader_t deferred_ps_c = COMPILE_PIXEL_SHADER(lines_ps(0));

PixelShader_t fwd_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(0));
PixelShader_t fwd_nsm_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(F_DISABLE_SHADOWMAP));

PixelShader_t fwd_ckt_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(F_IN_COCKPIT));
PixelShader_t fwd_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(lines_forward_ps(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t lines_ps_map_c = COMPILE_PIXEL_SHADER(lines_ps_map());
PixelShader_t lines_ps_sat_c = COMPILE_PIXEL_SHADER(lines_ps_sat());
PixelShader_t lines_ps_ir_c = COMPILE_PIXEL_SHADER(lines_ps_ir());

TECHNIQUE lockon_shadows
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(lk_shadow_vs_c)
		COMPILED_PIXEL_SHADER(NULL)
		SetGeometryShader(NULL);
		SetDepthStencilState(shadowmapDepthState, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(shadowmapRasterizerState);

	}
}

// no depth bias
#ifdef BUILDING_MATERIAL
	#define DEPTH_BIAS DEF_DEPTH_BIAS
#endif
#define TECHNIQUE_POSTFIX _cf
#include "./common/states.hlsl"
#include "./lines_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS

// depth bias
#define DEPTH_BIAS DEF_DEPTH_BIAS
#define TECHNIQUE_POSTFIX _cf_db
#include "./common/states.hlsl"
#include "./lines_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS
