monitorpos = "L"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_init.lua")

brightness_sensitive_materials = {
	"mpcd_align_mtl_y",
	"mpcd_symbols_1_w",
	"mpcd_symbols_1_b",
	"mpcd_symbols_2_w",
	"mpcdl_symbols_1_g",
	"mpcdl_symbols_2_g",
	"mpcdl_symbols_3",
	"mpcdl_symbols_4",
	"mpcdl_symbols_5",
	"mpcdl_symbols_6",
	"mpcdl_symbols_1",
	"tpod_symbols_L",
	-- EHSD
	"mpcdl_font_base",
	"mpcdl_tpod_font",
	"mpcdl_lmav_font",
	"mpcd_tpod_font_bg",
	"mpcd_ehsd_lines_fg",
	"mpcd_ehsd_lines_bg",
	"mpcd_ehsd_lines_fg",
	"mpcd_ehsd_lines_bg",
	"mpcd_ehsd_route_lines_fg",
	"mpcd_ehsd_dashed_lines_bg",
	"mpcd_ehsd_dashed_lines_fg",
	"mpcd_ehsd_route_lines_gr",
	"mpcd_ehsd_route_lines_bl",
	"mpcd_ehsd_route_lines_or",
	"mpcd_ehsd_route_lines_vl",
	"mpcd_ehsd_route_lines_rd",
	"mpcdl_ehsd_dashed_lines_bg",
	"mpcdl_ehsd_dashed_lines_fg",
	-- Stroke
	"mpcdl_strk_symb_fg",
	"mpcdl_strk_symb_bg",
	"font_MPCDL_stroke",
	"font_MPCDL_stroke_outline",
	-- HUD Repeater
	"hrl_pitch_ladder",
	"hrl_ind_material",
	"hrl_hdg_material",
	"hrl_align_material",
	"hrl_lines_material",
	"hrl_dashed_lines_material",
	"hrl_indication_font",
	"font_HUD_stroke_rl",
	"font_HUD_stroke_ol_rl",
	"HUD_RL_GREEN_BRIGHT",
	"BLACK",
}

opacity_sensitive_materials = {
	"mpcd_align_mtl_y",
	"mpcd_symbols_1_w",
	"mpcd_symbols_1_b",
	"mpcd_symbols_2_w",
	"mpcdl_symbols_1_g",
	"mpcdl_symbols_2_g",
	"mpcdl_symbols_3",
	"mpcdl_symbols_4",
	"mpcdl_symbols_5",
	"mpcdl_symbols_6",
	"mpcdl_symbols_1",
	"tpod_symbols_L",
	--EHSD
	"mpcdl_font_base",
	"mpcdl_tpod_font",
	"mpcdl_lmav_font",
	"mpcd_tpod_font_bg",
	"mpcd_ehsd_lines_fg",
	"mpcd_ehsd_lines_bg",
	"mpcd_ehsd_route_lines_fg",
	"mpcd_ehsd_dashed_lines_bg",
	"mpcd_ehsd_dashed_lines_fg",
	"mpcd_ehsd_route_lines_gr",
	"mpcd_ehsd_route_lines_bl",
	"mpcd_ehsd_route_lines_or",
	"mpcd_ehsd_route_lines_vl",
	"mpcd_ehsd_route_lines_rd",
	"mpcdl_ehsd_dashed_lines_bg",
	"mpcdl_ehsd_dashed_lines_fg",
	-- Stroke
	"mpcdl_strk_symb_fg",
	"mpcdl_strk_symb_bg",
	"font_MPCDL_stroke",
	"font_MPCDL_stroke_outline",
	-- HUD Repeater
	"hrl_pitch_ladder",
	"hrl_ind_material",
	"hrl_hdg_material",
	"hrl_align_material",
	"hrl_lines_material",
	"hrl_dashed_lines_material",
	"hrl_indication_font",
	"font_HUD_stroke_rl",
	"font_HUD_stroke_ol_rl",
	"HUD_RL_GREEN_BRIGHT",
	"BLACK",
}

color_sensitive_materials = {
	"mpcdl_symbols_1_g",
	"mpcdl_symbols_2_g",
	"mpcdl_symbols_3",
	"mpcdl_symbols_4",
	"mpcdl_symbols_5",
	"mpcdl_symbols_6",
	"mpcdl_symbols_1",
	"tpod_symbols_L",
	-- EHSD
	"mpcdl_font_base",
	"mpcdl_tpod_font",
	"mpcdl_lmav_font",
	-- Stroke
	"mpcdl_strk_symb_fg",
	"font_MPCDL_stroke",
	-- HUD Repeater
	"hrl_pitch_ladder",
	"hrl_ind_material",
	"hrl_hdg_material",
	"hrl_align_material",
	"hrl_lines_material",
	"hrl_dashed_lines_material",
	"hrl_indication_font",
	"font_HUD_stroke_rl",
	"font_HUD_stroke_ol_rl",
	"HUD_RL_GREEN_BRIGHT",
}

--try_find_assigned_viewport("LEFT_MFCD")
