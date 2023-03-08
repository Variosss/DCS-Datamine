---------------------
-- EHSD Page       --
-- Data Mode       --
---------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EHSD/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/Classified_Page.lua")

-- Global Variables
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 3.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
Add_MPCD_Element(MPCD_center)

-- MENU
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB02"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_02_pos
		BTN_Label.value			= "D\nA\nT\nA"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB03"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_03_pos
		BTN_Label.value			= "G\nP\nS\nE"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB04"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_04_pos
		BTN_Label.value			= "G\nP\nS\nX"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

--

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB08"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_08_pos
		BTN_Label.value			= "GPS"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

--

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB04"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_14_pos
		BTN_Label.value			= "X\nF\nE\nR"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

--

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB18"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_18_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

---------------------------------
-- SYMBOLS & ICONS
---------------------------------
local	EHSD_Symbol				= CreateElement "ceSMultiLine"
		EHSD_Symbol.name		= "EHSD_GPS_Down_Arrow"
		EHSD_Symbol.material	= stroke_material
		EHSD_Symbol.init_pos	= mpcd_btn_01_pos
		EHSD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_12_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "EHSD_SPT_Number"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.165), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB12_PB13_Data"}}
Add_MPCD_Element(BTN_Label)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Down_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_13_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_16_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "EHSD_SPT_Number"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(0.49), PosY(-0.93), 0}
		BTN_Label.value				= "PG"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB12_PB13_Data"}}
Add_MPCD_Element(BTN_Label)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Down_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_17_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol				= CreateElement "ceSMultiLine"
		EHSD_Symbol.name		= "EHSD_GPS_Down_Arrow"
		EHSD_Symbol.material	= stroke_material
		EHSD_Symbol.init_pos	= mpcd_btn_20_pos
		EHSD_Symbol.points_set	= {"MPCD_stroke_symbols", "tpod_right_arrow"}
		EHSD_Symbol.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol)

