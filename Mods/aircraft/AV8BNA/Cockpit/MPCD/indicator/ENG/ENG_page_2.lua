-----------------------
-- ENG Page          --
-- PHover Parameters --
-----------------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU LEFT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB01"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_01_pos
		BTN_Label.formats			= {"H\nO\nV\n%d"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"phover_idx"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB03"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_03_pos
		BTN_Label.value				= "P\nH\nO\nV"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU TOP
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB06"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_06_pos
		BTN_Label.value				= "HCLR"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB15"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_15_pos
		BTN_Label.value				="E\nW"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- SELECTION BOXES
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB03_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_03_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)

-- DATA LABELS
-- Columns
local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "phov_title_1"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(0.33), 0}
		PHOV_DATA_Label.value			= "10 SEC"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "CenterCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "phov_title_2"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {0.0, PosY(0.33), 0}
		PHOV_DATA_Label.formats			= {"HOVER %d"}
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "CenterCenter"
		PHOV_DATA_Label.controllers		= {{"phover_idx"}}
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "phov_title_3"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(0.33), PosY(0.33), 0}
		PHOV_DATA_Label.formats			= {"%s"}
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "CenterCenter"
		PHOV_DATA_Label.controllers		= {{"phover_type"}}
Add_MPCD_Element(PHOV_DATA_Label)

-- Rows
local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "stab_pos"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(0.18), 0}
		PHOV_DATA_Label.value			= "STAB"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "eng_rpm"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(0.11), 0}
		PHOV_DATA_Label.value			= "RPM"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "eng_jpt"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(0.04), 0}
		PHOV_DATA_Label.value			= "JPT"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_fuel"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.03), 0}
		PHOV_DATA_Label.value			= "FUEL"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_hweight"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.10), 0}
		PHOV_DATA_Label.value			= "HWT"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_oatc"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.17), 0}
		PHOV_DATA_Label.value			= "OATC"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_balt"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.24), 0}
		PHOV_DATA_Label.value			= "BALT"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_altm"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.31), 0}
		PHOV_DATA_Label.value			= "ALTM"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_ralt"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.38), 0}
		PHOV_DATA_Label.value			= "RALT"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_stpr"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.45), 0}
		PHOV_DATA_Label.value			= "STPR"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_rhov"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.69), 0}
		PHOV_DATA_Label.value			= "RHOV"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

local	PHOV_DATA_Label					= CreateElement "ceStringSLine"
		PHOV_DATA_Label.name			= "ac_rjpt"
		PHOV_DATA_Label.material		= stroke_font
		PHOV_DATA_Label.init_pos		= {PosX(-0.33), PosY(-0.76), 0}
		PHOV_DATA_Label.value			= "RJPT"
		PHOV_DATA_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Label.alignment		= "LeftCenter"
Add_MPCD_Element(PHOV_DATA_Label)

-- DATA VALUES
local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "stab_pos_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.40), PosY(0.18), 0}
		PHOV_DATA_Value.formats			= {"%1.1f;"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"eng_stab_pos"}}
Add_MPCD_Element(PHOV_DATA_Value)

local	ENG_Param_Symbol				= CreateElement "ceSMultiLine"
		ENG_Param_Symbol.name			= "stab_pos_symbol"
		ENG_Param_Symbol.material		= stroke_material
		ENG_Param_Symbol.init_pos		= {PosX(0.37), PosY(0.18), 0}
		ENG_Param_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		ENG_Param_Symbol.scale			= MPCD_STRK_SCALE
		ENG_Param_Symbol.controllers	= {{"eng_stab_pos_vector"}}
AddMPCDStrokeSymbol(ENG_Param_Symbol)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "eng_fan_rpm_h"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.34), PosY(0.11), 0}
		PHOV_DATA_Value.formats			= {"%1.f%%"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_rpm"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "eng_jpt_label_h"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.37), PosY(0.04), 0}
		PHOV_DATA_Value.formats			= {"%1.f;C"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_jpt"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "fuel_weight_h"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.33), PosY(-0.03), 0}
		PHOV_DATA_Value.formats			= {"%1.f#"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_fuel"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_hweight_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.33), PosY(-0.10), 0}
		PHOV_DATA_Value.formats			= {"%1.f#"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_hwt"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_oatc_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.37), PosY(-0.17), 0}
		PHOV_DATA_Value.formats			= {"%1.f;C"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_oatc"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_balt_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.37), PosY(-0.24), 0}
		PHOV_DATA_Value.formats			= {"%1.fFT"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_balt"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_altm_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.40), PosY(-0.31), 0}
		PHOV_DATA_Value.formats			= {"%1.2f"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_altm"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_ralt_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.37), PosY(-0.38), 0}
		PHOV_DATA_Value.formats			= {"%1.fFT"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_ralt"}}
Add_MPCD_Element(PHOV_DATA_Value)

--

local	PHOV_DATA_Value					= CreateElement "ceStringSLine"
		PHOV_DATA_Value.name			= "ac_stpr_v"
		PHOV_DATA_Value.material		= stroke_font
		PHOV_DATA_Value.init_pos		= {PosX(0.40), PosY(-0.45), 0}
		PHOV_DATA_Value.formats			= {"%1.2f"}
		PHOV_DATA_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		PHOV_DATA_Value.alignment		= "RightCenter"
		PHOV_DATA_Value.controllers		= {{"phover_stpr"}}
Add_MPCD_Element(PHOV_DATA_Value)

