--------------------------------------------------
-- TPOD Page: VCR Display Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

dofile(mpcd_path.."TPOD/TPOD_VIDEO_DSPLY.lua")
dofile(mpcd_path.."TPOD/TPOD_COMMON_DATA.lua")
dofile(mpcd_path.."TPOD/TPOD_RETICLES.lua")
dofile(mpcd_path.."TPOD/TPOD_MINIHUD.lua")

--------------------------------------------------
-- PAGE MENU
--------------------------------------------------
-- LEFT
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB01"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_01_pos
		TPOD_PBTN.value			= "V\nC\nR"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB02"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_02_pos
		TPOD_PBTN.value			= "D\nA\nT\nA"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB05"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_05_pos
		TPOD_PBTN.value			= "U\nN\nT\nD"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

-- TOP
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB06"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_06_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_lsr_status"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB07"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_07_pos
		TPOD_PBTN.value			= "NGC"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB08"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_08_pos
		TPOD_PBTN.value			= "FIRE"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}, {"tpod_lsr_armed"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB09"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_09_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_lsr_mode"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB10"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_10_pos
		TPOD_PBTN.value			= "REJ"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

-- RIGHT
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB11"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_11_pos
		TPOD_PBTN.value			= "M\n\T\nR\nY"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB12"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_12_pos
		TPOD_PBTN.value			= "C\n\A\nL"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB14"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_14_pos
		TPOD_PBTN.value			= "G\nR\nA\nY"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB15"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_15_pos
		TPOD_PBTN.value			= "R\nE\nC"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

-- BOTTOM
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB16"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_16_pos
		TPOD_PBTN.value			= "FF"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB17"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_17_pos
		TPOD_PBTN.value			= "PLAY"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB18"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_18_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB19"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_19_pos
		TPOD_PBTN.value			= "STOP"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB20"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_20_pos
		TPOD_PBTN.value			= "REW"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

-- SELECTION BOXES
-- LEFT
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB01_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_01_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB02_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_02_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB05_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_05_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_UNTRD"}}
AddMPCDStrokeSymbol(Selection_Box)

-- TOP
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB07_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_07_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_dsply_reject"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB08_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_08_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_lsr_ranging"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB10_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_10_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_lsr_firing"}}
AddMPCDStrokeSymbol(Selection_Box)

-- RIGHT
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB11_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_11_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_mt_vd"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB14_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_14_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_GRAY"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB15_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_15_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_REC"}}
AddMPCDStrokeSymbol(Selection_Box)

-- BOTTOM
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB16_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_16_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_FF"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB17_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_17_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_PLAY"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB20_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_20_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"TPOD_VCR_REW"}}
AddMPCDStrokeSymbol(Selection_Box)
