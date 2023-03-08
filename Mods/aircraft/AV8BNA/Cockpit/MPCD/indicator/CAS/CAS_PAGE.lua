--------------------------------------------------
-- CAS Page
--------------------------------------------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/CAS/CAS_PAGE_MENU.lua")

local base_line		= 0.80
local delta_line	= 0.07

--------------------------------------------------
-- Page Labels
--------------------------------------------------
local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line), 0}
		CAS_TEXT.value			= "REQ"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_01_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line), 0}
		CAS_TEXT.value			= "1"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_02_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 2), 0}
		CAS_TEXT.value			= "2"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_04_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 4), 0}
		CAS_TEXT.value			= "3"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_06_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 6), 0}
		CAS_TEXT.value			= "4"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_07_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 7), 0}
		CAS_TEXT.value			= "5"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_09_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 9), 0}
		CAS_TEXT.value			= "6"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_11_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 11), 0}
		CAS_TEXT.value			= "7"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_12_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 12), 0}
		CAS_TEXT.value			= "8"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_13_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.value			= "9"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_17_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 17), 0}
		CAS_TEXT.value			= "13"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_20_00"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.70),  PosY(base_line - delta_line * 20), 0}
		CAS_TEXT.value			= "14"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "RightCenter"
Add_MPCD_Element(CAS_TEXT)

--

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_01_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line), 0}
		CAS_TEXT.value			= "IP"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_01_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(0.30),  PosY(base_line - delta_line), 0}
		CAS_TEXT.value			= "WPT"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_02_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 2), 0}
		CAS_TEXT.value			= "BRG"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_03_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 3), 0}
		CAS_TEXT.value			= "POSB"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_04_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 4), 0}
		CAS_TEXT.value			= "RNG"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_04_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {0.0,  PosY(base_line - delta_line * 4), 0}
		CAS_TEXT.value			= "NM"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_05_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 5), 0}
		CAS_TEXT.value			= "POSR"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_05_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {0.0,  PosY(base_line - delta_line * 5), 0}
		CAS_TEXT.value			= "NM"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_06_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 6), 0}
		CAS_TEXT.value			= "ELEV"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_06_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {0.0,  PosY(base_line - delta_line * 6), 0}
		CAS_TEXT.value			= "FT"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_07_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 7), 0}
		CAS_TEXT.value			= "DESC"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_09_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 9), 0}
		CAS_TEXT.value			= "L/L"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_11_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 11), 0}
		CAS_TEXT.value			= "MARK"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_11_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(0.30),  PosY(base_line - delta_line * 11), 0}
		CAS_TEXT.value			= "CODE"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_12_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 12), 0}
		CAS_TEXT.value			= "FRND"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_13_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.value			= "EGRS"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_13_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.value			= "EGRS"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_13_02"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.10),  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.value			= "CP"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_13_03"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(0.30),  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.value			= "WPT"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_17_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 17), 0}
		CAS_TEXT.value			= "RMKS"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_20_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 20), 0}
		CAS_TEXT.value			= "TOT"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_21_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line - delta_line * 21), 0}
		CAS_TEXT.value			= "RTIME"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_22_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(0.10),  PosY(base_line - delta_line * 20), 0}
		CAS_TEXT.value			= "CS/T"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "LABEL_Line_23_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(0.10),  PosY(base_line - delta_line * 21), 0}
		CAS_TEXT.value			= "FAC:"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

-- FIELD MARKER
local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "Field_Edit_Marker"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.8),  PosY(base_line - delta_line), 0}
		CAS_TEXT.value			= "*"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Edit_Field", 0.46}}
Add_MPCD_Element(CAS_TEXT)

--------------------------------------------------
-- Page Data
--------------------------------------------------
local Col_01 = PosX(-0.45)
local Col_02 = PosX(0.05)
local Col_03 = PosX(0.15)
local Col_04 = PosX(0.45)
local Col_05 = PosX(-0.15)
local Col_06 = PosX(0.30)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.65),  PosY(base_line), 0}
		CAS_TEXT.formats		= {"%d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_01"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_01"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {PosX(-0.30),  PosY(base_line), 0}
		CAS_TEXT.value			= "ACTIVE"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_02"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_03"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_03"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_04"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_04,  PosY(base_line - delta_line), 0}
		CAS_TEXT.formats		= {"%d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_04"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_05"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 2), 0}
		CAS_TEXT.formats		= {"%03d.%d;"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_05"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_06"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_02,  PosY(base_line - delta_line * 2), 0}
		CAS_TEXT.value			= "T"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_06"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_07"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_02,  PosY(base_line - delta_line * 2), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_07"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_08"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 3), 0}
		CAS_TEXT.formats		= {"%03d.%d;"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_08"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_09"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_02,  PosY(base_line - delta_line * 3), 0}
		CAS_TEXT.value			= "T"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_09"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_10"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 4), 0}
		CAS_TEXT.formats		= {"%1.3f"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_10"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_11"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 5), 0}
		CAS_TEXT.formats		= {"%1.3f"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_11"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_12"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 6), 0}
		CAS_TEXT.formats		= {"%1.f"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_12"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_13"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 7), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_13"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_13b"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 8), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_13b"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_14"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 9), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_14"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_15"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 10), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_15"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_16"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 11), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_16"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_17"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_04,  PosY(base_line - delta_line * 11), 0}
		CAS_TEXT.formats		= {"%d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_17"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_18"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 12), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_18"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_19"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_02,  PosY(base_line - delta_line * 12), 0}
		CAS_TEXT.formats		= {"%1.f"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_19"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_20"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 13), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_20"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_21a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_05,  PosY(base_line - delta_line * 14), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_21a"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_21b"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_06,  PosY(base_line - delta_line * 14), 0}
		CAS_TEXT.formats		= {"%02d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_21b"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_22a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_05,  PosY(base_line - delta_line * 15), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_22a"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_22b"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_06,  PosY(base_line - delta_line * 15), 0}
		CAS_TEXT.formats		= {"%02d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_22b"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_23a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_05,  PosY(base_line - delta_line * 16), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_23a"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_23b"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_06,  PosY(base_line - delta_line * 16), 0}
		CAS_TEXT.formats		= {"%02d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_23b"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_27a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 17), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_27a"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_27a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 18), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_27b"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_27a"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 19), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_27c"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_24"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 20), 0}
		CAS_TEXT.formats		= {"%02d:%02d:%02d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_24"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_25"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_01,  PosY(base_line - delta_line * 21), 0}
		CAS_TEXT.formats		= {"%02d:%02d:%02d"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_25"}}
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "BRIEF_Field_26"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_06,  PosY(base_line - delta_line * 21), 0}
		CAS_TEXT.formats		= {"%s"}
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
		CAS_TEXT.controllers	= {{"CAS_BRIEF_Field_26"}}
Add_MPCD_Element(CAS_TEXT)
