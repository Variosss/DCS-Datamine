-- ******************************************
--   Emergency Procedures Checklist Display
-- ******************************************
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MAIN MENU
local	mpcd_mm_btn_01				= CreateElement "ceStringSLine"
		mpcd_mm_btn_01.name			= "mpcd_mm_btn_01"
		mpcd_mm_btn_01.material		= stroke_font
		mpcd_mm_btn_01.init_pos		= mpcd_btn_01_pos
		mpcd_mm_btn_01.alignment	= "CenterCenter"
		mpcd_mm_btn_01.value		= "W\nA\nR\nN"
		mpcd_mm_btn_01.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_01)

local	mpcd_mm_btn_02				= CreateElement "ceStringSLine"
		mpcd_mm_btn_02.name			= "mpcd_mm_btn_02"
		mpcd_mm_btn_02.material		= stroke_font
		mpcd_mm_btn_02.init_pos		= mpcd_btn_02_pos
		mpcd_mm_btn_02.alignment	= "CenterCenter"
		mpcd_mm_btn_02.value		= "C\nA\nU\nT"
		mpcd_mm_btn_02.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_02)

local	mpcd_mm_btn_03				= CreateElement "ceStringSLine"
		mpcd_mm_btn_03.name			= "mpcd_mm_btn_03"
		mpcd_mm_btn_03.material		= stroke_font
		mpcd_mm_btn_03.init_pos		= mpcd_btn_03_pos
		mpcd_mm_btn_03.alignment	= "CenterCenter"
		mpcd_mm_btn_03.value		= "E\nL\nE\nC"
		mpcd_mm_btn_03.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_03)

local	mpcd_mm_btn_04				= CreateElement "ceStringSLine"
		mpcd_mm_btn_04.name			= "mpcd_mm_btn_04"
		mpcd_mm_btn_04.material		= stroke_font
		mpcd_mm_btn_04.init_pos		= mpcd_btn_04_pos
		mpcd_mm_btn_04.alignment	= "CenterCenter"
		mpcd_mm_btn_04.value		= "A\nS\nY\nM"
		mpcd_mm_btn_04.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_04)

local	mpcd_mm_btn_05				= CreateElement "ceStringSLine"
		mpcd_mm_btn_05.name			= "mpcd_mm_btn_05"
		mpcd_mm_btn_05.material		= stroke_font
		mpcd_mm_btn_05.init_pos		= mpcd_btn_05_pos
		mpcd_mm_btn_05.alignment	= "CenterCenter"
		mpcd_mm_btn_05.value		= "T\n/\nO"
		mpcd_mm_btn_05.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_05)

local	mpcd_mm_btn_06a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_06a.name		= "mpcd_mm_btn_06a"
		mpcd_mm_btn_06a.material	= stroke_font
		mpcd_mm_btn_06a.init_pos	= {PosX(-0.65),  PosY(0.92), 0}
		mpcd_mm_btn_06a.alignment	= "CenterCenter"
		mpcd_mm_btn_06a.value		= "GEAR"
		mpcd_mm_btn_06a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_06a)

local	mpcd_mm_btn_06b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_06b.name		= "mpcd_mm_btn_06b"
		mpcd_mm_btn_06b.material	= stroke_font
		mpcd_mm_btn_06b.init_pos	= {PosX(-0.65),  PosY(0.86), 0}
		mpcd_mm_btn_06b.alignment	= "CenterCenter"
		mpcd_mm_btn_06b.value		= "LAND"
		mpcd_mm_btn_06b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_06b)

local	mpcd_mm_btn_07a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_07a.name		= "mpcd_mm_btn_07a"
		mpcd_mm_btn_07a.material	= stroke_font
		mpcd_mm_btn_07a.init_pos	= {PosX(-0.33),  PosY(0.92), 0}
		mpcd_mm_btn_07a.alignment	= "CenterCenter"
		mpcd_mm_btn_07a.value		= "EJCT"
		mpcd_mm_btn_07a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_07a)

