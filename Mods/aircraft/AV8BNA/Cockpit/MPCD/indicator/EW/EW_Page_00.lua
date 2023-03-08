-------------------
-- EW Page       --
-- RWR Mode      --
-------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EW/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU
-- LEFT
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB01"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= {PosX(-0.90), PosY(-0.65), 0}
		BTN_Label.formats		= {"ASPJ\nALT\n%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EW_ASPJ_Altitude"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB02"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_02_pos
		BTN_Label.value			= "P\nR\nO\nG"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB03"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= {PosX(-0.90), PosY(-0.00), 0}
		BTN_Label.formats		= {"JMR\n%d\n%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EW_Jammr_count"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB04"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= {PosX(-0.90), PosY( 0.30), 0}
		BTN_Label.formats		= {"FLR\n%d\n%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EW_Flare_count"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB05"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= {PosX(-0.90), PosY( 0.60), 0}
		BTN_Label.formats		= {"CHF\n%d\n%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EW_Chaff_count"}}
Add_MPCD_Element(BTN_Label)

-- TOP
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB06"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_06_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"strs_wpn_1a"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB07"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_07_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"strs_wpn_1b"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB08"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_08_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"strs_wpn_2a"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB09"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_09_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"strs_wpn_2b"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB10"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_10_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"strs_wpn_gun"}}
Add_MPCD_Element(BTN_Label)

-- RIGHT
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB11"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_11_pos
		BTN_Label.value			= "O\nF\nS\nT"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB12"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_12_pos
		BTN_Label.value			= "P\nR\nI"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB13"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_13_pos
		BTN_Label.value			= "L\nI\nM"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EW_PB14"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_14_pos
		BTN_Label.value			= "B\nI\nT"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

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
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- Selection Boxes
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB13_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_13_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"EW_Declutter"}}
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
		Selection_Box.controllers 	= {{"strs_wpn_1a_sel"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB07_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_07_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"strs_wpn_1b_sel"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB08_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_08_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"strs_wpn_2a_sel"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB09_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_09_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"strs_wpn_2b_sel"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB10_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_10_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"strs_gun_sel"}}
AddMPCDStrokeSymbol(Selection_Box)

-- EW DATA
local	EW_EXP_Status				= CreateElement "ceStringSLine"
		EW_EXP_Status.name			= "EW_EXP_Title"
		EW_EXP_Status.material		= stroke_font
		EW_EXP_Status.init_pos		= {PosX(-0.75), PosY(0.75), 0.0}
		EW_EXP_Status.value			= "EXP"
		EW_EXP_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_EXP_Status.alignment		= "CenterCenter"
Add_MPCD_Element(EW_EXP_Status)

local	EW_EXP_Status				= CreateElement "ceStringSLine"
		EW_EXP_Status.name			= "EW_EXP_Selection"
		EW_EXP_Status.material		= stroke_font
		EW_EXP_Status.init_pos		= {PosX(-0.75), PosY(0.67), 0.0}
		EW_EXP_Status.formats		= {"%s"}
		EW_EXP_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_EXP_Status.alignment		= "CenterCenter"
		EW_EXP_Status.controllers 	= {{"EW_EXP_Switch"}}
Add_MPCD_Element(EW_EXP_Status)

local	EW_RWR_Status				= CreateElement "ceStringSLine"
		EW_RWR_Status.name			= "EW_RWR_Title"
		EW_RWR_Status.material		= stroke_font
		EW_RWR_Status.init_pos		= {PosX(0.75), PosY(0.75), 0.0}
		EW_RWR_Status.value			= "RWR"
		EW_RWR_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_RWR_Status.alignment		= "CenterCenter"
Add_MPCD_Element(EW_RWR_Status)

local	EW_RWR_Status				= CreateElement "ceStringSLine"
		EW_RWR_Status.name			= "EW_RWR_Selection"
		EW_RWR_Status.material		= stroke_font
		EW_RWR_Status.init_pos		= {PosX(0.75), PosY(0.67), 0.0}
		EW_RWR_Status.formats		= {"%s"}
		EW_RWR_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_RWR_Status.alignment		= "CenterCenter"
		EW_RWR_Status.controllers 	= {{"EW_RWR_Switch"}}
Add_MPCD_Element(EW_RWR_Status)

-- RWR Indicator
local	RWR_Grid				= CreateElement "ceSMultiLine"
		RWR_Grid.name			= "EW_RWR_Grid"
		RWR_Grid.material		= stroke_material
		RWR_Grid.init_pos		= {0, 0, 0}
		RWR_Grid.points_set		= {"MPCD_stroke_symbols", "RWR_Grid"}
		RWR_Grid.scale			= MPCD_STRK_SCALE * 1.27
		RWR_Grid.controllers 	= {{"EW_RWR_Sts_ON"}}
AddMPCDStrokeSymbol(RWR_Grid)

-- 
local	EW_RWR_Status				= CreateElement "ceStringSLine"
		EW_RWR_Status.name			= "rwr_dis_type"
		EW_RWR_Status.material		= stroke_font
		EW_RWR_Status.init_pos		= {PosX(-0.05), PosY(0.03), 0.0}
		EW_RWR_Status.formats		= {"%s"}
		EW_RWR_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_RWR_Status.alignment		= "CenterCenter"
		EW_RWR_Status.controllers 	= {{"EW_RWR_Sts_ON"}, {"EW_RWR_Filter"}}
