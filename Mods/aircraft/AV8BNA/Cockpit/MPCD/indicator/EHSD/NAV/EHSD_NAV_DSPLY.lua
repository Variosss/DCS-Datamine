---------------------
-- EHSD Page       --
-- Navigation Mode --
---------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EHSD/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(mpcd_path.."Global/EHSD_MAP_VIDEO.lua")
dofile(mpcd_path.."Global/EHSD_Route_Lines.lua")
dofile(mpcd_path.."Global/EHSD_MAP_OVLY_1.lua")
dofile(mpcd_path.."Global/EHSD_Compass_Rose.lua")
dofile(mpcd_path.."Global/EHSD_Menu.lua")

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

-- AHRS Arrows
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Left_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_07_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "left_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB07_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Left_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_07_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "left_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB07_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Right_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_08_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "right_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB08_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Right_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_08_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "right_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB08_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ehsd_ahrs_dg_hdg_ol"
		BTN_Label.material			= stroke_font_outline
		BTN_Label.init_pos			= {PosX(-0.165), PosY(0.87), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB07_PB08_Data"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "ehsd_ahrs_dg_hdg"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(-0.165), PosY(0.87), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB07_PB08_Data"}}
Add_MPCD_Element(BTN_Label)

-- Data Blocks
dofile(mpcd_path.."NAV/EHSD_NAV_TACAN.lua")	-- TACAN Data Block
dofile(mpcd_path.."NAV/EHSD_NAV_WYPT.lua")	-- NAV Data Block
dofile(mpcd_path.."NAV/EHSD_AGM_JDAM.lua")	-- JDAM data

-- Master Arm Status
local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "selected_sensor_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(0.75), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_AG_Mode"}, {"strs_master_arm"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "selected_sensor_ol"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(0.75), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_AG_Mode"}, {"strs_master_arm"}}
Add_MPCD_Element(EHSD_Label)

-- Selected Sensor
local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "selected_sensor_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(0.65), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"ac_sel_sensor"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "selected_sensor_ol"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(0.65), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"ac_sel_sensor"}}
Add_MPCD_Element(EHSD_Label)

-- TARGET Steering Mode
local	EHSD_Label_Pos				= CreateElement "ceStringPoly"
		EHSD_Label_Pos.name			= "dtgt_steering"
		EHSD_Label_Pos.init_pos		= mpcd_btn_01_pos
Add_MPCD_Element(EHSD_Label_Pos)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "dtgt_steering_type_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.07), 0.0, 0}
		EHSD_Label.parent_element	= "dtgt_steering"
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_DTG_Steering_Type"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "dtgt_steering_type"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.07), 0.0, 0}
		EHSD_Label.parent_element	= "dtgt_steering"
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_DTG_Steering_Type"}}
Add_MPCD_Element(EHSD_Label)

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

-- GPS Error Values
local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_h_error_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_14"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_h_error"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_14"}}
Add_MPCD_Element(EHSD_Label)

--

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_v_error_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(-0.81), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_15"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_v_error"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(-0.80), PosY(-0.81), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_15"}}
Add_MPCD_Element(EHSD_Label)

-- COURSE
local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_label_ol"
		AC_Course_Data.material		= stroke_font_outline
		AC_Course_Data.init_pos		= {PosX(0.85), PosY(-0.45), 0}
		AC_Course_Data.value		= "CRS"
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "CenterCenter"
Add_MPCD_Element(AC_Course_Data)

local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_label"
		AC_Course_Data.material		= stroke_font
		AC_Course_Data.init_pos		= {PosX(0.85), PosY(-0.45), 0}
		AC_Course_Data.value		= "CRS"
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "CenterCenter"
Add_MPCD_Element(AC_Course_Data)

--

local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_value_ol"
		AC_Course_Data.material		= stroke_font_outline
		AC_Course_Data.init_pos		= {PosX(0.85), PosY(-0.52), 0}
		AC_Course_Data.formats		= {"%03d"}
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "CenterCenter"
		AC_Course_Data.controllers	= {{"nav_sel_crs"}}
Add_MPCD_Element(AC_Course_Data)

local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_value"
		AC_Course_Data.material		= stroke_font
		AC_Course_Data.init_pos		= {PosX(0.85), PosY(-0.52), 0}
		AC_Course_Data.formats		= {"%03d"}
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "CenterCenter"
		AC_Course_Data.controllers	= {{"nav_sel_crs"}}
Add_MPCD_Element(AC_Course_Data)

--

local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_delta_ol"
		AC_Course_Data.material		= stroke_font_outline
		AC_Course_Data.init_pos		= {PosX(0.90), PosY(-0.59), 0}
		AC_Course_Data.formats		= {"%2.1fNM"}
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "RightCenter"
		AC_Course_Data.controllers	= {{"nav_crs_delta"}}
Add_MPCD_Element(AC_Course_Data)

local	AC_Course_Data				= CreateElement "ceStringSLine"
		AC_Course_Data.name			= "nav_crs_delta"
		AC_Course_Data.material		= stroke_font
		AC_Course_Data.init_pos		= {PosX(0.90), PosY(-0.59), 0}
		AC_Course_Data.formats		= {"%2.1fNM"}
		AC_Course_Data.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		AC_Course_Data.alignment	= "RightCenter"
		AC_Course_Data.controllers	= {{"nav_crs_delta"}}
Add_MPCD_Element(AC_Course_Data)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_crs_delta_symbol_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {PosX(-0.25), 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "crs_delta"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "nav_crs_delta"
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_crs_delta_symbol"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {PosX(-0.25), 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "crs_delta"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "nav_crs_delta"
AddMPCDStrokeSymbol(EHSD_Symbol)

-- AIRCRAFT DATA
local	AC_Data_Value					= CreateElement "ceStringSLine"
		AC_Data_Value.name				= "ac_gt_deg_ol"
		AC_Data_Value.material			= stroke_font_outline
		AC_Data_Value.init_pos			= {PosX(-0.10), 0.0, 0}
		AC_Data_Value.formats			= {"%03d;"}
		AC_Data_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_200]
		AC_Data_Value.alignment			= "RightCenter"
		AC_Data_Value.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"ac_grd_trk_value"}}
