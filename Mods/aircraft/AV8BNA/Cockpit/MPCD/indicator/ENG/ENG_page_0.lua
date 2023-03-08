-----------------------
-- ENG Page          --
-- Engine Parameters --
-----------------------

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU LEFT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB03"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_03_pos
		BTN_Label.value				= "P\nH\nO\nV"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB05"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_05_pos
		BTN_Label.value				= "E\nM\nS"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU TOP
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB10"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_10_pos
		BTN_Label.value				= "JPT"
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
		BTN_Label.name				= "ENG_PB16"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_16_pos
		BTN_Label.value				= "ACCEL"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ENG_PB20"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_20_pos
		BTN_Label.value				= "FRZ"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- SELECTION BOXES
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB16_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_16_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"accel_mode_on"}}
AddMPCDStrokeSymbol(Selection_Box)

-- ENGINE PARAMETERS
-- DATA LABELS
local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_id"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {0.0, PosY(0.82), 0}
		ENG_Param_Label.value		= "ENG ID(3)-408"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "CenterCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "sortie_JPT"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.60), PosY(0.62), 0}
		ENG_Param_Label.value		= "SORTIE JPT"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "RightCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_life_count"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.80), PosY(0.55), 0}
		ENG_Param_Label.formats		= {"LIFE %d"}
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
		ENG_Param_Label.controllers	= {{"eng_life_count"}}
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_max_jpt"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.60), PosY(0.55), 0}
		ENG_Param_Label.value		= "MAX JPT"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "RightCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_ot_time"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.60), PosY(0.48), 0}
		ENG_Param_Label.value		= "OT TIME"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "RightCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_ot_time_l2"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.84), PosY(0.48), 0}
		ENG_Param_Label.value		= "SEC"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "stab_pos"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(0.34), 0}
		ENG_Param_Label.value		= "STAB POS"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "igv_label"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(0.20), 0}
		ENG_Param_Label.value		= "IGV"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "hov_label"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.75), PosY(0.20), 0}
		ENG_Param_Label.formats		= {"HOV %d"}
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
		ENG_Param_Label.controllers	= {{"phover_idx"}}
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_comp_rpm"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(0.13), 0}
		ENG_Param_Label.value		= "COMP RPM"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_fan_rpm"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(0.06), 0}
		ENG_Param_Label.value		= "FAN  RPM"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_jpt_label"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(-0.01), 0}
		ENG_Param_Label.value		= "JPT"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_cor_comp"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(-0.08), 0}
		ENG_Param_Label.value		= "COR COMP"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "eng_cor_fan"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(-0.15), 0}
		ENG_Param_Label.value		= "COR FAN"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "fuel_weight"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(-0.22), 0}
		ENG_Param_Label.value		= "FUEL WT"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "fuel_weight"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.10), PosY(-0.29), 0}
		ENG_Param_Label.value		= "H2O WT"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "LeftCenter"
Add_MPCD_Element(ENG_Param_Label)

-- DATA VALUES
local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "sortie_JPT"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.90), PosY(0.62), 0}
		ENG_Param_Value.formats		= {"%1.f;"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_sortie_JPT"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_max_jpt_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.90), PosY(0.55), 0}
		ENG_Param_Value.formats		= {"%1.f;C"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_max_jpt_val"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_ot_time_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.80), PosY(0.48), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_otemp_time"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "stab_pos_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.60), PosY(0.34), 0}
		ENG_Param_Value.formats		= {"%1.1f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_stab_pos"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Symbol				= CreateElement "ceSMultiLine"
		ENG_Param_Symbol.name			= "stab_pos_symbol"
		ENG_Param_Symbol.material		= stroke_material
		ENG_Param_Symbol.init_pos		= {PosX(0.64), PosY(0.34), 0}
		ENG_Param_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		ENG_Param_Symbol.scale			= MPCD_STRK_SCALE
		ENG_Param_Symbol.controllers	= {{"eng_stab_pos_vector"}}
AddMPCDStrokeSymbol(ENG_Param_Symbol)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_igv_value"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.56), PosY(0.20), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_igv_value"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_comp_rpm_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.60), PosY(0.13), 0}
		ENG_Param_Value.formats		= {"%1.f%%"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_comp_rpm_u"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_fan_rpm_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.60), PosY(0.06), 0}
		ENG_Param_Value.formats		= {"%1.f%%"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_fan_rpm_u"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_fan_rpm_h"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.93), PosY(0.06), 0}
		ENG_Param_Value.formats		= {"%1.f%%"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_fan_rpm_h"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_jpt_label_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.64), PosY(-0.01), 0}
		ENG_Param_Value.formats		= {"%1.f; "}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_jpt_value"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_jpt_label_h"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.97), PosY(-0.01), 0}
		ENG_Param_Value.formats		= {"%1.f; "}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_jpt_val_h"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_cor_comp_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.60), PosY(-0.08), 0}
		ENG_Param_Value.formats		= {"%1.f%%"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_comp_rpm_c"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "eng_cor_fan_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.60), PosY(-0.15), 0}
		ENG_Param_Value.formats		= {"%1.f%%"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"eng_fan_rpm_c"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "fuel_weight_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.56), PosY(-0.22), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"ac_fuel_wt"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "fuel_weight_h"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.89), PosY(-0.22), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"ac_fuel_wt_h"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "water_weight_v"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.56), PosY(-0.29), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"ac_water_wt"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "water_weight_h"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.89), PosY(-0.29), 0}
		ENG_Param_Value.formats		= {"%1.f"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "RightCenter"
		ENG_Param_Value.controllers	= {{"ac_water_wt_h"}}
Add_MPCD_Element(ENG_Param_Value)

-- ENGINE ACCELERATION TIMES
local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "acc_label"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {0.0, PosY(-0.43), 0}
		ENG_Param_Label.value		= "ACCELERATION"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "CenterCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "acc_rpm_l1"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.55), PosY(-0.50), 0}
		ENG_Param_Label.value		= "RPM"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "RightCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "acc_rpm_l2"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.20), PosY(-0.50), 0}
		ENG_Param_Label.value		= "35-60%"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "CenterCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "acc_rpm_l3"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(0.20), PosY(-0.50), 0}
		ENG_Param_Label.value		= "60-105%"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "CenterCenter"
Add_MPCD_Element(ENG_Param_Label)

local	ENG_Param_Label				= CreateElement "ceStringSLine"
		ENG_Param_Label.name		= "acc_time_l"
		ENG_Param_Label.material	= stroke_font
		ENG_Param_Label.init_pos	= {PosX(-0.55), PosY(-0.57), 0}
		ENG_Param_Label.value		= "TIME"
		ENG_Param_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Label.alignment	= "RightCenter"
Add_MPCD_Element(ENG_Param_Label)

--

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "acc_time_v1"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(-0.20), PosY(-0.57), 0}
		ENG_Param_Value.formats		= {"%1.1fSEC"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "CenterCenter"
		ENG_Param_Value.controllers	= {{"accel_time_1"}}
Add_MPCD_Element(ENG_Param_Value)

local	ENG_Param_Value				= CreateElement "ceStringSLine"
		ENG_Param_Value.name		= "acc_time_v2"
		ENG_Param_Value.material	= stroke_font
		ENG_Param_Value.init_pos	= {PosX(0.20), PosY(-0.57), 0}
		ENG_Param_Value.formats		= {"%1.1fSEC"}
		ENG_Param_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		ENG_Param_Value.alignment	= "CenterCenter"
		ENG_Param_Value.controllers	= {{"accel_time_2"}}
Add_MPCD_Element(ENG_Param_Value)

