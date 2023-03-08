#include "./common/states.hlsl"

#ifdef PASS_GEN_2
#undef PASS_GEN_2
#endif

#define PASS_GEN_2(ps_c, idx)		pass P##idx PASS_BODY(model_vs_c, ps_c, BLEND_STATE, DEPTH_STATE)
#define PASS_GEN_CKT_2(ps_c, idx)	pass P##idx PASS_BODY(model_vs_c, ps_c, BLEND_STATE, DEPTH_STATE_COCKPIT)
#define PASS_GEN_SEL_2(ps_c, idx)	pass P##idx PASS_BODY(model_vs_c, ps_c, BLEND_STATE, ENABLE_DEPTH_BUFFER_SELECTED)

TECH_NAME_GEN(normal, TECHNIQUE_POSTFIX)
{
	PASS_GEN_2(deferred_ps_c, 0)

	PASS_GEN_2(fwd_ps_c, 1)
	PASS_GEN_2(fwd_nsm_ps_c, 2)

	PASS_GEN_SEL_2(fwd_ps_c, 3)
	PASS_GEN_SEL_2(fwd_nsm_ps_c, 4)
}

TECH_NAME_GEN(normal_cockpit, TECHNIQUE_POSTFIX)
{
	PASS_GEN_CKT_2(deferred_ps_c, 0)

	PASS_GEN_CKT_2(fwd_ckt_ps_c, 1)
	PASS_GEN_CKT_2(fwd_ckt_nsm_ps_c, 2)
	PASS_GEN_CKT_2(fwd_ckt_gi_ps_c, 3)
	PASS_GEN_CKT_2(fwd_ckt_gi_nsm_ps_c, 4)

	PASS_GEN_SEL_2(fwd_ckt_ps_c, 5)
	PASS_GEN_SEL_2(fwd_ckt_nsm_ps_c, 6)
	PASS_GEN_SEL_2(fwd_ckt_gi_ps_c, 7)
	PASS_GEN_SEL_2(fwd_ckt_gi_nsm_ps_c, 8)
}

TECH_NAME_GEN(normal_map, TECHNIQUE_POSTFIX)
{
	pass P0
	{
		SET_RASTER_STATE;
		DISABLE_ALPHA_BLEND;
		DISABLE_DEPTH_BUFFER;
		COMPILED_VERTEX_SHADER(model_vs_c)
		COMPILED_PIXEL_SHADER(diffuse_sun_ps_map_c)
		GEOMETRY_SHADER_PLUG
	}
}

TECH_NAME_GEN(normal_sat, TECHNIQUE_POSTFIX)
{
	pass P0
	{
		SET_RASTER_STATE;
		DISABLE_ALPHA_BLEND;
		ENABLE_DEPTH_BUFFER;
		COMPILED_VERTEX_SHADER(model_vs_c)
		COMPILED_PIXEL_SHADER(diffuse_sun_ps_sat_c)
		GEOMETRY_SHADER_PLUG
	}
}

#if 1 //IR
TECH_NAME_GEN(normal_ir, TECHNIQUE_POSTFIX)
{
	pass P0
	{
		SET_RASTER_STATE;
		BLEND_STATE;
		DEPTH_STATE;
		COMPILED_VERTEX_SHADER(model_vs_c)
		COMPILED_PIXEL_SHADER(diffuse_sun_ps_ir_c)
		GEOMETRY_SHADER_PLUG
	}
}

#endif

TECH_NAME_GEN(cockpit_cubemap, TECHNIQUE_POSTFIX)
{
	pass P0
	{
		SET_RASTER_STATE;
		BLEND_STATE;
		DEPTH_STATE;
		COMPILED_VERTEX_SHADER(model_vs_c)
		COMPILED_PIXEL_SHADER(cockpit_cubemap_ps_c)
		GEOMETRY_SHADER_PLUG
	}
}


#undef PASS_GEN_2
