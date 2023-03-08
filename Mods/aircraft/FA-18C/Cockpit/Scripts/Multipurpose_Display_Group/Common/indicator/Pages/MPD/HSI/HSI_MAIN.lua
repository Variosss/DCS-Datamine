dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HSI/HSI_Definitions.lua")

local DistanceBetween120Lines = 30
local DistanceBetween150Lines = 48
local CustomStrDef = {fontScaleY_150, fontScaleX_150, 11 * GetScale(), fontInterlineDflt150 * GetScale()}

local NavType = 
{
	TACANType = 0,
	WYPTType = 1,
	MARKPOINTType = 2,
	OAPType = 3,
}

local StationPonterMode = 
{
	Normal = 0,
	TD = 1,--Target Designator 
}

addMPD_TDC_diamond()

------------------------------------------ Track up and North up ---------------------------------------------------
local TN_UP_Mode_Root = "Track_and_North_Up_Root"
addPlaceholder(TN_UP_Mode_Root, {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 0}})

local TN_UP_Mode = "Track_and_North_Up"
addPlaceholder(TN_UP_Mode, {0, 0}, TN_UP_Mode_Root, {{"MPD_HSI_CourseRoseMode_Track_North_UP", 0}})
drawCompass(400, TN_UP_Mode, {{"MPD_HSI_Compass_Label"}})
addStrokeSymbol("aircraft_Track_and_North_UP", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, 0}, TN_UP_Mode_Root, {{"MPD_HSI_CourseRoseMode_Track_North_UP", 1}})
addPlaceholder("Ground_Track_Pointer_TN_UP_Root", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GroundTrack"}})
addStrokeSymbol("Ground_Track_Pointer_TN_UP", {"stroke_symbols_MDI_AMPCD", "130-ground-track-pointer"}, "FromSet", {0, 355}, "Ground_Track_Pointer_TN_UP_Root")
local SpeedOffsetX = 50
local SpeedOffsetY = 20
addStrokeText("TrueSpeed_TN_UP_Mode", "", STROKE_FNT_DFLT_120, "RightCenter", {-SpeedOffsetX, -SpeedOffsetY}, TN_UP_Mode_Root, {{"MPD_HSI_TrueAndGroundSpeed", 0}}, {"%dT", "%dG"})
addStrokeText("GroundSpeed_TN_UP_Mode", "", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, -SpeedOffsetY}, TN_UP_Mode_Root, {{"MPD_HSI_TrueAndGroundSpeed", 1}}, {"%dT", "%dG"})
addStrokeText("RequireGroundSpeed_TN_UP_Mode", "", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, -SpeedOffsetY - 35}, TN_UP_Mode_Root, {{"MPD_HSI_RequireGroundSpeed"}})
-- CPL
addStrokeText("CPL_Cue", "CPL ", STROKE_FNT_DFLT_120, "RightCenter", {-SpeedOffsetX, SpeedOffsetY}, TN_UP_Mode_Root, {{"MPD_HSI_CplCue"}})
addStrokeText("CPL_Mode", "TCN", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, SpeedOffsetY}, TN_UP_Mode_Root, {{"MPD_HSI_CplMode"}}, {"", "ASL", "BNK", "SEQ%d", "WYPT", "TCN", "HDG", "P/R"})