Add_MPCD_Element(AC_Data_Value)

local	AC_Data_Value					= CreateElement "ceStringSLine"
		AC_Data_Value.name				= "ac_gt_deg"
		AC_Data_Value.material			= stroke_font
		AC_Data_Value.init_pos			= {PosX(-0.10), 0.0, 0}
		AC_Data_Value.formats			= {"%03d;"}
		AC_Data_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_200]
		AC_Data_Value.alignment			= "RightCenter"
		AC_Data_Value.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"ac_grd_trk_value"}}
Add_MPCD_Element(AC_Data_Value)

--

local	AC_Data_Value					= CreateElement "ceStringSLine"
		AC_Data_Value.name				= "ac_gs_kts_ol"
		AC_Data_Value.material			= stroke_font_outline
		AC_Data_Value.init_pos			= {PosX(0.10), 0.0, 0}
		AC_Data_Value.formats			= {"%3dKTS"}
		AC_Data_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_200]
		AC_Data_Value.alignment			= "LeftCenter"
		AC_Data_Value.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"ac_grd_spd_value"}}
Add_MPCD_Element(AC_Data_Value)

local	AC_Data_Value					= CreateElement "ceStringSLine"
		AC_Data_Value.name				= "ac_gs_kts"
		AC_Data_Value.material			= stroke_font
		AC_Data_Value.init_pos			= {PosX(0.10), 0.0, 0}
		AC_Data_Value.formats			= {"%3dKTS"}
		AC_Data_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_200]
		AC_Data_Value.alignment			= "LeftCenter"
		AC_Data_Value.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"ac_grd_spd_value"}}
Add_MPCD_Element(AC_Data_Value)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "aircraft_icon_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "aircraft_symbol"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"EHSD_AC_ICON"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "aircraft_icon"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0, 0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "aircraft_symbol"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}, {"EHSD_AC_ICON"}}
AddMPCDStrokeSymbol(EHSD_Symbol)
