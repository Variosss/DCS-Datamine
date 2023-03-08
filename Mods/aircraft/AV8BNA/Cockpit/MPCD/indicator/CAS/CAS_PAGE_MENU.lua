--------------------------------------------------
-- CAS Page Menu
--------------------------------------------------

-- LEFT
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB01"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_01_pos
		CAS_PBTN.value			= "D\nO\nW\nN"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
		CAS_PBTN.controllers	= {{"CAS_BRIEF_Field_Option"}}
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB02"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_02_pos
		CAS_PBTN.value			= "U\nP"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
		CAS_PBTN.controllers	= {{"CAS_BRIEF_Field_Option"}}
Add_MPCD_Element(CAS_PBTN)

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

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB05"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_05_pos
		CAS_PBTN.value			= "N\nE\nT\nS"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

-- TOP
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB06"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_06_pos
		CAS_PBTN.value			= "SAVE"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB07"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_07_pos
		CAS_PBTN.value			= "ARON"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB08"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_08_pos
		CAS_PBTN.value			= "PCLR"
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

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB10"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_10_pos
		CAS_PBTN.value			= "FTEXT"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

-- RIGHT
local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB12"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_12_pos
		CAS_PBTN.value			= "D\nS\nR"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB13"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_13_pos
		CAS_PBTN.value			= "S\nE\nN\nD"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(CAS_PBTN)

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB14"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_14_pos
		CAS_PBTN.value			= "D\nP\nI\nP"
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

local	CAS_PBTN				= CreateElement "ceStringSLine"
		CAS_PBTN.name			= "CAS_PB20"
		CAS_PBTN.material		= stroke_font
		CAS_PBTN.init_pos		= mpcd_btn_20_pos
		CAS_PBTN.value			= "USE"
		CAS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		CAS_PBTN.alignment		= "CenterCenter"
		CAS_PBTN.controllers	= {{"CAS_BRIEF_Record_Loaded"}}
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
		Selection_Box.init_pos		= mpcd_btn_20_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"CAS_BRIEF_Record_Selected"}}
AddMPCDStrokeSymbol(Selection_Box)
