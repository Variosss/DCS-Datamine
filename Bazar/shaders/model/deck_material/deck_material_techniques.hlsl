#include "./common/states.hlsl"

#ifdef PASS_GEN_2
#undef PASS_GEN_2
#endif

#define PASS_GEN_2(ps_c, idx)		pass P##idx PASS_BODY(deck_vs_c, ps_c, BLEND_STATE, DEPTH_STATE)

technique11 normal
{
	PASS_GEN_2(deferred_ps_c, 0)

	PASS_GEN_2(fwd_ps_c, 1)
	PASS_GEN_2(fwd_nsm_ps_c, 2)
}

technique11 normal_map
{
	pass P0
	{
		SET_RASTER_STATE;
		DISABLE_ALPHA_BLEND;
		DISABLE_DEPTH_BUFFER;
		COMPILED_VERTEX_SHADER(deck_vs_c)
		COMPILED_PIXEL_SHADER(deck_ps_map_c)
		GEOMETRY_SHADER_PLUG
	}
}

technique11 normal_sat
{
	pass P0
	{
		SET_RASTER_STATE;
		DISABLE_ALPHA_BLEND;
		ENABLE_DEPTH_BUFFER;
		COMPILED_VERTEX_SHADER(deck_vs_c)
		COMPILED_PIXEL_SHADER(deck_ps_sat_c)
		GEOMETRY_SHADER_PLUG
	}
}

#if 1 //IR
technique11 normal_ir
{
	pass P0
	{
		SET_RASTER_STATE;
		DISABLE_ALPHA_BLEND;
		ENABLE_DEPTH_BUFFER;
		COMPILED_VERTEX_SHADER(deck_vs_c)
		COMPILED_PIXEL_SHADER(deck_ps_ir_c)
		GEOMETRY_SHADER_PLUG
	}
}

#endif

#undef PASS_GEN_2
