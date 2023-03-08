------------------
-- AG Base Page --
------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_page_NAV_base.lua")
dofile(hud_path.."/Global/HUD_Digital_Heading.lua")
dofile(hud_path.."/Global/HUD_TD_Base.lua")

GS_SlantRange_Scale = 20 * MilToDI(HUD_SCALE) * GetScale()

--dofile(hud_path.."/Global/HUD_Alignment.lua")

-- MSC Elements
MAV_HUD_center					= CreateElement "ceSimple"
MAV_HUD_center.name				= "MAV_HUD_center"
MAV_HUD_center.init_pos			= {0, 0, 0}
MAV_HUD_center.parent_element	= HUD_center.name
MAV_HUD_center.controllers		= {{"sms_dmg_lvl_0"}}
AddHUDElement(MAV_HUD_center)

-- Velocity Vector
hud_vvm								= CreateElement "ceSimple"
hud_vvm.name						= "hud_vvm"
hud_vvm.init_pos					= {0, 0.0, 0}
hud_vvm.parent_element				= HUD_center.name
hud_vvm.controllers					= {{"nav_dmg_lvl_0"}, {"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(hud_vvm)

local	VVM_Symbol					= CreateElement "ceSMultiLine"
		VVM_Symbol.name				= "HUD_VVM_Uncaged"
		VVM_Symbol.material			= stroke_material
		VVM_Symbol.init_pos			= {0.0, 4.0 * MilToDI(HUD_SCALE), 0}
		VVM_Symbol.points_set		= {"HUD_stroke_symbols", "FPM"}
		VVM_Symbol.parent_element	= hud_vvm.name
		VVM_Symbol.controllers		= {{"gunsight_occlusion", GS_SlantRange_Scale}}
		VVM_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(VVM_Symbol)

-- SYMBOLOGY
local	GUN_Symbol					= CreateElement "ceSMultiLine"
		GUN_Symbol.name				= "Gun_Cross"
		GUN_Symbol.material			= stroke_material
		GUN_Symbol.init_pos			= {0, 0, 0}
		GUN_Symbol.points_set		= {"HUD_stroke_symbols", "Gun_Cross"}
		GUN_Symbol.parent_element	= HUD_center.name
		GUN_Symbol.controllers		= {{"hud_waterline", -2.0 * HUD_SCALE}, {"AG_Gun_Cross"}}
		GUN_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(GUN_Symbol)

-- Steering Data
local	STP_Symbol					= CreateElement "ceSMultiLine"
		STP_Symbol.name				= "HDG_Caret"
		STP_Symbol.material			= stroke_material
		STP_Symbol.init_pos			= {0.0, 10.0 * MilToDI(HUD_SCALE), 0}
		STP_Symbol.points_set		= {"HUD_stroke_symbols", "HDG_Caret"}
		STP_Symbol.parent_element	= HUD_center.name
		STP_Symbol.scale			= HUD_SCALE * 0.7
AddHUDStrokeSymbol(STP_Symbol)

local	STP_Symbol					= CreateElement "ceSMultiLine"
		STP_Symbol.name				= "Steering_Cue"
		STP_Symbol.material			= stroke_material
		STP_Symbol.init_pos			= {0.0, 10.0 * MilToDI(HUD_SCALE), 0}
		STP_Symbol.points_set		= {"HUD_stroke_symbols", "Steering_Cue"}
		STP_Symbol.parent_element	= HUD_center.name
		STP_Symbol.scale			= HUD_SCALE * 0.7
		STP_Symbol.controllers		= {{"nav_dmg_lvl_0"}, {"nav_steering_error", 0.002083 * HUD_SCALE}}
AddHUDStrokeSymbol(STP_Symbol)

local	STP_Data					= CreateElement "ceStringSLine"
		STP_Data.name				= "steerpoint_hdg"
		STP_Data.material			= stroke_font
		STP_Data.init_pos			= {0, -9.0 * MilToDI(HUD_SCALE), 0}
		STP_Data.formats			= {"%03d"}
		STP_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_100]
		STP_Data.alignment			= "CenterCenter"
		STP_Data.parent_element		= "Steering_Cue"
		STP_Data.controllers		= {{"nav_bearing"}}
AddHUDElement(STP_Data)

local	STR_Symbol					= CreateElement "ceSMultiLine"
		STR_Symbol.name				= "Steerpoint_Cue"
		STR_Symbol.material			= stroke_material
		STR_Symbol.init_pos			= {0, 0, 0}
		STR_Symbol.points_set		= {"HUD_stroke_symbols", "Steerpoint_Cue"}
		STR_Symbol.parent_element	= HUD_center.name
		STR_Symbol.scale			= HUD_SCALE
		STR_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"gunsight_occlusion", GS_SlantRange_Scale}, {"nav_steerpoint", HUD_SCALE}}
