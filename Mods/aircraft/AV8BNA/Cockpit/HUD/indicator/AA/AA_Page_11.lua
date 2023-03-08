--------------------
-- AA Page: AIM-9 --
--------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AA/AA_Base.lua")

local	gunsight_pos					= CreateElement "ceSimple"
		gunsight_pos.name				= "gun_boresight"
		gunsight_pos.init_pos			= {0, 0, 0}
		gunsight_pos.parent_element		= HUD_center.name
		gunsight_pos.controllers		= {{"avn_dmg_lvl_1"}, {"hud_waterline", -1.95 * HUD_SCALE}}
AddHUDElement(gunsight_pos)

--DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Sidewinder_Load_Count"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%d 9M %s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"sms_dmg_lvl_0"}, {"avn_dmg_lvl_1"}, {"wpn_safe_warn"}, {"aim9_count"}}
AddHUDElement(Window02)

-- SYMBOLOGY
local	AIM_Symbol					= CreateElement "ceSMultiLine"
		AIM_Symbol.name				= "sidewinder_search"
		AIM_Symbol.material			= stroke_material
		AIM_Symbol.init_pos			= {0, 0, 0}
		AIM_Symbol.points_set		= {"HUD_stroke_symbols", "AIM9_Search"}
		AIM_Symbol.parent_element	= HUD_center.name
		AIM_Symbol.scale			= HUD_SCALE
		AIM_Symbol.controllers		= {{"avn_dmg_lvl_1"}, {"sw_searching", HUD_SCALE}}
AddHUDStrokeSymbol(AIM_Symbol)

local	AIM_Symbol					= CreateElement "ceSMultiLine"
		AIM_Symbol.name				= "sidewinder_lock"
		AIM_Symbol.material			= stroke_material
		AIM_Symbol.init_pos			= {0, 0, 0}
		AIM_Symbol.points_set		= {"HUD_stroke_symbols", "sidewinder_lock"}
		AIM_Symbol.parent_element	= HUD_center.name
		AIM_Symbol.scale			= HUD_SCALE
		AIM_Symbol.controllers		= {{"avn_dmg_lvl_1"}, {"sw_locked", HUD_SCALE}}
AddHUDStrokeSymbol(AIM_Symbol)

local	AIM_Symbol					= CreateElement "ceSMultiLine"
		AIM_Symbol.name				= "sidewinder_SEAM"
		AIM_Symbol.material			= stroke_material
		AIM_Symbol.init_pos			= {0, 0, 0}
		AIM_Symbol.points_set		= {"HUD_stroke_symbols", "AIM9_SEAM"}
		AIM_Symbol.parent_element	= gunsight_pos.name
		AIM_Symbol.scale			= HUD_SCALE
		AIM_Symbol.controllers		= {{"sw_SEAM"}}
AddHUDStrokeSymbol(AIM_Symbol)

local	AIM_Symbol					= CreateElement "ceSMultiLine"
		AIM_Symbol.name				= "Gun_Cross"
		AIM_Symbol.material			= stroke_material
		AIM_Symbol.init_pos			= {0, 0, 0}
		AIM_Symbol.points_set		= {"HUD_stroke_symbols", "Gun_Cross"}
		AIM_Symbol.parent_element	= gunsight_pos.name
		AIM_Symbol.scale			= HUD_SCALE
		AIM_Symbol.controllers		= {{"AA_gunsight_SIM"}}
AddHUDStrokeSymbol(AIM_Symbol)

