------------------------------
-- VSTOL Page: AWLS Seering
------------------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."VSTOL/VSTOL_Base.lua")

-- DIGITAL DATA
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Steerpoint_Data"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -108.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%1.1f DME"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"nav_dmg_lvl_0"}, {"awls_DME_range"}}
AddHUDElement(Window02)

-- SYMBOLOGY
local	VFP_center						= CreateElement "ceSimple"
		VFP_center.name					= "AWLS_Center"
		VFP_center.init_pos				= {0, 0, 0}
		VFP_center.parent_element		= HUD_center.name
		VFP_center.controllers			= {{"nav_dmg_lvl_0"}, {"vstol_vfpm", 0.6, HUD_SCALE}}
AddHUDElement(VFP_center)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "Steering_Marks"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, 0.0, 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_Steering"}
		AWLS_Symbol.parent_element		= VFP_center.name
		AWLS_Symbol.scale				= HUD_SCALE
AddHUDStrokeSymbol(AWLS_Symbol)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "AWLS_Azimuth"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, 0.0, 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_Azimuth"}
		AWLS_Symbol.parent_element		= VFP_center.name
		AWLS_Symbol.scale				= HUD_SCALE
		AWLS_Symbol.controllers 		= {{"awls_azimuth_steering", 0.0048 * HUD_SCALE}}
AddHUDStrokeSymbol(AWLS_Symbol)

local	AWLS_Symbol						= CreateElement "ceSMultiLine"
		AWLS_Symbol.name				= "AWLS_Elevation"
		AWLS_Symbol.material			= stroke_material
		AWLS_Symbol.init_pos			= {0.0, 0.0, 0}
		AWLS_Symbol.points_set			= {"HUD_stroke_symbols", "ILS_GlideSlope"}
		AWLS_Symbol.parent_element		= VFP_center.name
		AWLS_Symbol.scale				= HUD_SCALE
		AWLS_Symbol.controllers 		= {{"awls_elevation_steering", 0.014 * HUD_SCALE}}
AddHUDStrokeSymbol(AWLS_Symbol)