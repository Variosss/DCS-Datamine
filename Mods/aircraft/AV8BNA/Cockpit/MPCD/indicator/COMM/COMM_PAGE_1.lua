---------------
-- COMM      --
-- Main Page --
---------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- MENU LEFT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB01"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_01_pos
		BTN_Label.value				= "S\nT\nA\nT"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU TOP
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB06"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_06_pos
		BTN_Label.value				= "SCAN"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB07"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_07_pos
		BTN_Label.value				= "FF"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB08"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_08_pos
		BTN_Label.value				= "AJ"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB09"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_09_pos
		BTN_Label.value				= "MX"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB14"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_14_pos
		BTN_Label.value				= "H\nQ"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB15"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_15_pos
		BTN_Label.value				="E\nW"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB17"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_17_pos
		BTN_Label.value				= "COMM2"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_PB20"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_20_pos
		BTN_Label.value				= "COMM1"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- Navigation Arrows
local	COMM_Symbol					= CreateElement "ceSMultiLine"
		COMM_Symbol.name			= "COMM_Line_Up_Arrow"
		COMM_Symbol.material		= stroke_material
		COMM_Symbol.init_pos		= mpcd_btn_05_pos
		COMM_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		COMM_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(COMM_Symbol)

local	COMM_Symbol					= CreateElement "ceSMultiLine"
		COMM_Symbol.name			= "COMM_Line_Down_Arrow"
		COMM_Symbol.material		= stroke_material
		COMM_Symbol.init_pos		= mpcd_btn_04_pos
		COMM_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		COMM_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(COMM_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_Line_Selector"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(-0.90), PosY(0.45), 0}
		BTN_Label.value				= "LINE"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

--

local	COMM_Symbol					= CreateElement "ceSMultiLine"
		COMM_Symbol.name			= "COMM_PG_Up_Arrow"
		COMM_Symbol.material		= stroke_material
		COMM_Symbol.init_pos		= mpcd_btn_11_pos
		COMM_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		COMM_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(COMM_Symbol)

local	COMM_Symbol					= CreateElement "ceSMultiLine"
		COMM_Symbol.name			= "COMM_PG_Down_Arrow"
		COMM_Symbol.material		= stroke_material
		COMM_Symbol.init_pos		= mpcd_btn_12_pos
		COMM_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		COMM_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(COMM_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "COMM_Line_Selector"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.45), 0}
		BTN_Label.value				= "PG"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- SELECTION BOXES
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB17_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_17_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"COM2_Selected"}}
AddMPCDStrokeSymbol(Selection_Box)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB20_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_20_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
		Selection_Box.controllers 	= {{"COM1_Selected"}}
AddMPCDStrokeSymbol(Selection_Box)

-- COMM DATA

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL1"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.75), PosY(0.80), 0}
		COMM_Table_Label.value		= "CH"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL2"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.60), PosY(0.80), 0}
		COMM_Table_Label.value		= "FREQ/MOD"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL3"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.23), PosY(0.80), 0}
		COMM_Table_Label.value		= "COLOR"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL4"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(0.02), PosY(0.80), 0}
		COMM_Table_Label.value		= "CIPH"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL5"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(0.20), PosY(0.80), 0}
		COMM_Table_Label.value		= "AGENCY"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_TOP_COL6"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(0.47), PosY(0.80), 0}
		COMM_Table_Label.value		= "CALL"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "LeftCenter"
Add_MPCD_Element(COMM_Table_Label)

--

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_BTM_DEG"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.65), PosY(-0.70), 0}
		COMM_Table_Label.value		= "DEGRADE"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "CenterCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_BTM_DEG_VAL"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.33), PosY(-0.70), 0}
		COMM_Table_Label.value		= "OFF"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "CenterCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_BTM_TIME"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.65), PosY(-0.77), 0}
		COMM_Table_Label.value		= "TIME"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "CenterCenter"
Add_MPCD_Element(COMM_Table_Label)

local	COMM_Table_Label			= CreateElement "ceStringSLine"
		COMM_Table_Label.name		= "LBL_BTM_TIME_VAL"
		COMM_Table_Label.material	= stroke_font
		COMM_Table_Label.init_pos	= {PosX(-0.33), PosY(-0.77), 0}
		COMM_Table_Label.value		= "OFF"
		COMM_Table_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		COMM_Table_Label.alignment	= "CenterCenter"
Add_MPCD_Element(COMM_Table_Label)

--

local line = 0.83

for i = 1, 10 do
	line = line - 0.13;
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_NO_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(-0.65), PosY(line), 0}
			COMM_Table_Row.formats		= {"%d"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "RightCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelID", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_FR_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(-0.60), PosY(line), 0}
			COMM_Table_Row.formats		= {"%03d.%03d%s"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "LeftCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelFreq", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_CLR_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(-0.23), PosY(line), 0}
			COMM_Table_Row.formats		= {"%s"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "LeftCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelColor", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_CPH_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(-0.02), PosY(line), 0}
			COMM_Table_Row.formats		= {"%s"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "LeftCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelCipher", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_ACY_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(0.20), PosY(line), 0}
			COMM_Table_Row.formats		= {"%s"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "LeftCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelAgency", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
	local	COMM_Table_Row				= CreateElement "ceStringSLine"
			COMM_Table_Row.name			= "FREQ_CHANNEL_ACY_" .. string.format("%02d", i)
			COMM_Table_Row.material		= stroke_font
			COMM_Table_Row.init_pos		= {PosX(0.47), PosY(line), 0}
			COMM_Table_Row.formats		= {"%s"}
			COMM_Table_Row.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
			COMM_Table_Row.alignment	= "LeftCenter"
			COMM_Table_Row.controllers	= {{"COM_ChannelCallSign", i}}
	Add_MPCD_Element(COMM_Table_Row)
	
end