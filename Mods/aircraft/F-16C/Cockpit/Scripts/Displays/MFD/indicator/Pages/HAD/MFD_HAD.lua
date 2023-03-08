dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")


local HAD_MENU_LVL =
{
	MAIN		= 0,
	CNTL_P1		= 1,
	CNTL_P2		= 2,
}

local HAD_DECLUTTER =
{
	LINE_1				= 0,
	LINE_2				= 1,
	LINE_3				= 2,
	LINE_4				= 3,
	SAM					= 4,
	NAV_1				= 5,
	NAV_2				= 6,
	NAV_3				= 7,
	CNTL				= 8,
	RINGS				= 9,
}

------------------------------------------------------------------ HAD-------------------------------------------------------------
local ROOT_PAGE	= addPlaceholder("ROOT_PAGE",	nil, nil)
local Expand_layer = addPlaceholder("Expand_layer", nil, ROOT_PAGE.name, {{"HAD_ExpandModes"}})
local HADCenter = addPlaceholder("HADCenter", nil, Expand_layer.name, {{"HAD_DisplayCenter"}})
addStrokeSymbol("Aircraft_Symbol", {"stroke_symbols_MFD", "Aircraft-symbol"}, "FromSet", {0, 0}, HADCenter.name, {{"MFD_SetColor_Group_1"}}, 1.0)
------------------------------------------------------------------- RINGS ---------------------------------------------------------------
local RangeRingRadius = 100
local RingsPH = addPlaceholder("RingsPH", nil, HADCenter.name, {{"HAD_Declutter", HAD_DECLUTTER.RINGS}, {"HAD_isShowElementAtExpandModes"}})
addStrokeCircle("Range_Ring_1", RangeRingRadius * 1, nil, RingsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeCircle("Range_Ring_2", RangeRingRadius * 2, nil, RingsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeCircle("Range_Ring_3", RangeRingRadius * 3, nil, RingsPH.name, {{"HAD_HideDecenteredIndication"}, {"MFD_SetColor_Group_5"}})
-- Heading PH
local Heading_PH = addPlaceholder("HAD_Heading_PH", nil, HADCenter.name, {{"HAD_Heading"}})
--------------------------------------------------------------------------------------------------------

-----HARM DLZ (WEZ) Line
for i = 0, 24 do
    addVarLenStrokeLine("WezRoute_1_Line_"..i, 80, {0,-100}, nil, Expand_layer.name, {{"HAD_HarmWez", RangeRingRadius, i}, {"MFD_SetColor_Group_2"}})
end
 -----HARM DLZ (WEZ) Line (Dashed)
for i = 0, 24 do
    addVarLenStrokeLine("WezRouteD_1_Line_"..i, 80, {0,-100}, nil, Expand_layer.name, {{"HAD_HarmWezDashed", RangeRingRadius, i}, {"MFD_SetColor_Group_2"}}, nil, true, 10, 10)
end

--NAVIGATION ROUTE---
local circleRadius = 4
for i = 0, 24 do

    local STPT_Root = addPlaceholder("NavigationRoute_1_WYPT_Root_"..i, nil, Heading_PH.name, {{"HAD_WaypointPosition", RangeRingRadius, i}})

    addStrokeCircle("NavigationRoute_1_WYPT_circle_"..i, circleRadius, nil, STPT_Root.name, {{"HAD_WaypointType", WPT_Types.STPT, i}, {"MFD_SetColor_Group_2"}})

    for j = 1, 4 do
        addStrokeCircle("NavigationRoute_1_Selected_STPT_circle_"..i.."_"..j, j, nil, STPT_Root.name, {{"HAD_WaypointType", WPT_Types.STPT_SELECTED, i}, {"MFD_SetColor_Group_2"}})
    end
end

for i = 0, 23 do
    addVarLenStrokeLine("NavigationRoute_1_Line_"..i, 80, nil, nil, Heading_PH.name, {{"HAD_NavRouteLine", RangeRingRadius, i, circleRadius}, {"MFD_SetColor_Group_2"}})
 end

   ---------------------------------------------------------------DYNAMIC_DATA----------------------------------------------------------------------------
local PosValidPH = addPlaceholder("HAD_AircraftPosValid_PH", nil, ROOT_PAGE.name, {{"HAD_AircraftPosValid"}})
addPlaceholder("DefenseZones_Keeper", nil, PosValidPH.name, {{"HAD_Declutter", HAD_DECLUTTER.SAM}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.HAD_CONTACT}})
addPlaceholder("System_AirTracks_Keeper", nil, PosValidPH.name, {{"HAD_SystemAirTracksShow"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.HAD_SYSTEM_TRACKS}})
 ---------------------------------------------------------------- BULLSEYE ----------------------------------------------------------------
local CicledCirleRoot = addPlaceholder("Bullseye_Root", nil, Heading_PH.name, {{"HAD_BullseyePosition", RangeRingRadius}})
local CicledCirleRadius = 1
addStrokeCircle("Bullseye_Cirle_First", CicledCirleRadius, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Second", CicledCirleRadius * 5, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Third", CicledCirleRadius * 10, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})

