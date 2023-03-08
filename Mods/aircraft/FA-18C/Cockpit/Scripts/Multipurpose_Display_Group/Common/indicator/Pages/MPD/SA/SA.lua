dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HSI/HSI_Definitions.lua")

local LEVELS = 
{
	LEVEL_TOP = 0,
	LEVEL_SENSOR = 1
}

local MODES = 
{
	TRACK_UP_MODE = 0,
	DECENTERED_MODE = 1
}

local TOP_LEVELS =
{
	BASE = 0,
	DCLTR = 1
}


------------------------------------------ DECLUTTER PLACEHOLDERS ------------------------------------------
local SA_DCLTR_REJ1_PH = addPlaceholder("SA Declutter REJ1", {0, 0}, nil, {SA_DeclutterREJ1_Show_controller})
local SA_DCLTR_REJ2_PH = addPlaceholder("SA Declutter REJ2", {0, 0}, nil, {SA_DeclutterREJ2_Show_controller})
local SA_DCLTR_MREJ1_PH = addPlaceholder("SA Declutter MREJ1", {0, 0}, nil, {SA_DeclutterMREJ1_Show_controller})
local SA_DCLTR_MREJ2_PH = addPlaceholder("SA Declutter MREJ2", {0, 0}, nil, {SA_DeclutterMREJ2_Show_controller})


------------------------------------------ TRACK UP MODE ------------------------------------------
local TopLevel_TrackUp_Root = "TopLevel_TrackUp_Root"
addPlaceholder(TopLevel_TrackUp_Root, {0, 0}, SA_DCLTR_REJ1_PH.name, {{"MPD_SA_ModeShow", MODES.TRACK_UP_MODE}, {"MPD_SA_CompasRoseRotate"}})
drawCompass(400, TopLevel_TrackUp_Root, {{"MPD_SA_Compass_Label"}})
addStrokeSymbol("aircraft_Track_UP", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, -25}, nil, {{"MPD_SA_ModeShow", MODES.TRACK_UP_MODE}, {"MPD_SA_EXP_PlanePos", LittleCompassInternalRadius}})
addStrokeSymbol("Ground_Track_Pointer_Track_UP", {"stroke_symbols_MDI_AMPCD", "130-ground-track-pointer"}, "FromSet", nil, TopLevel_TrackUp_Root, {{"MPD_SA_GroundTrackPointer", 355}})

local NavType =
{
	TACAN	= 0,
	WYPT	= 1,
}