Add_MPCD_Element(EW_RWR_Status)

local	EW_RWR_Status				= CreateElement "ceStringSLine"
		EW_RWR_Status.name			= "rwr_dis_mode"
		EW_RWR_Status.material		= stroke_font
		EW_RWR_Status.init_pos		= {PosX(0.05), PosY(0.03), 0.0}
		EW_RWR_Status.value			= "L"
		EW_RWR_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_RWR_Status.alignment		= "CenterCenter"
		EW_RWR_Status.controllers 	= {{"EW_RWR_Sts_ON"}, {"EW_Declutter"}}
Add_MPCD_Element(EW_RWR_Status)

local	EW_RWR_Status				= CreateElement "ceStringSLine"
		EW_RWR_Status.name			= "rwr_fail_type"
		EW_RWR_Status.material		= stroke_font
		EW_RWR_Status.init_pos		= {0.0, PosY(-0.07), 0.0}
		EW_RWR_Status.formats		= {"%s"}
		EW_RWR_Status.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		EW_RWR_Status.alignment		= "CenterCenter"
		EW_RWR_Status.controllers 	= {{"EW_RWR_Sts_ON"}, {"EW_RWR_Failure"}}
Add_MPCD_Element(EW_RWR_Status)

-- CONTACTS (16 max)
for i = 1, 16 do

	local	EW_RWR_Threat				= CreateElement "ceSimple"
			EW_RWR_Threat.name			= "RWR_Threat_" .. string.format("%02d", i)
			EW_RWR_Threat.init_pos		= {0.0, 0.0, 0.0}
			EW_RWR_Threat.controllers	= {{"EW_ThreatPos", i-1, 0.125}, {"EW_Threat_is_Primary", i-1}}
	Add_MPCD_Element(EW_RWR_Threat)
	
	local	EW_RWR_Threat					= CreateElement "ceStringSLine"
			EW_RWR_Threat.name				= "ThreatCode" .. string.format("%02d", i)
			EW_RWR_Threat.material			= stroke_font
			EW_RWR_Threat.init_pos			= {0.0, 0.0, 0.0}
			EW_RWR_Threat.parent_element	= "RWR_Threat_" .. string.format("%02d", i)
			EW_RWR_Threat.formats			= {"%s"}
			EW_RWR_Threat.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
			EW_RWR_Threat.alignment			= "CenterCenter"
			EW_RWR_Threat.controllers 		= {{"EW_ThreatCode", i-1}}
	Add_MPCD_Element(EW_RWR_Threat)

	local	EW_RWR_Threat					= CreateElement "ceSMultiLine"
			EW_RWR_Threat.name				= "ThreatAirborneSymbol" .. string.format("%02d", i)
			EW_RWR_Threat.material			= stroke_material
			EW_RWR_Threat.init_pos			= {0.0, PosY(0.06), 0.0}
			EW_RWR_Threat.parent_element	= "RWR_Threat_" .. string.format("%02d", i)
			EW_RWR_Threat.points_set		= {"MPCD_stroke_symbols", "RWR_AirThreats"}
			EW_RWR_Threat.scale				= MPCD_STRK_SCALE
			EW_RWR_Threat.controllers 		= {{"EW_Threat_is_Airborne", i-1}}
	AddMPCDStrokeSymbol(EW_RWR_Threat)
	
	local	EW_RWR_Threat					= CreateElement "ceSMultiLine"
			EW_RWR_Threat.name				= "ThreatSeaborneSymbol" .. string.format("%02d", i)
			EW_RWR_Threat.material			= stroke_material
			EW_RWR_Threat.init_pos			= {0.0, PosY(-0.05), 0.0}
			EW_RWR_Threat.parent_element	= "RWR_Threat_" .. string.format("%02d", i)
			EW_RWR_Threat.points_set		= {"MPCD_stroke_symbols", "RWR_SeaThreats"}
			EW_RWR_Threat.scale				= MPCD_STRK_SCALE
			EW_RWR_Threat.controllers 		= {{"EW_Threat_is_Seaborne", i-1}}
	AddMPCDStrokeSymbol(EW_RWR_Threat)
	
	local	EW_RWR_Threat					= CreateElement "ceSMultiLine"
			EW_RWR_Threat.name				= "ThreatNewSymbol" .. string.format("%02d", i)
			EW_RWR_Threat.material			= stroke_material
			EW_RWR_Threat.init_pos			= {0.0, 0.0, 0.0}
			EW_RWR_Threat.parent_element	= "RWR_Threat_" .. string.format("%02d", i)
			EW_RWR_Threat.points_set		= {"MPCD_stroke_symbols", "RWR_NewThreat"}
			EW_RWR_Threat.scale				= MPCD_STRK_SCALE
			EW_RWR_Threat.controllers 		= {{"EW_Threat_is_New", i-1}}
	AddMPCDStrokeSymbol(EW_RWR_Threat)
	
end