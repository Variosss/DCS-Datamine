dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

add_PB_label(4, "OVRD")
--
local FCR_NotModeMenu = addPlaceholder("FCR_NotModeMenu_RootAA", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})

--
local AzimuthScanLimitsRoot = addPlaceholder("Azimuth_Scan_Limits_Root", nil, noParent, noControllers)
local AzimuthScanLimitsHeight = 400
local AzimuthScanLimitsWidth = 240
addStrokeLine("Azimuth_Scan_Limits_Left",  AzimuthScanLimitsHeight, {0, -AzimuthScanLimitsHeight / 2}, 0, AzimuthScanLimitsRoot.name, {{"FCR_AntennaWidthScan", -1}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Azimuth_Scan_Limits_Right", AzimuthScanLimitsHeight, {0, -AzimuthScanLimitsHeight / 2}, 0, AzimuthScanLimitsRoot.name, {{"FCR_AntennaWidthScan", 1}, {"MFD_SetColor_Group_1"}})

--addStrokeSymbol("Reacquisition_Caret", {"stroke_symbols_MFD", "Reacquisition-Caret"}, "FromSet", {16, -30}, AntennaElevationTicsRoot.name, {{"MFD_SetColor_Group_1"}}, 1.0)

local Altitude_LineLen = 15
local AltitudeLineRoot = addPlaceholder("Altitude_Line_Root", {239, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
for i = 0, 2 do
    addStrokeLine("Altitude_Line_"..i, Altitude_LineLen, {0, 120 - i * 120}, 90, AltitudeLineRoot.name, {{"MFD_SetColor_Group_4"}})
end

local CONT_Label = addStrokeText("CONT_Label", "CONT", STROKE_FNT_DFLT_10_14, "CenterCenter", {214, 135}, FCR_NotModeMenu.name, noControllers)
addSizeClipMask(CONT_Label, 2, 20, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}}, {25, 0})

addStrokeText("READY_Label", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, -203}, FCR_NotModeMenu.name, noControllers)

-- bearing and range from steerpoint/bullseye
addStrokeText("FCR_Bearing_range", "000 00", STROKE_FNT_DFLT_8_12, "LeftCenter", {PB_positions[17][1] - 5, PB_positions[17][2] - 40}, nil, {{"FCR_BearingRangeLabel"}})

---------------------------------------------------------------- LIGHT BLUE COLOR ----------------------------------------------------------------
local CicledCirleRoot = addPlaceholder("Bullseye_Root", {0, -240}, nil, {{"MFD_FCR_AA_Bullseye_Pos"}})
local CicledCirleRadius = 1
addStrokeCircle("Bullseye_Cirle_First", CicledCirleRadius, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Second", CicledCirleRadius * 5, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Third", CicledCirleRadius * 10, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})

---------------------------------------------------------------- END LIGHT BLUE COLOR ----------------------------------------------------------------

-- targets, radar video signal
addPlaceholder("DBG_AA_RadarContactsKeeper", nil, nil, {{"FCR_RadarContactsShow"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RADAR_CONTACTS}})
addPlaceholder("AA_RadarTracksKeeper", nil, nil, {{"FCR_RadarTracksShow"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RADAR_TRACKS}})
addPlaceholder("System_AirTracksKeeper", nil, nil, {{"MFD_FCR_SystemAirTracksShow"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.FCR_SYSTEM_TRACKS}})

-- tracked target shape
local trackedTgtPlaceholder	= addPlaceholder("FCR_TrackedTgtPlaceholder", nil, nil, {{"MFD_FCR_AA_TrackedTarget_Pos", 1}})

local trackedTargetSymbol = addPlaceholder("FCR_trackedTargetSymbolPlaceholder", nil, trackedTgtPlaceholder.name, {{"MFD_FCR_AA_TrackedTarget"}})
addStrokeSymbol("FCR_Symbol_Unknown", {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 1}, {"MFD_FCR_AA_TrackedTarget_Color"}})
addStrokeSymbol("FCR_Symbol_Friendly", {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 2}, {"MFD_FCR_AA_TrackedTarget_Color"}})
addStrokeSymbol("FCR_Symbol_Hostile", {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 3}, {"MFD_FCR_AA_TrackedTarget_Color"}})
addStrokeSymbol("FCR_Symbol_Ambiguous", {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 4}, {"MFD_FCR_AA_TrackedTarget_Color"}})