local	mpcd_mm_btn_07b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_07b.name		= "mpcd_mm_btn_07b"
		mpcd_mm_btn_07b.material	= stroke_font
		mpcd_mm_btn_07b.init_pos	= {PosX(-0.33),  PosY(0.86), 0}
		mpcd_mm_btn_07b.alignment	= "CenterCenter"
		mpcd_mm_btn_07b.value		= "DTCH"
		mpcd_mm_btn_07b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_07b)

local	mpcd_mm_btn_08				= CreateElement "ceStringSLine"
		mpcd_mm_btn_08.name			= "mpcd_mm_btn_08"
		mpcd_mm_btn_08.material		= stroke_font
		mpcd_mm_btn_08.init_pos		= mpcd_btn_08_pos
		mpcd_mm_btn_08.alignment	= "CenterCenter"
		mpcd_mm_btn_08.value		= "ENG"
		mpcd_mm_btn_08.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_08)

local	mpcd_mm_btn_09				= CreateElement "ceStringSLine"
		mpcd_mm_btn_09.name			= "mpcd_mm_btn_09"
		mpcd_mm_btn_09.material		= stroke_font
		mpcd_mm_btn_09.init_pos		= mpcd_btn_09_pos
		mpcd_mm_btn_09.alignment	= "CenterCenter"
		mpcd_mm_btn_09.value		= "FUEL"
		mpcd_mm_btn_09.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_09)

local	mpcd_mm_btn_10a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_10a.name		= "mpcd_mm_btn_10a"
		mpcd_mm_btn_10a.material	= stroke_font
		mpcd_mm_btn_10a.init_pos	= {PosX(0.65), PosY(0.92), 0}
		mpcd_mm_btn_10a.alignment	= "CenterCenter"
		mpcd_mm_btn_10a.value		= "FLT"
		mpcd_mm_btn_10a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_10a)

local	mpcd_mm_btn_10b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_10b.name		= "mpcd_mm_btn_10b"
		mpcd_mm_btn_10b.material	= stroke_font
		mpcd_mm_btn_10b.init_pos	= {PosX(0.65), PosY(0.86), 0}
		mpcd_mm_btn_10b.alignment	= "CenterCenter"
		mpcd_mm_btn_10b.value		= "CONT"
		mpcd_mm_btn_10b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_10b)

local	mpcd_mm_btn_11				= CreateElement "ceStringSLine"
		mpcd_mm_btn_11.name			= "mpcd_mm_btn_11"
		mpcd_mm_btn_11.material		= stroke_font
		mpcd_mm_btn_11.init_pos		= mpcd_btn_11_pos
		mpcd_mm_btn_11.alignment	= "CenterCenter"
		mpcd_mm_btn_11.value		= "B\nR\nK\nS"
		mpcd_mm_btn_11.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_11)

local	mpcd_mm_btn_12				= CreateElement "ceStringSLine"
		mpcd_mm_btn_12.name			= "mpcd_mm_btn_12"
		mpcd_mm_btn_12.material		= stroke_font
		mpcd_mm_btn_12.init_pos		= mpcd_btn_12_pos
		mpcd_mm_btn_12.alignment	= "CenterCenter"
		mpcd_mm_btn_12.value		= "F\nI\nR\nE"
		mpcd_mm_btn_12.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_12)

local	mpcd_mm_btn_13a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_13a.name		= "mpcd_mm_btn_13a"
		mpcd_mm_btn_13a.material	= stroke_font
		mpcd_mm_btn_13a.init_pos	= {PosX(0.90), 0.00, 0}
		mpcd_mm_btn_13a.alignment	= "CenterCenter"
		mpcd_mm_btn_13a.value		= "S\nM\nO\nK"
		mpcd_mm_btn_13a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_13a)

local	mpcd_mm_btn_13b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_13b.name		= "mpcd_mm_btn_13b"
		mpcd_mm_btn_13b.material	= stroke_font
		mpcd_mm_btn_13b.init_pos	= mpcd_btn_13_pos
		mpcd_mm_btn_13b.alignment	= "CenterCenter"
		mpcd_mm_btn_13b.value		= "F\nU\nM\nE"
		mpcd_mm_btn_13b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_13b)

