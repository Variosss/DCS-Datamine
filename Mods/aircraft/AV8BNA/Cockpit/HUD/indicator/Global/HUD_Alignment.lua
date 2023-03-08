-- Alignment

-- HUD Alignment Elements
local DBG_RED = MakeMaterial(nil, {255,0,0,50})

local	HUD_water_line					= CreateElement "ceSMultiLine"
		HUD_water_line.name				= "HUD_water_line"
		HUD_water_line.material			= stroke_material
		HUD_water_line.init_pos			= {0, -5.0 * MilToDI(HUD_SCALE), 0}
		HUD_water_line.points_set		= {"HUD_stroke_symbols", "waterline"}
		HUD_water_line.parent_element	= HUD_center.name
		HUD_water_line.scale			= HUD_SCALE
AddHUDStrokeSymbol(HUD_water_line)

local	HUD_hdg_line				= CreateElement "ceSMultiLine"
		HUD_hdg_line.name			= "HUD_hdg_line"
		HUD_hdg_line.material		= "SIMPLE_WHITE"
		HUD_hdg_line.init_pos		= {0, 0, 0}
		HUD_hdg_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_hdg_line.parent_element	= HUD_center.name
		HUD_hdg_line.scale			= HUD_SCALE
		HUD_hdg_line.controllers	= {{"hud_waterline", 2.0}}
AddHUDStrokeSymbol(HUD_hdg_line)

local	HUD_hdg_line				= CreateElement "ceSMultiLine"
		HUD_hdg_line.name			= "HUD_gunsight_line"
		HUD_hdg_line.material		= "DBG_BLACK"
		HUD_hdg_line.init_pos		= {0, 0, 0}
		HUD_hdg_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_hdg_line.parent_element	= HUD_center.name
		HUD_hdg_line.scale			= HUD_SCALE
		HUD_hdg_line.controllers	= {{"hud_waterline", -2.0}}
AddHUDStrokeSymbol(HUD_hdg_line)


local	HUD_water_line					= CreateElement "ceSMultiLine"
		HUD_water_line.name				= "HUD_water_line_alg_L"
		HUD_water_line.material			= "DBG_RED"
		HUD_water_line.init_pos			= {-40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_water_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_water_line.parent_element	= HUD_center.name
		HUD_water_line.scale			= HUD_SCALE
AddHUDStrokeSymbol(HUD_water_line)

local	HUD_water_line					= CreateElement "ceSMultiLine"
		HUD_water_line.name				= "HUD_water_line_alg_R"
		HUD_water_line.material			= "DBG_RED"
		HUD_water_line.init_pos			= {40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_water_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_water_line.parent_element	= HUD_center.name
		HUD_water_line.scale			= HUD_SCALE
AddHUDStrokeSymbol(HUD_water_line)

local	HUD_water_line					= CreateElement "ceSMultiLine"
		HUD_water_line.name				= "HUD_water_line_horz_L"
		HUD_water_line.material			= "PURPLE"
		HUD_water_line.init_pos			= {-40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_water_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_water_line.parent_element	= HUD_center.name
		HUD_water_line.scale			= HUD_SCALE
		HUD_water_line.controllers		= {{"hud_waterline", -4.7}}
AddHUDStrokeSymbol(HUD_water_line)

local	HUD_water_line					= CreateElement "ceSMultiLine"
		HUD_water_line.name				= "HUD_water_line_horz_R"
		HUD_water_line.material			= "PURPLE"
		HUD_water_line.init_pos			= {40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_water_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_water_line.parent_element	= HUD_center.name
		HUD_water_line.scale			= HUD_SCALE
		HUD_water_line.controllers		= {{"hud_waterline", -4.7}}
AddHUDStrokeSymbol(HUD_water_line)

local	HUD_CFOV_line					= CreateElement "ceSMultiLine"
		HUD_CFOV_line.name				= "HUD_CFOV_line_L"
		HUD_CFOV_line.material			= "DBG_RED"
		HUD_CFOV_line.init_pos			= {-40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_CFOV_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_CFOV_line.scale				= HUD_SCALE
AddHUDStrokeSymbol(HUD_CFOV_line)

local	HUD_CFOV_line					= CreateElement "ceSMultiLine"
		HUD_CFOV_line.name				= "HUD_CFOV_line_R"
		HUD_CFOV_line.material			= "DBG_RED"
		HUD_CFOV_line.init_pos			= {40 * MilToDI(HUD_SCALE), 0, 0}
		HUD_CFOV_line.points_set		= {"HUD_stroke_symbols", "line174-6"}
		HUD_CFOV_line.scale				= HUD_SCALE
AddHUDStrokeSymbol(HUD_CFOV_line)

local	HUD_PL_Center					= CreateElement "ceSMultiLine"
		HUD_PL_Center.name				= "HUD_water_line"
		HUD_PL_Center.material			= "DBG_RED"
		HUD_PL_Center.init_pos			= {0, 0.0, 0}
		HUD_PL_Center.points_set		= {"HUD_stroke_symbols", "Gun_Cross"}
		HUD_PL_Center.parent_element	= INS_HUD_center.name
		HUD_PL_Center.scale				= HUD_SCALE
AddHUDStrokeSymbol(HUD_PL_Center)


--[[
HUD_Data_Center					= CreateElement "ceSimple"
HUD_Data_Center.name			= "HUD_Data_Center"
HUD_Data_Center.init_pos		= {0, 7.0 * MilToDI(HUD_SCALE), 0}
HUD_Data_Center.parent_element	= HUD_center.name
HUD_Data_Center.controllers		= {{"HUD_base_data", HUD_SCALE}}
AddHUDElement(HUD_Data_Center)

AC_Velocity_Vector					= CreateElement "ceSimple"
AC_Velocity_Vector.name				= "AC_Velocity_Vector"
AC_Velocity_Vector.init_pos			= {0, 0, 0}
AC_Velocity_Vector.parent_element	= HUD_center.name
AC_Velocity_Vector.controllers		= {{"AC_VV", HUD_SCALE}}
AddHUDElement(AC_Velocity_Vector)
--]]

