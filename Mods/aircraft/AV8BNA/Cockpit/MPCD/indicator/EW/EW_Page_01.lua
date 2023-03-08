-------------------
-- EW Page       --
-- ECM Prog Mode --
-------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EW/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU
-- LEFT
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB02"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_02_pos
		BTN_Label.value			= "P\nR\nO\nG"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- TOP
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB06"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_06_pos
		BTN_Label.value			= "ALL"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB07"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_07_pos
		BTN_Label.value			= "CHF"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB08"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_08_pos
		BTN_Label.value			= "FLR"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- RIGHT
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB15"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_15_pos
		BTN_Label.value			= "E\nW"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers 	= {{"EW_Recall"}}
Add_MPCD_Element(BTN_Label)

-- BOTTOM
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB18"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_18_pos
		BTN_Label.format		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- SELECTED MENU OPTIONS
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB02_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_02_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB15_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_15_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"EW_Recall"}}
AddMPCDStrokeSymbol(Selection_Box)

-- TOP
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB06_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_06_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"EW_CMD_ALL"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB07_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_07_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"EW_CMD_CHF"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB08_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_08_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"EW_CMD_FLR"}}
AddMPCDStrokeSymbol(Selection_Box)

-- DISPENSER PROGRAMMING DATA
local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopLeft_CHF"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.50), PosY(0.70), 0.0}
		CMD_Program.value			= "CHF"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopLeft_CHF_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.25), PosY(0.70), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DTL_CHF_Count"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopLeft_FLR"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.50), PosY(0.62), 0.0}
		CMD_Program.value			= "FLR"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopLeft_FLR_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.25), PosY(0.62), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DTL_FLR_Count"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopRight_CHF"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(0.70), 0.0}
		CMD_Program.value			= "CHF"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopRight_CHF_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.55), PosY(0.70), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DTR_CHF_Count"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopRight_FLR"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(0.62), 0.0}
		CMD_Program.value			= "FLR"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_TopRight_FLR_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.55), PosY(0.62), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DTR_FLR_Count"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Bottom_CHF"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(0.30), 0.0}
		CMD_Program.value			= "CHF"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Bottom_CHF_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.15), PosY(0.30), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DBC_CHF_Count"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Bottom_FLR"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(0.22), 0.0}
		CMD_Program.value			= "FLR"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Bottom_FLR_Count"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.15), PosY(0.22), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_DBC_FLR_Count"}}
Add_MPCD_Element(CMD_Program)

-- CMD PROGRAM
local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.50), PosY(-0.20), 0.0}
		CMD_Program.value			= "CHF"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

--

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BRSTQ"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.45), PosY(-0.28), 0.0}
		CMD_Program.value			= "BQTY"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BQTY"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(-0.28), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_BQTY"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BQRD"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(-0.28), 0.0}
		CMD_Program.formats			= {"%s"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_BQTY_C"}}
Add_MPCD_Element(CMD_Program)

--

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BRSTI"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(-0.28), 0.0}
		CMD_Program.value			= "BINT"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BINT"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.72), PosY(-0.28), 0.0}
		CMD_Program.formats			= {"%1.1f"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_BINT"}}
Add_MPCD_Element(CMD_Program)

--

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BRSTI"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(-0.28), 0.0}
		CMD_Program.value			= "BINT"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BINT"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.72), PosY(-0.28), 0.0}
		CMD_Program.formats			= {"%1.1f"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_BINT"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_BIRD"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.72), PosY(-0.28), 0.0}
		CMD_Program.formats			= {"%s"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_BINT_C"}}
Add_MPCD_Element(CMD_Program)

--

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SLVOQ"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.45), PosY(-0.36), 0.0}
		CMD_Program.value			= "SQTY"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SQTY"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(-0.36), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_SQTY"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SLVOI"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(-0.36), 0.0}
		CMD_Program.value			= "SINT"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SINT"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.70), PosY(-0.36), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_CHF_DISP"}, {"EW_CHF_SINT"}}
Add_MPCD_Element(CMD_Program)

--
local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_FLR"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.50), PosY(-0.60), 0.0}
		CMD_Program.value			= "FLR"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_FLR_DISP"}}
Add_MPCD_Element(CMD_Program)

--

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SLVOQ"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.45), PosY(-0.68), 0.0}
		CMD_Program.value			= "QTY"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_FLR_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SQTY"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(-0.10), PosY(-0.68), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_FLR_DISP"}, {"EW_FLR_SQTY"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SLVOI"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.30), PosY(-0.68), 0.0}
		CMD_Program.value			= "INT"
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "LeftCenter"
		CMD_Program.controllers 	= {{"EW_FLR_DISP"}}
Add_MPCD_Element(CMD_Program)

local	CMD_Program					= CreateElement "ceStringSLine"
		CMD_Program.name			= "Disp_Prog_CHF_SINT"
		CMD_Program.material		= stroke_font
		CMD_Program.init_pos		= {PosX(0.70), PosY(-0.68), 0.0}
		CMD_Program.formats			= {"%d"}
		CMD_Program.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CMD_Program.alignment		= "RightCenter"
		CMD_Program.controllers 	= {{"EW_FLR_DISP"}, {"EW_FLR_SINT"}}
Add_MPCD_Element(CMD_Program)
