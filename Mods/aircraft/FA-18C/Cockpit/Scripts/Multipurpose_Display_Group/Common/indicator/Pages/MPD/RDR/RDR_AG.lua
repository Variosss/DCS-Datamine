dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

------------------------------------------------------------------------------
-- AG, non-backup, is planned for GM mode

-- Grid
local gridOffsetY = 11
local Grid_Mask_Width = AG_TacticalAreaWidth
local Grid_Mask_Height = AG_TacticalAreaHeight - gridOffsetY * 2
local Grid_Position = {0, 1 + gridOffsetY}
local Grid_AnglePoint_PosX = 43
local Grid_AnglePoint_PosY = 218
local Grid_Indices = {0, 1, 2, 0, 2, 3, 0, 3, 4, 0, 4, 5}
local Grid_Vertices = 
{
	{-Grid_AnglePoint_PosX, -Grid_Mask_Height / 2},
	{Grid_AnglePoint_PosX, -Grid_Mask_Height / 2},
	{Grid_Mask_Width / 2, -Grid_Mask_Height / 2 + Grid_AnglePoint_PosY},
	{Grid_Mask_Width / 2, Grid_Mask_Height / 2},
	{-Grid_Mask_Width / 2, Grid_Mask_Height / 2},
	{-Grid_Mask_Width / 2, -Grid_Mask_Height / 2 + Grid_AnglePoint_PosY}
}
local clippedObject
local openingMaskMap = openMaskArea(0, "AG_Radar_Mask_MAP", Grid_Vertices, Grid_Indices, Grid_Position, nil, {{"MPD_RDR_AG_ShowGrid"}})

local openingMaskEXP = openMaskArea(0, "AG_Radar_Box_Mask_MAP", nil, nil, nil, nil, {{"MPD_RDR_AG_EXP_Enable"}})
set_box_w_h(openingMaskEXP, AG_TacticalAreaWidth, AG_TacticalAreaHeight)

clippedObject = AddVideoSignalRender_MPD(1024, 1024)
setClipLevel(clippedObject, 1)

