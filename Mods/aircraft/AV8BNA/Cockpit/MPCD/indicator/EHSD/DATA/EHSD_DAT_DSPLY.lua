---------------------
-- EHSD Page       --
-- Data Mode       --
---------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EHSD/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(mpcd_path.."Global/EHSD_MAP_VIDEO.lua")
dofile(mpcd_path.."Global/EHSD_Compass_Rose.lua")
dofile(mpcd_path.."Global/EHSD_Menu.lua")
dofile(mpcd_path.."ALGN/EHSD_ALN_DATA.lua")
dofile(mpcd_path.."DATA/EHSD_DAT_Routes.lua")

-- Global Variables
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 3.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
Add_MPCD_Element(MPCD_center)

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "Aircraft_Position"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.parent_element	= "MPCD_center"
		MPCD_center.controllers		= {{"EHSD_DATA_AC_POS", EHSD_Scale}}
Add_MPCD_Element(MPCD_center)

-- Navigation Arrows
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_12_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_12_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "EHSD_SPT_Number_OL"
		BTN_Label.material			= stroke_font_outline
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.165), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB12_PB13_Data"}}
Add_MPCD_Element(BTN_Label)

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
		EHSD_Symbol.name			= "EHSD_Down_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_13_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Down_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_13_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- Data Blocks
local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_Latitude_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.89), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_01"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_Latitude"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.89), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_01"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_Longitude_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.82), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_02"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_Longitude"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.82), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_02"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_DATUM_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_03"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Global_DATUM"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_03"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Selected_Sensor_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.64), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_04"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Selected_Sensor_OL"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(0.64), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_04"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_05_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.30), PosY(0.89), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_05"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_05"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.30), PosY(0.89), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_05"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_06_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.30), PosY(0.82), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_06"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_06"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.30), PosY(0.82), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_06"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_07_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.50), PosY(0.75), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_07"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_07"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.50), PosY(0.75), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_07"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_09_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.50), PosY(0.68), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_09"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_09"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.50), PosY(0.68), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_09"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_10_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(-0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_10"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_10"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(-0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_10"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_11_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(-0.81), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_11"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_11"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(-0.85), PosY(-0.81), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_11"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_12_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.50), PosY(-0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_12"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_12"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.50), PosY(-0.74), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_12"}}
Add_MPCD_Element(EHSD_Data)

--

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_13_OL"
		EHSD_Data.material			= stroke_font_outline
		EHSD_Data.init_pos			= {PosX(0.30), PosY(-0.81), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_13"}}
Add_MPCD_Element(EHSD_Data)

local	EHSD_Data					= CreateElement "ceStringSLine"
		EHSD_Data.name				= "EHSD_Data_Block_13"
		EHSD_Data.material			= stroke_font
		EHSD_Data.init_pos			= {PosX(0.30), PosY(-0.81), 0}
		EHSD_Data.formats			= {"%s"}
		EHSD_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Data.alignment			= "LeftCenter"
		EHSD_Data.controllers		= {{"EHSD_Data_Block_13"}}
Add_MPCD_Element(EHSD_Data)

-- Symbols: Steerpoint
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_WPT_POS"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_WPT_POS"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STPOS_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_WPT_POS"}, {"EHSD_DATA_WOS_POS", EHSD_Scale}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STPOS"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_WPT_POS"}, {"EHSD_DATA_WOS_POS", EHSD_Scale}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- Symbols: TACAN
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_TCN_POS"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_TCN_POS"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_TCN_POS"}, {"EHSD_DATA_TOS_POS", EHSD_Scale}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Data_STP"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_DATA_TCN_POS"}, {"EHSD_DATA_TOS_POS", EHSD_Scale}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- Aircraft 
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "aircraft_icon_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.parent_element	= "Aircraft_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "aircraft_symbol"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers		= {{"EHSD_AC_ICON"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "aircraft_icon"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.parent_element	= "Aircraft_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "aircraft_symbol"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers		= {{"EHSD_AC_ICON"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- SCALE
local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_scale_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.78), PosY(-0.60), 0}
		EHSD_Label.value			= "SCL"
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_scale"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.78), PosY(-0.60), 0}
		EHSD_Label.value			= "SCL"
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_scale_val_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.78), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%d"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"ehsd_scale_value"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_scale_val"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.78), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%d"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"ehsd_scale_value"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_zoom_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.07), 0.0, 0}
		EHSD_Label.parent_element	= "ehsd_map_scale_val_ol"
		EHSD_Label.value			= "Z"
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"ehsd_zoom_enabled"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_map_zoom"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.07), 0.0, 0}
		EHSD_Label.parent_element	= "ehsd_map_scale_val"
		EHSD_Label.value			= "Z"
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"ehsd_zoom_enabled"}}
Add_MPCD_Element(EHSD_Label)
