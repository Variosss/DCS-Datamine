local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."NAV/NAV_Base.lua")

--DIGITAL DATA RIGHT

-- SYMBOLOGY
local	VVM_center						= CreateElement "ceSimple"
		VVM_center.name					= "AWLS_Center"
		VVM_center.init_pos				= {0, 0, 0}
		VVM_center.parent_element		= HUD_center.name
		VVM_center.controllers			= {{"nav_dmg_lvl_0"}, {"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(VVM_center)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "Steering_Marks"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, -9.0 * MilToDI(HUD_SCALE), 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_Steering"}
		AWLS_Symbol.parent_element		= VVM_center.name
		AWLS_Symbol.scale				= HUD_SCALE
AddHUDStrokeSymbol(AWLS_Symbol)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "AWLS_Azimuth"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, 0.0, 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_Azimuth"}
		AWLS_Symbol.parent_element		= VVM_center.name
		AWLS_Symbol.scale				= HUD_SCALE
		AWLS_Symbol.controllers 		= {{"awls_azimuth_steering", 0.0048 * HUD_SCALE}}
AddHUDStrokeSymbol(AWLS_Symbol)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "AWLS_Elevation"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, 0.0, 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_GlideSlope"}
		AWLS_Symbol.parent_element		= VVM_center.name
		AWLS_Symbol.scale				= HUD_SCALE
		AWLS_Symbol.controllers 		= {{"awls_elevation_steering", 0.014 * HUD_SCALE}}
AddHUDStrokeSymbol(AWLS_Symbol)