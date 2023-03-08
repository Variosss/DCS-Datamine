---------------------
-- VSTOL Base Page --
---------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_definitions.lua")
dofile(hud_path.."HUD_page_VSTOL_base.lua")

-- HUD Centers
VFP_center						= CreateElement "ceSimple"
VFP_center.name					= "VFP_center"
VFP_center.init_pos				= {0, 0.0, 0}
VFP_center.parent_element		= HUD_center.name
VFP_center.controllers			= {{"nav_dmg_lvl_0"}, {"hud_reject_2"}, {"ac_pitch_horiz", 0.0, HUD_SCALE}}
AddHUDElement(VFP_center)

local	VFP_Symbol					= CreateElement "ceSMultiLine"
		VFP_Symbol.name				= "VFP_Hi"
		VFP_Symbol.material			= stroke_material
		VFP_Symbol.init_pos			= {0.0 * MilToDI(HUD_SCALE), 0.0 * MilToDI(HUD_SCALE), 0}
		VFP_Symbol.points_set		= {"HUD_stroke_symbols", "vfp"}
		VFP_Symbol.parent_element	= HUD_center.name
		VFP_Symbol.scale			= HUD_SCALE
		VFP_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"vstol_vfpm", HUD_SCALE}}
AddHUDStrokeSymbol(VFP_Symbol)

local	VSTOL_Symbol				= CreateElement "ceSMultiLine"
		VSTOL_Symbol.name			= "NRAS_Cue_Box"
		VSTOL_Symbol.material		= stroke_material
		VSTOL_Symbol.init_pos		= {-18.0 * MilToDI(HUD_SCALE), 0.0 * MilToDI(HUD_SCALE), 0}
		VSTOL_Symbol.points_set		= {"HUD_stroke_symbols", "NRAS_Cue_Box"}
		VSTOL_Symbol.parent_element	= "airspeed_txt"
		VSTOL_Symbol.scale			= HUD_SCALE
		VSTOL_Symbol.controllers 	= {{"vstol_nras_cue"}}
AddHUDStrokeSymbol(VSTOL_Symbol)


-- DIGITAL DATA LEFT
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "GS_Label"
		Window01.material			= stroke_font
		Window01.init_pos			= {-90.0 * MilToDI(HUD_SCALE), -143.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "S"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"hud_reject_2"}}
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

-- Engine RPM
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "ENG_RPM_Label"
		Window01.material			= stroke_font
		Window01.init_pos			= {-55.0 * MilToDI(HUD_SCALE), -156.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "R"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"hud_reject_2"}, {"vstol_threshold_0"}}
AddHUDElement(Window01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "ENG_RPM_Value"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), 0, 0}
		Window01.formats			= {"%1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= "ENG_RPM_Label"
		Window01.controllers		= {{"vstol_eng_rpm"}}
AddHUDElement(Window01)

-- Engine TEMP
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "ENG_TEMP_Label"
		Window01.material			= stroke_font
		Window01.init_pos			= {-55.0 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "J"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"hud_reject_2"}, {"vstol_threshold_0"}}