local	mpcd_mm_btn_14				= CreateElement "ceStringSLine"
		mpcd_mm_btn_14.name			= "mpcd_mm_btn_14"
		mpcd_mm_btn_14.material		= stroke_font
		mpcd_mm_btn_14.init_pos		= mpcd_btn_14_pos
		mpcd_mm_btn_14.alignment	= "CenterCenter"
		mpcd_mm_btn_14.value		= "G\nU\nN"
		mpcd_mm_btn_14.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_14)

local	mpcd_mm_btn_15				= CreateElement "ceStringSLine"
		mpcd_mm_btn_15.name			= "mpcd_mm_btn_15"
		mpcd_mm_btn_15.material		= stroke_font
		mpcd_mm_btn_15.init_pos		= mpcd_btn_15_pos
		mpcd_mm_btn_15.alignment	= "CenterCenter"
		mpcd_mm_btn_15.value		= "J\nE\nT\nT"
		mpcd_mm_btn_15.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_15)

local	mpcd_mm_btn_16a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_16a.name		= "mpcd_mm_btn_16a"
		mpcd_mm_btn_16a.material	= stroke_font
		mpcd_mm_btn_16a.init_pos	= {PosX(0.65), PosY(-0.80), 0}
		mpcd_mm_btn_16a.alignment	= "CenterCenter"
		mpcd_mm_btn_16a.value		= "FLT"
		mpcd_mm_btn_16a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_16a)

local	mpcd_mm_btn_16b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_16b.name		= "mpcd_mm_btn_16b"
		mpcd_mm_btn_16b.material	= stroke_font
		mpcd_mm_btn_16b.init_pos	= {PosX(0.65), PosY(-0.86), 0}
		mpcd_mm_btn_16b.alignment	= "CenterCenter"
		mpcd_mm_btn_16b.value		= "CONT"
		mpcd_mm_btn_16b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_16b)

local	mpcd_mm_btn_16c				= CreateElement "ceStringSLine"
		mpcd_mm_btn_16c.name		= "mpcd_mm_btn_16c"
		mpcd_mm_btn_16c.material	= stroke_font
		mpcd_mm_btn_16c.init_pos	= mpcd_btn_16_pos
		mpcd_mm_btn_16c.alignment	= "CenterCenter"
		mpcd_mm_btn_16c.value		= "CNPY"
		mpcd_mm_btn_16c.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_16c)

local	mpcd_mm_btn_17a				= CreateElement "ceStringSLine"
		mpcd_mm_btn_17a.name		= "mpcd_mm_btn_17a"
		mpcd_mm_btn_17a.material	= stroke_font
		mpcd_mm_btn_17a.init_pos	= {PosX(0.33), PosY(-0.80), 0}
		mpcd_mm_btn_17a.alignment	= "CenterCenter"
		mpcd_mm_btn_17a.value		= "EMER"
		mpcd_mm_btn_17a.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_17a)

local	mpcd_mm_btn_17b				= CreateElement "ceStringSLine"
		mpcd_mm_btn_17b.name		= "mpcd_mm_btn_17b"
		mpcd_mm_btn_17b.material	= stroke_font
		mpcd_mm_btn_17b.init_pos	= {PosX(0.33), PosY(-0.86), 0}
		mpcd_mm_btn_17b.alignment	= "CenterCenter"
		mpcd_mm_btn_17b.value		= "DC"
		mpcd_mm_btn_17b.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_17b)

local	mpcd_mm_btn_17c				= CreateElement "ceStringSLine"
		mpcd_mm_btn_17c.name		= "mpcd_mm_btn_17c"
		mpcd_mm_btn_17c.material	= stroke_font
		mpcd_mm_btn_17c.init_pos	= mpcd_btn_17_pos
		mpcd_mm_btn_17c.alignment	= "CenterCenter"
		mpcd_mm_btn_17c.value		= "FAIL"
		mpcd_mm_btn_17c.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_17c)