AddHUDStrokeSymbol(STR_Symbol)

-- NO WEAPON WARNING
local	AG_NWPN_Symbol					= CreateElement "ceSMultiLine"
		AG_NWPN_Symbol.name				= "warning_cue"
		AG_NWPN_Symbol.material			= stroke_material
		AG_NWPN_Symbol.init_pos			= {0, 0, 0}
		AG_NWPN_Symbol.points_set		= {"HUD_stroke_symbols", "warning"}
		AG_NWPN_Symbol.scale			= HUD_SCALE
		AG_NWPN_Symbol.controllers 		= {{"sms_dmg_lvl_0"}, {"ammo_count_zero"}}
AddHUDStrokeSymbol(AG_NWPN_Symbol)

-- PICKLE DOWN
local	AG_Symbol					= CreateElement "ceSMultiLine"
		AG_Symbol.name				= "pickle_down_warning"
		AG_Symbol.material			= stroke_material
		AG_Symbol.init_pos			= {0, 0, 0}
		AG_Symbol.points_set		= {"HUD_stroke_symbols", "warning"}
		AG_Symbol.scale				= HUD_SCALE
		AG_Symbol.controllers 		= {{"msc_dmg_lvl_1"}, {"pickle_down_warning"}}
AddHUDStrokeSymbol(AG_Symbol)

-- ROLL STABILIZED SIGHT
local	AG_Symbol					= CreateElement "ceSMultiLine"
		AG_Symbol.name				= "rss_aiming_carets"
		AG_Symbol.material			= stroke_material
		AG_Symbol.init_pos			= {0, 0, 0}
		AG_Symbol.points_set		= {"HUD_stroke_symbols", "pitch_cue"}
		AG_Symbol.scale				= HUD_SCALE
		AG_Symbol.parent_element	= HUD_center.name
		AG_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"ac_roll"}, {"rss_aiming_carets", HUD_SCALE}}
AddHUDStrokeSymbol(AG_Symbol)

local	AG_Symbol					= CreateElement "ceSMultiLine"
		AG_Symbol.name				= "rss_bomb_sight"
		AG_Symbol.material			= stroke_material
		AG_Symbol.init_pos			= {0, 0, 0}
		AG_Symbol.points_set		= {"HUD_stroke_symbols", "DSL_SIght"}
		AG_Symbol.scale				= HUD_SCALE
		AG_Symbol.parent_element	= HUD_center.name
		AG_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"ac_roll"}, {"rss_bomb_sight", HUD_SCALE}}
AddHUDStrokeSymbol(AG_Symbol)

local half_x  = 0.5 * 1024 * mils_ratio
local half_y  = 0.5 * 4 * mils_ratio

