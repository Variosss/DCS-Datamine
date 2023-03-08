
-- Data Windows LEFT
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "airspeed_txt"
		Window01.material			= stroke_font
		Window01.init_pos			= {-55.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window01.formats			= {"%1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= ADC_HUD_center.name
		Window01.controllers		= {{"VSTOL_MasterMode"}, {"ac_ias"}}
AddHUDElement(Window01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "airspeed_true"
		Window01.material			= stroke_font
		Window01.init_pos			= {-83.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "T"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window01.alignment			= "CenterCenter"
		Window01.parent_element		= ADC_HUD_center.name
		Window01.controllers		= {{"VSTOL_MasterMode"}, {"nav_dmg_lvl_4"}, {"AG_MasterMode"}}
AddHUDElement(Window01)

-- Overtemp
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "overtemp_txt"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), -20.0 * MilToDI(HUD_SCALE), 0}
		Window01.formats			= {"OT %1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"ac_eng_overtemp"}}
AddHUDElement(Window01)

-- Data Windows RIGHT
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_hd_cl_txt"
		Window02.material			= stroke_font
		Window02.init_pos			= {87.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%2d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"adc_dmg_lvl_1"}, {"ac_alt_hd_0"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_hd_ch_txt"
		Window02.material			= stroke_font
		Window02.init_pos			= {87.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%03d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_100]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"adc_dmg_lvl_1"}, {"ac_alt_hd_1"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_hd_m_txt"
		Window02.material			= stroke_font
		Window02.init_pos			= {70.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"adc_dmg_lvl_1"}, {"ac_alt_th"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_hd_mode_txt"
		Window02.material			= stroke_font
		Window02.init_pos			= {48.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%s"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"adc_dmg_lvl_1"}, {"ac_alt_mode"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_agl"
		Window02.material			= stroke_font
		Window02.init_pos			= {48.0 * MilToDI(HUD_SCALE), -20.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%s"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"ac_alt_agl"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_calibration"
		Window02.material			= stroke_font
		Window02.init_pos			= {60.0 * MilToDI(HUD_SCALE), -20.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%2.2f"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"ac_alt_kst"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "altitude_agl"
		Window02.material			= stroke_font
		Window02.init_pos			= {48.0 * MilToDI(HUD_SCALE), -33.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%4.1f PROX"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"VSTOL_MasterMode"}, {"TCN_PROX_Range"}}
AddHUDElement(Window02)


-- CST/TTT OPTIONS
local	CST_TTT_Symbol					= CreateElement "ceSMultiLine"
		CST_TTT_Symbol.name				= "CST_Lubber_Line"
		CST_TTT_Symbol.material			= stroke_material
		CST_TTT_Symbol.init_pos			= {-66.5 * MilToDI(HUD_SCALE), -20.0 * MilToDI(HUD_SCALE), 0}
		CST_TTT_Symbol.points_set		= {"HUD_stroke_symbols", "Steering_Cue"}
		CST_TTT_Symbol.scale			= HUD_SCALE * 0.7
		CST_TTT_Symbol.parent_element	= ADC_HUD_center.name
		CST_TTT_Symbol.controllers 		= {{"timer_cst_enabled"}}
AddHUDStrokeSymbol(CST_TTT_Symbol)

local	CST_TTT_Symbol					= CreateElement "ceSMultiLine"
		CST_TTT_Symbol.name				= "CST_Caret"
		CST_TTT_Symbol.material			= stroke_material
		CST_TTT_Symbol.init_pos			= {0, 0, 0}
		CST_TTT_Symbol.points_set		= {"HUD_stroke_symbols", "HDG_Caret"}
		CST_TTT_Symbol.scale			= HUD_SCALE * 0.7
		CST_TTT_Symbol.parent_element	= "CST_Lubber_Line"
		CST_TTT_Symbol.controllers 		= {{"timer_cst_cue", 0.1 * HUD_SCALE}}
AddHUDStrokeSymbol(CST_TTT_Symbol)

-- GPWS
local	GPWS_Symbol					= CreateElement "ceSMultiLine"
		GPWS_Symbol.name			= "GPWS_Arrow"
		GPWS_Symbol.material		= stroke_material
		GPWS_Symbol.init_pos		= {0, 0, 0}
		GPWS_Symbol.points_set		= {"HUD_stroke_symbols", "pullup"}
		GPWS_Symbol.scale			= HUD_SCALE
		GPWS_Symbol.controllers 	= {{"adc_dmg_lvl_0"}, {"GPWS_Warning"}, {"ac_roll"}}
AddHUDStrokeSymbol(GPWS_Symbol)

-- A/A TACAN PROX
local	TCN_PROX_Symbol					= CreateElement "ceSMultiLine"
		TCN_PROX_Symbol.name			= "TCN_PROX_Warning"
		TCN_PROX_Symbol.material		= stroke_material
		TCN_PROX_Symbol.init_pos		= {0, 0, 0}
		TCN_PROX_Symbol.points_set		= {"HUD_stroke_symbols", "Obstacle-Warning"}
		TCN_PROX_Symbol.scale			= HUD_SCALE
		TCN_PROX_Symbol.controllers 	= {{"adc_dmg_lvl_0"}, {"TCN_PROX_Warning"}}
AddHUDStrokeSymbol(TCN_PROX_Symbol)