local	mpcd_mm_btn_18				= CreateElement "ceStringSLine"
		mpcd_mm_btn_18.name			= "mpcd_mm_btn_18"
		mpcd_mm_btn_18.material		= stroke_font
		mpcd_mm_btn_18.init_pos		= mpcd_btn_18_pos
		mpcd_mm_btn_18.alignment	= "CenterCenter"
		mpcd_mm_btn_18.formats		= {"%s"}
		mpcd_mm_btn_18.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_18.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(mpcd_mm_btn_18)

local	mpcd_mm_btn_20				= CreateElement "ceStringSLine"
		mpcd_mm_btn_20.name			= "mpcd_mm_btn_20"
		mpcd_mm_btn_20.material		= stroke_font
		mpcd_mm_btn_20.init_pos		= mpcd_btn_20_pos
		mpcd_mm_btn_20.alignment	= "CenterCenter"
		mpcd_mm_btn_20.value		= "NEXT"
		mpcd_mm_btn_20.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_20.controllers	= {{"EPCD_DataFrame_Next"}}
Add_MPCD_Element(mpcd_mm_btn_20)


-- SELECTED OPTIONS
local	EPCD_OPT_01				= CreateElement "ceSMultiLine"
		EPCD_OPT_01.name		= "EPCD_OPT_01"
		EPCD_OPT_01.material	= stroke_material
		EPCD_OPT_01.init_pos	= mpcd_btn_01_pos
		EPCD_OPT_01.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_01.scale		= MPCD_STRK_SCALE
		EPCD_OPT_01.controllers	= {{"EPCD_Selected_Frame", 1}}
AddMPCDStrokeSymbol(EPCD_OPT_01)

local	EPCD_OPT_02				= CreateElement "ceSMultiLine"
		EPCD_OPT_02.name		= "EPCD_OPT_02"
		EPCD_OPT_02.material	= stroke_material
		EPCD_OPT_02.init_pos	= mpcd_btn_02_pos
		EPCD_OPT_02.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_02.scale		= MPCD_STRK_SCALE
		EPCD_OPT_02.controllers	= {{"EPCD_Selected_Frame", 2}}
AddMPCDStrokeSymbol(EPCD_OPT_02)

local	EPCD_OPT_03				= CreateElement "ceSMultiLine"
		EPCD_OPT_03.name		= "EPCD_OPT_03"
		EPCD_OPT_03.material	= stroke_material
		EPCD_OPT_03.init_pos	= mpcd_btn_03_pos
		EPCD_OPT_03.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_03.scale		= MPCD_STRK_SCALE
		EPCD_OPT_03.controllers	= {{"EPCD_Selected_Frame", 3}}
AddMPCDStrokeSymbol(EPCD_OPT_03)

local	EPCD_OPT_04				= CreateElement "ceSMultiLine"
		EPCD_OPT_04.name		= "EPCD_OPT_04"
		EPCD_OPT_04.material	= stroke_material
		EPCD_OPT_04.init_pos	= mpcd_btn_04_pos
		EPCD_OPT_04.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_04.scale		= MPCD_STRK_SCALE
		EPCD_OPT_04.controllers	= {{"EPCD_Selected_Frame", 4}}
AddMPCDStrokeSymbol(EPCD_OPT_04)

local	EPCD_OPT_05				= CreateElement "ceSMultiLine"
		EPCD_OPT_05.name		= "EPCD_OPT_05"
		EPCD_OPT_05.material	= stroke_material
		EPCD_OPT_05.init_pos	= mpcd_btn_05_pos
		EPCD_OPT_05.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_05.scale		= MPCD_STRK_SCALE
		EPCD_OPT_05.controllers	= {{"EPCD_Selected_Frame", 5}}
AddMPCDStrokeSymbol(EPCD_OPT_05)

local	EPCD_OPT_06				= CreateElement "ceSMultiLine"
		EPCD_OPT_06.name		= "EPCD_OPT_06"
		EPCD_OPT_06.material	= stroke_material
		EPCD_OPT_06.init_pos	= {PosX(-0.65), PosY( 0.89), 0}
		EPCD_OPT_06.points_set	= {"MPCD_stroke_symbols", "horz_box_large"}
		EPCD_OPT_06.scale		= MPCD_STRK_SCALE
		EPCD_OPT_06.controllers	= {{"EPCD_Selected_Frame", 6}}
