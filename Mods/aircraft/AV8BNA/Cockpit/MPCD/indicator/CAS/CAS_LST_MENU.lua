--------------------------------------------------
-- CAS Page: Briefing list display Menu
--------------------------------------------------

-- MAIN MENU
local	CAS_Symbol				= CreateElement "ceSMultiLine"
		CAS_Symbol.name			= "CAS_PB03"
		CAS_Symbol.material		= stroke_material
		CAS_Symbol.init_pos		= mpcd_btn_03_pos
		CAS_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		CAS_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(CAS_Symbol)

local	CAS_Symbol				= CreateElement "ceSMultiLine"
		CAS_Symbol.name			= "CAS_PB04"
		CAS_Symbol.material		= stroke_material
		CAS_Symbol.init_pos		= mpcd_btn_04_pos
		CAS_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		CAS_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(CAS_Symbol)

-- TOP
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB07"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_07_pos
		CAS_PBTN.value			= "ARON"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB09"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_09_pos
		CAS_PBTN.value			= "BMODE"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

-- RIGHT
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB13"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_13_pos
		CAS_PBTN.value			= "S\nE\nN\nD"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)


local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB15"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_15_pos
		CAS_PBTN.value			= "E\nW"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

-- BOTTOM
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB17"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_17_pos
		CAS_PBTN.value			= "CAS"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB18"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_18_pos
		CAS_PBTN.formats		= {"%s"}
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
		CAS_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB19"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_19_pos
		CAS_PBTN.value			= "RCALL"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

-- SELECTION BOXES
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB17_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_17_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB20_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_19_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)
