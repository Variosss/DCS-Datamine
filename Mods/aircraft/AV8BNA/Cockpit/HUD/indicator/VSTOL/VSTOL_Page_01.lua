---------------------------
-- VSTOL Page: Normal NAV
---------------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."VSTOL/VSTOL_Base.lua")

-- DIGITAL DATA
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Steerpoint_Data"
		Window02.material				= stroke_font
		Window02.init_pos				= {60.0 * MilToDI(HUD_SCALE), -108.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"nav_dmg_lvl_0"}, {"steerpoint_data"}}
AddHUDElement(Window02)

-- SYMBOLOGY
local	STR_Symbol					= CreateElement "ceSMultiLine"
		STR_Symbol.name				= "Steerpoint_Cue"
		STR_Symbol.material			= stroke_material
		STR_Symbol.init_pos			= {0.0, 0.0 * MilToDI(HUD_SCALE), 0}
		STR_Symbol.points_set		= {"HUD_stroke_symbols", "Steerpoint_Cue"}
		STR_Symbol.parent_element	= HUD_center.name
		STR_Symbol.scale			= HUD_SCALE
		STR_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"nav_steerpoint", HUD_SCALE}}
AddHUDStrokeSymbol(STR_Symbol)

