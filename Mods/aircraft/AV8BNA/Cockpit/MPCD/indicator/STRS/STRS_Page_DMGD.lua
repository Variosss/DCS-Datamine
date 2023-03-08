--------------------------------------------------
-- STRS - No SMS Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

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

--------------------------------------------------
-- MENU
--------------------------------------------------
local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB11"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_11_pos
		STRS_PBTN.value			= "S\nI\nT\nE"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
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
		STRS_PBTN.name			= "STRS_PB18"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_18_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(STRS_PBTN)

-- Selection Boxes
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "SITE_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_11_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_SITE_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)