AddMPCDStrokeSymbol(EPCD_OPT_06)

local	EPCD_OPT_07				= CreateElement "ceSMultiLine"
		EPCD_OPT_07.name		= "EPCD_OPT_07"
		EPCD_OPT_07.material	= stroke_material
		EPCD_OPT_07.init_pos	= {PosX(-0.33), PosY( 0.89), 0}
		EPCD_OPT_07.points_set	= {"MPCD_stroke_symbols", "horz_box_large"}
		EPCD_OPT_07.scale		= MPCD_STRK_SCALE
		EPCD_OPT_07.controllers	= {{"EPCD_Selected_Frame", 7}}
AddMPCDStrokeSymbol(EPCD_OPT_07)

local	EPCD_OPT_08				    = CreateElement "ceSMultiLine"
		EPCD_OPT_08.name			= "EPCD_OPT_08"
		EPCD_OPT_08.material		= stroke_material
		EPCD_OPT_08.init_pos		= mpcd_btn_08_pos
		EPCD_OPT_08.points_set	    = {"MPCD_stroke_symbols", "horz_box"}
		EPCD_OPT_08.scale			= MPCD_STRK_SCALE
		EPCD_OPT_08.controllers 	= {{"EPCD_Selected_Frame",8}}
AddMPCDStrokeSymbol(EPCD_OPT_08)

local	EPCD_OPT_09				    = CreateElement "ceSMultiLine"
		EPCD_OPT_09.name			= "EPCD_OPT_09"
		EPCD_OPT_09.material		= stroke_material
		EPCD_OPT_09.init_pos		= mpcd_btn_09_pos
		EPCD_OPT_09.points_set	    = {"MPCD_stroke_symbols", "horz_box"}
		EPCD_OPT_09.scale			= MPCD_STRK_SCALE
		EPCD_OPT_09.controllers 	= {{"EPCD_Selected_Frame",9}}
AddMPCDStrokeSymbol(EPCD_OPT_09)

local	EPCD_OPT_10				= CreateElement "ceSMultiLine"
		EPCD_OPT_10.name		= "EPCD_OPT_10"
		EPCD_OPT_10.material	= stroke_material
		EPCD_OPT_10.init_pos	= {PosX( 0.65), PosY( 0.89), 0}
		EPCD_OPT_10.points_set	= {"MPCD_stroke_symbols", "horz_box_large"}
		EPCD_OPT_10.scale		= MPCD_STRK_SCALE
		EPCD_OPT_10.controllers	= {{"EPCD_Selected_Frame", 10}}
AddMPCDStrokeSymbol(EPCD_OPT_10)

local	EPCD_OPT_11				= CreateElement "ceSMultiLine"
		EPCD_OPT_11.name		= "EPCD_OPT_11"
		EPCD_OPT_11.material	= stroke_material
		EPCD_OPT_11.init_pos	= mpcd_btn_11_pos
		EPCD_OPT_11.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_11.scale		= MPCD_STRK_SCALE
		EPCD_OPT_11.controllers	= {{"EPCD_Selected_Frame", 11}}
AddMPCDStrokeSymbol(EPCD_OPT_11)

local	EPCD_OPT_12				= CreateElement "ceSMultiLine"
		EPCD_OPT_12.name		= "EPCD_OPT_12"
		EPCD_OPT_12.material	= stroke_material
		EPCD_OPT_12.init_pos	= mpcd_btn_12_pos
		EPCD_OPT_12.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_12.scale		= MPCD_STRK_SCALE
		EPCD_OPT_12.controllers	= {{"EPCD_Selected_Frame", 12}}
AddMPCDStrokeSymbol(EPCD_OPT_12)

local	EPCD_OPT_13				= CreateElement "ceSMultiLine"
		EPCD_OPT_13.name		= "EPCD_OPT_13"
		EPCD_OPT_13.material	= stroke_material
		EPCD_OPT_13.init_pos	= {PosX( 0.92), PosY(-0.00), 0}
		EPCD_OPT_13.points_set	= {"MPCD_stroke_symbols", "vert_box_large"}
		EPCD_OPT_13.scale		= MPCD_STRK_SCALE
		EPCD_OPT_13.controllers	= {{"EPCD_Selected_Frame", 13}}
