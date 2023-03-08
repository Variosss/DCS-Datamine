--------------------------------------------------
-- STRS IR Maverick Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Common Elements
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(mpcd_path.."STRS_WPN_LST.lua")
dofile(mpcd_path.."STRS_WPN_SYMB.lua")	-- Weapons Symbology
dofile(mpcd_path.."STRS_WPN_PRG.lua")	-- STRS Main Menu

--------------------------------------------------
-- SYMBOLS & INDICATORS
--------------------------------------------------
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "aircraft_icon"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0, PosY(0.25), 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "stores_wingform"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(STRS_Symbol)

-- Weapons Status
local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "SMS_Status"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { PosX(-0.80),  PosY(0.80), 0}
		STRS_Label.value		= "WPN FAIL"
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_Label.alignment	= "LeftCenter"
		STRS_Label.controllers	= {{"strs_wpn_1a_fail"}}
Add_MPCD_Element(STRS_Label)

local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "gun_status"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { PosX(0.65),  PosY(0.80), 0}
		STRS_Label.value		= "NOT CLEAR"
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_Label.alignment	= "LeftCenter"
		STRS_Label.controllers	= {{"strs_wpn_gun_fail"}}
Add_MPCD_Element(STRS_Label)

local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "safe_arm_indicator"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { PosX(-0.80),  PosY(0.70), 0}
		STRS_Label.formats		= {"%s"}
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		STRS_Label.alignment	= "LeftCenter"
		STRS_Label.controllers	= {{"strs_master_arm"}}
Add_MPCD_Element(STRS_Label)

-- Page Messages

local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "Message_Line_1"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { 0.0,  PosY(-0.20), 0}
		STRS_Label.formats		= {"%s"}
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		STRS_Label.alignment	= "CenterCenter"
		STRS_Label.controllers	= {{"strs_message_line_1"}}
Add_MPCD_Element(STRS_Label)

local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "Message_Line_1"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { 0.0,  PosY(-0.28), 0}
		STRS_Label.formats		= {"%s"}
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		STRS_Label.alignment	= "CenterCenter"
		STRS_Label.controllers	= {{"strs_message_line_2"}}
Add_MPCD_Element(STRS_Label)

--------------------------------------------------
-- Page Menu
--------------------------------------------------
local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB02"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_02_pos
		STRS_PBTN.value			= "C\nO\nO\nL"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_cool_btn"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB04"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_04_pos
		STRS_PBTN.value			= "W\nR\nD"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB11"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_11_pos
		STRS_PBTN.value			= "S\nI\nT\nE"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB14"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_14_pos
		STRS_PBTN.value			= "S\nT\nE\nP"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_step_btn"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB15"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_15_pos
		STRS_PBTN.value			= "E\nW"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB16"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_16_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"STRS_PB16_Mode"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB17"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_17_pos
		STRS_PBTN.value			= "ABST"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB18"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_18_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB20"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_20_pos
		STRS_PBTN.value			= "TONE"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_READY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.08), 0}
		STRS_PBTN.parent_element	= "STRS_PB20"
		STRS_PBTN.formats			= {"%s"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_status"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_PRIORITY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.16), 0}
		STRS_PBTN.parent_element	= "STRS_PB20"
		STRS_PBTN.formats			= {"STA %d"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_station"}}
Add_MPCD_Element(STRS_PBTN)

-- Selection Boxes
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "COOL_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_02_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_COOL_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "SITE_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_11_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_SITE_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "ABST_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_17_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_ABST_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "TONE_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_20_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_TONE_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)
