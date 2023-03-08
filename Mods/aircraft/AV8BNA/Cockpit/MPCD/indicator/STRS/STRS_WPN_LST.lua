--------------------------------------------------
-- STRS Weapons List (all modes)
--------------------------------------------------
local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB06"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_06_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_wpn_1a"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB07"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_07_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_wpn_1b"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB08"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_08_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_wpn_2a"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB09"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_09_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_wpn_2b"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB10"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_10_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_wpn_gun"}}
Add_MPCD_Element(STRS_PBTN)

-- Selection Boxes
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "PB06_Boxed"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_06_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_wpn_1a_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "PB07_Boxed"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_07_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_wpn_1b_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "PB08_Boxed"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_08_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_wpn_2a_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "PB09_Boxed"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_09_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_wpn_2b_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "PB10_Boxed"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_10_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_gun_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)