AddMPCDStrokeSymbol(EPCD_OPT_13)

local	EPCD_OPT_14				= CreateElement "ceSMultiLine"
		EPCD_OPT_14.name		= "EPCD_OPT_14"
		EPCD_OPT_14.material	= stroke_material
		EPCD_OPT_14.init_pos	= mpcd_btn_14_pos
		EPCD_OPT_14.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_14.scale		= MPCD_STRK_SCALE
		EPCD_OPT_14.controllers	= {{"EPCD_Selected_Frame", 14}}
AddMPCDStrokeSymbol(EPCD_OPT_14)

local	EPCD_OPT_15				= CreateElement "ceSMultiLine"
		EPCD_OPT_15.name		= "EPCD_OPT_15"
		EPCD_OPT_15.material	= stroke_material
		EPCD_OPT_15.init_pos	= mpcd_btn_15_pos
		EPCD_OPT_15.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		EPCD_OPT_15.scale		= MPCD_STRK_SCALE
		EPCD_OPT_15.controllers	= {{"EPCD_Selected_Frame", 15}}
AddMPCDStrokeSymbol(EPCD_OPT_15)

local	EPCD_OPT_16				= CreateElement "ceSMultiLine"
		EPCD_OPT_16.name		= "EPCD_OPT_16"
		EPCD_OPT_16.material	= stroke_material
		EPCD_OPT_16.init_pos	= {PosX( 0.65), PosY(-0.87), 0}
		EPCD_OPT_16.points_set	= {"MPCD_stroke_symbols", "horz_box_xlarge"}
		EPCD_OPT_16.scale		= MPCD_STRK_SCALE
		EPCD_OPT_16.controllers	= {{"EPCD_Selected_Frame", 16}}
AddMPCDStrokeSymbol(EPCD_OPT_16)

local	EPCD_OPT_17				= CreateElement "ceSMultiLine"
		EPCD_OPT_17.name		= "EPCD_OPT_17"
		EPCD_OPT_17.material	= stroke_material
		EPCD_OPT_17.init_pos	= {PosX( 0.33), PosY(-0.87), 0}
		EPCD_OPT_17.points_set	= {"MPCD_stroke_symbols", "horz_box_xlarge"}
		EPCD_OPT_17.scale		= MPCD_STRK_SCALE
		EPCD_OPT_17.controllers	= {{"EPCD_Selected_Frame", 17}}
AddMPCDStrokeSymbol(EPCD_OPT_17)

-- DATA FRAMES
local text_line = 0.75
local j = 0
local i = 1

for i = 1, 17 do
	-- NO DATA
	local	no_data_frm_warn				= CreateElement "ceStringSLine"
			no_data_frm_warn.name			= "no_data_frm_warn" .. string.format("%02d", i)
			no_data_frm_warn.material		= stroke_font
			no_data_frm_warn.init_pos		= {0, 0, 0}
			no_data_frm_warn.alignment		= "CenterCenter"
			no_data_frm_warn.value			= "NO DATA FRAME"
			no_data_frm_warn.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
			no_data_frm_warn.controllers	= {{"EPCD_No_DataFrame", i}}
	Add_MPCD_VIDEO_Element(no_data_frm_warn)
	
	-- DATA LINES
	text_line = 0.75
	
	for j = 0, 20 do
		local	data_frm_text				= CreateElement "ceStringSLine"
				data_frm_text.name			= "data_frm_text" .. string.format("%02d", i) .. string.format("%02d", j)
				data_frm_text.material		= stroke_font
				data_frm_text.init_pos		= {PosX(-0.82), PosY(text_line), 0}
				data_frm_text.alignment		= "LeftCenter"
				data_frm_text.formats		= {"%s"}
				data_frm_text.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
				data_frm_text.controllers	= {{"EPCD_DataFrame_Line", i, j}}
		Add_MPCD_VIDEO_Element(data_frm_text)
		
		text_line = text_line - 0.08
	end
	
end