local	rss_bomb_bfl						= CreateElement "ceSimpleLineObject"
		rss_bomb_bfl.name					= "rss_bomb_bfl"	
		rss_bomb_bfl.material				= hud_dashed_line
		rss_bomb_bfl.tex_params				= {{0, 0.5}, {1, 0.5}, {1/(2 * half_x), 1}}
		rss_bomb_bfl.vertices				= { {0, 0}, {2 * half_x, 0} }
		rss_bomb_bfl.width					= 0.6 * MilToDI(HUD_SCALE)
		rss_bomb_bfl.init_pos				= {0, 0, 0}
		rss_bomb_bfl.parent_element			= HUD_center.name
		rss_bomb_bfl.controllers			= {{"nav_dmg_lvl_0"}, {"ac_roll"}, {"rss_bomb_sight_BFL", HUD_SCALE}}
AddHUDElement(rss_bomb_bfl)

-- Pull Up Cue
local	PUC_Symbol					= create_hud_symbol( 666, 109, 780, 128)
		PUC_Symbol.name				= "PUC_Symbol"
		PUC_Symbol.init_pos			= {0, -2.0, 0}
		PUC_Symbol.parent_element	= hud_vvm.name
		PUC_Symbol.controllers		= {{"msc_dmg_lvl_0"}, {"pull_up_cue"}}
AddHUDElement(PUC_Symbol)


-- DIGITAL DATA LEFT
-- Ground Speed
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "GS_Label"
		Window01.material			= stroke_font
		Window01.init_pos			= {-90.0 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "S"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"avn_dmg_lvl_0"}, {"hud_reject_2"}}
AddHUDElement(Window01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "GS_Value"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), 0, 0}
		Window01.formats			= {"%1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= "GS_Label"
		Window01.controllers		= {{"ac_gs"}}
AddHUDElement(Window01)

-- Laser Status
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "tpod_laser_status"
		Window01.material			= stroke_font
		Window01.init_pos			= {-80.0 * MilToDI(HUD_SCALE), -195.0 * MilToDI(HUD_SCALE), 0}
		Window01.formats			= {"%s"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window01.alignment			= "CenterCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"tpod_blinker_1hz"}, {"TPOD_Laser_Warning"}}
AddHUDElement(Window01)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "lst_mode_status"
		Window02.material				= stroke_font
		Window02.init_pos				= {60.0 * MilToDI(HUD_SCALE), -104.0 * MilToDI(HUD_SCALE), 0}
		Window02.value					= "LST"
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"lst_mode"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "acp_dlvr_mode"
		Window02.material				= stroke_font
		Window02.init_pos				= {60.0 * MilToDI(HUD_SCALE), -117.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"wpn_safe_warn"}, {"ACP_delivery_mode"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Steerpoint_Data"
		Window02.material				= stroke_font
		Window02.init_pos				= {60.0 * MilToDI(HUD_SCALE), -156.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"nav_dmg_lvl_0"}, {"steerpoint_data"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "ag_dist_to_tgt"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -156.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%1.1f TGT"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"AG_TGT_lock"}, {"AG_TGT_Range"}}
AddHUDElement(Window02)

-- Time Data
local	TMR_HUD_center					= CreateElement "ceSimple"
		TMR_HUD_center.name				= "TMR_HUD_center"
		TMR_HUD_center.init_pos			= {0, -182.0 * MilToDI(HUD_SCALE), 0}
		TMR_HUD_center.parent_element	= HUD_center.name
		TMR_HUD_center.controllers		= {{"avn_dmg_lvl_0"}, {"hud_reject_2"}, {"timer_time_data"}}
AddHUDElement(TMR_HUD_center)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "AC_Timer_Real_Indicator"
		Window02.material			= stroke_font
		Window02.init_pos			= {60.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.value				= "R"
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= TMR_HUD_center.name
		Window02.controllers		= {{"tmr_real_selected"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "AC_Timer_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.formats			= {"%02d.%02d.%02d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= TMR_HUD_center.name
		Window02.controllers		= {{"tmr_value"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "TTT_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), -182.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%02d.%02d.%02d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"timer_cst_data"}, {"timer_cst_value"}}
AddHUDElement(Window02)