local TACANMarkNameNTU = "TACANMarkRootBackup"
addPlaceholder(TACANMarkNameNTU, {0, 0}, TopLevel_TrackUp_Root, {{"MPD_SA_Navigation_Mark", NavType.TACAN}})
addStrokeSymbol("TACANMark_Front_NUT", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-front"}, "FromSet", {0, 440}, TACANMarkNameNTU)
addStrokeSymbol("TACANMark_Back_NUT", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-back"}, "FromSet", {0, -440}, TACANMarkNameNTU)

local WYPTMarkNameBackup = "WYPTMarkRootBackup"
local offsetForWYPTMark = 362
addPlaceholder(WYPTMarkNameBackup, {0, 0}, TopLevel_TrackUp_Root, {{"MPD_SA_Navigation_Mark", NavType.WYPT}})
addStrokeSymbol("WYPTMark_Front_NUT", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-head-mark"}, "FromSet", {0, offsetForWYPTMark + 5}, WYPTMarkNameBackup)
addStrokeSymbol("WYPTMark_Back_NUT", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-tail-mark"}, "FromSet", {0, -offsetForWYPTMark}, WYPTMarkNameBackup)

----------------------------------------- DECENTERED MODE -----------------------------------------
local openingMask = openMaskArea(0, "HSI_Mask", {}, {}, {0, 0})
set_box_w_h(openingMask, 850, 900)
local clippedObject

local SA_DCNTR_DCLTR_REJ1_PH = addPlaceholder("SA Decentered Declutter REJ1", {0, 0}, nil, {SA_DeclutterREJ1_Show_controller})
local TopLevel_Decentered_Root = "TopLevel_Decentered_Root"
addPlaceholder(TopLevel_Decentered_Root, {0, offsetDecenterPivot}, SA_DCNTR_DCLTR_REJ1_PH.name, {{"MPD_SA_ModeShow", MODES.DECENTERED_MODE}, {"MPD_SA_CompasRoseRotate"}})
drawCompass(760, TopLevel_Decentered_Root, {{"MPD_SA_Compass_Label"}}, true)
clippedObject = addStrokeSymbol("aircraft_CourseRoseMode_Decentered", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, offsetDecenterPivot}, nil, {{"MPD_SA_ModeShow", MODES.DECENTERED_MODE}, {"MPD_SA_EXP_PlanePos", LittleCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("Ground_Track_Pointer_Decentered", {"stroke_symbols_MDI_AMPCD", "130-ground-track-pointer"}, "FromSet", nil, TopLevel_Decentered_Root, {{"MPD_SA_ModeShow", MODES.DECENTERED_MODE}, {"MPD_SA_GroundTrackPointer", 730}})
setClipLevel(clippedObject, 1)

-- TACAN marks for Decentered mode
local TACANMarkNameDCTR = "TACANMarkRootDecentered"
clippedObject = addPlaceholder(TACANMarkNameDCTR, {0, 0}, TopLevel_Decentered_Root, {{"MPD_SA_Navigation_Mark", NavType.TACAN}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("TACANMark_Front_DCTR", {"stroke_symbols_MDI_AMPCD", "TACAN-mark-front"}, "FromSet", {0, 800}, TACANMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("TACANMark_Back_DCTR", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-back"}, "FromSet", {0, -800}, TACANMarkNameDCTR)
setClipLevel(clippedObject, 1)

-- WYPT marks for Decentered mode
local WYPTMarkNameDCTR = "WYPTMarkRootDecentered"
clippedObject = addPlaceholder(WYPTMarkNameDCTR, {0, 0}, TopLevel_Decentered_Root, {{"MPD_SA_Navigation_Mark", NavType.WYPT}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_Front_DCTR", {"stroke_symbols_MDI_AMPCD", "Waypoint-head-mark"}, "FromSet", {0, 720}, WYPTMarkNameDCTR)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("WYPTMark_Back_DCTR", 	{"stroke_symbols_MDI_AMPCD", "Waypoint-tail-mark"}, "FromSet", {0, -720}, WYPTMarkNameDCTR)
setClipLevel(clippedObject, 1)

closeMaskArea(1, "HSI_MaskClose", openingMask.vertices, openingMask.indices, openingMask.init_pos)

-------------------------------------------- DATA WINDOW --------------------------------------------
local YTInfo = 400	--T - top
local TRCSpaceBetweenRow = 30

local XLCInfo = -450	--LC - left corner
addStrokeText("Window_1", "WINDOW 1", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YTInfo},								SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window1"}}, {"%03d°/%5.1f", "%03d°"})
addStrokeText("Window_2", "WINDOW 2", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo + 30, YTInfo - TRCSpaceBetweenRow},		SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window2"}})
addStrokeText("Window_3", "WINDOW 3", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo + 30, YTInfo - TRCSpaceBetweenRow * 2},	SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window3"}})
addStrokeText("Window_4", "WINDOW 4", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YTInfo - TRCSpaceBetweenRow * 3},	SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window4"}})

addStrokeText("Window_5", "WINDOW 5", STROKE_FNT_DFLT_120, "CenterCenter", {0, YTInfo},									SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window5"}})

local XRCInfo = 450	--RC - right corner
addStrokeText("Window_6", "WINDOW 6", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YTInfo},							SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window6"}}, {"%03d/%5.1f", "%03d", "     %5.1f"})
addStrokeText("Window_7", "WINDOW 7", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YTInfo - TRCSpaceBetweenRow},		SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window7"}})
addStrokeText("Window_8", "WINDOW 8", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YTInfo - TRCSpaceBetweenRow * 2},	SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window8"}})
addStrokeText("Window_9", "WINDOW 9", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YTInfo - TRCSpaceBetweenRow * 3},	SA_DCLTR_REJ2_PH.name, {{"MPD_SA_Window9"}})

local YBInfo = -340	--B - bottom
addStrokeText("Window_10", "WINDOW 10", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YBInfo}, nil, {{"MPD_SA_Window10"}})
addStrokeText("Window_11", "WINDOW 11", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YBInfo - TRCSpaceBetweenRow}, nil, {{"MPD_SA_Window11"}})
addStrokeText("Window_12", "WINDOW 12", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YBInfo - TRCSpaceBetweenRow * 2}, nil, {{"MPD_SA_Window12"}})
addStrokeText("Window_13", "WINDOW 13", STROKE_FNT_DFLT_120, "LeftCenter", {XLCInfo, YBInfo - TRCSpaceBetweenRow * 3}, nil, {{"MPD_SA_Window13"}})

addStrokeText("Window_14", "WINDOW 14", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YBInfo}, nil, {{"MPD_SA_Window14"}})
addStrokeText("Window_15", "WINDOW 15", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YBInfo - TRCSpaceBetweenRow}, nil, {{"MPD_SA_Window15"}}, {"%s / %.1f", "%d / %03d"})
addStrokeText("Window_16", "WINDOW 16", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YBInfo - TRCSpaceBetweenRow * 2}, nil, {{"MPD_SA_Window16"}}, {"BRA %03d/%d"})
addStrokeText("Window_17", "WINDOW 17", STROKE_FNT_DFLT_120, "RightCenter", {XRCInfo, YBInfo - TRCSpaceBetweenRow * 3}, nil, {{"MPD_SA_Window17"}}, {"BE %03d/%d"})

addStrokeText("Window_18", "WINDOW 18", STROKE_FNT_DFLT_120, "CenterCenter", {0, YBInfo - TRCSpaceBetweenRow * 3}, nil, {{"MPD_SA_Window18"}})

------------------------------------------------ PROGRESS BARs ------------------------------------------------
local CustomStrDef = {fontScaleY_120, 13 * GetScale() , 4 * GetScale(), fontInterlineDflt120 * GetScale()}

local BoxSizeX = 100
local BoxSizeY = 24
local segmentSize = 3
local boxXOffset = 155

local ProgressBarsRoot = "ProgressBars_Root"
addPlaceholder(ProgressBarsRoot, nil, nil, {{"MPD_SA_ProgressBars_Show"}})

addStrokeText("Chaff_ProgressBar_Label", nil, CustomStrDef, "LeftCenter", {XLCInfo - 25, YBInfo}, ProgressBarsRoot, {{"MPD_SA_ProgressBar_ChaffLabel"}})
addStrokeBoxDashed("Chaff_ProgressBar_Box", BoxSizeX, BoxSizeY, segmentSize, segmentSize, {boxXOffset, 0}, "Chaff_ProgressBar_Label")
addFillAreaWithLines("Chaff_ProgressBar", BoxSizeX - 2, BoxSizeY - 2, nil, "Chaff_ProgressBar_Box", {{"MPD_SA_ProgressBar_ChaffLength", BoxSizeX - 2}})

addStrokeText("Flares_ProgressBar_Label", nil, CustomStrDef, "LeftCenter", {XLCInfo - 25, YBInfo - TRCSpaceBetweenRow}, ProgressBarsRoot, {{"MPD_SA_ProgressBar_FlaresLabel"}})
addStrokeBoxDashed("Flares_ProgressBar_Box", BoxSizeX, BoxSizeY, segmentSize, segmentSize, {boxXOffset, 0}, "Flares_ProgressBar_Label")
addFillAreaWithLines("Flares_ProgressBar", BoxSizeX - 2, BoxSizeY - 2, nil, "Flares_ProgressBar_Box", {{"MPD_SA_ProgressBar_FlaresLength", BoxSizeX - 2}})

addStrokeText("GEN_X_01_ProgressBar_Label", nil, CustomStrDef, "LeftCenter", {XLCInfo - 25, YBInfo - TRCSpaceBetweenRow * 2}, ProgressBarsRoot, {{"MPD_SA_ProgressBar_GENXO1Label"}})
addStrokeBoxDashed("GEN_X_01_ProgressBar_Box", BoxSizeX, BoxSizeY, segmentSize, segmentSize, {boxXOffset, 0}, "GEN_X_01_ProgressBar_Label")
addFillAreaWithLines("GEN_X_01_ProgressBar", BoxSizeX - 2, BoxSizeY - 2, nil, "GEN_X_01_ProgressBar_Box", {{"MPD_SA_ProgressBar_GENXO1Length", BoxSizeX - 2}})

addStrokeText("GEN_X_02_ProgressBar_Label", nil, CustomStrDef, "LeftCenter", {XLCInfo - 25, YBInfo - TRCSpaceBetweenRow * 3}, ProgressBarsRoot, {{"MPD_SA_ProgressBar_GENXO2Label"}})
addStrokeBoxDashed("GEN_X_02_ProgressBar_Box", BoxSizeX, BoxSizeY, segmentSize, segmentSize, {boxXOffset, 0}, "GEN_X_02_ProgressBar_Label")
addFillAreaWithLines("GEN_X_02_ProgressBar", BoxSizeX - 2, BoxSizeY - 2, nil, "GEN_X_02_ProgressBar_Box", {{"MPD_SA_ProgressBar_GENXO2Length", BoxSizeX - 2}})

-------------------------------------------------- Waypoints --------------------------------------------------
local SA_Sequence_Root = "SA_Sequence_Root"
addPlaceholder(SA_Sequence_Root, nil, nil, {{"MPD_SA_Waypoint_SequenceRoot", offsetDecenterPivot}})
for i = 0, 13 do
	addVarLenStrokeLine("WYPTSeqLine_"..i, 80, nil, nil, SA_Sequence_Root, {{"MPD_SA_Waypoint_SequenceLine", i, LittleCompassInternalRadius, BigCompassInternalRadius}}, true, 10, 10)
end

local WaypointSymbol_Root = "WaypointSymbol_Root"
addPlaceholder(WaypointSymbol_Root, nil, nil, {{"MPD_SA_Waypoint_SymbolRoot", offsetDecenterPivot, 0}})
addPlaceholder("WaypointSymbolPos_Root", nil, WaypointSymbol_Root, {{"MPD_SA_Waypoint_SymbolPos", LittleCompassInternalRadius, BigCompassInternalRadius, 0}})

addStrokeSymbol("WaypointSymbol", {"stroke_symbols_MDI_AMPCD", "Waypoint-symbol"}, "FromSet", {0, 0}, "WaypointSymbolPos_Root", {{"MPD_SA_Waypoint_Type", 0}})

addStrokeSymbol("TD_Symbol", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, "WaypointSymbolPos_Root", {{"MPD_SA_Waypoint_Type", 1}})

local BullseyeSymbol_Root = "BullseyeSymbol_Root"
addPlaceholder(BullseyeSymbol_Root, nil, nil, {{"MPD_SA_Bullseye_SymbolRoot", offsetDecenterPivot}})
addStrokeCircle("BullseyeSymbol", 30, nil, BullseyeSymbol_Root, {{"MPD_SA_Bullseye_SymbolPos", LittleCompassInternalRadius, BigCompassInternalRadius}})
addPlaceholder("BullseyeSymbol_Arrow_Root", nil, "BullseyeSymbol", {{"MPD_SA_Bullseye_TrueCourse"}})
addStrokeSymbol("BullseyeSymbol_Arrow", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "FromSet", {0, 45}, "BullseyeSymbol_Arrow_Root")
addStrokeText("BullseyeNumber", nil, STROKE_FNT_DFLT_120, "CenterCenter", nil, "BullseyeSymbol", {{"MPD_SA_Bullseye_Number"}})

------------------------------- Offse aimpoints --------------------------------
addPlaceholder("OAPSymbol_Root", nil, nil, {{"MPD_SA_Waypoint_SymbolRoot", offsetDecenterPivot, 1}})
addPlaceholder("OAPRootPH", nil, "OAPSymbol_Root", {{"MPD_SA_Waypoint_SymbolPos", LittleCompassInternalRadius, BigCompassInternalRadius, 1}})
addStrokeLine("OAPLine1", 20, {10,  0}, 90, "OAPRootPH", {{"MPD_SA_Waypoint_Type", 3}})
addStrokeLine("OAPLine2", 20, {0,  -10}, 0, "OAPRootPH", {{"MPD_SA_Waypoint_Type", 3}})
addStrokeSymbol("TD_OAPSymbol", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, 0}, "OAPRootPH", {{"MPD_SA_Waypoint_Type", 2}})

--------------------------------------------------- EW DATA ---------------------------------------------------
local ewRootName = "SA_EW_Root"
addPlaceholder(ewRootName, {0, 0}, nil, {{"MPD_SA_EW_Show"}})

local EW_LittleCompasRadius = 360
local EW_BigCompasRadius = 720
local EW_Symbol_Scale = 1.65

local function AddEwSymbol(num, level)
	local EW_Symbol_Root = "EW_Symbol_Root"..num
	local clippedObject
	addPlaceholder(EW_Symbol_Root, {0, 0}, ewRootName, {{"MPD_SA_EW_Symbol_Pos", num, EW_LittleCompasRadius, EW_BigCompasRadius, offsetDecenterPivot}})
	clippedObject = addStrokeSymbol("SA_EW_Symbol_Main"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol"}, "FromSet", nil, EW_Symbol_Root, {{"MPD_SA_EW_Symbol_Rotate", num}}, EW_Symbol_Scale)
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeText("SA_EW_ThreatSymbol"..num, "", STROKE_FNT_DFLT_100, "CenterCenter", nil, EW_Symbol_Root, {{"MPD_SA_EW_ThreatSymbol", num}})
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeSymbol("SA_EW_Symbol_SecondLine"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol-Second-Line"}, "FromSet", nil, "SA_EW_Symbol_Main"..num, {{"MPD_SA_EW_PriorityLine", num, 2}}, EW_Symbol_Scale)
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeSymbol("SA_EW_Symbol_ThirdLine"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol-Third-Line"}, "FromSet", nil, "SA_EW_Symbol_Main"..num, {{"MPD_SA_EW_PriorityLine", num, 1}}, EW_Symbol_Scale)
	setClipLevel(clippedObject, level)
end

local EW_Indices = {0, 1, 2}
local EW_SymWidth = 48 * EW_Symbol_Scale
local EW_SymHeight = 42 * EW_Symbol_Scale
local EW_Vertices = 
{
	{-EW_SymWidth / 2, EW_SymHeight / 2},
	{ EW_SymWidth / 2, EW_SymHeight / 2},
	{ 0, -EW_SymHeight / 2}	
}

local openingMaskEW = openMaskArea(0, "EW_Mask", EW_Vertices, EW_Indices, {0, -5 * EW_Symbol_Scale }, ewRootName, {{"MPD_SA_EW_Symbol_Pos", 0, EW_LittleCompasRadius, EW_BigCompasRadius, offsetDecenterPivot}})
for i = 1,4 do
	local num = i-1
	local level = 0
	if i == 1 then
		level = 1
	end

	AddEwSymbol(num, level)
end
closeMaskArea(1, "EW_Mask_Close", openingMaskEW.vertices, openingMaskEW.indices, openingMaskEW.init_pos)

-------------------------------------------- FLIR POINT --------------------------------------------
local FLIR_PointPH = addPlaceholder("SA FLIR Point PH", {0, 0}, nil, {{"MPD_SA_FLIR_Point", LittleCompassInternalRadius, BigCompassInternalRadius, offsetDecenterPivot}})
addStrokeBox("SA FLIR Point box", 20, 20, "CenterCenter", {0, 0}, FLIR_PointPH.name)
addStrokeCircle("SA FLIR Point dot", 1, nil, FLIR_PointPH.name)

-------------------------------------------- TOP LEVEL --------------------------------------------

-- TDC Cursor
addMPD_TDC_diamond()
local TDC_Root = "TDC_Root"
local TDCLineLen = 80
local TDCLineOffset = 40
local TDCLabelOffsetX = TDCLineOffset + 10
local TDCLabelOffsetY = TDCLineLen / 4
addPlaceholder(TDC_Root, {0, 0}, nil, {{"TDC_assignedDisplay"}, {"MPD_SA_TDCPosition", 512}})
addStrokeLine("TDC_Line_Right", TDCLineLen, {TDCLineOffset, -TDCLineLen / 2}, 0, TDC_Root, {{"MPD_SA_SetYellowColor"}})
addStrokeLine("TDC_Line_Left", TDCLineLen, {-TDCLineOffset, -TDCLineLen / 2}, 0, TDC_Root, {{"MPD_SA_SetYellowColor"}})
addStrokeText("TDC_MaxAltitude", nil, STROKE_FNT_DFLT_100, "RightCenter", {-TDCLabelOffsetX, TDCLabelOffsetY}, TDC_Root, {{"MPD_SA_TDCAltitude_Max"}, {"MPD_SA_SetYellowColor"}})
addStrokeText("TDC_RelativeAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {TDCLabelOffsetX, TDCLabelOffsetY}, TDC_Root, {{"MPD_SA_TDCAltitude_Relative"}, {"MPD_SA_SetYellowColor"}})

-- Step Cursor
local SC_PH = addPlaceholder("SC PH", {0, 0}, nil, {{"MPD_SA_SC_Position", 512}})
addStrokeBox("SC Box", 250, 60, "CenterCenter", {0, 0}, SC_PH.name, {{"MPD_SA_SetYellowColor"}})
addStrokeText("SC Mach", "X.X", STROKE_FNT_DFLT_100, "RightCenter", {-40, 0}, SC_PH.name, {{"MPD_SA_SC_Mach"}, {"MPD_SA_SetYellowColor"}})
addStrokeText("SC Rel Alt", "XX", STROKE_FNT_DFLT_100, "LeftCenter", {40, 0}, SC_PH.name, {{"MPD_SA_SC_RelAlt"}, {"MPD_SA_SetYellowColor"}})


-------------------------------------------- TOP LEVEL PUSHBUTTONs --------------------------------------------
local TopLevelPBs_Root = "TopLevelPBs_Root"
addPlaceholder(TopLevelPBs_Root, {0, 0}, nil, {{"MPD_SA_PBsLevelShow", LEVELS.LEVEL_TOP}})

local PLID_PH = addPlaceholder("PLID PBs Placeholder", {0, 0}, TopLevelPBs_Root, nil)
add_PB_label(2, {"PLID", PLID_PH.name, {{"MPD_SA_PLID_Enabled"}}})

local PLID_Track_PH = addPlaceholder("PLID Tracks PBs Placeholder", {0, 0}, TopLevelPBs_Root, {{"MPD_SA_PLID_Track"}})
add_PB_label(2, {"UNK", PLID_Track_PH.name})
add_PB_label(3, {"HOS", PLID_Track_PH.name})
add_PB_label(4, {"FRND", PLID_Track_PH.name})

--local PLID_PPLI_PH = addPlaceholder("PLID PPLI PBs Placeholder", {0, 0}, TopLevelPBs_Root, {{"MPD_SA_PLID_PPLI"}})
--add_PB_label(4, {"C2", PLID_PPLI_PH.name})

add_PB_label(5, {"SENSR", TopLevelPBs_Root})

local TopLevelPBs_6_10_Root = "TopLevelPBs_6_10_Root"
addPlaceholder(TopLevelPBs_6_10_Root, {0, 0}, TopLevelPBs_Root, {{"MPD_SA_PBs_6_10_TopLevelShow", TOP_LEVELS.BASE}})
add_PB_label(6,		{"MAP",		TopLevelPBs_6_10_Root, nil, {{"MPD_SA_MapShow"}}})

local pb7_dcltr = add_PB_label(7,		{"DCLTR",	TopLevelPBs_6_10_Root}, {"", TopLevelPBs_6_10_Root, {{"MPD_SA_DcltrLevel"}}})[2]
pb7_dcltr.formats =
{
	"",
	"REJ1",
	"REJ2",
	"MREJ1",
	"MREJ2",
}

add_PB_label(8,		{"",		TopLevelPBs_6_10_Root, {{"MPD_SA_Scaling"}}})
add_PB_label(9, 	{"   ", 	TopLevelPBs_6_10_Root, {{"MPD_SA_Markpoint_addPoint"}}})
add_PB_label(10,	{"DCNTR",	TopLevelPBs_6_10_Root, nil, {{"MPD_SA_ModeShow", MODES.DECENTERED_MODE}}})

local TopLevelPBs_6_10_Dcltr = "TopLevelPBs_6_10_Dcltr"
addPlaceholder(TopLevelPBs_6_10_Dcltr, {0, 0}, TopLevelPBs_Root, {{"MPD_SA_PBs_6_10_TopLevelShow", TOP_LEVELS.DCLTR}})
add_PB_label(6,		{"OFF",		TopLevelPBs_6_10_Dcltr, nil, {{"MPD_SA_DcltrSelectBox", SA_DCLTR_LEVELS.OFF}}})
add_PB_label(7,		{"REJ1",	TopLevelPBs_6_10_Dcltr, nil, {{"MPD_SA_DcltrSelectBox", SA_DCLTR_LEVELS.REJ1}}})
add_PB_label(8,		{"REJ2",	TopLevelPBs_6_10_Dcltr, nil, {{"MPD_SA_DcltrSelectBox", SA_DCLTR_LEVELS.REJ2}}})
add_PB_label(9,		{"MREJ1",	TopLevelPBs_6_10_Dcltr, nil, {{"MPD_SA_DcltrSelectBox", SA_DCLTR_LEVELS.MREJ1}}})
add_PB_label(10,	{"MREJ2",	TopLevelPBs_6_10_Dcltr, nil, {{"MPD_SA_DcltrSelectBox", SA_DCLTR_LEVELS.MREJ2}}})

add_PB_label(11, {"WYPT", TopLevelPBs_Root, {{"MPD_HSI_Waypoint_PB_Label"}}, {{"MPD_HSI_Waypoint_PB_Box"}}})
add_PB_symbol(12, "124-arrow-up", TopLevelPBs_Root)
addStrokeText("WYPT_Page_Number", "", STROKE_FNT_DFLT_100, "RightCenter", {505, 60}, TopLevelPBs_Root, {{"MPD_HSI_WYPT_Data_WaypointSelectedNumber"}})
add_PB_symbol(13, "124-arrow-down", TopLevelPBs_Root)
add_PB_label(14, {"WPDSG", TopLevelPBs_Root, {{"MPD_HSI_Waypoint_TDLabel"}}})
add_PB_label(15, {"    ", TopLevelPBs_Root, {{"MPD_HSI_WYPT_SequencePBLabel"}}, {{"MPD_HSI_WYPT_SequencePBBox"}}})

add_PB_label(16, {"AUTO", TopLevelPBs_Root, nil, {{"MPD_HSI_AUTOBox"}}})
add_PB_label(17, {"TXDSG", TopLevelPBs_Root, nil, {{"MPD_SA_TXDSG_Box"}}})
add_PB_label(19, {"STEP", TopLevelPBs_Root})
add_PB_label(20, {"EXP", TopLevelPBs_Root, {{"MPD_SA_EXP_Show"}}, {{"MPD_SA_EXP_Box"}}})
--------------------------------------------- SENSOR PUSHBUTTONs ----------------------------------------------
local SensorLevelPBs_Root = "SensorLevelPBs_Root"
addPlaceholder(SensorLevelPBs_Root, {0, 0}, nil, {{"MPD_SA_PBsLevelShow", LEVELS.LEVEL_SENSOR}})
local pb3 = add_PB_label(3, {"HARM", SensorLevelPBs_Root, nil, true})[1]
local pb4 = add_PB_label(4, {"FLTR", SensorLevelPBs_Root, nil, {{"MPD_SA_SENSOR_FLIR_Box"}}})[1]
local pb5 = add_PB_label(5, {"LINK4", SensorLevelPBs_Root, nil, true})[1]

local vBox_sizeX = 25
local vBox_sizeY = 124
local vBox_offsetX = 7
add_X_Over("SA_SENSOR_PB_3_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb3.name, {{"MPD_SA_SENSOR_HARM_NotEnabled"}})
add_X_Over("SA_SENSOR_PB_4_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb4.name, {{"MPD_SA_SENSOR_FLIR_NotEnabled"}})
add_X_Over("SA_SENSOR_PB_5_Break_X", 	vBox_sizeX, vBox_sizeY, {vBox_offsetX, 0}, pb5.name, {{"MPD_SA_SENSOR_LINK4_NotEnabled"}})

add_PB_label(6, {"IFF", SensorLevelPBs_Root})	-- no function
local pb7 = add_PB_label(7, {"RWR", SensorLevelPBs_Root, nil, {{"MPD_SA_SENSOR_RWR_Box"}}}, {"", SensorLevelPBs_Root, {{"MPD_SA_SENSOR_RWR_Select"}}})[3]
pb7.formats = {	"",
				"ALL",
				"CRIT\nLETH",
				"CRIT",
				}
local pb8 = add_PB_label(8, {"FRIEND", SensorLevelPBs_Root, nil, {{"MPD_SA_SENSOR_FRIEND_Box"}}}, {"", SensorLevelPBs_Root, {{"MPD_SA_SENSOR_FRIEND_Select"}}})[3]
pb8.formats = {	"OFF",
				"NO ID",
				"RWR ID",
				}
add_PB_label(9, {"UNK", SensorLevelPBs_Root, nil, {{"MPD_SA_SENSOR_UNK_Box"}}})
add_PB_label(10, {"SA", SensorLevelPBs_Root})

add_PB_label(11, {"OCS1", SensorLevelPBs_Root})	-- no function
add_PB_label(12, {"OCS2", SensorLevelPBs_Root})	-- no function
add_PB_label(13, {"F/F", SensorLevelPBs_Root, nil, {{"MPD_SA_FF_PB_Box"}}})
add_PB_label(14, {"PPLI", SensorLevelPBs_Root, nil, {{"MPD_SA_PPLI_PB_Box"}}})
add_PB_label(15, {"SURV", SensorLevelPBs_Root, nil, {{"MPD_SA_SURV_PB_Box"}}})

--------------------------------------------- Course Line -----------------------------------------------------
local TACANCourseLine_DCTR = "TACANCourseLineRoot_DCTR"
clippedObject = addPlaceholder(TACANCourseLine_DCTR, nil, TopLevel_Decentered_Root, {{"MPD_SA_Navigation_CourseLineCenter", NavType.TACAN, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("TACANCourseLine_up_DCTR", nil, nil, nil, TACANCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineLen", NavType.TACAN, BigCompassInternalRadius, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("TACANCourseLine_down_DCTR", nil, nil, nil, TACANCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineLen", NavType.TACAN, BigCompassInternalRadius, 1}})
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("TACANCourseLineArrow_DCTR", {0,  0}, TACANCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineArrow", NavType.TACAN, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("TACANCourseLine_head_left_DCTR", 20, {0,  0}, 150, "TACANCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("TACANCourseLine_head_right_DCTR", 20, {0,  0}, 210, "TACANCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)

local WYPTCourseLine_DCTR = "WYPTCourseLineRoot_DCTR"
clippedObject = addPlaceholder(WYPTCourseLine_DCTR, nil, TopLevel_Decentered_Root, {{"MPD_SA_Navigation_CourseLineCenter", NavType.WYPT, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("WYPTCourseLine_up_DCTR", nil, nil, nil, WYPTCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineLen", NavType.WYPT, BigCompassInternalRadius, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("WYPTCourseLine_down_DCTR", nil, nil, nil, WYPTCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineLen", NavType.WYPT, BigCompassInternalRadius, 1}})
setClipLevel(clippedObject, 1)
clippedObject = addPlaceholder("WYPTCourseLineArrow_DCTR", {0,  0}, WYPTCourseLine_DCTR, {{"MPD_SA_Navigation_CourseLineArrow", NavType.WYPT, BigCompassInternalRadius}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("WYPTCourseLine_head_left_DCTR", 20, {0,  0}, 150, "WYPTCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("WYPTCourseLine_head_right_DCTR", 20, {0,  0}, 210, "WYPTCourseLineArrow_DCTR")
setClipLevel(clippedObject, 1)

local TACANCourseLine = "TACANCourseLineRoot"
addPlaceholder(TACANCourseLine, nil, TopLevel_TrackUp_Root, {{"MPD_SA_Navigation_CourseLineCenter", NavType.TACAN, LittleCompassInternalRadius}})
addVarLenStrokeLine("TACANCourseLine_up", nil, nil, nil, TACANCourseLine, {{"MPD_SA_Navigation_CourseLineLen", NavType.TACAN, LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("TACANCourseLine_down", nil, nil, nil, TACANCourseLine, {{"MPD_SA_Navigation_CourseLineLen", NavType.TACAN, LittleCompassInternalRadius, 1}})
addPlaceholder("TACANCourseLineArrow", {0,  0}, TACANCourseLine, {{"MPD_SA_Navigation_CourseLineArrow", NavType.TACAN, LittleCompassInternalRadius}})
addStrokeLine("TACANCourseLine_head_left", 20, {0,  0}, 150, "TACANCourseLineArrow")
addStrokeLine("TACANCourseLine_head_right", 20, {0,  0}, 210, "TACANCourseLineArrow")

local WYPTCourseLine = "WYPTCourseLineRoot"
addPlaceholder(WYPTCourseLine, nil, TopLevel_TrackUp_Root, {{"MPD_SA_Navigation_CourseLineCenter", NavType.WYPT, LittleCompassInternalRadius}})
addVarLenStrokeLine("WYPTCourseLine_up", nil, nil, nil, WYPTCourseLine, {{"MPD_SA_Navigation_CourseLineLen", NavType.WYPT, LittleCompassInternalRadius, 0}})
addVarLenStrokeLine("WYPTCourseLine_down", nil, nil, nil, WYPTCourseLine, {{"MPD_SA_Navigation_CourseLineLen", NavType.WYPT, LittleCompassInternalRadius, 1}})
addPlaceholder("WYPTCourseLineArrow", {0,  0}, WYPTCourseLine, {{"MPD_SA_Navigation_CourseLineArrow", NavType.WYPT, LittleCompassInternalRadius}})
addStrokeLine("WYPTCourseLine_head_left", 20, {0,  0}, 150, "WYPTCourseLineArrow")
addStrokeLine("WYPTCourseLine_head_right", 20, {0,  0}, 210, "WYPTCourseLineArrow")