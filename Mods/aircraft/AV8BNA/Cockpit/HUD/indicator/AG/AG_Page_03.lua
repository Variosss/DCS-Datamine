------------------------------
-- AG GPs, CBUs & LGBs Page --
------------------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AG/AG_Base.lua")

local	HUD_center_line					= CreateElement "ceSimple"
		HUD_center_line.name			= "HUD_center_line"
		HUD_center_line.init_pos		= {0, 0, 0}
		HUD_center_line.parent_element	= HUD_center.name
		HUD_center_line.controllers		= {{"nav_dmg_lvl_2"}, {"adc_dmg_lvl_0"}}
AddHUDElement(HUD_center_line)

local	HUD_center_pos					= CreateElement "ceSimple"
		HUD_center_pos.name				= "HUD_center_pos"
		HUD_center_pos.init_pos			= {0, 0, 0}
		HUD_center_pos.parent_element	= HUD_center_line.name
		HUD_center_pos.controllers		= {{"nav_dmg_lvl_2"}, {"avn_dmg_lvl_1"}, {"AG_TGT_azimuth", 1.0}, {"AG_TGT_elevation", HUD_SCALE}}
AddHUDElement(HUD_center_pos)

local	hud_vvm_pos						= CreateElement "ceSimple"
		hud_vvm_pos.name				= "hud_vvm_pos"
		hud_vvm_pos.init_pos			= {0, 0.0, 0}
		hud_vvm_pos.parent_element		= HUD_center.name
		hud_vvm_pos.controllers			= {{"nav_dmg_lvl_2"}, {"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(hud_vvm_pos)

-- AUTO MODE
local HFOV_radius  =  180 * HUD_SCALE
local HUD_Boundary = RFOV_radius * GetScale()

local	AUTO_Mode_Ret 					= CreateElement "ceSimpleLineObject"
		AUTO_Mode_Ret.name				= "AUTO_Mode_Ret"	
		AUTO_Mode_Ret.material   		= hud_line_indicators
		AUTO_Mode_Ret.width       		= 0.7 * MilToDI(HUD_SCALE)
		AUTO_Mode_Ret.init_pos			= {0, 0, 0}
		AUTO_Mode_Ret.parent_element	= HUD_center_pos.name
		AUTO_Mode_Ret.controllers  		= {{"auto_mode"}, {"auto_asl", HUD_Boundary}, {"asl_roll"}}
AddHUDElement(AUTO_Mode_Ret)

local	AUTO_Mode_Ret					= CreateElement "ceSimple"
		AUTO_Mode_Ret.name				= "auto_TD_ASL"
		AUTO_Mode_Ret.init_pos			= {0.0, 0.0, 0}
		AUTO_Mode_Ret.parent_element	= "AUTO_Mode_Ret"
		AUTO_Mode_Ret.controllers		= {{"AG_TGT_elevation", -1.0 * HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(AUTO_Mode_Ret)

local	AUTO_Mode_Ret					= CreateElement "ceSMultiLine"
		AUTO_Mode_Ret.name				= "AUTO_Release_Cue"
		AUTO_Mode_Ret.material			= stroke_material
		AUTO_Mode_Ret.init_pos			= {0, 0, 0}
		AUTO_Mode_Ret.points_set		= {"HUD_stroke_symbols", "AUTO_Release_Cue"}
		AUTO_Mode_Ret.parent_element	= "auto_TD_ASL"
		AUTO_Mode_Ret.controllers		= {{"auto_rel_cue", 0.2 * HUD_SCALE}}
		AUTO_Mode_Ret.scale				= HUD_SCALE
AddHUDStrokeSymbol(AUTO_Mode_Ret)

-- CCIP MODE
local half_x  = 0.5 * 1024 * mils_ratio
local half_y  = 0.5 * 4 * mils_ratio

local	CCIP_Mode_Ret					= CreateElement "ceSimple"
		CCIP_Mode_Ret.name				= "ccip_cross_aimpoint"
		CCIP_Mode_Ret.init_pos			= {0, 0, 0}
		CCIP_Mode_Ret.parent_element	= HUD_center.name
		CCIP_Mode_Ret.controllers		= {{"nav_dmg_lvl_2"}, {"avn_dmg_lvl_1"}, {"ccip_mode"}, {"ccip_cross", HUD_Boundary, HUD_SCALE}}
AddHUDElement(CCIP_Mode_Ret)

local	CCIP_Mode_Ret					= CreateElement "ceSMultiLine"
		CCIP_Mode_Ret.name				= "CCIP_Cross"
		CCIP_Mode_Ret.material			= stroke_material
		CCIP_Mode_Ret.init_pos			= {0, 0, 0}
		CCIP_Mode_Ret.points_set		= {"HUD_stroke_symbols", "CCIP_Cross"}
		CCIP_Mode_Ret.parent_element	= "ccip_cross_aimpoint"
		CCIP_Mode_Ret.controllers		= {{"ccip_cross_n"}}
		CCIP_Mode_Ret.scale				= HUD_SCALE
AddHUDStrokeSymbol(CCIP_Mode_Ret)

local	CCIP_Mode_Ret					= CreateElement "ceSMultiLine"
		CCIP_Mode_Ret.name				= "CCIP_Cross_Limited"
		CCIP_Mode_Ret.material			= stroke_material
		CCIP_Mode_Ret.init_pos			= {0, 0, 0}
		CCIP_Mode_Ret.points_set		= {"HUD_stroke_symbols", "CCIP_Cross_Limited"}
		CCIP_Mode_Ret.parent_element	= "ccip_cross_aimpoint"
		CCIP_Mode_Ret.controllers		= {{"ccip_cross_l"}}
		CCIP_Mode_Ret.scale				= HUD_SCALE
AddHUDStrokeSymbol(CCIP_Mode_Ret)

local	CCIP_Mode_Ret 					= CreateElement "ceSimpleLineObject"
		CCIP_Mode_Ret.name				= "Ret_CCIP_BFL"	
		CCIP_Mode_Ret.material   		= hud_dashed_line
		CCIP_Mode_Ret.tex_params		= {{0, 0.5}, {1, 0.5}, {1/(2 * half_x), 1}}
		CCIP_Mode_Ret.vertices			= { {0, 0}, {2 * half_x, 0} }
		CCIP_Mode_Ret.width       		= 0.7 * MilToDI(HUD_SCALE)
		CCIP_Mode_Ret.init_pos			= {0, 0, 0}
		CCIP_Mode_Ret.parent_element	= hud_vvm_pos.name
		CCIP_Mode_Ret.controllers  		= {{"nav_dmg_lvl_2"}, {"avn_dmg_lvl_1"}, {"ccip_mode"}, {"ccip_bfl", HUD_SCALE, HUD_Boundary}}
AddHUDElement(CCIP_Mode_Ret)

local	CCIP_Mode_Ret					= CreateElement "ceSMultiLine"
		CCIP_Mode_Ret.name				= "Ret_CCIP_RCue"
		CCIP_Mode_Ret.material			= stroke_material
		CCIP_Mode_Ret.init_pos			= {0, 0, 0}
		CCIP_Mode_Ret.points_set		= {"HUD_stroke_symbols", "AUTO_Release_Cue"}
		CCIP_Mode_Ret.parent_element	= "ccip_cross_aimpoint"
		CCIP_Mode_Ret.controllers		= {{"ccip_refl_cue"}}
		CCIP_Mode_Ret.scale				= HUD_SCALE
AddHUDStrokeSymbol(CCIP_Mode_Ret)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "auto_time_to_go"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%1.f   SEC"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"nav_dmg_lvl_2"}, {"avn_dmg_lvl_1"}, {"auto_mode"}, {"auto_TTG_value"}}
AddHUDElement(Window02)