local trackedTargetSymbolRectangleSolid = addPlaceholder("trackedTargetSymbolRectangleSolid", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 1}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SolidRectangle_"..i, {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", {0, 0}, trackedTargetSymbolRectangleSolid.name, {{"MFD_FCR_AA_TrackedTarget_Color"}}, i)
end

local trackedTargetSymbolCircleSolid = addPlaceholder("trackedTargetSymbolCircleSolid", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 2}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SolidCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, trackedTargetSymbolCircleSolid.name, {{"MFD_FCR_AA_TrackedTarget_Color"}}, i)
end

local trackedTargetSymbolTriangleSolid = addPlaceholder("trackedTargetSymbolTriangleSolid", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 3}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SolidTriangle_"..i, {"stroke_symbols_MFD", "air-track-triangle-big"}, "FromSet", {0, 0}, trackedTargetSymbolTriangleSolid.name, {{"MFD_FCR_AA_TrackedTarget_Color"}}, i)
end

local trackedTargetSymbolRectangleSolidAmbiguous = addPlaceholder("trackedTargetSymbolRectangleSolidAmbiguous", nil, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTargetTypeHAFU", 4}})
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SolidRectangleAmbiguous_"..i, {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", {0, 0}, trackedTargetSymbolRectangleSolidAmbiguous.name, {{"MFD_FCR_AA_TrackedTarget_Color"}}, i)
end

