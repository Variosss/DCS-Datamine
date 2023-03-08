---------------------
-- AG ROCKETS Page --
---------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AG/AG_Base.lua")

-- SYMBOLOGY
local	RKT_Symbol					= CreateElement "ceSMultiLine"
		RKT_Symbol.name				= "AG_RKT_Reticle"
		RKT_Symbol.material			= stroke_material
		RKT_Symbol.init_pos			= {-6.55 * MilToDI(HUD_SCALE), 6.55 * MilToDI(HUD_SCALE), 0}
		RKT_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Reticle"}
		RKT_Symbol.parent_element	= HUD_center.name
		RKT_Symbol.scale			= HUD_SCALE
		RKT_Symbol.controllers		= {{"avn_dmg_lvl_1"}, {"AG_gunsight"}}
AddHUDStrokeSymbol(RKT_Symbol)

local	RKT_Symbol					= CreateElement "ceSMultiLine"
		RKT_Symbol.name				= "rkt_ret_rng_max"
		RKT_Symbol.material			= stroke_material
		RKT_Symbol.init_pos			= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		RKT_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Limits_ind"}
		RKT_Symbol.parent_element	= "AG_RKT_Reticle"
		RKT_Symbol.scale			= HUD_SCALE
		RKT_Symbol.controllers		= {{"gun_max_range", 1.6 * HUD_SCALE}}
AddHUDStrokeSymbol(RKT_Symbol)

local	RKT_Symbol					= CreateElement "ceSMultiLine"
		RKT_Symbol.name				= "rkt_ret_rng_min"
		RKT_Symbol.material			= stroke_material
		RKT_Symbol.init_pos			= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		RKT_Symbol.points_set		= {"HUD_stroke_symbols", "AG_Gun_Limits_ind"}
		RKT_Symbol.parent_element	= "AG_RKT_Reticle"
		RKT_Symbol.scale			= HUD_SCALE
		RKT_Symbol.controllers		= {{"gun_min_range", 1.6 * HUD_SCALE}}
AddHUDStrokeSymbol(RKT_Symbol)

local	gun_slant_range					= CreateElement "ceSimpleLineObject"
		gun_slant_range.name			= "gun_slant_range"
		gun_slant_range.material		= hud_line_indicators
		gun_slant_range.width			= 2.0 * MilToDI(HUD_SCALE)
		gun_slant_range.init_pos		= {6.55 * MilToDI(HUD_SCALE), -6.55 * MilToDI(HUD_SCALE), 0}
		gun_slant_range.parent_element	= "AG_RKT_Reticle"
		gun_slant_range.controllers		= {{"gun_slant_range", GS_SlantRange_Scale}}
AddHUDElement(gun_slant_range)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Gun_Load_Count"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%d RKT"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"sms_dmg_lvl_0"}, {"wpn_safe_warn"}, {"rkt_ammo_count"}}
AddHUDElement(Window02)
