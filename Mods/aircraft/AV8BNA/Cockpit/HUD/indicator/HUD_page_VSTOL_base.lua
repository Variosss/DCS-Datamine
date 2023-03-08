local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."HUD_definitions.lua")

-- HUD Center
HUD_center					= CreateElement "ceSimple"
HUD_center.name				= "HUD_center"
HUD_center.init_pos			= {0, 0, 0}
HUD_center.controllers		= {{"hud_waterline", HUD_Waterline}}
AddHUDElement(HUD_center)

-- INS Elements
INS_HUD_center					= CreateElement "ceSimple"
INS_HUD_center.name				= "INS_HUD_center"
INS_HUD_center.init_pos			= {0, 0, 0}
INS_HUD_center.parent_element	= HUD_center.name
INS_HUD_center.controllers		= {{"nav_dmg_lvl_3"}}
AddHUDElement(INS_HUD_center)

-- ADC Elements
ADC_HUD_center					= CreateElement "ceSimple"
ADC_HUD_center.name				= "ADC_HUD_center"
ADC_HUD_center.init_pos			= {0, 0, 0}
ADC_HUD_center.parent_element	= HUD_center.name
ADC_HUD_center.controllers		= {{"adc_dmg_lvl_0"}}
AddHUDElement(ADC_HUD_center)

-- Global Elements
if not hud_repeater then dofile(hud_path.."/Global/HUD_NAVFLIR.lua") end
dofile(hud_path.."/Global/HUD_Heading_Tape.lua")
dofile(hud_path.."/Global/HUD_Pitch_Ladder.lua")
dofile(hud_path.."/Global/HUD_ADC_Data.lua")

-- Data Windows LEFT
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "MSG_Warning"
		Window01.material			= stroke_font
		Window01.init_pos			= {-90.0 * MilToDI(HUD_SCALE), -117.0 * MilToDI(HUD_SCALE), 0}
		Window01.parent_element		= HUD_center.name
		Window01.value				= "MSG"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "LeftCenter"
		Window01.controllers		= {{"MSG_Warning"}}
AddHUDElement(Window01)

local	Symbol01					= CreateElement "ceSMultiLine"
		Symbol01.name				= "AOA_Alpha"
		Symbol01.material			= stroke_material
		Symbol01.init_pos			= {-90.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Symbol01.points_set			= {"HUD_stroke_symbols", "alpha"}
		Symbol01.parent_element		= ADC_HUD_center.name
		Symbol01.scale				= HUD_SCALE
		Symbol01.controllers		= {{"hud_reject_1"}}
AddHUDStrokeSymbol(Symbol01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "AOA_Value"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), 0, 0}
		Window01.formats			= {"%1.1f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= "AOA_Alpha"
		Window01.controllers		= {{"ac_aoa"}}
AddHUDElement(Window01)

-- DIGITAL DATA RIGHT
local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "Aux_Heading_Mode"
		Window02.material			= stroke_font
		Window02.init_pos			= {60.0 * MilToDI(HUD_SCALE), -221.0 * MilToDI(HUD_SCALE), 0}
		Window02.value				= "T"
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= HUD_center.name
		Window02.controllers		= {{"hdg_dmg_lvl_0"}, {"ac_hdg_mode"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "AC_Timer_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), -221.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%03d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= HUD_center.name
		Window02.controllers		= {{"hdg_dmg_lvl_0"}, {"ac_hdg_aux"}}
AddHUDElement(Window02)