AddHUDElement(Window01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "ENG_TEMP_Value"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), 0, 0}
		Window01.formats			= {"%1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= "ENG_TEMP_Label"
		Window01.controllers		= {{"vstol_eng_jpt"}}
AddHUDElement(Window01)

-- POWER SCALE
local	Window01						= CreateElement "ceStringSLine"
		Window01.name					= "PWR_SCALE_Label"
		Window01.material				= stroke_font
		Window01.init_pos				= {-57.0 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window01.formats				= {"%s"}
		Window01.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment				= "CenterCenter"
		Window01.parent_element			= HUD_center.name
		Window01.controllers			= {{"hud_reject_1"}, {"vstol_pwr_margin_type"}}
AddHUDElement(Window01)

local	pwr_margin_scale				= CreateElement "ceSimpleLineObject"
		pwr_margin_scale.name			= "pwr_margin_scale"
		pwr_margin_scale.material		= hud_line_indicators
		pwr_margin_scale.width			= 1.0
		pwr_margin_scale.init_pos		= {0, 0, 0}
		pwr_margin_scale.parent_element	= "PWR_SCALE_Label"
		pwr_margin_scale.controllers	= {{"vstol_pwr_margin_scale", 12.5 * GetScale() * MilToDI(HUD_SCALE)}}
AddHUDElement(pwr_margin_scale)

local	Window01						= CreateElement "ceStringSLine"
		Window01.name					= "VSTOL_WATER_FLOW"
		Window01.material				= stroke_font
		Window01.init_pos				= {15.0 * MilToDI(HUD_SCALE), -7.0 * MilToDI(HUD_SCALE), 0}
		Window01.value					= "W"
		Window01.stringdefs				= stringdefs[STROKE_FNT_DFLT_100]
		Window01.alignment				= "CenterCenter"
		Window01.parent_element			= "PWR_SCALE_Label"
		Window01.controllers			= {{"vstol_water_flow"}}
AddHUDElement(Window01)

-- ANALOG DATA LEFT
local	Symbol01					= CreateElement "ceSMultiLine"
		Symbol01.name				= "AOA_analog_scale"
		Symbol01.material			= stroke_material
		Symbol01.init_pos			= {-50.0 * MilToDI(HUD_SCALE), -96.0 * MilToDI(HUD_SCALE), 0}
		Symbol01.points_set			= {"HUD_stroke_symbols", "AOA_analog_scale"}
		Symbol01.parent_element		= ADC_HUD_center.name
		Symbol01.scale				= HUD_SCALE
AddHUDStrokeSymbol(Symbol01)

local	Symbol01					= CreateElement "ceSMultiLine"
		Symbol01.name				= "AOA_LEFT_Indicator"
		Symbol01.material			= stroke_material
		Symbol01.init_pos			= {-40.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Symbol01.points_set			= {"HUD_stroke_symbols", "LEFT_Indicator"}
		Symbol01.parent_element		= ADC_HUD_center.name
		Symbol01.scale				= HUD_SCALE
		Symbol01.controllers 		= {{"ac_aoa_ind", 0.125 * HUD_SCALE}}
AddHUDStrokeSymbol(Symbol01)

local	aoa_zero_line					= CreateElement "ceSimpleLineObject"
		aoa_zero_line.name				= "aoa_zero_line"
		aoa_zero_line.material			= hud_line_indicators
		aoa_zero_line.width				= 1.0
		aoa_zero_line.init_pos			= {-47.5 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		aoa_zero_line.parent_element	= ADC_HUD_center.name
		aoa_zero_line.controllers		= {{"ac_aoa_zero_line", 0.125 * HUD_SCALE}}
AddHUDElement(aoa_zero_line)

-- DIGITAL DATA RIGHT
-- Vertical Velocity Data
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "VVI_FPM"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -95.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%1.f FPM"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= ADC_HUD_center.name
		Window02.controllers			= {{"hud_reject_1"}, {"ac_fpm"}}
AddHUDElement(Window02)

-- Time Data
local	TMR_HUD_center					= CreateElement "ceSimple"
		TMR_HUD_center.name				= "TMR_HUD_center"
		TMR_HUD_center.init_pos			= {0, -143.0 * MilToDI(HUD_SCALE), 0}
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
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), -143.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%02d.%02d.%02d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"timer_cst_data"}, {"timer_cst_value"}}
AddHUDElement(Window02)

-- NOZZLE Position
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "NOZZLE_POS_Label"
		Window02.material			= stroke_font
		Window02.init_pos			= {52.5 * MilToDI(HUD_SCALE), -156.0 * MilToDI(HUD_SCALE), 0}
		Window02.value				= "N"
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= HUD_center.name
		Window02.controllers		= {{"hud_reject_2"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "NOZZLE_POS_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {-5.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.formats			= {"%1.f"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= "NOZZLE_POS_Label"
		Window02.controllers		= {{"vstol_nzl_pos"}}
AddHUDElement(Window02)

-- FLAPS Position
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "FLAPS_POS_Label"
		Window02.material			= stroke_font
		Window02.init_pos			= {52.5 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window02.value				= "F"
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= HUD_center.name
		Window02.controllers		= {{"hud_reject_2"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "FLAPS_POS_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {-5.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.formats			= {"%1.f"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "RightCenter"
		Window02.parent_element		= "FLAPS_POS_Label"
		Window02.controllers		= {{"vstol_flp_pos"}}
AddHUDElement(Window02)

-- NWS Mode
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "NSW_Mode_Indicator"
		Window02.material			= stroke_font
		Window02.init_pos			= {22.5 * MilToDI(HUD_SCALE), -182.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%s"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= HUD_center.name
		Window02.controllers		= {{"vstol_nws_mode"}}
AddHUDElement(Window02)

-- ANALOG DATA RIGHT
local	Symbol02					= CreateElement "ceSMultiLine"
		Symbol02.name				= "VSI_Analog_Scale"
		Symbol02.material			= stroke_material
		Symbol02.init_pos			= {50.0 * MilToDI(HUD_SCALE), -105.0 * MilToDI(HUD_SCALE), 0}
		Symbol02.points_set			= {"HUD_stroke_symbols", "VSI_Analog_Scale"}
		Symbol02.parent_element		= HUD_center.name
		Symbol02.scale				= HUD_SCALE
AddHUDStrokeSymbol(Symbol02)

local	Symbol02					= CreateElement "ceSMultiLine"
		Symbol02.name				= "VIS_RIGHT_Indicator"
		Symbol02.material			= stroke_material
		Symbol02.init_pos			= {43.0 * MilToDI(HUD_SCALE), -95.0 * MilToDI(HUD_SCALE), 0}
		Symbol02.points_set			= {"HUD_stroke_symbols", "RIGHT_Indicator"}
		Symbol02.parent_element		= ADC_HUD_center.name
		Symbol02.scale				= HUD_SCALE
		Symbol02.controllers 		= {{"ac_fpm_ind", 0.19 * HUD_SCALE}}
AddHUDStrokeSymbol(Symbol02)

local	fpm_zero_line					= CreateElement "ceSimpleLineObject"
		fpm_zero_line.name				= "fpm_zero_line"
		fpm_zero_line.material			= hud_line_indicators
		fpm_zero_line.width				= 1.0
		fpm_zero_line.init_pos			= {50.0 * MilToDI(HUD_SCALE), -95.0 * MilToDI(HUD_SCALE), 0}
		fpm_zero_line.parent_element	= ADC_HUD_center.name
		fpm_zero_line.controllers		= {{"ac_fpm_zero_line", 0.19 * HUD_SCALE}}
AddHUDElement(fpm_zero_line)

-- ANALOG DATA Center
local	Symbol03					= CreateElement "ceSMultiLine"
		Symbol03.name				= "Depressed_Attitude_Indicator"
		Symbol03.material			= stroke_material
		Symbol03.init_pos			= {0.0, 0.0, 0}
		Symbol03.points_set			= {"HUD_stroke_symbols", "witch_hat"}
		Symbol03.parent_element		= HUD_center.name
		Symbol03.scale				= HUD_SCALE
		Symbol03.controllers		= {{"hud_depress", 8.0 * HUD_SCALE}}
AddHUDStrokeSymbol(Symbol03)

local	Symbol03					= CreateElement "ceSMultiLine"
		Symbol03.name				= "Pitch_Cue"
		Symbol03.material			= stroke_material
		Symbol03.init_pos			= {0.0, 0.0, 0}
		Symbol03.points_set			= {"HUD_stroke_symbols", "pitch_cue"}
		Symbol03.parent_element		= HUD_center.name
		Symbol03.scale				= HUD_SCALE
		Symbol03.controllers		= {{"ac_roll"}, {"vstol_pitch_cue", HUD_SCALE}}
AddHUDStrokeSymbol(Symbol03)

local	Symbol03					= CreateElement "ceSMultiLine"
		Symbol03.name				= "LG_Symbol"
		Symbol03.material			= stroke_material
		Symbol03.init_pos			= {0.0, -182.0 * MilToDI(HUD_SCALE), 0}
		Symbol03.points_set			= {"HUD_stroke_symbols", "main_gear_ind"}
		Symbol03.parent_element		= HUD_center.name
		Symbol03.scale				= HUD_SCALE
AddHUDStrokeSymbol(Symbol03)

local	Symbol03					= CreateElement "ceSMultiLine"
		Symbol03.name				= "NG_Symbol"
		Symbol03.material			= stroke_material
		Symbol03.init_pos			= {0.0, -182.0 * MilToDI(HUD_SCALE), 0}
		Symbol03.points_set			= {"HUD_stroke_symbols", "nose_gear_ind"}
		Symbol03.parent_element		= HUD_center.name
		Symbol03.scale				= HUD_SCALE
AddHUDStrokeSymbol(Symbol03)

local	hud_vstol_sideslip					= CreateElement "ceSMultiLine"
		hud_vstol_sideslip.name				= "Slideslip_Indicatoir"
		hud_vstol_sideslip.material			= stroke_material
		hud_vstol_sideslip.init_pos			= {0.0, -182.0 * MilToDI(HUD_SCALE), 0}
		hud_vstol_sideslip.points_set		= {"HUD_stroke_symbols", "slideslip_ind"}
		hud_vstol_sideslip.parent_element	= HUD_center.name
		hud_vstol_sideslip.scale			= HUD_SCALE
		hud_vstol_sideslip.controllers		= {{"vstol_ac_sideslip", 0.031 * HUD_SCALE}}
AddHUDStrokeSymbol(hud_vstol_sideslip)

local	hud_NW_ctr_Ind					= CreateElement "ceStringSLine"
		hud_NW_ctr_Ind.name				= "NWS_Center_indicator"
		hud_NW_ctr_Ind.material			= stroke_font
		hud_NW_ctr_Ind.init_pos			= {0.0, 0.0, 0.0}
		hud_NW_ctr_Ind.value			= "C"
		hud_NW_ctr_Ind.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		hud_NW_ctr_Ind.alignment		= "CenterCenter"
		hud_NW_ctr_Ind.parent_element	= hud_vstol_sideslip.name
		hud_NW_ctr_Ind.controllers		= {{"vstol_nw_centered"}}
AddHUDElement(hud_NW_ctr_Ind)
