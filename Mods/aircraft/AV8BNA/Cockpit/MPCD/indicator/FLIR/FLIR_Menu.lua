--------------------------------------------------
-- FLIR Main Menu
--------------------------------------------------

-- GLOBAL MENU
local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB11"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_11_pos
		FLIR_PBTN.value			= "R\nE\nJ"
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB13"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_13_pos
		FLIR_PBTN.value			= "F\nL\nR\nM"
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB15"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_15_pos
		FLIR_PBTN.value			= "E\nW"
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB18"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_18_pos
		FLIR_PBTN.formats		= {"%s"}
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
		FLIR_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB19"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_19_pos
		FLIR_PBTN.formats		= {"LIM/%d"}
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
		FLIR_PBTN.controllers	= {{"flir_tgt_limiter"}}
Add_MPCD_Element(FLIR_PBTN)

-- COMMON MENU
local	FLIR_PBTN					= CreateElement "ceStringSLine"
		FLIR_PBTN.name				= "FLIR_PB03"
		FLIR_PBTN.material			= stroke_font
		FLIR_PBTN.init_pos			= mpcd_btn_03_pos
		FLIR_PBTN.formats			= {"%s"}
		FLIR_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment			= "CenterCenter"
		FLIR_PBTN.controllers 		= {{"FLIR_PB03_Mode"}}
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN					= CreateElement "ceStringSLine"
		FLIR_PBTN.name				= "FLIR_PB14"
		FLIR_PBTN.material			= stroke_font
		FLIR_PBTN.init_pos			= mpcd_btn_14_pos
		FLIR_PBTN.value				= "G\nR\nA\nY"
		FLIR_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment			= "CenterCenter"
		FLIR_PBTN.controllers 		= {{"flir_grayscale"}}
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN					= CreateElement "ceStringSLine"
		FLIR_PBTN.name				= "FLIR_PB16"
		FLIR_PBTN.material			= stroke_font
		FLIR_PBTN.init_pos			= mpcd_btn_16_pos
		FLIR_PBTN.value				= "NITE"
		FLIR_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment			= "CenterCenter"
		FLIR_PBTN.controllers 		= {{"flir_menu_common"}}
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN					= CreateElement "ceStringSLine"
		FLIR_PBTN.name				= "FLIR_PB17"
		FLIR_PBTN.material			= stroke_font
		FLIR_PBTN.init_pos			= mpcd_btn_17_pos
		FLIR_PBTN.value				= "UPDT"
		FLIR_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment			= "CenterCenter"
		FLIR_PBTN.controllers 		= {{"flir_menu_common"}}
Add_MPCD_Element(FLIR_PBTN)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB20"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_20_pos
		FLIR_PBTN.value			= "BLK"
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
		FLIR_PBTN.controllers 	= {{"flir_menu_common"}}
Add_MPCD_Element(FLIR_PBTN)

-- Symbols & Icons
local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_Down_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_04_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_common"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_Up_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_05_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_common"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "top_left_arrows"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {PosX(-0.95),  PosY(0.45), 0}
		FLIR_TEXT.formats			= {"%s"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_menu_options_1"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_LVL_Down_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_01_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_manual"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_LVL_Up_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_02_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_manual"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "top_left_arrows"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {PosX(-0.95),  PosY(-0.45), 0}
		FLIR_TEXT.formats			= {"%s"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_menu_options_2"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_TEMP_LVL_Down_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {PosX(-0.80), PosY(-0.60), 0}
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_flrm"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_TEMP_LVL_Up_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {PosX(-0.80), PosY(-0.30), 0}
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_flrm"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "FLIR_TEMP_LVL"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {PosX(-0.80),  PosY(-0.45), 0}
		FLIR_TEXT.formats			= {"%s"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_temp_sense"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_TGT_SZ_Down_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {PosX(-0.80), PosY(0.30), 0}
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_flrm"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "FLIR_TGT_SZ_Up_Arrow"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {PosX(-0.80), PosY(0.60), 0}
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_flrm"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "FLIR_TGT_Size"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {PosX(-0.80),  PosY(0.45), 0}
		FLIR_TEXT.formats			= {"%s"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_tgt_size"}}
Add_MPCD_Element(FLIR_TEXT)


-- SELECTION BOXES
local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "PB03_Boxed"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_03_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_manual"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "PB11_Boxed"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_11_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_reject"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "PB13_Boxed"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_13_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_flrm"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "PB13_Boxed"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_14_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers 	= {{"flir_menu_greyscale"}}
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "PB20_Boxed"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= mpcd_btn_20_pos
		FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers		= {{"flir_bh_polarity"}}
AddMPCDStrokeSymbol(FLIR_Symbol)