local Bullseye_LOS = addPlaceholder("Bullseye_LOS", {-215, -195}, nil, {{"HAD_BullseyeLOS_VisibleState", 1}})
local Bullseye_LOS_Radius = 17
addStrokeCircle("Bullseye_LOS_Cirle", Bullseye_LOS_Radius, nil, Bullseye_LOS.name, {{"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Range", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", nil, Bullseye_LOS.name, {{"HAD_BullseyeLOS_Range"}, {"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Bearing", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", {0, -Bullseye_LOS_Radius * 1.8}, Bullseye_LOS.name, {{"HAD_BullseyeLOS_Bearing"}, {"MFD_SetColor_Group_1"}})
local Bullseye_LOS_Pointer = addPlaceholder("Bullseye_LOS_Pointer", nil, Bullseye_LOS.name, {{"HAD_Heading"}, {"HAD_BullseyeLOS_PointerRotation"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_1", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.8)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_2", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.6)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_3", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.4)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_4", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.2)

 -- bearing and range from steerpoint/bullseye
addStrokeText("HAD_Bearing_range", "000 00", STROKE_FNT_DFLT_8_12, "LeftCenter", {PB_positions[17][1] - 5, PB_positions[17][2] - 35}, nil, {{"HAD_BearingRangeLabel"}})

local Aircraft_reference_symbol_Root = addPlaceholder("Aircraft_reference_symbol_Root", {0,0}, nil, {{"HAD_BullseyeLOS_VisibleState", 0}})
-- A/C Reference symbol
local AC_Reference_PH = addPlaceholder("AC_Reference_root", {-215, -210}, Aircraft_reference_symbol_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("Aircraft_reference_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_PH.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("Azimuth_Steering_Bar", 40, {0, -20}, 0, AC_Reference_PH.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_PH.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

local Bullseye_LOS_Mask_PH = addPlaceholder("Bullseye_LOS_Mask_PH", {-220, -195})
addSizeClipMask(Bullseye_LOS_Mask_PH, 2, 70, nil, {-19, 0})
------------------------------------------------------------------MENU LEVEL-------------------------------------------------------------
local HAD_PAGE			= addPlaceholder("HAD_PAGE",		nil, ROOT_PAGE.name, 	{{"HAD_MenuShow", HAD_MENU_LVL.MAIN}})
local HAD_CNTL_PAGE_1	= addPlaceholder("HAD_CNTL_PAGE_1",	nil, ROOT_PAGE.name,	{{"HAD_MenuShow", HAD_MENU_LVL.CNTL_P1}})
local HAD_CNTL_PAGE_2	= addPlaceholder("HAD_CNTL_PAGE_2",	nil, ROOT_PAGE.name,  	{{"HAD_MenuShow", HAD_MENU_LVL.CNTL_P2}})
------------------------------------------------------------------ HAD PAGE -------------------------------------------------------------
  --SCALE
local RangeScaleRoot = addPlaceholder("Range_Scale_Root", {PB_positions[20][1] + 10 , (PB_positions[20][2] - PB_positions[19][2]) / 2 + PB_positions[19][2]}, HAD_PAGE.name, {{"HAD_isShowElementAtExpandModes"}})
addStrokeText("Range_Scale_Value", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-12, 0}, RangeScaleRoot.name, {{"HAD_Scale"}})
local DecrementSymbol = addStrokeSymbol("Decrement_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -25}, RangeScaleRoot.name, {{"HAD_ShowDecreaseScaleSymbol"}}, 3.5)
local IncrementSymbol = addStrokeSymbol("Increment_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, 25}, RangeScaleRoot.name, {{"HAD_ShowIncreaseScaleSymbol"}}, 3.5)
IncrementSymbol.init_rot = {180}
addSizeClipMask(RangeScaleRoot, 2, 72, {{"HAD_isShowElementAtExpandModes", RangeScaleRoot.name}}, {-19, 0})

add_PB_label(1, 			"   ", 		HAD_PAGE.name, {{"HAD_DEP"}, {"HAD_isShowElementAtExpandModes"}})
add_PB_label(3, 			"NORM",		ROOT_PAGE.name, {{"HAD_DecluttEXP", 2}})
add_Selectable_PB_Label(3, 	"EXP1", 	ROOT_PAGE.name, {{"HAD_DecluttEXP", 1, 0, 0}}, {{"HAD_DecluttEXP", 1, 1, 0}})
add_Selectable_PB_Label(3, 	"EXP2", 	ROOT_PAGE.name, {{"HAD_DecluttEXP", 1, 0, 1}}, {{"HAD_DecluttEXP", 1, 1, 1}})
add_Selectable_PB_Label(4, 	"THRT", 	HAD_PAGE.name, {{"HAD_THRT", 0}},	{{"HAD_THRT", 1}})
add_Selectable_PB_Label(5, 	"CNTL", 	HAD_PAGE.name, {{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.CNTL}},	{{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.CNTL}})

add_Simple_PB_label(8, 		"FR\nON", 	HAD_PAGE.name, {{"HAD_DecluttFR"}}, nil, {"", "FR\nON", "FL\nON", "FR\nOFF"})
add_Simple_PB_label(9, 		"GS\nOF", 	HAD_PAGE.name, {{"HAD_DecluttGS"}}, nil, {"", "GS\nOF", "GS\nMZ"})
add_Simple_PB_label(10, 	"T\nI", 	HAD_PAGE.name, {{"HAD_DecluttTI"}}, nil, {"", "T\nI", "NC", "SD", "TI\nOFF"})

add_Simple_PB_label(16, 	"MEM", 		HAD_PAGE.name)
add_Simple_PB_label(18, 	"TM", 		HAD_PAGE.name, {{"HAD_DecluttTM"}}, nil, {"", "TM", "AL", "NO"})

--HAD TOF-TOT-LAUNCH_MODE
addStrokeText("TOF", 		 "", STROKE_FNT_DFLT_8_12, "RightCenter", {PB_positions[10][1] - 40, PB_positions[10][2] + 10},	HAD_PAGE.name,{{"HAD_PreLaunch_TOF"}})
addStrokeText("TOT", 		 "", STROKE_FNT_DFLT_8_12, "RightCenter", {PB_positions[10][1] - 40, PB_positions[10][2] - 10},	HAD_PAGE.name,{{"HAD_PreLaunch_TOT"}})
addStrokeText("Launch mode", "", STROKE_FNT_DFLT_8_12, "RightCenter", {PB_positions[10][1] - 40, PB_positions[10][2] - 30},	HAD_PAGE.name,{{"HAD_Launch_Mode"}})
-- TDOA
addFillBox("fillBox", 57, 20, 						  "Center", {PB_positions[15][1], PB_positions[15][2] + 22}, 	HAD_PAGE.name, {{"HAD_TDOA_Mode", 1}})
addBlackText("TDOA_mode", 	"", STROKE_FNT_DFLT_10_14,"Center", {PB_positions[15][1] - 27, PB_positions[15][2] + 15},	HAD_PAGE.name, {{"HAD_TDOA_Mode", 2}})
addVarLenStrokeLine("HAD_TDOA_Slave_LineToTarget",	  200, {0, -100}, nil, HAD_PAGE.name, {{"HAD_TDOA_Slave_LineFromAcft", 8},{"HAD_SYS_AirTrack_Color", 3}}, nil, false)
-- EXPANDED MODE 
local ExpandInformation = addPlaceholder("ExpandInformation", nil, HAD_PAGE.name, {{"ExpandInformation_SHOW"}})
	addStrokeText("BearingTarget", "", 	STROKE_FNT_DFLT_10_14, "Center", {PB_positions[1][1] - 73, PB_positions[1][2] - 27}, ExpandInformation.name, {{"HAD_ExpandMode_Orientation"}}, {"%3d°"})
	addStrokeText("MajorAxis"	 , "", 	STROKE_FNT_DFLT_10_14, "Center", {PB_positions[2][1] - 85, PB_positions[2][2] - 27}, ExpandInformation.name, {{"HAD_ExpandMode_MajorAxis"}})
	addStrokeText("MinorAxis"	 , "", 	STROKE_FNT_DFLT_10_14, "Center", {PB_positions[3][1] - 55, PB_positions[3][2] - 27}, ExpandInformation.name, {{"HAD_ExpandMode_MinorAxis"}})
	addStrokeText("ArmSim"		 , "", 	STROKE_FNT_DFLT_10_14, "Center", {PB_positions[4][1] - 20, PB_positions[4][2] - 27}, ExpandInformation.name, {{"HAD_ExpandMode_MiscellaneousField"}})
	addStrokeText("PGMs"		 , "", 	STROKE_FNT_DFLT_10_14, "Center", {PB_positions[5][1] - 25, PB_positions[5][2] - 27}, ExpandInformation.name, {{"HAD_ExpandMode_PGMs"}})

--TDC cursor
addPlaceholder("Cursor", {0, 0}, ROOT_PAGE.name, {{"HAD_TDC_position"}, {"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Up", 20, {10, 10}, 90, "Cursor", {{"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Down", 20, {10, -10}, 90, "Cursor", {{"MFD_SetColor_Group_2"}})

------------------------------------------------------------HAD CNTL PAGE 1 ----------------------------------------------------------------
add_PB_label(1, 			"PRE", 		HAD_CNTL_PAGE_1.name)
add_PB_label(2, 			"TER\nTBL1",HAD_CNTL_PAGE_1.name)
add_Selectable_PB_Label(5, 	"CNTL", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.CNTL}},	{{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.CNTL}})

add_Selectable_PB_Label(6, 	"LINE1", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.LINE_1}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.LINE_1}})
add_Selectable_PB_Label(7, 	"LINE2", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.LINE_2}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.LINE_2}})
add_Selectable_PB_Label(8, 	"LINE3", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.LINE_3}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.LINE_3}})
add_Selectable_PB_Label(9, 	"LINE4", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.LINE_4}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.LINE_4}})
add_Simple_PB_label(10, 	"PAGE\n1", 	HAD_CNTL_PAGE_1.name)

