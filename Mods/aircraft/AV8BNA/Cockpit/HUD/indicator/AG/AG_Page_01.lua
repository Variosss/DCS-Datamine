-----------------
-- AG GUN Page --
-----------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AG/AG_Base.lua")

local	gun_boresight					= CreateElement "ceSimple"
		gun_boresight.name				= "gun_boresight"
		gun_boresight.init_pos			= {0, 0, 0}
		gun_boresight.parent_element	= HUD_center.name
		gun_boresight.controllers		= {{"hud_waterline", -2.0 * HUD_SCALE}}
AddHUDElement(gun_boresight)

-- SYMBOLOGY
local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "AG_Gun_Reticle"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {-6.55 * MilToDI(HUD_SCALE), 6.55 * MilToDI(HUD_SCALE), 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Reticle"}
		GUN_Symbol.parent_element	= HUD_center.name
		GUN_Symbol.controllers		= {{"AG_gunsight", HUD_SCALE}}
		GUN_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(GUN_Symbol)

local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "gun_ret_rng_max"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Limits_ind"}
		GUN_Symbol.parent_element	= "AG_Gun_Reticle"
		GUN_Symbol.scale			= HUD_SCALE
		GUN_Symbol.controllers		= {{"gun_max_range", 1.6 * HUD_SCALE}}
AddHUDStrokeSymbol(GUN_Symbol)

local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "gun_ret_rng_min"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Limits_ind"}
		GUN_Symbol.parent_element	= "AG_Gun_Reticle"
		GUN_Symbol.scale			= HUD_SCALE
		GUN_Symbol.controllers		= {{"gun_min_range", 1.6 * HUD_SCALE}}
AddHUDStrokeSymbol(GUN_Symbol)

local	gun_slant_range					= CreateElement "ceSimpleLineObject"
		gun_slant_range.name			= "gun_slant_range"
		gun_slant_range.material		= hud_line_indicators
		gun_slant_range.width			= 2.0 * MilToDI(HUD_SCALE)
		gun_slant_range.init_pos		= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		gun_slant_range.parent_element	= "AG_Gun_Reticle"
		gun_slant_range.controllers		= {{"gun_slant_range", GS_SlantRange_Scale}}
AddHUDElement(gun_slant_range)

local	AG_NWPN_Symbol					= CreateElement "ceSMultiLine"
		AG_NWPN_Symbol.name				= "warning_cue"
		AG_NWPN_Symbol.material			= stroke_material
		AG_NWPN_Symbol.init_pos			= {0, 0, 0}
		AG_NWPN_Symbol.points_set		= {"HUD_stroke_symbols", "warning"}
		AG_NWPN_Symbol.scale			= HUD_SCALE
		AG_NWPN_Symbol.controllers 		= {{"gun_fail_warning"}}
AddHUDStrokeSymbol(AG_NWPN_Symbol)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Gun_Load_Count"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%d GUN"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"avn_dmg_lvl_1"}, {"sms_dmg_lvl_0"}, {"wpn_safe_warn"}, {"gun_ammo_count"}}
AddHUDElement(Window02)
