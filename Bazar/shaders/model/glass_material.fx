#define GLASS_MATERIAL

#include "common/shader_macroses.hlsl"
#include "common/uniforms.hlsl"
#define EXTERN_ATMOSPHERE_INSCATTER_ID
#include "common/atmosphereSamples.hlsl"

#include "functions/glass.hlsl"

#include "functions/lk_shadow.hlsl"

#include "functions/radar.hlsl"
#include "functions/impostor.hlsl"
#include "functions/cockpit_glass_uv.hlsl"

#include "../common/States11.hlsl"
#include "../common/ShadowStates.hlsl"

// compile shaders
VertexShader_t model_vs_c = COMPILE_VERTEX_SHADER(model_vs());
VertexShader_t lk_shadow_vs_c = COMPILE_VERTEX_SHADER(lk_shadow_vs());

PixelShader_t fwd_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(0));
PixelShader_t fwd_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(F_DISABLE_SHADOWMAP));

PixelShader_t fwd_ckt_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(F_IN_COCKPIT));
PixelShader_t fwd_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass1(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t fwd_drp_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(0));
PixelShader_t fwd_drp_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(F_DISABLE_SHADOWMAP));
PixelShader_t fwd_drp_ckt_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(F_IN_COCKPIT));
PixelShader_t fwd_drp_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_drp_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_drp_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_droplets(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t fwd_ice_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(0));
PixelShader_t fwd_ice_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(F_DISABLE_SHADOWMAP));
PixelShader_t fwd_ice_ckt_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(F_IN_COCKPIT));
PixelShader_t fwd_ice_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_ice_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_ice_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_icing(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t fwd_fog_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(0));
PixelShader_t fwd_fog_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(F_DISABLE_SHADOWMAP));
PixelShader_t fwd_fog_ckt_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(F_IN_COCKPIT));
PixelShader_t fwd_fog_ckt_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(F_IN_COCKPIT | F_DISABLE_SHADOWMAP));
PixelShader_t fwd_fog_ckt_gi_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(F_IN_COCKPIT | F_COCKPIT_GI));
PixelShader_t fwd_fog_ckt_gi_nsm_ps_c = COMPILE_PIXEL_SHADER(forward_ps_pass_fogging(F_IN_COCKPIT | F_COCKPIT_GI | F_DISABLE_SHADOWMAP));

PixelShader_t diffuse_sun_ps_map_c = COMPILE_PIXEL_SHADER(diffuse_sun_ps_map());
PixelShader_t diffuse_sun_ps_sat_c = COMPILE_PIXEL_SHADER(diffuse_sun_ps_sat());
PixelShader_t glassFLIR_ps_c = COMPILE_PIXEL_SHADER(glassFLIR_ps());
PixelShader_t lk_shadow_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_ps());
PixelShader_t lk_shadow_transparent_ps_c = COMPILE_PIXEL_SHADER(lk_shadow_transparent_ps());

VertexShader_t radar_vs_c = COMPILE_VERTEX_SHADER(radar_vs());
PixelShader_t radar_ps_c = COMPILE_PIXEL_SHADER(radar_ps());
PixelShader_t radar_edge_ps_c = COMPILE_PIXEL_SHADER(radar_edge_ps());
GeometryShader radar_edge_gs_c = CompileShader(gs_4_0, radar_edge_gs());

PixelShader_t impostor_ps_c = COMPILE_PIXEL_SHADER(impostor_ps());

VertexShader_t cockpit_glass_uv_vs_c = COMPILE_VERTEX_SHADER(cockpit_glass_uv_vs());
PixelShader_t cockpit_glass_uv_ps_c = COMPILE_PIXEL_SHADER(cockpit_glass_uv_ps());

BlendState enableGlassAlphaBlend
{
	BlendEnable[0] = TRUE;

	SrcBlend = ONE;
	DestBlend = SRC1_COLOR;
	BlendOp = ADD;

#if BLEND_MODE == BM_TRANSPARENT || BLEND_MODE == BM_SHADOWED_TRANSPARENT
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = INV_SRC_ALPHA;
	BlendOpAlpha = ADD;
#else
	SrcBlendAlpha = SRC_ALPHA;
	DestBlendAlpha = ONE;//ZERO;
	BlendOpAlpha = ADD;
#endif

	RenderTargetWriteMask[0] = 0x0f; //RED | GREEN | BLUE | ALPHA
};

// no depth bias
#ifdef BUILDING_MATERIAL
	#define DEPTH_BIAS DEF_DEPTH_BIAS
#endif
#define TECHNIQUE_POSTFIX _cf
#include "./glass_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS

// depth bias
#define DEPTH_BIAS DEF_DEPTH_BIAS
#define TECHNIQUE_POSTFIX _cf_db
#include "./glass_material_techniques.hlsl"
#undef TECHNIQUE_POSTFIX
#undef DEPTH_BIAS

TECHNIQUE lockon_shadows
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(lk_shadow_vs_c)
		COMPILED_PIXEL_SHADER(lk_shadow_ps_c)
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
		COMPILED_PIXEL_SHADER(lk_shadow_transparent_ps_c)

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

TECHNIQUE cockpit_glass_uv
{
	pass P0
	{
		COMPILED_VERTEX_SHADER(cockpit_glass_uv_vs_c)
		COMPILED_PIXEL_SHADER(cockpit_glass_uv_ps_c)
		SetGeometryShader(NULL);
		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);
	}
}