addStrokeSymbol("FCR_Symbol_Unknown_Bugged", {"stroke_symbols_MFD", "bugged-target-big"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MFD_SetColor_Group_2"}})
-- tracked target, aspect angle pointer (fixed size)
local trackedTgtAspectAngPtrLen  = 10
addStrokeLine("FCR_STT_AspectAnglePointer", trackedTgtAspectAngPtrLen, {0, 13}, 0, trackedTargetSymbol.name, {{"MFD_FCR_AA_TrackedTarget_Color"}})
-- tracked target, altitude readout4
addStrokeText("FCR_STT_Altitude", "", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -22}, trackedTgtPlaceholder.name, {{"MFD_FCR_AA_TrackedTarget_Altitude"}, {"MFD_FCR_AA_TrackedTarget_Color"}})

local trackedTgtTailPlaceholder	= addPlaceholder("FCR_TrackedTgtTailPlaceholder", nil, trackedTgtPlaceholder.name, 	{{"MFD_FCR_AA_TrackedTarget"}, {"MFD_FCR_AA_TrackedTargetTail_State"}})
for i = 0, 12 do
    addStrokeLine("FCR_TrackedTgtTail_line"..i, 6, {-6 + i, -9},  180, trackedTgtTailPlaceholder.name, {{"MFD_FCR_AA_TrackedTarget_Color"}})
end

local trackedTgtXPlaceholder	= addPlaceholder("FCR_TrackedTgtXPlaceholder", nil, trackedTgtPlaceholder.name, 	{{"MFD_FCR_AA_TrackedTargetX_State"}})
addStrokeLine("FCR_TrackedTgtX_line1", 34, { 12,  -12},   45, 	trackedTgtXPlaceholder.name, 	{{"MFD_SetColor_Red"}})
addStrokeLine("FCR_TrackedTgtX_line2", 34, {-12,  -12},  -45, 	trackedTgtXPlaceholder.name, 	{{"MFD_SetColor_Red"}})

local tt_dataRoot = addPlaceholder("FCR_STT_ShowRoot", {0, PB_positions[3][2] - 15}, nil, {{"MFD_FCR_AA_TrackedTargetData_Show", 1}})
addStrokeText("FCR_STT_AspectDeg",	 "", STROKE_FNT_DFLT_8_12, "LeftTop",	{PB_positions[1][1] - 40, 0},	tt_dataRoot.name, {{"MFD_FCR_AA_TrackedTarget_AspectDeg"}})
addStrokeText("FCR_STT_MagGgrTrack", "", STROKE_FNT_DFLT_8_12, "LeftTop", 	{PB_positions[1][1], 0}, 		tt_dataRoot.name, {{"MFD_FCR_AA_TrackedTarget_MagGrTrack"}})
addStrokeText("FCR_STT_NCTR_Data",	 "", STROKE_FNT_DFLT_8_12, "CenterTop", {PB_positions[3][1], 0}, 		tt_dataRoot.name, {{"MFD_FCR_AA_TrackedTarget_NCTR_TrackType"}})
addStrokeText("FCR_STT_Cas",		 "", STROKE_FNT_DFLT_8_12, "CenterTop", {PB_positions[4][1], 0}, 		tt_dataRoot.name, {{"MFD_FCR_AA_TrackedTarget_CAS"}})
addStrokeText("FCR_STT_ClosureRate", "", STROKE_FNT_DFLT_8_12, "RightTop", 	{PB_positions[5][1] + 40, 0},	tt_dataRoot.name, {{"MFD_FCR_AA_TrackedTarget_ClosureRate"}})

local trackedTgtJammingPH = addPlaceholder("trackedTgtJammingPH", nil, trackedTgtPlaceholder.name, {{"MFD_FCR_AA_TrackedTargetJamming"}})
addStrokeLine("trackedTgt_jammingLine1", 15, {0,  5},  120, trackedTgtJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("trackedTgt_jammingLine2", 15, {0,  5}, -120, trackedTgtJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("trackedTgt_jammingLine3", 15, {0, -5},  120, trackedTgtJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("trackedTgt_jammingLine4", 15, {0, -5}, -120, trackedTgtJammingPH.name, {{"MFD_SetColor_Yellow"}})

-- tracked Target donor mark
local trackedTgt_DonorMark_PH = addPlaceholder("trackedTgt_DonorMark_PH", nil, trackedTgtPlaceholder.name, {{"MFD_FCR_AA_TrackedTarget_DonorMark"}})
for i = 0.0, 0.3, 0.15 do
	addStrokeSymbol("trackedTgt_DonorMarkCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, trackedTgt_DonorMark_PH.name, {{"MFD_SetColor_Black"}}, i)
end

-- secondary tracked target
local trackSearchTargetSize = 10
local trackTankTargetSize = 12

local FCR_SecondTrackPlaceholder = addPlaceholder("FCR_SecondTarget", nil, nil, {{"MFD_FCR_SecondTrackPos"}})
local FCR_SecondTrack = addStrokeSymbol("FCR_SecondTrack", {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", nil, FCR_SecondTrackPlaceholder.name, {{"MFD_FCR_SecondTrackRotate"}, {"MFD_FCR_AA_SecondTrackedTarget_Color"}})
addStrokeText("FCR_SecondTrack_Altitude", "22", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -19}, FCR_SecondTrackPlaceholder.name, {{"MFD_FCR_SecondTrackAltitude"}, {"MFD_FCR_AA_SecondTrackedTarget_Color"}})
addStrokeLine("FCR_SecondTrack_Search_Pointer", trackedTgtAspectAngPtrLen, {0, 13}, 0, FCR_SecondTrack.name, {{"MFD_FCR_AA_SecondTrackedTarget_Color"}})

local FCR_SecondTrackSolid = addPlaceholder("FCR_SecondTrackSolid", nil, FCR_SecondTrack.name)
for i = 0, 1, 1.0/7.0 do
	addStrokeSymbol("FCR_SecondTrackSolid_"..i, {"stroke_symbols_MFD", "fcr-target-big"}, "FromSet", {0, 0}, FCR_SecondTrackSolid.name, {{"MFD_FCR_AA_SecondTrackedTarget_Color"}}, i)
end

local FCR_SecondTgtTailPlaceholder	= addPlaceholder("FCR_SecondTrackedTgtTailPlaceholder", nil, FCR_SecondTrack.name, {{"MFD_FCR_AA_SecondTrackedTargetTail_State"}})
for i = 0, 12 do
    addStrokeLine("FCR_SecondTrackedTgtTail_line"..i, 6, {-6 + i, -9},  180, FCR_SecondTgtTailPlaceholder.name, {{"MFD_FCR_AA_SecondTrackedTarget_Color"}})
end

local FCR_SecondTgtXPlaceholder	= addPlaceholder("FCR_SecondTrackedTgtXPlaceholder", nil, FCR_SecondTrack.name, {{"MFD_FCR_AA_SecondTrackedTargetX_State"}})
addStrokeLine("FCR_SecondTrackedTgtX_line1", 34, { 12,  -12},   45, FCR_SecondTgtXPlaceholder.name, {{"MFD_SetColor_Red"}})
addStrokeLine("FCR_SecondTrackedTgtX_line2", 34, {-12,  -12},  -45, FCR_SecondTgtXPlaceholder.name, {{"MFD_SetColor_Red"}})

local FCR_SecondTrackJammingPH = addPlaceholder("FCR_SecondTrackJammingPH", nil, FCR_SecondTrackPlaceholder.name, {{"MFD_FCR_SecondTrackJamming"}})
addStrokeLine("SecondTrack_jammingLine1", 15, {0,  5},  120, FCR_SecondTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("SecondTrack_jammingLine2", 15, {0,  5}, -120, FCR_SecondTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("SecondTrack_jammingLine3", 15, {0, -5},  120, FCR_SecondTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("SecondTrack_jammingLine4", 15, {0, -5}, -120, FCR_SecondTrackJammingPH.name, {{"MFD_SetColor_Yellow"}})

-- Second Target donor mark
local FCR_SecondTrack_DonorMark_PH = addPlaceholder("FCR_SecondTrack_DonorMark_PH", nil, trackedTgtPlaceholder.name, {{"MFD_FCR_SecondTrack_DonorMark"}})
for i = 0.0, 0.3, 0.15 do
	addStrokeSymbol("FCR_SecondTrack_DonorMarkCircle_"..i, {"stroke_symbols_MFD", "air-track-circle-big"}, "FromSet", {0, 0}, FCR_SecondTrack_DonorMark_PH.name, {{"MFD_SetColor_Black"}}, i)
end

-- TDC cursor
local CursorRoot = addPlaceholder("Cursor_Root", {0, 0}, noParent, {{"FCR_TDC_position"}, {"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Left", 30, {15, -15}, 0, CursorRoot.name, {{"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Right", 30, {-15, -15}, 0, CursorRoot.name, {{"MFD_SetColor_Group_2"}})
addStrokeText("Max_Search_Altitude", "  ", STROKE_FNT_DFLT_10_14, "LeftCenter", {20,  17}, CursorRoot.name, {{"FCR_AA_ScanAltitudeLimit", 0}, {"FCR_AA_ScanAltitudeColor", 0}})
addStrokeText("Min_Search_Altitude", "  ", STROKE_FNT_DFLT_10_14, "LeftCenter", {20, -17}, CursorRoot.name, {{"FCR_AA_ScanAltitudeLimit", 1}, {"FCR_AA_ScanAltitudeColor", 1}})

local Bullseye_LOS_Mask_PH = addPlaceholder("Bullseye_LOS_Mask_PH", {-220, -195})
addSizeClipMask(Bullseye_LOS_Mask_PH, 2, 70, nil, {-19, 0})

---------------------------------------------------------------- WHITE COLOR ----------------------------------------------------------------
addStrokeText("FCR_A-A_DL_Declutter", "ALL", STROKE_FNT_DFLT_8_12, "LeftCenter", {PB_positions[15][1] - 18, PB_positions[15][2] + 22}, nil, {{"MFD_FCR_AA_DL_DeclutterLabel"}}, {"", "ALL", "FTR+", "TGTS", "NONE"})

addStrokeSymbol("FCR_Steerpoint_Symbol", {"stroke_symbols_MFD", "fcr-steerpoint"}, "FromSet", {0, -240}, nil, {{"FCR_Steerpoint_Pos"}})

-- Expansion Box
local Expansion_Box_Root = addPlaceholder("Expansion_Box_Root", {0, 0}, noParent, 	 {{"MFD_FCR_ExpansionBox"}})
addVarLenStrokeLine("Expansion_Box_Line_1", nil, nil, 0, Expansion_Box_Root.name,    {{"MFD_FCR_ExpansionBoxLine", tactical_display_sz}})
addVarLenStrokeLine("Expansion_Box_Line_2", nil, nil, -90, Expansion_Box_Root.name,  {{"MFD_FCR_ExpansionBoxLine", tactical_display_sz}})
addVarLenStrokeLine("Expansion_Box_Line_3", nil, nil, 180, Expansion_Box_Root.name,  {{"MFD_FCR_ExpansionBoxLine", tactical_display_sz}})
addVarLenStrokeLine("Expansion_Box_Line_4", nil, nil, 90, Expansion_Box_Root.name,   {{"MFD_FCR_ExpansionBoxLine", tactical_display_sz}})

-- Target intercept steering symbol
local InterceptSteeringRoot = addPlaceholder("InterceptSteering_Root", {0, 0}, noParent, {{"MFD_FCR_AA_InterceptSteering"}, {"MFD_SetColor_Group_2"}})
addStrokeSymbol("InterceptSteering_Symbol", {"stroke_symbols_MFD", "intercept-cue"}, "FromSet", {0, 0}, InterceptSteeringRoot.name, {{"MFD_SetColor_Group_2"}})
---------------------------------------------------------------- END WHITE COLOR ----------------------------------------------------------------


---------------------------------------------------------------------- DLZ ----------------------------------------------------------------------
local AA_Missile =
{
	AIM_9LM	= 1,
	AIM_9X	= 3,
	AIM_120	= 4,
}

-- СOMMON
local dlzWidth = 20
local dlzRange = 240 - 6
local DLZ_Offset = 240 - Altitude_LineLen - dlzWidth - 10
local DLZ_root = addPlaceholder("DLZ_root", {DLZ_Offset, -120}, nil, {{"MFD_FCR_DLZ_Show"}})

local rmin1_root = addPlaceholder("DLZ_Rmin1_root",{0, 0}, DLZ_root.name, {{"MFD_FCR_AA_DLZ_RMin1"}})
addStrokeLine("DLZ_Rmin1",		dlzWidth, {0, 0}, -90, rmin1_root.name)
local rmin2_root = addPlaceholder("DLZ_Rmin2_root", {0, 0}, DLZ_root.name, {{"MFD_FCR_AA_DLZ_RMin2"}})
addStrokeLine("DLZ_Rmin2",		dlzWidth, {0, 0}, -90, rmin2_root.name)
local rmax2_root = addPlaceholder("DLZ_Rmax2_root", {0, 0}, DLZ_root.name, {{"MFD_FCR_AA_DLZ_RMax2"}})
addStrokeLine("DLZ_Rmax2",		dlzWidth, {0, 0}, -90, rmax2_root.name)
local rmax1_root = addPlaceholder("DLZ_Rmax1_root", {0, 0}, DLZ_root.name, {{"MFD_FCR_AA_DLZ_RMax1"}})
addStrokeLine("DLZ_Rmax1",		dlzWidth, {0, 0}, -90, rmax1_root.name)

addVarLenStrokeLine("DLZ_nonManeuv",	0, {0, 0},		  0, DLZ_root.name, {{"MFD_FCR_AA_DLZ_nonManeuv"}}, dlzRange)
addVarLenStrokeLine("DLZ_Maneuv",	0, {dlzWidth, 0}, 0, DLZ_root.name, {{"MFD_FCR_AA_DLZ_Maneuv"}}, dlzRange)

-- Caret
local dlzRangeCaret = addStrokeSymbol("DLZ_TgtRange",   {"stroke_symbols_HUD", "AA-DLZ-range"},	"FromSet", {0, 0}, DLZ_root.name, {{"MFD_FCR_AA_DLZ_TargetRange"}}, 2.0)
addStrokeText("HUD_AA_DLZ_TgtClosureRate", "", STROKE_FNT_DFLT_8_12, "RightCenter", {-15, 0}, dlzRangeCaret.name, {{"MFD_FCR_AA_DLZ_TargetClosureRate"}})
addStrokeText("HUD_AA_DLZ_AIM120_AF_Pole", "", STROKE_FNT_DFLT_8_12, "RightCenter", {-15, -17}, dlzRangeCaret.name, {{"MFD_FCR_AA_DLZ_AIM120_AF_Pole"}})

local dlzRaero = addStrokeSymbol("DLZ_Raero", {"stroke_symbols_HUD", "DLZ-Raero"}, "FromSet", {7, 0}, DLZ_root.name,  {{"MFD_FCR_AA_DLZ_RAero"}}, 3.0)

local DLZ_AIM_root = addPlaceholder("DLZ_AIM_root", {0, 0}, DLZ_root.name, {{"MFD_FCR_DLZ_Show"}})
addStrokeText("DLZ_PreLaunchTOF", "", STROKE_FNT_DFLT_8_12, "RightCenter", {20, -7}, DLZ_AIM_root.name, {{"MFD_FCR_AA_PreLaunchTOF"}})

-- AIM-120
local DLZ_AIM120_root = addPlaceholder("DLZ_AIM120_root", {0, 0}, DLZ_root.name, {{"MFD_FCR_AA_MissileSelected", AA_Missile.AIM_120}})
addStrokeSymbol("DLZ_ActRange", {"stroke_symbols_HUD", "DLZ-Act-range"},	"FromSet", {0, 0}, DLZ_AIM120_root.name, {{"MFD_FCR_AA_DLZ_ActRange"}}, 3.0)
addStrokeText("DLZ_PostLaunchTOF", "", STROKE_FNT_DFLT_8_12, "RightCenter", {20, -27}, DLZ_AIM120_root.name, {{"MFD_FCR_AA_PostLaunchTOF"}})
-------------------------------------------------------------------- END DLZ --------------------------------------------------------------------

----------------------------------------------------------------- RWS TUC DATA ------------------------------------------------------------------
local FCR_TUC_contactData = addPlaceholder("FCR_TUC_contactData", nil, nil, {{"MFD_FCR_RawRadarTUCContactPos", tactical_display_sz_half}})
addStrokeText("FCR_TUC_contact_Altitude", "22", STROKE_FNT_DFLT_10_14, "CenterTop", {0, -17}, FCR_TUC_contactData.name, {{"MFD_FCR_RawRadarTUCContactAltitude"}})
--------------------------------------------------------------- END RWS TUC DATA ----------------------------------------------------------------

----------------------------------------------------------------- STEERING CUE ------------------------------------------------------------------
local FCR_AA_AMRAAM_PH = addPlaceholder("FCR_AA_AMRAAM_PH", {0, 0}, nil, {{"MFD_FCR_SteeringCueState"}})
addStrokeCircle("FCR_AA_ASE", 262/2, {0, 0}, FCR_AA_AMRAAM_PH.name, {{"MFD_FCR_AllowableSteeringErrorRadius"}, {"MFD_SetColor_Group_2"}})
addStrokeCircle("FCR_AA_ASC", 5, {0, 0}, FCR_AA_AMRAAM_PH.name, {{"MFD_FCR_AttackSteeringCuePosition"}, {"MFD_SetColor_Group_2"}})
--------------------------------------------------------------- END STEERING CUE ----------------------------------------------------------------

---------------------------------------------------------------- ACM SLEW DATA ------------------------------------------------------------------
local FCR_ACM_SLEW_PH = addPlaceholder("FCR_ACM_SLEW_PH", {0, 0}, nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.ACM_SLEW}, {"FCR_ACM_Slew_VisibleState"}})
addStrokeText("Slew_Max_Search_Altitude", "  ", STROKE_FNT_DFLT_10_14, "CenterCenter", {0,  17}, FCR_ACM_SLEW_PH.name, {{"FCR_AA_ScanAltitudeLimit", 0}, {"FCR_AA_ScanAltitudeColor", 0}})
addStrokeText("Slew_Min_Search_Altitude", "  ", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, -17}, FCR_ACM_SLEW_PH.name, {{"FCR_AA_ScanAltitudeLimit", 1}, {"FCR_AA_ScanAltitudeColor", 1}})
addStrokeSymbol("Slew_Scan_Center_Symbol", {"stroke_symbols_MFD", "intercept-cue"}, "FromSet", {0, 0}, FCR_ACM_SLEW_PH.name, {{"FCR_ACM_Slew_ScanCenterPosition"}, {"MFD_SetColor_Group_2"}})
-------------------------------------------------------------- END ACM SLEW DATA ----------------------------------------------------------------

--
add_PB_label(3, "NORM",	nil, {{"MFD_FCR_EXP_Label", 0}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_Selectable_PB_Label(3, "EXP", nil, {{"MFD_FCR_EXP_Label", 1, 0}}, {{"MFD_FCR_EXP_Label", 1, 1}})

add_PB_label(4, "OVRD",	nil, nil, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})

add_PB_label(17, "  ", FCR_NotModeMenu.name, {{"FCR_ElevBarScanLabel"}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(18, "  ", FCR_NotModeMenu.name, {{"FCR_AntennaWidthLabel"}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})


-- MODE MENU labels
add_PB_label(1, "CRM",	FCR_NotModeMenu.name, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.CRM}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.CRM}})
add_PB_label(1, "ACM",	FCR_NotModeMenu.name, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.ACM}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.ACM}})

local FCR_ModeMenuPH = addPlaceholder("FCR_ModeMenu_RootAA", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MODE}})
add_PB_label(1, "CRM",	FCR_ModeMenuPH.name, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.CRM}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.CRM}})
add_PB_label(1, "ACM",	FCR_ModeMenuPH.name, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.ACM}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.ACM}})

add_PB_label(2, "RWS",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.CRM_RWS}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "ULS",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.CRM_ULS}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "VS",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.CRM_VS}},  {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "TWS",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.CRM_TWS}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "20",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.ACM_30_20}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "60",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.ACM_10_60}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "BORE",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.ACM_BORE}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
add_PB_label(2, "SLEW",	nil, {{"FCR_OperatingMode", 1, FCR_OPERATING_MODE.ACM_SLEW}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