------------------------------------------ Decentered mode ---------------------------------------------------
local openingMask = openMaskArea(0, "HSI_Mask", {}, {}, {0, 0})
set_box_w_h(openingMask, 850, 900)
local DCTR_Mode_Root = "Decentered_Root"
addPlaceholder(DCTR_Mode_Root, {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 2}})
local DCTR_Mode = "DCTR"
-- NOTE: to make any changes consistent, better to send the decentered position to MDG via mux. The digital map camera depends on this value.
addPlaceholder(DCTR_Mode, {0, -400}, DCTR_Mode_Root, {{"MPD_HSI_CourseRoseMode_Rotate"}})
drawCompass(760, DCTR_Mode, {{"MPD_HSI_Compass_Label"}}, true)
clippedObject = addStrokeSymbol("aircraft_CourseRoseMode_Decentered", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, -400}, nil, {{"MPD_HSI_CourseRoseMode_Airplane_Decentered"}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeText("TrueSpeed_DCTR_Mode", "", STROKE_FNT_DFLT_120, "RightCenter", {-SpeedOffsetX, 0}, "aircraft_CourseRoseMode_Decentered", {{"MPD_HSI_TrueAndGroundSpeed", 0}}, {"%dT", "%dG"})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeText("GroundSpeed_DCTR_Mode", "", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, 0}, "aircraft_CourseRoseMode_Decentered", {{"MPD_HSI_TrueAndGroundSpeed", 1}}, {"%dT", "%dG"})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeText("RequireGroundSpeed_DCTR_Mode", "", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, -35}, "aircraft_CourseRoseMode_Decentered", {{"MPD_HSI_RequireGroundSpeed"}})
setClipLevel(clippedObject, 1)
-- CPL
clippedObject = addStrokeText("CPL_Cue_DCTR_Mode", "CPL ", STROKE_FNT_DFLT_120, "RightCenter", {-SpeedOffsetX, SpeedOffsetY * 2}, "aircraft_CourseRoseMode_Decentered", {{"MPD_HSI_CplCue"}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeText("CPL_Mode_DCTR_Mode", "TCN", STROKE_FNT_DFLT_120, "LeftCenter", {SpeedOffsetX, SpeedOffsetY * 2}, "aircraft_CourseRoseMode_Decentered", {{"MPD_HSI_CplMode"}}, {"", "ASL", "BNK", "SEQ", "WYPT", "TCN", "HDG", "P/R"})
setClipLevel(clippedObject, 1)
-- TACAN mark for Decentered mode
local TACANMarkNameDCTR = "TACANMarkRootDecentered"
clippedObject = addPlaceholder(TACANMarkNameDCTR, {0, 0}, DCTR_Mode, {{"MPD_HSI_Navigation_Mark", NavType.TACANType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("TACANMark_Front_DCTR", {"stroke_symbols_MDI_AMPCD", "TACAN-mark-front"}, "FromSet", {0, 800}, TACANMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("TACANMark_Back_DCTR", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-back"}, "FromSet", {0, -800}, TACANMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("PH_ForTACANStationSymbol", {0, 0}, DCTR_Mode, {{"MPD_HSI_Navigation_Mark", NavType.TACANType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("TACANMark_StationSymbol_DCTR", {"stroke_symbols_MDI_AMPCD", "150-TACAN-situation"}, "FromSet", {0, 0}, "PH_ForTACANStationSymbol", {{"MPD_HSI_Navigation_StationSymbol", NavType.TACANType , BigCompassInternalRadius, StationPonterMode.Normal}})
setClipLevel(clippedObject, 1)

local TACANCourseLine_DCTR = "TACANCourseLineRoot_DCTR"
clippedObject = addPlaceholder(TACANCourseLine_DCTR, nil, DCTR_Mode, {{"MPD_HSI_Navigation_CourseLineCenter", NavType.TACANType, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("TACANCourseLine_up_DCTR", nil, nil, nil, TACANCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineLen", NavType.TACANType, BigCompassInternalRadius, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("TACANCourseLine_down_DCTR", nil, nil, nil, TACANCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineLen", NavType.TACANType, BigCompassInternalRadius, 1}})
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("TACANCourseLineArrow_DCTR", {0,  0}, TACANCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineArrow", NavType.TACANType, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("TACANCourseLine_head_left_DCTR", 20, {0,  0}, 150, "TACANCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("TACANCourseLine_head_right_DCTR", 20, {0,  0}, 210, "TACANCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)

-- Waypoint mark for Decentered mode
local WYPTMarkNameDCTR = "WYPTMarkRootDecentered"
clippedObject = addPlaceholder(WYPTMarkNameDCTR, {0, 0}, DCTR_Mode, {{"MPD_HSI_Navigation_Mark", NavType.WYPTType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_Front_DCTR", {"stroke_symbols_MDI_AMPCD", "Waypoint-head-mark"}, "FromSet", {0, 720}, WYPTMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_Back_DCTR", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-tail-mark"}, "FromSet", {0, -720}, WYPTMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("PH_ForWYPTStationSymbol", {0, 0}, DCTR_Mode, {{"MPD_HSI_Navigation_Mark", NavType.WYPTType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_StationSymbol_DCTR", {"stroke_symbols_MDI_AMPCD", "Waypoint-symbol"}, "FromSet", {0, 0}, "PH_ForWYPTStationSymbol", {{"MPD_HSI_Navigation_StationSymbol", NavType.WYPTType , BigCompassInternalRadius, StationPonterMode.Normal}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.WYPTType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_TD_DCTR", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, "PH_ForWYPTStationSymbol", {{"MPD_HSI_Navigation_StationSymbol", NavType.WYPTType , BigCompassInternalRadius, StationPonterMode.TD}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.WYPTType}})
setClipLevel(clippedObject, 1)

local WYPTCourseLine_DCTR = "WYPTCourseLineRoot_DCTR"
clippedObject = addPlaceholder(WYPTCourseLine_DCTR, nil, DCTR_Mode, {{"MPD_HSI_Navigation_CourseLineCenter", NavType.WYPTType, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("WYPTCourseLine_up_DCTR", nil, nil, nil, WYPTCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineLen", NavType.WYPTType, BigCompassInternalRadius, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("WYPTCourseLine_down_DCTR", nil, nil, nil, WYPTCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineLen", NavType.WYPTType, BigCompassInternalRadius, 1}})
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("WYPTCourseLineArrow_DCTR", {0,  0}, WYPTCourseLine_DCTR, {{"MPD_HSI_Navigation_CourseLineArrow", NavType.WYPTType, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("WYPTCourseLine_head_left_DCTR", 20, {0,  0}, 150, "WYPTCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("WYPTCourseLine_head_right_DCTR", 20, {0,  0}, 210, "WYPTCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)

-- OAP for Decentered mode
local OAPMarkNameDCTR = "OAPMarkNameDCTR"
clippedObject = addPlaceholder(OAPMarkNameDCTR, {0, 0}, DCTR_Mode, {{"MPD_HSI_Navigation_Mark", NavType.OAPType}, {"MPD_HSI_Navigation_StationSymbol", NavType.OAPType , BigCompassInternalRadius, StationPonterMode.Normal}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.OAPType}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("OAPLine1DCTR", 20, {10,  0}, 90, OAPMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("OAPLine2DCTR", 20, {0,  -10}, 0, OAPMarkNameDCTR)
setClipLevel(clippedObject, 1)

closeMaskArea(1, "HSI_MaskClose", openingMask.vertices, openingMask.indices, openingMask.init_pos)
addPlaceholder("Selected_heading_symbol_DCTR", {0, -400}, nil, {{"MPD_HSI_HSEL_Mark_Decentered"}})
addStrokeSymbol("Selected_heading_symbol_mark_DCTR", {"stroke_symbols_MDI_AMPCD", "141-heading-mark"}, "FromSet", {0, 790}, "Selected_heading_symbol_DCTR")

local DCTR_RootWithNoMask = "Decentered_RootWithNoMask"
addPlaceholder(DCTR_RootWithNoMask, {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 2}})
local DCTR_ModeWithNoMask = "DCTR_WithNoMask"
addPlaceholder(DCTR_ModeWithNoMask, {0, -400}, DCTR_RootWithNoMask, {{"MPD_HSI_CourseRoseMode_Rotate"}})
for i = 0, 15 do
   addVarLenStrokeLine("WYPTSeqLine_DCTR_"..i, 80, nil, nil, DCTR_ModeWithNoMask, {{"MPD_HSI_Waypoint_SequenceLine", i, BigCompassInternalRadius}}, true, 10, 10)
end
addPlaceholder("Ground_Track_Pointer_DCTR_Root", {0, 0}, DCTR_ModeWithNoMask, {{"MPD_HSI_GroundTrack"}})
addStrokeSymbol("Ground_Track_Pointer_DCTR", {"stroke_symbols_MDI_AMPCD", "130-ground-track-pointer"}, "FromSet", {0, 730}, "Ground_Track_Pointer_DCTR_Root")

addPlaceholder("HSI_LubberLine_DCTR_Root", nil, DCTR_RootWithNoMask, {{"MPD_HSI_LubberLine"}})
addStrokeLine("HSI_LubberLine_DCTR", 80, {0,  320}, 0, "HSI_LubberLine_DCTR_Root")
addPlaceholder("HSI_TrueHeading_DCTR_Root", nil, DCTR_RootWithNoMask, {{"MPD_HSI_TrueHeading"}})
addStrokeLine("HSI_TrueHeading_DCTR", 80, {0,  350}, 180, "HSI_TrueHeading_DCTR_Root")
addStrokeText("TRUE_HeadingCue_DCTR", "TRUE", STROKE_FNT_DFLT_120, "CenterCenter", {0, 390}, DCTR_RootWithNoMask, {{"MPD_HSI_TrueHeading"}})

local XTRCInfo = 450	--TRC - top right corner
local YTRCInfo = 400	--TRC - top right corner
local TRCSpaceBetweenRow = 30
addStrokeText("TRCData", "", STROKE_FNT_DFLT_120, "RightCenter", {XTRCInfo, YTRCInfo}, nil, {{"MPD_HSI_Waypoint_RangeBearing"}}, {"%03d°/%5.1f", "%03d°", "     %5.1f"})
addStrokeText("TRCTime", "", STROKE_FNT_DFLT_120, "RightCenter", {XTRCInfo, YTRCInfo - TRCSpaceBetweenRow}, nil, {{"MPD_HSI_Waypoint_TimeToGo"}})
addStrokeText("WPT_FuelRemaining", "XXXXX",	STROKE_FNT_DFLT_120, "RightCenter", {XTRCInfo, YTRCInfo - TRCSpaceBetweenRow * 2}, nil, {{"MPD_HSI_Waypoint_FuelRemaining", TRCSpaceBetweenRow}})	-- FPAS
addStrokeText("WPT_DistToDescent", "XX",	STROKE_FNT_DFLT_120, "RightCenter", {XTRCInfo, YTRCInfo - TRCSpaceBetweenRow * 3}, nil, {{"MPD_HSI_Waypoint_DistToDescent", TRCSpaceBetweenRow}})	-- FPAS
addStrokeText("TRCInfo", "", STROKE_FNT_DFLT_120, "RightCenter", {XTRCInfo, YTRCInfo - TRCSpaceBetweenRow * 2}, nil, {{"MPD_HSI_Waypoint_GPS_ID"}})
addStrokeText("WYPT_Page_Number", "", STROKE_FNT_DFLT_100, "RightCenter", {505, 60}, nil, {{"MPD_HSI_WYPT_Data_WaypointSelectedNumber"}})

local CSELXPos = 480	--BRC - bottom right corner
local CSELYPos = -423	--BRC - bottom right corner
addStrokeText("CSELData_Label", "CSEL", STROKE_FNT_DFLT_120, "RightTop", {CSELXPos, CSELYPos}, nil)
addStrokeText("CSELData", nil, STROKE_FNT_DFLT_120, "RightTop", {CSELXPos, CSELYPos - DistanceBetween120Lines}, nil, {{"MPD_HSI_CSEL"}}, {"%03.0f°"})

addStrokeText("CourceLinePerpendicularRange", "", STROKE_FNT_DFLT_120, "RightCenter", {467, -360 - DistanceBetween120Lines * 1.5}, nil, {{"MPD_HSI_CourseLinePerpendicularDistance"}})

local HSELXPos = -CSELXPos
local HSELYPos = CSELYPos
addStrokeText("HSELData_Label", "HSEL", STROKE_FNT_DFLT_120, "LeftTop", {HSELXPos, HSELYPos}, nil)
addStrokeText("HSELData", nil, STROKE_FNT_DFLT_120, "LeftTop", {HSELXPos, HSELYPos - DistanceBetween120Lines}, nil, {{"MPD_HSI_HSEL"}}, {"%03.0f°"})
addPlaceholder("Selected_heading_symbol", {0, 0}, nil, {{"MPD_HSI_HSEL_Mark"}})
addStrokeSymbol("Selected_heading_symbol_mark", {"stroke_symbols_MDI_AMPCD", "141-heading-mark"}, "FromSet", {0, 430}, "Selected_heading_symbol")

-- Align display
local ALGN_DISLP = addPlaceholder("AlignDisplay", {0, 0}, nil, {{"MPD_HSI_EnableAlignDisplay"}})
local XGRNDLabel = 0
local YGRNDLabel = -170	
addStrokeText("AlignType", "GRND", STROKE_FNT_DFLT_120, "CenterCenter", {XGRNDLabel * 30, YGRNDLabel}, ALGN_DISLP.name, {{"MPD_HSI_AlignType"}})
addStrokeLine("AlignType_Line", 180, {-90, YGRNDLabel - 17}, -90, ALGN_DISLP.name)
local XBottLabel = -117
local YBottLabel = YGRNDLabel - 34
addStrokeText("AlignQual", "QUAL: 0.5   OK", STROKE_FNT_DFLT_120, "LeftCenter", {XBottLabel, YBottLabel}, ALGN_DISLP.name, {{"MPD_HSI_AlignQuality"}})
addStrokeText("AlignTime", "TIME:38:13", STROKE_FNT_DFLT_120, "LeftCenter", {XBottLabel, YBottLabel - 30}, ALGN_DISLP.name, {{"MPD_HSI_AlignTime"}})
addStrokeText("AlignWaypoints", "", STROKE_FNT_DFLT_120, "LeftCenter", {XBottLabel, YBottLabel - 60}, ALGN_DISLP.name, {{"MPD_HSI_AlignWaypoints"}})

addPlaceholder("ADF_Mark_Root", {0, 0}, nil, {{"MPD_HSI_ADF_Mark"}})
addStrokeSymbol("ADF_Mark", {"stroke_symbols_MDI_AMPCD", "133-ADF-mark"}, "FromSet", {0, 430}, "ADF_Mark_Root")

------------------------------------- RTC ------------------------------------- 
local RTCYPos = -390
addStrokeText("RTC_ZuluTimeOfDay", nil, STROKE_FNT_DFLT_120, "CenterCenter", {-367, RTCYPos}, nil, {{"MPD_HSI_RTC_ZuluTimeOfDay"}})
addStrokeText("RTC_Elapsed/CountdownTime", nil, STROKE_FNT_DFLT_120, "CenterCenter", {420, -360}, nil, {{"MPD_HSI_RTC_Elapsed_Countdown_Time"}})

------------------------------------ TACAN ------------------------------------ 
local XTACANInfo = -450	
local YTACANInfo = 400
local TRCSpaceBetweenRow = 30
addStrokeText("TACANTimeToGo", "", STROKE_FNT_DFLT_120, "LeftCenter", {XTACANInfo + 30, YTACANInfo - TRCSpaceBetweenRow}, nil, {{"MPD_HSI_TACAN_TimeToGo"}})
addStrokeText("TACAN_FuelRemaining", "XXXXX", STROKE_FNT_DFLT_120, "LeftCenter", {XTACANInfo, YTACANInfo - TRCSpaceBetweenRow * 3}, nil, {{"MPD_HSI_TACAN_FuelRemaining"}})
addStrokeText("TACAN_DistToDescent", "XX", STROKE_FNT_DFLT_120, "LeftCenter", {XTACANInfo, YTACANInfo - TRCSpaceBetweenRow * 4}, nil, {{"MPD_HSI_TACAN_DistToDescent"}})
-- For north up and track up
local TACANMarkNameNTU = "TACANMarkRootNTU"
addPlaceholder(TACANMarkNameNTU, {0, 0}, TN_UP_Mode, {{"MPD_HSI_Navigation_Mark", NavType.TACANType}})
addStrokeSymbol("TACANMark_StationSymbol", 	{"stroke_symbols_MDI_AMPCD", "150-TACAN-situation"}, "FromSet", {0, 0}, TACANMarkNameNTU, {{"MPD_HSI_Navigation_StationSymbol", NavType.TACANType , LittleCompassInternalRadius, StationPonterMode.Normal}})

local TACANCourseLine = "TACANCourseLineRoot"
addPlaceholder(TACANCourseLine, nil, TN_UP_Mode, {{"MPD_HSI_Navigation_CourseLineCenter", NavType.TACANType, LittleCompassInternalRadius}})
addVarLenStrokeLine("TACANCourseLine_up", nil, nil, nil, TACANCourseLine, {{"MPD_HSI_Navigation_CourseLineLen", NavType.TACANType, LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("TACANCourseLine_down", nil, nil, nil, TACANCourseLine, {{"MPD_HSI_Navigation_CourseLineLen", NavType.TACANType, LittleCompassInternalRadius, 1}})
addPlaceholder("TACANCourseLineArrow", {0,  0}, TACANCourseLine, {{"MPD_HSI_Navigation_CourseLineArrow", NavType.TACANType, LittleCompassInternalRadius}})
addStrokeLine("TACANCourseLine_head_left", 20, {0,  0}, 150, "TACANCourseLineArrow")
addStrokeLine("TACANCourseLine_head_right", 20, {0,  0}, 210, "TACANCourseLineArrow")
---------------------------------- Waypoints ---------------------------------- 
-- For north up and track up
local WYPTMarkNameNTU = "WYPTMarkRootNTU"
local offsetForWYPTMark = 362
addPlaceholder(WYPTMarkNameNTU, {0, 0}, TN_UP_Mode, {{"MPD_HSI_Navigation_Mark", NavType.WYPTType}})
addStrokeSymbol("WYPTMark_Front_NUT", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-head-mark"}, "FromSet", {0, offsetForWYPTMark + 5}, WYPTMarkNameNTU)
addStrokeSymbol("WYPTMark_Back_NUT", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-tail-mark"}, "FromSet", {0, -offsetForWYPTMark}, WYPTMarkNameNTU)
addStrokeSymbol("WYPTMark_StationSymbol", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-symbol"}, "FromSet", {0, 0}, WYPTMarkNameNTU, {{"MPD_HSI_Navigation_StationSymbol", NavType.WYPTType , LittleCompassInternalRadius, StationPonterMode.Normal}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.WYPTType}})
addStrokeSymbol("WYPTMark_TD", 	{"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, WYPTMarkNameNTU, {{"MPD_HSI_Navigation_StationSymbol", NavType.WYPTType , LittleCompassInternalRadius, StationPonterMode.TD}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.WYPTType}})

local WYPTCourseLine = "WYPTCourseLineRoot"
addPlaceholder(WYPTCourseLine, nil, TN_UP_Mode, {{"MPD_HSI_Navigation_CourseLineCenter", NavType.WYPTType, LittleCompassInternalRadius}})
addVarLenStrokeLine("WYPTCourseLine_up", nil, nil, nil, WYPTCourseLine, {{"MPD_HSI_Navigation_CourseLineLen", NavType.WYPTType, LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("WYPTCourseLine_down", nil, nil, nil, WYPTCourseLine, {{"MPD_HSI_Navigation_CourseLineLen", NavType.WYPTType, LittleCompassInternalRadius, 1}})
addPlaceholder("WYPTCourseLineArrow", {0,  0}, WYPTCourseLine, {{"MPD_HSI_Navigation_CourseLineArrow", NavType.WYPTType, LittleCompassInternalRadius}})
addStrokeLine("WYPTCourseLine_head_left", 20, {0,  0}, 150, "WYPTCourseLineArrow")
addStrokeLine("WYPTCourseLine_head_right", 20, {0,  0}, 210, "WYPTCourseLineArrow")

for i = 0, 13 do
   addVarLenStrokeLine("WYPTSeqLine_"..i, 80, nil, nil, TN_UP_Mode, {{"MPD_HSI_Waypoint_SequenceLine", i, LittleCompassInternalRadius}}, true, 10, 10)
end

addPlaceholder("HSI_LubberLine_Root", nil, "aircraft_Track_and_North_UP", {{"MPD_HSI_LubberLine"}})
addStrokeLine("HSI_LubberLine", 80, {0,  370}, 0, "HSI_LubberLine_Root")
addPlaceholder("HSI_TrueHeading_Root", nil, "aircraft_Track_and_North_UP", {{"MPD_HSI_TrueHeading"}})
addStrokeLine("HSI_TrueHeading", 80, {0,  400}, 180, "HSI_TrueHeading_Root")
addStrokeText("TRUE_HeadingCue", "TRUE", STROKE_FNT_DFLT_120, "CenterCenter", {0, 430}, TN_UP_Mode_Root, {{"MPD_HSI_TrueHeading"}})

---------------------------------- Markpoints ---------------------------------- 
local MarkpointMarkNameNTU = "MarkpointMarkRootNTU"
addPlaceholder(MarkpointMarkNameNTU, {0, 0}, TN_UP_Mode, {{"MPD_HSI_Navigation_Mark", NavType.MARKPOINTType}})
addStrokeSymbol("MarkpointMark_StationSymbol", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-symbol"}, "FromSet", {0, 0}, MarkpointMarkNameNTU, {{"MPD_HSI_Navigation_StationSymbol", NavType.MARKPOINTType , LittleCompassInternalRadius, StationPonterMode.Normal}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.MARKPOINTType}})
addStrokeSymbol("MarkpointMark_TD", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, MarkpointMarkNameNTU, {{"MPD_HSI_Navigation_StationSymbol", NavType.MARKPOINTType , LittleCompassInternalRadius, StationPonterMode.TD}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.MARKPOINTType}})

------------------------------- Offse aimpoints --------------------------------
addPlaceholder("OAPRootPH", {0, 0}, TN_UP_Mode, {{"MPD_HSI_Navigation_Mark", NavType.OAPType}})
addPlaceholder("OAP_PH", {0, 0}, "OAPRootPH", {{"MPD_HSI_Navigation_StationSymbol", NavType.OAPType , LittleCompassInternalRadius, StationPonterMode.Normal}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.OAPType}})
addStrokeLine("OAPLine1", 20, {10,  0}, 90, "OAP_PH")
addStrokeLine("OAPLine2", 20, {0,  -10}, 0, "OAP_PH")
addStrokeSymbol("OAPMark_TD", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, "OAPRootPH", {{"MPD_HSI_Navigation_StationSymbol", NavType.OAPType , LittleCompassInternalRadius, StationPonterMode.TD}, {"MPD_HSI_Waypoint_SymbolRotation", NavType.OAPType}})

-------------------------------- JDAM JSOW ---------------------------------
local JDAM_TGT_PNT = "JDAM_TGT_PNT"

local openingMask = openMaskArea(0, "PlusArea", {}, {}, {0, 0}, TN_UP_Mode, {{"MPD_HSI_IAM_Tgt_Pnt"}, {"MPD_HSI_IAM_Plus_Symb", LittleCompassInternalRadius}})
set_box_w_h(openingMask, 16, 16)

addPlaceholder(JDAM_TGT_PNT, {0, 0}, TN_UP_Mode, {{"MPD_HSI_IAM_Tgt_Pnt"}})
addStrokeSymbol("PPMark_Symbol", {"stroke_symbols_MDI_AMPCD", "JDAM-Target"}, "FromSet", {0, 0}, JDAM_TGT_PNT, {{"MPD_HSI_IAM_TGT_Symbol", LittleCompassInternalRadius, 0}})
addStrokeBox("TOO_diamond_box", 18, 18, "CenterCenter", nil, JDAM_TGT_PNT, {{"MPD_HSI_IAM_TGT_Symbol", LittleCompassInternalRadius, 1}})

addStrokeSymbol("LPMark_Symbol", {"stroke_symbols_MDI_AMPCD", "PrePlanned-Launch-Point"}, "FromSet", {0, 0}, TN_UP_Mode, {{"MPD_HSI_LP_Symbol", LittleCompassInternalRadius}})
addStrokeCircle("InRngLAR", 10, {0, 0}, JDAM_TGT_PNT, {{"MPD_HSI_InRngLAR_Circles", LittleCompassInternalRadius, 0}})
addStrokeCircle("MINRngLAR", 10, {0, 0}, JDAM_TGT_PNT, {{"MPD_HSI_InRngLAR_Circles", LittleCompassInternalRadius, 1}})
addVarLenStrokeLine("DefaultToTgtLine", 10, {0, 0}, 0, "InRngLAR", {{"MPD_HSI_DefaultToTgtLineLen", LittleCompassInternalRadius}}, true, 15, 10)
addStrokeLine("Predictive_Max_Range", 20, {-10, 0}, -90, "InRngLAR", {{"MPD_HSI_Predictive_Max_Range", LittleCompassInternalRadius}})
addStrokeLine("Terminal_Heading", 40, {0, 0}, 0, "PPMark_Symbol", {{"MPD_HSI_PP_Terminal_Heading"}})
addStrokeLine("Bearing_To_LP", 80, {0, 0}, 0, "LPMark_Symbol", {{"MPD_HSI_Bearing_To_LP"}})

addPlaceholder("DynInZoneLAR_Ref_Pnt", {0, 0}, TN_UP_Mode, {{"MPD_HSI_IAM_DynInZoneLAR_Pnt", LittleCompassInternalRadius}})
addVarLenStrokeLine("DynInZoneLAR1", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt", {{"MPD_HSI_DynInZoneLAR", LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("DynInZoneLAR2", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt", {{"MPD_HSI_DynInZoneLAR", LittleCompassInternalRadius, 1}})
addStrokeCircle("DynInZoneLAR_Min", 10, {0, 0}, "DynInZoneLAR_Ref_Pnt", {{"MPD_HSI_DynInZoneLAR_Rng", LittleCompassInternalRadius, 0}})
addStrokeCircle("DynInZoneLAR_Max", 10, {0, 0}, "DynInZoneLAR_Ref_Pnt", {{"MPD_HSI_DynInZoneLAR_Rng", LittleCompassInternalRadius, 1}})

addPlaceholder("DynInZoneLAR_Ref_Pnt1", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt", LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_1", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt1", {{"MPD_HSI_DynInZoneLAR_GBU24", LittleCompassInternalRadius, 0}})
addPlaceholder("DynInZoneLAR_Ref_Pnt2", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt", LittleCompassInternalRadius, 1}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_2", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt2", {{"MPD_HSI_DynInZoneLAR_GBU24", LittleCompassInternalRadius, 1}})
addPlaceholder("DynInZoneLAR_Ref_Pnt3", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt", LittleCompassInternalRadius, 2}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_3", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt3", {{"MPD_HSI_DynInZoneLAR_GBU24", LittleCompassInternalRadius, 2}})
addPlaceholder("DynInZoneLAR_Ref_Pnt4", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt", LittleCompassInternalRadius, 3}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_4", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt4", {{"MPD_HSI_DynInZoneLAR_GBU24", LittleCompassInternalRadius, 3}})


addPlaceholder("DynInZoneLAR_Ref_Pnt1_PP", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt_PP", LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_1_PP", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt1_PP", {{"MPD_HSI_DynInZoneLAR_GBU24_PP", LittleCompassInternalRadius, 0}}, true, 10, 5, "INDICATION_COMMON_AMBER")
addPlaceholder("DynInZoneLAR_Ref_Pnt2_PP", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt_PP", LittleCompassInternalRadius, 1}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_2_PP", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt2_PP", {{"MPD_HSI_DynInZoneLAR_GBU24_PP", LittleCompassInternalRadius, 1}}, true, 10, 5, "INDICATION_COMMON_AMBER")
addPlaceholder("DynInZoneLAR_Ref_Pnt3_PP", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt_PP", LittleCompassInternalRadius, 2}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_3_PP", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt3_PP", {{"MPD_HSI_DynInZoneLAR_GBU24_PP", LittleCompassInternalRadius, 2}}, true, 10, 5, "INDICATION_COMMON_AMBER")
addPlaceholder("DynInZoneLAR_Ref_Pnt4_PP", {0, 0}, TN_UP_Mode, {{"MPD_HSI_GBU24_DynInZoneLAR_Pnt_PP", LittleCompassInternalRadius, 3}})
addVarLenStrokeLine("DynInZoneLAR_GBU24_4_PP", 10, {0, 0}, 0, "DynInZoneLAR_Ref_Pnt4_PP", {{"MPD_HSI_DynInZoneLAR_GBU24_PP", LittleCompassInternalRadius, 3}}, true, 10, 5, "INDICATION_COMMON_AMBER")



addPlaceholder("Plus_Symb", {0,0}, TN_UP_Mode, {{"MPD_HSI_IAM_Tgt_Pnt"}, {"MPD_HSI_IAM_Plus_Symb", LittleCompassInternalRadius}})
local PlusCue1 = addStrokeLine("Plus_Symb1", 6, {0, 0}, 0, "Plus_Symb")
setClipLevel(PlusCue1, 1)
local PlusCue2 = addStrokeLine("Plus_Symb2", 6, {0, 0}, 180, "Plus_Symb")
setClipLevel(PlusCue2, 1)
local PlusCue3= addStrokeLine("Plus_Symb3", 6, {0, 0}, 90, "Plus_Symb")
setClipLevel(PlusCue3, 1)
local PlusCue4= addStrokeLine("Plus_Symb4", 6, {0, 0}, -90, "Plus_Symb")
setClipLevel(PlusCue4, 1)

closeMaskArea(1, "PlusAreaClose", openingMask.vertices, openingMask.indices, openingMask.init_pos, TN_UP_Mode, {{"MPD_HSI_IAM_Tgt_Pnt"}, {"MPD_HSI_IAM_Plus_Symb", LittleCompassInternalRadius}})

-------------------------------- HARPOON ---------------------------------
local HARPOON_HPTP = "HARPOON_HPTP"
addPlaceholder(HARPOON_HPTP, {0, 0}, TN_UP_Mode, {{"MPD_HSI_HARPOON_HPTP", LittleCompassInternalRadius}})

local openingMask1 = openMaskArea(0, "HPTPArea", {}, {}, {0, 0}, HARPOON_HPTP, {{"MPD_HSI_HARPOON_HPTP_Symb"}})
set_box_w_h(openingMask1, 14, 14)

addStrokeCircle("HARPOON_HPTP_SYMB", 10, {0, 0}, HARPOON_HPTP, {{"MPD_HSI_HARPOON_HPTP_Symb"}})
addVarLenStrokeLine("HARPOON_HPTP_L1", 30, {0, 0}, 90, "HARPOON_HPTP_SYMB", {{"MPD_HSI_HARPOON_HPTP_L"}})
addVarLenStrokeLine("HARPOON_HPTP_L2", 30, {0, 0}, 180, "HARPOON_HPTP_SYMB", {{"MPD_HSI_HARPOON_HPTP_L"}})
addVarLenStrokeLine("HarpoonHPTPBrgLine", 150, {0, 0}, 0, "HARPOON_HPTP_SYMB", {{"MPD_HSI_HARPOON_HPTP_Bearing_Line", LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("HarpoonHPTPBrgLineStroke", 150, {0, 0}, 0, "HARPOON_HPTP_SYMB", {{"MPD_HSI_HARPOON_HPTP_Bearing_Line", LittleCompassInternalRadius, 1}}, true, 15, 10)

local HARPOON_DESTR_PNT = "HARPOON_DESTR_PNT"
addPlaceholder(HARPOON_DESTR_PNT, {0, 0}, HARPOON_HPTP, {{"MPD_HSI_HARPOON_DESTR_PNT", LittleCompassInternalRadius}})

addPlaceholder("DestrPnt", {0, 0}, HARPOON_DESTR_PNT, {{"MPD_HSI_HARPOON_Destr_Symb"}})
addStrokeLine("HarpoonDestrPnt1", 20, {0, 0}, 45, "DestrPnt")
addStrokeLine("HarpoonDestrPnt2", 20, {0, 0}, -45, "DestrPnt")
addStrokeLine("HarpoonDestrPnt3", 20, {0, 0}, 135, "DestrPnt")
addStrokeLine("HarpoonDestrPnt4", 20, {0, 0}, -135, "DestrPnt")

addVarLenStrokeLine("HarpoonBrgLine", 150, {0, 0}, 180, HARPOON_DESTR_PNT, {{"MPD_HSI_HARPOON_Bearing_Line", LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("HarpoonBrgLineStroke", 150, {0, 0}, 180, HARPOON_DESTR_PNT, {{"MPD_HSI_HARPOON_Bearing_Line", LittleCompassInternalRadius, 1}}, true, 15, 10)

addPlaceholder("SrchPnt", {0, 0}, "DestrPnt", {{"MPD_HSI_HARPOON_Srch", LittleCompassInternalRadius}})
addStrokeLine("HarpoonSrchLine", 20, {10, 0}, 90, "SrchPnt")

addPlaceholder("BOLRmaxPnt", {0, 0}, "DestrPnt", {{"MPD_HSI_HARPOON_RMAX", LittleCompassInternalRadius}})
addStrokeLine("HarpoonRmaxLine", 40, {15, 0}, 90, "BOLRmaxPnt")

closeMaskArea(1, "HPTPAreaClose", openingMask1.vertices, openingMask1.indices, openingMask1.init_pos, HARPOON_HPTP, {{"MPD_HSI_HARPOON_HPTP_Symb"}})


---------------------------------- PB LABELS ---------------------------------- 
MenuPageSublevel = 
{
	HSI_MAIN_MENU_PAGE			= 0,
	HSI_SUBMENU_MODE_PAGE		= 1,
	HSI_SUBMENU_VEC_PAGE		= 2,
	HSI_SUBMENU_POS_PAGE		= 3,
	HSI_SUBMENU_UPDATE_PAGE		= 4,
	HSI_SUBMENU_ACPT_REJ_PAGE	= 5,
	HSI_SUBMENU_UPDATING_PAGE	= 6,
}

MenuPageSublevel_16_20 =
{
	HSI_MENU_16_20_MAIN		= 0,
	HSI_MENU_16_20_IFA		= 1,
	HSI_MENU_16_20_CV		= 2,
}


----------------------------- NORMAL MODE ----------------------------- 
local Main_Name_1_5 = "HSI_Main_Root_PB_1_5"
addPlaceholder(Main_Name_1_5, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_1_5", MenuPageSublevel.HSI_MAIN_MENU_PAGE}})
add_PB_label(2, 	{"VEC", 	Main_Name_1_5, nil, {{"MPD_HSI_VEC_NavMode_Box"}}})
add_PB_label(3, 	{"MODE", 	Main_Name_1_5})
add_PB_label(4, 	{"ILS", 	Main_Name_1_5, {{"MPD_HSI_Main_ILS_VisibleState"}}, {{"MPD_HSI_Main_ILS_Box"}}})
add_PB_label(5, 	{"TCN", 	Main_Name_1_5, nil, {{"MPD_HSI_Main_TCN_Box"}}})

local Main_Name_6_10 = "HSI_Main_Root_PB_6_10"
addPlaceholder(Main_Name_6_10, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_6_10", MenuPageSublevel.HSI_MAIN_MENU_PAGE}})
add_PB_label(6, 	{"", Main_Name_6_10, {{"MPD_HSI_POS_Keeping"}}})
add_PB_label(7, 	{"UPDT", 	Main_Name_6_10, {{"MPD_HSI_UPOD_VisibleState"}}})
add_PB_label(8, 	{"", 		Main_Name_6_10, {{"MPD_HSI_Scaling"}}})
add_PB_label(9, 	{"   ", 	Main_Name_6_10, {{"MPD_HSI_Markpoint_addPoint"}}})
add_PB_label(10, 	{"DATA", 	Main_Name_6_10})

add_PB_label(11, {"WYPT", nil, {{"MPD_HSI_Waypoint_PB_Label"}}, {{"MPD_HSI_Waypoint_PB_Box"}}})
add_PB_symbol(12, "124-arrow-up")
add_PB_symbol(13, "124-arrow-down")
add_PB_label(14, {"WPDSG", nil, {{"MPD_HSI_Waypoint_TDLabel"}}})
add_PB_label(15, {"    ", nil, {{"MPD_HSI_WYPT_SequencePBLabel"}}, {{"MPD_HSI_WYPT_SequencePBBox"}}})

local Main_Name_16_20 = "HSI_Main_Root_PB_16_20"
addPlaceholder(Main_Name_16_20, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_16_20", MenuPageSublevel_16_20.HSI_MENU_16_20_MAIN}})
add_PB_label(16, {"AUTO",		Main_Name_16_20, nil, {{"MPD_HSI_AUTOBox"}}})
add_PB_label(17, {"TIMEUFC",	Main_Name_16_20, nil, {{"MPD_HSI_Main_TIMEUFC_Box"}}})
add_PB_label(19, {"STD HDG",	Main_Name_16_20, {{"MPD_HSI_STD_HDG", 0}}, {{"MPD_HSI_STD_HDG", 1}}})
add_PB_label(20, {"SENSORS",	Main_Name_16_20})

----------------------------- VIEW MODE -----------------------------
local Select_Compass_Rose_Name = "HSI_Select_Compass_Rose"
addPlaceholder(Select_Compass_Rose_Name, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_1_5", MenuPageSublevel.HSI_SUBMENU_MODE_PAGE}})
add_PB_label(1, {"SLEW", Select_Compass_Rose_Name})
add_PB_label(2, {"DCTR", Select_Compass_Rose_Name})
add_PB_label(3, {"MAP", Select_Compass_Rose_Name, {{"MPD_HSI_PB_Label_Main_PB_1_5", MenuPageSublevel.HSI_SUBMENU_MODE_PAGE}}, {{"MPD_HSI_MAP_PB_Box"}}})
add_PB_label(4, {"N UP", Select_Compass_Rose_Name})
add_PB_label(5, {"T UP", Select_Compass_Rose_Name})

----------------------------- VEC MODE -----------------------------
local Select_Vector_Navigation_Mode = "HSI_Select_Vector_Navigation_Mode"
addPlaceholder(Select_Vector_Navigation_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_1_5", MenuPageSublevel.HSI_SUBMENU_VEC_PAGE}})
add_PB_label(1,		{"L4", Select_Vector_Navigation_Mode})
add_PB_label(2,		{"RETURN", Select_Vector_Navigation_Mode})
add_PB_label(3,		{"L16", Select_Vector_Navigation_Mode})

----------------------------- POS MODE -----------------------------
local Select_Position_Keeping_Mode = "HSI_Select_Position_Keeping_Mode"
addPlaceholder(Select_Position_Keeping_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_6_10", MenuPageSublevel.HSI_SUBMENU_POS_PAGE}})
add_PB_label(6,		{"INS", Select_Position_Keeping_Mode})
add_PB_label(7,		{"TCN", Select_Position_Keeping_Mode})
add_PB_label(8,		{"ADC", Select_Position_Keeping_Mode})
add_PB_label(9,		{"GPS", Select_Position_Keeping_Mode})
add_PB_label(10,	{"HSI", Select_Position_Keeping_Mode})

----------------------------- UPDATE MODE -----------------------------
local Select_Update_Mode = "HSI_Select_Update_Mode"
addPlaceholder(Select_Update_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_6_10", MenuPageSublevel.HSI_SUBMENU_UPDATE_PAGE}})
add_PB_label(3,		{"CANCEL", Select_Update_Mode})
add_PB_label(4,		{"GPS", Select_Update_Mode})
add_PB_label(5,		{"VEL", Select_Update_Mode})
add_PB_label(6,		{"TCN", Select_Update_Mode})
add_PB_label(7,		{"DSG", Select_Update_Mode})
add_PB_label(8,		{"AUTO", Select_Update_Mode})
add_PB_label(9,		{"MAP", Select_Update_Mode})
add_PB_label(10,	{"HSI", Select_Update_Mode})

----------------------------- ACPT/REJ MODE -----------------------------
local Select_AcptRej_Mode = "HSI_Select_AcptRej_Mode"
addPlaceholder(Select_AcptRej_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_6_10", MenuPageSublevel.HSI_SUBMENU_ACPT_REJ_PAGE}})
add_PB_label(6,		{"ACPT", Select_AcptRej_Mode})
add_PB_label(10,	{"REJ", Select_AcptRej_Mode})

----------------------------- UPDATING MODE -----------------------------
local Select_Updating_Mode = "HSI_Select_Updating_Mode"
addPlaceholder(Select_Updating_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_6_10", MenuPageSublevel.HSI_SUBMENU_UPDATING_PAGE}})
add_PB_label(8,		{"AUTO", Select_Updating_Mode, nil, true})
add_PB_label(10,	{"HSI", Select_Updating_Mode})

----------------------------- IFA MODE -----------------------------
local Select_IFA_Mode = "HSI_Select_IFA_Mode"
addPlaceholder(Select_IFA_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_16_20", MenuPageSublevel_16_20.HSI_MENU_16_20_IFA}})
add_PB_label(17, {"SEA",		Select_IFA_Mode, nil, {{"MPD_HSI_IFA_SEA_Box"}}})
add_PB_label(19, {"LAND",		Select_IFA_Mode, nil, {{"MPD_HSI_IFA_LAND_Box"}}})
add_PB_label(20, {"CONT\nPVU ",	Select_IFA_Mode, {{"MPD_HSI_IFA_CONT_PVU_Display"}}, {{"MPD_HSI_IFA_CONT_PVU_Box"}}})

----------------------------- CV MODE -----------------------------
local Select_CV_Mode = "HSI_Select_CV_Mode"
addPlaceholder(Select_CV_Mode, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_16_20", MenuPageSublevel_16_20.HSI_MENU_16_20_CV}})
add_PB_label(16, {"AUTO",		Select_CV_Mode, nil, {{"MPD_HSI_AUTOBox"}}})
add_PB_label(17, {"MAN",		Select_CV_Mode, nil, {{"MPD_HSI_CV_MAN_Box"}}})
add_PB_label(19, {"STD HDG",	Select_CV_Mode, {{"MPD_HSI_STD_HDG", 0}}, {{"MPD_HSI_STD_HDG", 1}}})
add_PB_label(20, {"SENSORS",	Select_CV_Mode})