local angle = 0
local GrigPH = addPlaceholder("GrigPH", {0, AG_TacticalAreaOffsetY}, nil, {{"MPD_RDR_AG_ShowGrid"}})
local LineOffset = 50
clippedObject = addStrokeLine("0_Deg_Line", AG_TacticalAreaHeight, nil, 0, GrigPH.name, {{"MPD_RDR_AG_MAP_GridLinePosRot", LineOffset, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("30_Deg_Line", AG_TacticalAreaHeight , nil, 0, GrigPH.name, {{"MPD_RDR_AG_MAP_GridLinePosRot", LineOffset, 30}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("neg30_Deg_Line", AG_TacticalAreaHeight , nil, 0, GrigPH.name, {{"MPD_RDR_AG_MAP_GridLinePosRot", LineOffset, -30}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("60_Deg_Line", AG_TacticalAreaHeight , nil, 0, GrigPH.name, {{"MPD_RDR_AG_MAP_GridLinePosRot", LineOffset, 60}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("neg60_Deg_Line", AG_TacticalAreaHeight , nil, 0, GrigPH.name, {{"MPD_RDR_AG_MAP_GridLinePosRot", LineOffset, -60}})
setClipLevel(clippedObject, 1)

addStrokeArc("First Arc",   840 / 4 * 1, 120, 60, nil, GrigPH.name, controllers, 1)
addStrokeArc("Second Arc",  840 / 4 * 2, 120, 60, nil, GrigPH.name, controllers, 1)
addStrokeArc("Third Arc",   840 / 4 * 3, 120, 60, nil, GrigPH.name, controllers, 1)
addStrokeArc("Fourth Arc",  840 / 4 * 4, 120, 60, nil, GrigPH.name, controllers, 1)

-- Designation Cursor
local DesignationCursorPH = addPlaceholder("DesignationCursorPH", nil, GrigPH.name, {{"MPD_RDR_AG_DesignationCursor_Show"}})
clippedObject = addStrokeLine("DesignationCursor_LineAzimuth", AG_TacticalAreaHeight , nil, 0, DesignationCursorPH.name, {{"MPD_RDR_AG_DesignationCursor_Azimuth"}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeCircle("DesignationCursor_CircleRange", 10, nil, DesignationCursorPH.name, {{"MPD_RDR_AG_DesignationCursor_Range", AG_TacticalAreaHeight}}, 120 / 180 * math.pi)
setClipLevel(clippedObject, 1)

-- Designated target symbol
local DesignatedTarget_PH = addPlaceholder("DesignatedTarget_PH", {0, AG_TacticalAreaOffsetY}, nil, {{"MPD_RDR_AG_TargetDesignatedPosition", AG_TacticalAreaHeight}})
local TD_crossSize_X = 100
local TD_crossSize_Y = 60
clippedObject = addStrokeLine("TD_VerticalLine", TD_crossSize_Y, {0, -TD_crossSize_Y / 2}, 0, DesignatedTarget_PH.name)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("TD_HorisontalLine", TD_crossSize_X, {-TD_crossSize_X / 2, 0}, -90, DesignatedTarget_PH.name)
setClipLevel(clippedObject, 1)

--EXP cursor
clippedObject = addStrokeLine("EXP_Cursor_Vertical_Line", AG_TacticalAreaHeight, {0, -AG_TacticalAreaHeight / 2}, 0, openingMaskEXP.name, {{"MPD_RDR_AG_EXP_Cursor", 1}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("EXP_Cursor_Horizontal_Line", AG_TacticalAreaHeight, {AG_TacticalAreaHeight / 2, 0}, 90, openingMaskEXP.name, {{"MPD_RDR_AG_EXP_Cursor", 0}})
setClipLevel(clippedObject, 1)

-- EXP Designated target symbol
local EXP_DesignatedTarget_PH = addPlaceholder("EXP_DesignatedTarget_PH", nil, nil, {{"MPD_RDR_AG_EXP_TargetDesignatedPosition"}})
local EXP_TD_crossSize_Y = 60
clippedObject = addStrokeLine("EXP_TD_VerticalLine", EXP_TD_crossSize_Y, {0, -EXP_TD_crossSize_Y / 2}, 0, EXP_DesignatedTarget_PH.name)
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("EXP_TD_HorisontalLine", EXP_TD_crossSize_Y, {-EXP_TD_crossSize_Y / 2, 0}, -90, EXP_DesignatedTarget_PH.name)
setClipLevel(clippedObject, 1)

---------------------------------------------- TRACK ---------------------------------------------
local TrackedTarget_PH = addPlaceholder("AG_TrackedTarget_PH", {0, AG_TacticalAreaOffsetY}, nil, {{"MPD_RDR_AG_TrackSymbol", AG_TacticalAreaHeight}})
local TrackedTargetSymLen = 30
for i = 1, 4 do
	clippedObject = addStrokeLine("AG_TrackedTarget_ShapePiece_"..i, TrackedTargetSymLen, {-TrackedTargetSymLen * 0.5, 2 * (i - 2.5)}, -90, TrackedTarget_PH.name)
	setClipLevel(clippedObject, 1)
end
local TrackedDataOffset = TrackedTargetSymLen * 0.5 + 10
clippedObject = addStrokeText("AG_TrackedTarget_GroundSpeed", "000", STROKE_FNT_DFLT_120, "RightCenter", {-TrackedDataOffset, 0}, TrackedTarget_PH.name, {{"MPD_RDR_AG_TrackGroundSpeed"}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeText("AG_TrackedTarget_Heading", "111", STROKE_FNT_DFLT_120, "LeftCenter", {TrackedDataOffset, 0}, TrackedTarget_PH.name, {{"MPD_RDR_AG_TrackHeading"}}, {"%d°"})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeLine("AG_TrackedTarget_AspectPointer", 20, {0, 0}, 0, TrackedTarget_PH.name, {{"MPD_RDR_AG_TrackAspectPointer", 20}})
setClipLevel(clippedObject, 1)
--------------------------------------------------------------------------------------------------

---------------------------------------- AG SEA/GMT TRACK ----------------------------------------
addPlaceholder("AG_targetsKeeper", {0, AG_TacticalAreaOffsetY}, nil, {{"MPD_RDR_AG_TracksShow"}, {"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RDR_AG_TRACKS}})
--------------------------------------------------------------------------------------------------

------------------------------- EXP unesignation Cursor for MAP -------------------------------
local UndesignationCursorPH = addPlaceholder("EXP_undesignationCursorPH", {0, AG_TacticalAreaOffsetY}, nil, {{"MPD_RDR_AG_EXP_UndesignatedCursor_Root"}})
setClipLevel(UndesignationCursorPH, 1)

clippedObject = addVarLenStrokeLine("UndesignationCursor_Line_Right", 1000, nil, 0, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_RotateAzimuthZone", 0}, {"MPD_RDR_AG_EXP_UndesignatedCursor_LineLength", AG_TacticalAreaHeight}})
setClipLevel(clippedObject, 1)
clippedObject = addVarLenStrokeLine("UndesignationCursor_Line_Left", 1000, nil, 0, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_RotateAzimuthZone", 1}, {"MPD_RDR_AG_EXP_UndesignatedCursor_LineLength", AG_TacticalAreaHeight}})
setClipLevel(clippedObject, 1)

local EXP_undesignationCursor_Mask_Right_PH = addPlaceholder("EXP_undesignationCursor_Mask_Right_PH", nil, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_RotateAzimuthZone", 0}})
setClipLevel(EXP_undesignationCursor_Mask_Right_PH, 2)

local EXP_undesignationCursor_Mask_Right = openMaskArea(1, "EXP_undesignationCursor_Mask_Right", nil, nil, {AG_TacticalAreaWidth, AG_TacticalAreaHeight}, EXP_undesignationCursor_Mask_Right_PH.name)
set_box_w_h(EXP_undesignationCursor_Mask_Right, AG_TacticalAreaWidth * 2, AG_TacticalAreaHeight * 3)

local EXP_undesignationCursor_Mask_Left_PH = addPlaceholder("EXP_undesignationCursor_Mask_Left_PH", nil, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_RotateAzimuthZone", 1}})
setClipLevel(EXP_undesignationCursor_Mask_Left_PH, 2)

local EXP_undesignationCursor_Mask_Left = openMaskArea(1, "EXP_undesignationCursor_Mask_Left", nil, nil, {-AG_TacticalAreaWidth, AG_TacticalAreaHeight}, EXP_undesignationCursor_Mask_Left_PH.name)
set_box_w_h(EXP_undesignationCursor_Mask_Left, AG_TacticalAreaWidth * 2, AG_TacticalAreaHeight * 3)

clippedObject = addStrokeCircle("UndesignationCursor_CircleRange_Min", 360, nil, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_CircleRange", AG_TacticalAreaHeight, 0}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeCircle("UndesignationCursor_CircleRange_Max", 560, nil, UndesignationCursorPH.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_CircleRange", AG_TacticalAreaHeight, 1}})
setClipLevel(clippedObject, 1)

closeMaskArea(1, "EXP_undesignationCursor_Mask_Left_Close", EXP_undesignationCursor_Mask_Left.vertices, EXP_undesignationCursor_Mask_Left.indices, EXP_undesignationCursor_Mask_Left.init_pos)
closeMaskArea(1, "EXP_undesignationCursor_Mask_Right_Close", EXP_undesignationCursor_Mask_Right.vertices, EXP_undesignationCursor_Mask_Right.indices, EXP_undesignationCursor_Mask_Right.init_pos)

clippedObject = addStrokeSymbol("EXP_undesignationCursor_From_EXP1_To_EXP2", {"stroke_symbols_MDI_AMPCD", "EXP2-FROM-EXP1"}, "FromSet", nil, openingMaskEXP.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_EXPtoEXPCursor", 512, 1}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("EXP_undesignationCursor_From_EXP1_To_EXP3", {"stroke_symbols_MDI_AMPCD", "EXP3-FROM-EXP1"}, "FromSet", nil, openingMaskEXP.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_EXPtoEXPCursor", 512, 2}})
setClipLevel(clippedObject, 1)
clippedObject = addStrokeSymbol("EXP_undesignationCursor_From_EXP2_To_EXP3", {"stroke_symbols_MDI_AMPCD", "EXP3-FROM-EXP2"}, "FromSet", nil, openingMaskEXP.name, {{"MPD_RDR_AG_EXP_UndesignatedCursor_EXPtoEXPCursor", 512, 3}})
setClipLevel(clippedObject, 1)
--------------------------------------------------------------------------------------------------


closeMaskArea(1, "AG_Radar_Box_Mask_MAP_Close", openingMaskEXP.vertices, openingMaskEXP.indices, openingMaskEXP.init_pos)
closeMaskArea(1, "AG_Radar_Mask_Map_Close", openingMaskMap.vertices, openingMaskMap.indices, openingMaskMap.init_pos)

-- Break X
add_X_Over("breakX_placeholder", 352, 352,  nil, nil, {{"HUD_Break_X"}})

-- Elevation caret, radar positioned
add_RDR_caret("Elevation_caret", {-tactical_display_sz_half, 0}, -90, nil, {{"MPD_RDR_ElevationCaret", tactical_display_sz_half}})
-- Optimal elevation caret
local OptimalElevationCaretPH = addPlaceholder("OptimalElevationCaretPH", {-tactical_display_sz_half, 0}, nil, {{"MPD_RDR_AG_OptimalElevation", tactical_display_sz_half}})
addStrokeLine("OptimalElevationCaretLine1", 24, {0, 1}, -90, OptimalElevationCaretPH.name)
addStrokeLine("OptimalElevationCaretLine2", 24, {0, -1}, -90, OptimalElevationCaretPH.name)
-- Radar modes
local RadarModePlaceholder = addPlaceholder("RadarModePlaceholder", {PB_positions[5][1] + side_PB_shiftX, 335}, nil, {{"MPD_RDR_AG_RadarModePH"}, {"MPD_RDR_AG_RadarModeLayoutShow", 0}})
addStrokeText("Radar_mode", nil, STROKE_FNT_DFLT_120, "LeftCenter", nil, RadarModePlaceholder.name, {{"MPD_RDR_OperatingMode"}},
	{"", "RWS", "VS", "TWS", "MAP", "GMT", "SEA", "TA", "AGR", "PVU"})
add_X_Over("Radar_mode_X_Over", 66, 24, {glyphNominalWidth120 * 1.5 + fontIntercharDflt120, 0}, RadarModePlaceholder.name, {{"MPD_RDR_OperatingModeFail"}})

addStrokeText("Radar_AG_mode_Layout", "MAP\n\nGMT\n\nSEA\n\nTA", PB_TextFont, "CenterCenter", {-470, 245}, nil, {{"MPD_RDR_AG_RadarModeLayoutShow", 1}})

-- Time to release
addStrokeText("Time to release", nil, STROKE_FNT_DFLT_120, "RightCenter", {400, 430}, nil, {{"MPD_RDR_AG_TimeToRelease"}})

-- EXP Angle-Off-Track indication
addStrokeText("Angle_Off_Track_Indication", "     ", STROKE_FNT_DFLT_120, "CenterBottom", {0, upper_data_block_posY}, nil,
	{{"MPD_RDR_AG_EXP_AngleOffTrack"}}, {"%03.0f°%s"})

-- TRACK, MEM status
addStrokeText("TrackStatus", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, -tactical_display_sz_half + 0}, nil, {{"MPD_RDR_AG_TrackStatus"}})

-- TDC cursor
addAcqusitionCursor()
