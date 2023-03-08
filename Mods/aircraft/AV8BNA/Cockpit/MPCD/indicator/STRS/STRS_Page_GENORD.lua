--------------------------------------------------
-- STRS Main Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Common Elements
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(mpcd_path.."STRS_WPN_LST.lua")	-- Weapons Selection
dofile(mpcd_path.."STRS_WPN_SYMB.lua")	-- Weapons Symbology
dofile(mpcd_path.."STRS_MAIN_MENU.lua")	-- STRS Main Menu
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
		STRS_PBTN.name			= "STRS_PB05"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_05_pos
		STRS_PBTN.value			= "L\nO\nP"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_lop_btn"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB12"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_12_pos
		STRS_PBTN.value			= "L\nO\nF\nT"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_loft_btn"}}
Add_MPCD_Element(STRS_PBTN)

--

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "LOP_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_05_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_LOP_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "LOFTS_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_12_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_LOFT_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)