add_Simple_PB_label(16, 	"MEM", 		HAD_CNTL_PAGE_1.name)
add_Selectable_PB_Label(17, "SAM", 		HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.SAM}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.SAM}})
add_Selectable_PB_Label(18, "NAV3", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.NAV_3}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.NAV_3}})
add_Selectable_PB_Label(19, "NAV2", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.NAV_2}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.NAV_2}})
add_Selectable_PB_Label(20,	"NAV1", 	HAD_CNTL_PAGE_1.name, {{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.NAV_1}},	{{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.NAV_1}})
------------------------------------------------------------HAD CNTL PAGE 2 -----------------------------------------------------------------
add_Simple_PB_label(1, 		"REC", 		HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(2, 		"DATA\nMED",HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(4, 		"RPD", 		HAD_CNTL_PAGE_2.name)
add_Selectable_PB_Label(5, 	"CNTL", 	HAD_CNTL_PAGE_2.name, {{"HAD_SelectedDeclutter", 1, HAD_DECLUTTER.CNTL}},	{{"HAD_SelectedDeclutter", 0, HAD_DECLUTTER.CNTL}})

add_Simple_PB_label(6, 		"DNLD", 	HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(7, 		"AA", 		HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(10, 	"PAGE\n2",	HAD_CNTL_PAGE_2.name)

add_Simple_PB_label(16, 	"GPS\nZERO",HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(17, 	"REC\nZERO",HAD_CNTL_PAGE_2.name)
add_Simple_PB_label(20, 	"GP1", 		HAD_CNTL_PAGE_2.name)