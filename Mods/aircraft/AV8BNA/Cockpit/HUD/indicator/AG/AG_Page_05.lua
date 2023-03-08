------------------
-- AG AGMs Page --
------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AG/AG_Base.lua")

local	hud_vvm_pos						= CreateElement "ceSimple"
		hud_vvm_pos.name				= "hud_vvm_pos"
		hud_vvm_pos.init_pos			= {0, 0.0, 0}
		hud_vvm_pos.parent_element		= MAV_HUD_center.name
		hud_vvm_pos.controllers			= {{"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(hud_vvm_pos)

-- AGM-65X
-- SYMBOLS
local	AGM_Symbol					= CreateElement "ceSMultiLine"
		AGM_Symbol.name				= "IRMV_Reticle"
		AGM_Symbol.material			= stroke_material
		AGM_Symbol.init_pos			= {0.5 * MilToDI(HUD_SCALE), 0.5 * MilToDI(HUD_SCALE), 0}
		AGM_Symbol.points_set		= {"HUD_stroke_symbols", "slideslip_ind"}
		AGM_Symbol.parent_element	= "hud_vvm_pos"
		AGM_Symbol.scale			= HUD_SCALE
		AGM_Symbol.controllers		= {{"AGM65X_Reticle"}}
AddHUDStrokeSymbol(AGM_Symbol)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "agm65x_count"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -117.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%d %s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= MAV_HUD_center.name
		Window02.controllers			= {{"wpn_safe_warn"}, {"MAV_count"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "agm65x_uncaged"
		Window02.material				= stroke_font
		Window02.init_pos				= {8.0 * MilToDI(HUD_SCALE), 0.0, 0}
		Window02.value					= "U"
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= "agm65x_count"
		Window02.controllers			= {{"IM_uncaged"}}
AddHUDElement(Window02)

local	Window02_Box					= CreateElement "ceSMultiLine"
		Window02_Box.name				= "Window02_Box"
		Window02_Box.material			= stroke_material
		Window02_Box.init_pos			= {98.0 * MilToDI(HUD_SCALE), -117.0 * MilToDI(HUD_SCALE), 0}
		Window02_Box.points_set			= {"HUD_stroke_symbols", "Uncaged_Box"}
		Window02_Box.parent_element		= MAV_HUD_center.name
		Window02_Box.controllers		= {{"wpn_safe_warn"}, {"IM_selected_sensor"}}
		Window02_Box.scale				= HUD_SCALE
AddHUDStrokeSymbol(Window02_Box)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "agm65x_in_rng"
		Window02.material				= stroke_font
		Window02.init_pos				= {70.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Window02.value					= "IN RNG"
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= MAV_HUD_center.name
		Window02.controllers			= {{"MAV_INRNG"}}
AddHUDElement(Window02)

-- AGM-122A
-- SYMBOLS
local	AGM_Symbol					= CreateElement "ceSMultiLine"
		AGM_Symbol.name				= "Sidearm_Sight"
		AGM_Symbol.material			= stroke_material
		AGM_Symbol.init_pos			= {0, 0, 0}
		AGM_Symbol.points_set		= {"HUD_stroke_symbols", "Sidearm_sight"}
		AGM_Symbol.parent_element	= MAV_HUD_center.name
		AGM_Symbol.scale			= HUD_SCALE
		AGM_Symbol.controllers		= {{"SA_sight_uncaged", -2.0 * HUD_SCALE}}
AddHUDStrokeSymbol(AGM_Symbol)

local	AGM_Symbol					= CreateElement "ceSMultiLine"
		AGM_Symbol.name				= "Sidearm_sight_caged"
		AGM_Symbol.material			= stroke_material
		AGM_Symbol.init_pos			= {0, 0, 0}
		AGM_Symbol.points_set		= {"HUD_stroke_symbols", "Sidearm_sight_caged"}
		AGM_Symbol.parent_element	= MAV_HUD_center.name
		AGM_Symbol.scale			= HUD_SCALE
		AGM_Symbol.controllers		= {{"SA_sight_caged", -2.0 * HUD_SCALE}}
AddHUDStrokeSymbol(AGM_Symbol)


-- DIGITAL DATA RIGHT
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "sidearm_count"
		Window02.material			= stroke_font
		Window02.init_pos			= {110.0 * MilToDI(HUD_SCALE), -117.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%d SA"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= MAV_HUD_center.name
		Window02.controllers		= {{"wpn_safe_warn"}, {"SA_ammo_count"}}
AddHUDElement(Window02)

