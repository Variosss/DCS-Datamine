--------------------
-- AA Page: GUNS --
--------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AA/AA_Base.lua")

local	gunsight_pos					= CreateElement "ceSimple"
		gunsight_pos.name				= "gun_boresight"
		gunsight_pos.init_pos			= {0, 0, 0}
		gunsight_pos.parent_element		= HUD_center.name
		gunsight_pos.controllers		= {{"hud_waterline", -2.0 * HUD_SCALE}, {"avn_dmg_lvl_1"}, {"sms_dmg_lvl_0"}, {"AA_gunsight", HUD_SCALE}}
AddHUDElement(gunsight_pos)

--DIGITAL DATA RIGHT
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

-- SYMBOLOGY
local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "Gun_Cross"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {0, 0, 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "Gun_Cross"}
		GUN_Symbol.parent_element	= HUD_center.name
		GUN_Symbol.controllers		= {{"hud_waterline", -2.0 * HUD_SCALE}}
		GUN_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(GUN_Symbol)

local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "gun_reticle_lr"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {0, 0, 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "AA_long_range"}
		GUN_Symbol.parent_element	= gunsight_pos.name
		GUN_Symbol.controllers		= {{"AA_lr_gun_reticle"}}
		GUN_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(GUN_Symbol)

local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "gun_reticle_sr"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {0, 0, 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "AA_short_range"}
		GUN_Symbol.parent_element	= gunsight_pos.name
		GUN_Symbol.controllers		= {{"AA_sr_gun_reticle"}}
		GUN_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(GUN_Symbol)

local	gun_bullet_fp 					= CreateElement "ceSimpleLineObject"
		gun_bullet_fp.name				= "gun_bullet_fp"	
		gun_bullet_fp.material   		= hud_line_indicators
		gun_bullet_fp.width       		= 1.0 * HUD_SCALE
		gun_bullet_fp.init_pos			= {0, 0, 0}
		gun_bullet_fp.parent_element	= gunsight_pos.name
		gun_bullet_fp.controllers  		= {{"AA_gunsight_bfp"}}
AddHUDElement(gun_bullet_fp)

local	AG_NWPN_Symbol					= CreateElement "ceSMultiLine"
		AG_NWPN_Symbol.name				= "warning_cue"
		AG_NWPN_Symbol.material			= stroke_material
		AG_NWPN_Symbol.init_pos			= {0, 0, 0}
		AG_NWPN_Symbol.points_set		= {"HUD_stroke_symbols", "warning"}
		AG_NWPN_Symbol.scale			= HUD_SCALE
		AG_NWPN_Symbol.controllers 		= {{"gun_fail_warning"}}
AddHUDStrokeSymbol(AG_NWPN_Symbol)
