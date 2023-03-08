---------------
-- SDAT      --
-- Main Menu --
---------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/Classified_Page.lua")

-- MENU LEFT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB02"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_02_pos
		BTN_Label.value				= "G\nP\nS\nX"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB04"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_04_pos
		BTN_Label.value				= "O\nL\nX"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB05"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_05_pos
		BTN_Label.value				= "D\nT\nX"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU TOP
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB08"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_08_pos
		BTN_Label.value				= "TFER"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB10"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_10_pos
		BTN_Label.value				= "ERSE"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB15"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_15_pos
		BTN_Label.value				="E\nW"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine" 
		BTN_Label.name				= "PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)
