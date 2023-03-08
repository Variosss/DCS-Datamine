--------------------------------------------------
-- STRS Main Menu (all modes)
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
		STRS_Symbol.name			= "TRNG_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_16_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_trng_btn"}, {"STRS_TRNG_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "TONE_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_20_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_TONE_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)
