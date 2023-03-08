--------------------------------------------------
-- TPOD Page: Primary Display Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

dofile(mpcd_path.."TPOD/TPOD_VIDEO_DSPLY.lua")
dofile(mpcd_path.."TPOD/TPOD_COMMON_DATA.lua")
dofile(mpcd_path.."TPOD/TPOD_STBY_Page.lua")
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
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_fov_mode"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB02"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_02_pos
		TPOD_PBTN.value			= "D\nA\nT\nA"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_Symbol				= CreateElement "ceSMultiLine"
		TPOD_Symbol.name		= "TPOD_ZM_Down_Arrow"
		TPOD_Symbol.material	= stroke_material
		TPOD_Symbol.init_pos	= mpcd_btn_03_pos
		TPOD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		TPOD_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "TPOD_Zoom"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(-0.95), PosY(0.15), 0}
		TPOD_TEXT.value			= "Z\nM"
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "TPOD_Zoom_Value"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(-0.80), PosY(0.15), 0}
		TPOD_TEXT.formats		= {"%1.1fX"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"tpod_video_zoom"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_Symbol				= CreateElement "ceSMultiLine"
		TPOD_Symbol.name		= "TPOD_ZM_Up_Arrow"
		TPOD_Symbol.material	= stroke_material
		TPOD_Symbol.init_pos	= mpcd_btn_04_pos
		TPOD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		TPOD_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB05"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_05_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_tv_output_mode"}}
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
		TPOD_PBTN.value			= "LTIP"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}, {"tpod_lsr_armed"}, {"tpod_lsr_rng_enabled"}}
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
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_swfv_mode"}}
Add_MPCD_Element(TPOD_PBTN)

-- RIGHT
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB11"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_11_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_flir_polarity"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_Symbol				= CreateElement "ceSMultiLine"
		TPOD_Symbol.name		= "TPOD_FG_Up_Arrow"
		TPOD_Symbol.material	= stroke_material
		TPOD_Symbol.init_pos	= mpcd_btn_12_pos
		TPOD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		TPOD_Symbol.scale		= MPCD_STRK_SCALE
		TPOD_Symbol.controllers	= {{"tpod_flir_mode"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "TPOD_FLIR_Gain"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(0.95), PosY(0.15), 0}
		TPOD_TEXT.value			= "G\nN"
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"tpod_flir_mode"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "TPOD_FLIR_Gain_Value"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(-0.10), 0.0, 0}
		TPOD_TEXT.parent_element	= "TPOD_FLIR_Gain"
		TPOD_TEXT.formats			= {"%d"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_flir_gain"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_Symbol				= CreateElement "ceSMultiLine"
		TPOD_Symbol.name		= "TPOD_FG_Down_Arrow"
		TPOD_Symbol.material	= stroke_material
		TPOD_Symbol.init_pos	= mpcd_btn_13_pos
		TPOD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		TPOD_Symbol.scale		= MPCD_STRK_SCALE
		TPOD_Symbol.controllers	= {{"tpod_flir_mode"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB14"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_14_pos
		TPOD_PBTN.value			= "M\nT\nC"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_AG_Mode"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB15"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_15_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"tpod_operational_mode"}}
Add_MPCD_Element(TPOD_PBTN)

-- BOTTOM
local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB16"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_16_pos
		TPOD_PBTN.value			= "SLAVE"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB17"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_17_pos
		TPOD_PBTN.value			= "PIP"
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}}
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
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}, {"tpod_trk_inr"}}
Add_MPCD_Element(TPOD_PBTN)

local	TPOD_PBTN				= CreateElement "ceStringSLine"
		TPOD_PBTN.name			= "TPOD_PB20"
		TPOD_PBTN.material		= stroke_font
		TPOD_PBTN.init_pos		= mpcd_btn_20_pos
		TPOD_PBTN.formats		= {"%s"}
		TPOD_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_PBTN.alignment		= "CenterCenter"
		TPOD_PBTN.controllers	= {{"TPOD_is_Operational"}, {"tpod_trk_ar_pt"}}
Add_MPCD_Element(TPOD_PBTN)

-- SELECTION BOXES
-- LEFT
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB01_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_01_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_fov_nm"}}
AddMPCDStrokeSymbol(Selection_Box)

-- TOP
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB07_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_07_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_lsr_ranging"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB08_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_08_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_lsr_firing"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB10_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_10_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_fov_sw"}}
AddMPCDStrokeSymbol(Selection_Box)

-- RIGHT
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB14_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_14_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_MTC"}}
AddMPCDStrokeSymbol(Selection_Box)

-- BOTTOM
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB16_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_16_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_sensor_slaved"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB17_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_17_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_PIP"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB19_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_19_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_trk_sensor"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB20_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_20_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"TPOD_is_Operational"}, {"tpod_trk_eo"}}
AddMPCDStrokeSymbol(Selection_Box)
