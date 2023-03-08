-------------------
-- AG JDAMs Page --
-------------------
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

local	HUD_center_pos					= CreateElement "ceSimple"
		HUD_center_pos.name				= "JDAM_center_pos"
		HUD_center_pos.init_pos			= {0, -45.0 * MilToDI(HUD_SCALE), 0}
		HUD_center_pos.parent_element	= MAV_HUD_center.name
AddHUDElement(HUD_center_pos)


-- SYMBOLS
local HFOV_radius  = 180 * MilToDI(HUD_SCALE)	-- mils
local HUD_Boundary = RFOV_radius * GetScale()

local	JDAM_Symbols					= CreateElement "ceSMultiLine"
		JDAM_Symbols.name				= "NIRD_Center_Dot"
		JDAM_Symbols.material			= stroke_material
		JDAM_Symbols.init_pos			= {0, 0, 0}
		JDAM_Symbols.points_set			= {"HUD_stroke_symbols", "NIRD_Steering_Dot"}
		JDAM_Symbols.parent_element		= "JDAM_center_pos"
		JDAM_Symbols.scale				= HUD_SCALE
		JDAM_Symbols.controllers		= {{"JDAM_Center_Dot"}}
AddHUDStrokeSymbol(JDAM_Symbols)

local	JDAM_Symbols					= CreateElement "ceSMultiLine"
		JDAM_Symbols.name				= "NIRD_Range_Circle"
		JDAM_Symbols.material			= stroke_material
		JDAM_Symbols.init_pos			= {0, 0, 0}
		JDAM_Symbols.points_set			= {"HUD_stroke_symbols", "NIRD_Range_Circle"}
		JDAM_Symbols.parent_element		= "JDAM_center_pos"
		JDAM_Symbols.scale				= HUD_SCALE
		JDAM_Symbols.controllers		= {{"JDAM_LAR_Range"}}
AddHUDStrokeSymbol(JDAM_Symbols)

local	JDAM_Symbols					= CreateElement "ceSMultiLine"
		JDAM_Symbols.name				= "JDAM_LAR_Rmax"
		JDAM_Symbols.material			= stroke_material
		JDAM_Symbols.init_pos			= {0, 0, 0}
		JDAM_Symbols.points_set			= {"HUD_stroke_symbols", "JDAM_Rmax"}
		JDAM_Symbols.parent_element		= "NIRD_Range_Circle"
		JDAM_Symbols.scale				= HUD_SCALE
		JDAM_Symbols.controllers		= {{"hud_waterline", -2.8 * HUD_SCALE}}
AddHUDStrokeSymbol(JDAM_Symbols)

local	JDAM_Symbols					= CreateElement "ceSMultiLine"
		JDAM_Symbols.name				= "JDAM_LAR_RMin"
		JDAM_Symbols.material			= stroke_material
		JDAM_Symbols.init_pos			= {0, 0, 0}
		JDAM_Symbols.points_set			= {"HUD_stroke_symbols", "NIRD_LAR_Limits"}
		JDAM_Symbols.parent_element		= "NIRD_Range_Circle"
		JDAM_Symbols.scale				= HUD_SCALE
		JDAM_Symbols.controllers		= {{"JDAM_LAR_Min_Range"}, {"hud_waterline", 2.8 * HUD_SCALE}}
AddHUDStrokeSymbol(JDAM_Symbols)

local	JDAM_LAR_rng_max					= CreateElement "ceSimpleLineObject"
		JDAM_LAR_rng_max.name				= "JDAM_LAR_rng_max"
		JDAM_LAR_rng_max.material			= hud_line_indicators
		JDAM_LAR_rng_max.width				= 0.8 * MilToDI(HUD_SCALE)
		JDAM_LAR_rng_max.init_pos			= {0, 0, 0}
		JDAM_LAR_rng_max.parent_element		= "NIRD_Range_Circle"
		JDAM_LAR_rng_max.controllers		= {{"JDAM_LAR_Max_Range", 38 * MilToDI(HUD_SCALE) * GetScale()}}
AddHUDElement(JDAM_LAR_rng_max)

-- DIGITAL DATA CENTER
-- Terminal Parameters
local	HUD_Center_Window					= CreateElement "ceStringSLine"
		HUD_Center_Window.name				= "JDAM_TERM_Status"
		HUD_Center_Window.material			= stroke_font
		HUD_Center_Window.init_pos			= {-10.0 * MilToDI(HUD_SCALE), -67.5 * MilToDI(HUD_SCALE), 0}
		HUD_Center_Window.formats			= {"%s"}
		HUD_Center_Window.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		HUD_Center_Window.alignment			= "CenterBottom"
		HUD_Center_Window.parent_element	= "NIRD_Range_Circle"
		HUD_Center_Window.controllers		= {{"JDAM_Term_Parameters"}}
AddHUDElement(HUD_Center_Window)

-- Target List
local half_x  	= 0.5 * 1024 * mils_ratio
local half_y  	= 0.5 * 4 * mils_ratio
local x_pos		= 0.0

for i = 1, 11 do
	local	HUD_Center_Window					= CreateElement "ceStringSLine"
			HUD_Center_Window.name				= "JDAM_Target_Index" .. string.format("%02d", i)
			HUD_Center_Window.material			= stroke_font
			HUD_Center_Window.init_pos			= {x_pos * MilToDI(HUD_SCALE), -67.5 * MilToDI(HUD_SCALE), 0}
			HUD_Center_Window.formats			= {"%s"}
			HUD_Center_Window.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
			HUD_Center_Window.alignment			= "CenterBottom"
			HUD_Center_Window.parent_element	= "NIRD_Range_Circle"
			HUD_Center_Window.controllers		= {{"JDAM_Target_ListN", i - 1}}
	AddHUDElement(HUD_Center_Window)
	
	x_pos = x_pos + 8
	
end

-- LAR Percent
local	HUD_Center_Window					= CreateElement "ceStringSLine"
		HUD_Center_Window.name				= "JDAM_TERM_Status"
		HUD_Center_Window.material			= stroke_font
		HUD_Center_Window.init_pos			= {0, -85.5 * MilToDI(HUD_SCALE), 0}
		HUD_Center_Window.formats			= {"%1.0f"}
		HUD_Center_Window.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		HUD_Center_Window.alignment			= "CenterCenter"
		HUD_Center_Window.parent_element	= "NIRD_Range_Circle"
		HUD_Center_Window.controllers		= {{"JDAM_LAR_Percent"}}
AddHUDElement(HUD_Center_Window)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "jdam_count"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%d %s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= MAV_HUD_center.name
		Window02.controllers			= {{"wpn_safe_warn"}, {"JDAM_count"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "jdam_in_rng"
		Window02.material				= stroke_font
		Window02.init_pos				= {70.0 * MilToDI(HUD_SCALE), -143.0 * MilToDI(HUD_SCALE), 0}
		Window02.value					= "IN RNG"
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= MAV_HUD_center.name
		Window02.controllers			= {{"JDAM_INRNG"}}
AddHUDElement(Window02)

