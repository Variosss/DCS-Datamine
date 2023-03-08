#include "common/shader_macroses.hlsl"
#include "common/uniforms.hlsl"
#define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"

#include "functions/diffuse_sun.hlsl"

#include "functions/flat_shadow.hlsl"
#include "functions/lk_shadow.hlsl"

#include "functions/radar.hlsl"
#include "functions/impostor.hlsl"
#include "functions/cockpit_cubemap.hlsl"

#include "common/States11.hlsl"
#include "common/ShadowStates.hlsl"

// compile shaders
VertexShader_t model_vs_c = COMPILE_VERTEX_SHADER(model_vs());
VertexShader_t flat_shadow_vs_c = COMPILE_VERTEX_SHADER(flat_shadow_vs());
VertexShader_t lk_shadow_vs_c = COMPILE_VERTEX_SHADER(lk_shadow_vs());

PixelShader_t deferred_ps_c = COMPILE_PIXEL_SHADER(deferred_ps(0));

PixelShader_t fwd_ps_c = COMPILE_PIXEL_SHADER(forward_ps(0));
PixelShader_t fwd_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps(F_DISABLE_SHADOWMAP));

PixelShader_t fwd_ckt_ps_c = COMPILE_PIXEL_SHADER(forward_ps(F_IN_COCKPIT));
PixelShader_t fwd_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(forward_ps(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t diffuse_sun_ps_map_c = COMPILE_PIXEL_SHADER(diffuse_sun_ps_map());
PixelShader_t diffuse_sun_ps_sat_c = COMPILE_PIXEL_SHADER(diffuse_sun_ps_sat());
#if 1 //IR
PixelShader_t diffuse_sun_ps_ir_c = COMPILE_PIXEL_SHADER(diffuse_sun_ps_ir());
#endif
PixelShader_t flat_shadow_ps_c = COMPILE_PIXEL_SHADER(flat_shadow_ps());
PixelShader_t flat_shadow_transparent_ps_c = COMPILE_PIXEL_SHADER(flat_shadow_transparent_ps());
PixelShader_t lk_shadow_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_ps());
PixelShader_t lk_shadow_transparent_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_transparent_ps());

VertexShader_t radar_vs_c = COMPILE_VERTEX_SHADER(radar_vs());
PixelShader_t radar_ps_c = COMPILE_PIXEL_SHADER(radar_ps());
PixelShader_t radar_edge_ps_c = COMPILE_PIXEL_SHADER(radar_edge_ps());
GeometryShader radar_edge_gs_c = CompileShader(gs_4_0, radar_edge_gs());

PixelShader_t impostor_ps_c = COMPILE_PIXEL_SHADER(impostor_ps());

PixelShader_t cockpit_cubemap_ps_c = COMPILE_PIXEL_SHADER(cockpit_cubemap_ps());

// no depth bias
#ifdef BUILDING_MATERIAL
	#define DEPTH_BIAS DEF_DEPTH_BIAS
#endif
#define TECHNIQUE_POSTFIX _cf
#include "./def_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS

// depth bias
#define DEPTH_BIAS DEF_DEPTH_BIAS
#define TECHNIQUE_POSTFIX _cf_db
#include "./def_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS

TECHNIQUE flat_shadow
{
	pass P0
	{
		SET_RASTER_STATE_FLAT_SHADOW;

		FLAT_SHADOW_ALPHA_BLEND;

		ENABLE_FLAT_SHADOW_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(flat_shadow_vs_c)
		SetPixelShader(flat_shadow_ps_c);

		GEOMETRY_SHADER_PLUG
	}

	pass FLIR {
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(FlatShadowsState, FLAT_SHADOW_TEST);

		SET_RASTER_STATE_FLAT_SHADOW;

		COMPILED_VERTEX_SHADER(flat_shadow_vs_c)
		SetPixelShader(flat_shadow_ps_c);

		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE flat_shadow_transparent
{
	pass P0
	{
		SET_RASTER_STATE_FLAT_SHADOW;

		FLAT_SHADOW_ALPHA_BLEND;

		ENABLE_FLAT_SHADOW_DEPTH_BUFFER;

		COMPILED_VERTEX_SHADER(flat_shadow_vs_c)
		SetPixelShader(flat_shadow_transparent_ps_c);

		GEOMETRY_SHADER_PLUG
	}

	pass FLIR {
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetDepthStencilState(FlatShadowsState, FLAT_SHADOW_TEST);

		SET_RASTER_STATE_FLAT_SHADOW;

		COMPILED_VERTEX_SHADER(flat_shadow_vs_c)
		SetPixelShader(flat_shadow_ps_c);

		GEOMETRY_SHADER_PLUG
	}
}

TECHNIQUE lockon_shadows
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(lk_shadow_vs_c)
	#if defined(SHADOW_WITH_ALPHA_TEST)
		COMPILED_PIXEL_SHADER(lk_shadow_ps_c)
	#else
		SetPixelShader(NULL);
	#endif
		SetGeometryShader(NULL);
		SetDepthStencilState(shadowmapDepthState, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(shadowmapRasterizerState);
	}
}

TECHNIQUE lockon_shadows_transparent
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(lk_shadow_vs_c)
	#if defined(SHADOW_WITH_ALPHA_TEST)
		COMPILED_PIXEL_SHADER(lk_shadow_transparent_ps_c)
	#else
		SetPixelShader(NULL);
	#endif

		SetGeometryShader(NULL);

		SetDepthStencilState(shadowmapDepthState, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(shadowmapRasterizerState);
	}
}

TECHNIQUE radar
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(radar_vs_c)
		COMPILED_PIXEL_SHADER(radar_ps_c)
		SetGeometryShader(NULL);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullFront);
	}
#ifndef FOREST_MATERIAL
	pass P1
	{
		SetVertexShader(radar_vs_c);
		SetGeometryShader(radar_edge_gs_c);
		SetPixelShader(radar_edge_ps_c);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullFront);

	}
#endif
}

TECHNIQUE impostor
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(model_vs_c)
		COMPILED_PIXEL_SHADER(impostor_ps_c)
		SetGeometryShader(NULL);
		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(impostorBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullFront);
	}
}

