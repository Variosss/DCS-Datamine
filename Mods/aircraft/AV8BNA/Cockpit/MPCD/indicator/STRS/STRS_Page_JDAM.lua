--------------------------------------------------
-- STRS JDAM Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Common Elements
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(mpcd_path.."STRS_WPN_LST.lua")

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

