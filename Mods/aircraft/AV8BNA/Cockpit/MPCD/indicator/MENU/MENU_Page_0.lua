dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU LEFT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB01"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_01_pos
		BTN_Label.value				= "F\nL\nI\nR"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB02"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_02_pos
		BTN_Label.value				= "E\nH\nS\nD"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB03"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_03_pos
		BTN_Label.value				= "D\nM\nT"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB04"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_04_pos
		BTN_Label.value				= "S\nT\nR\nS"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB05"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_05_pos
		BTN_Label.value				= "H\nU\nD"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU TOP
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB06"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_06_pos
		BTN_Label.value				= "BIT"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB08"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_08_pos
		BTN_Label.value				= "VREST"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB11"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_11_pos
		BTN_Label.value				= "E\nN\nG"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB12"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_12_pos
		BTN_Label.value				= "C\nO\nN\nF"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB13"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_13_pos
		BTN_Label.value				= "T\nP\nO\nD"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"mm_tpod"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB14"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_14_pos
		BTN_Label.value				= "I\nF\nF"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

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
		BTN_Label.name				= "PB16"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_16_pos
		BTN_Label.value				= "CARD"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB17"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_17_pos
		BTN_Label.value				= "CAS"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.value				= "EMER"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB19"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_19_pos
		BTN_Label.value				= "SDAT"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "PB20"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_20_pos
		BTN_Label.value				= "COMM"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

