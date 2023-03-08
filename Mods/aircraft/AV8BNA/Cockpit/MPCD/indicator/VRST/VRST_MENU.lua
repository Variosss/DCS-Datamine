dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
-- ***********************
--   V/STOL REST Display
--   MAINN MENU
-- ***********************

-- COMMON MENU
local	mpcd_mm_btn_06				= CreateElement "ceStringSLine"
		mpcd_mm_btn_06.name			= "mpcd_mm_btn_06"
		mpcd_mm_btn_06.material		= stroke_font
		mpcd_mm_btn_06.init_pos		= mpcd_btn_06_pos
		mpcd_mm_btn_06.alignment	= "CenterCenter"
		mpcd_mm_btn_06.value		= "VL"
		mpcd_mm_btn_06.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_06)

local	mpcd_mm_btn_07				= CreateElement "ceStringSLine"
		mpcd_mm_btn_07.name			= "mpcd_mm_btn_07"
		mpcd_mm_btn_07.material		= stroke_font
		mpcd_mm_btn_07.init_pos		= mpcd_btn_07_pos
		mpcd_mm_btn_07.alignment	= "CenterCenter"
		mpcd_mm_btn_07.value		= "VTO"
		mpcd_mm_btn_07.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_07)

local	mpcd_mm_btn_08				= CreateElement "ceStringSLine"
		mpcd_mm_btn_08.name			= "mpcd_mm_btn_08"
		mpcd_mm_btn_08.material		= stroke_font
		mpcd_mm_btn_08.init_pos		= mpcd_btn_08_pos
		mpcd_mm_btn_08.alignment	= "CenterCenter"
		mpcd_mm_btn_08.value		= "STO"
		mpcd_mm_btn_08.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_08)

local	mpcd_mm_btn_11				= CreateElement "ceStringSLine"
		mpcd_mm_btn_11.name			= "mpcd_mm_btn_11"
		mpcd_mm_btn_11.material		= stroke_font
		mpcd_mm_btn_11.init_pos		= mpcd_btn_11_pos
		mpcd_mm_btn_11.alignment	= "CenterCenter"
		mpcd_mm_btn_11.value		= "C\nR\nU\nS"
		mpcd_mm_btn_11.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_11)
        
local	mpcd_mm_btn_12				= CreateElement "ceSMultiLine"
		mpcd_mm_btn_12.name			= "mpcd_mm_btn_12"
		mpcd_mm_btn_12.material		= stroke_material
		mpcd_mm_btn_12.init_pos		= mpcd_btn_12_pos
		mpcd_mm_btn_12.points_set	= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		mpcd_mm_btn_12.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(mpcd_mm_btn_12)

local	mpcd_mm_btn_13				= CreateElement "ceSMultiLine"
		mpcd_mm_btn_13.name			= "mpcd_mm_btn_13"
		mpcd_mm_btn_13.material		= stroke_material
		mpcd_mm_btn_13.init_pos		= mpcd_btn_13_pos
		mpcd_mm_btn_13.points_set	= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		mpcd_mm_btn_13.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(mpcd_mm_btn_13)

local	nav_indx_number				= CreateElement "ceStringSLine"
		nav_indx_number.name		= "nav_indx_number"
		nav_indx_number.material	= stroke_font
		nav_indx_number.init_pos	= {PosX(0.95), PosY(0.165), 0}
		nav_indx_number.alignment	= "RightCenter"
		nav_indx_number.formats		= {"%s%d"}
		nav_indx_number.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		nav_indx_number.controllers	= {{"nav_index_number"}}
Add_MPCD_Element(nav_indx_number)

local	mpcd_mm_btn_14				= CreateElement "ceStringSLine"
		mpcd_mm_btn_14.name			= "mpcd_mm_btn_14"
		mpcd_mm_btn_14.material		= stroke_font
		mpcd_mm_btn_14.init_pos		= mpcd_btn_14_pos
		mpcd_mm_btn_14.alignment	= "CenterCenter"
		mpcd_mm_btn_14.value		= "B\nN\nG\nO"
		mpcd_mm_btn_14.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_14)

local	mpcd_mm_btn_18				= CreateElement "ceStringSLine"
		mpcd_mm_btn_18.name			= "mpcd_mm_btn_18"
		mpcd_mm_btn_18.material		= stroke_font
		mpcd_mm_btn_18.init_pos		= mpcd_btn_18_pos
		mpcd_mm_btn_18.alignment	= "CenterCenter"
		mpcd_mm_btn_18.formats		= {"%s"}
		mpcd_mm_btn_18.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_18.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(mpcd_mm_btn_18)

