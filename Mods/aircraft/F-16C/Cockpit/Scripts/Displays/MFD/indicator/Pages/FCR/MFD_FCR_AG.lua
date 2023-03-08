dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

add_PB_label(4, "OVRD")

local RangeArcsPH = addPlaceholder("Range Arcs PH", {0, -238}, noParent, {{"FCR_AG_MapRoot"}, {"FCR_AG_rangeArcsRoot"}, {"MFD_HSD_RadarConeRot"}, {"FCR_AG_BSCAN"}})
AddAgRangeArcs(120, RangeArcsPH.name, {{"FCR_AG_rangeArcs", 6}})
AddAgRangeArcs(60, RangeArcsPH.name, {{"FCR_AG_rangeArcs", 3}})
AddAgRangeArcs(20, RangeArcsPH.name, {{"FCR_AG_rangeArcs", 1}})

AddAgAcquisitionCursor({{"FCR_AG_MapRoot"}, {"FCR_AG_AcquisitionCursorShow"}, {"FCR_AG_AcquisitionCursorPosition"}})

-- Freeze mode
local FreezePH = addPlaceholder("Freeze PH", nil, noParent, {{"FCR_AG_MapRoot"}, {"FCR_AG_FreezeEnable"}})
local radius = 10
local FzPresPosCirc = addStrokeCircle("Present Position in Freeze mode", radius, nil, FreezePH.name, {{"FCR_AG_PresentPositionPos"}, {"FCR_AG_PresentPositionRot"}})
addStrokeLine("Present Position Pointer in Freeze mode", radius * 2, nil, 0, FzPresPosCirc.name)

addStrokeText("Present Position to crosshair heading", "123°", STROKE_FNT_DFLT_10_14, "LeftCenter", {-183, -180}, FreezePH.name, {{"FCR_AG_PresentPositionToChHeading"}, {"FCR_AG_BSCAN"}}, {"%3d°"})
addStrokeText("Present Position to crosshair range NM", "11.3 NM", STROKE_FNT_DFLT_10_14, "LeftCenter", {-183, -200}, FreezePH.name, {{"FCR_AG_PresentPositionToChRange"}, {"FCR_AG_BSCAN"}}, {"%.1f NM"})

local FreezeCCPH = addPlaceholder("Freeze Cursor Coordinate PH", nil, FreezePH.name, {{"FCR_AG_CursorCoordinateShow"}})
addStrokeText("Cursor Coordinate Latitude", "123° 54.037 N", STROKE_FNT_DFLT_10_14, "RightCenter", {210, 190}, FreezeCCPH.name, {{"FCR_AG_CursorCoordinateLatitude"}, {"FCR_AG_BSCAN"}}, {"%3d°%7.3f %c"})
addStrokeText("Cursor Coordinate Longitude", "123° 54.037 W", STROKE_FNT_DFLT_10_14, "RightCenter", {210, 170}, FreezeCCPH.name, {{"FCR_AG_CursorCoordinateLongitude"}, {"FCR_AG_BSCAN"}}, {"%3d°%7.3f %c"})
-- Gaint gage
AddGainGage()
-- EXP, DBS indication
local ExpPH = addPlaceholder("Expanded and DBS PH", nil, noParent, {{"FCR_AG_MapRoot"}, {"FCR_AG_ExpDbsRoot"}})
addStrokeSymbol("Situation Awareness Cue", {"stroke_symbols_MFD", "AG-EXP-SAC"}, "FromSet", nil, ExpPH.name, {{"FCR_AG_SituationAwarenessCuePos"}})

local YardStickPH = addPlaceholder("Yard stick PH", {-200, 195}, ExpPH.name)
addStrokeLine("Yard stick left", 10, nil, -180, YardStickPH.name)
addVarLenStrokeLine("Yard stick main", 30, nil, -90, YardStickPH.name, {{"FCR_AG_YardStickLen"}})
addStrokeLine("Yard stick right", 10, nil, -180, YardStickPH.name, {{"FCR_AG_YardStickPos"}})

AddAgExpCursor(ExpPH.name, {{"FCR_AG_ExpCursorShow"}})
-- Time to go
addStrokeText("Time To Go", nil, STROKE_FNT_DFLT_10_14, "RightCenter", {210, -190}, noParent, {{"FCR_AG_TimeToGo"}})

-- bulseye
local CicledCirleRoot = addPlaceholder("Bullseye_Root", {0, 0}, nil, {{"FCR_AG_MapRoot"}, {"FCR_AG_Bullseye_Pos"}})
local CicledCirleRadius = 1
addStrokeCircle("Bullseye_Cirle_First", CicledCirleRadius, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Second", CicledCirleRadius * 5, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Third", CicledCirleRadius * 10, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
-- bearing and range from steerpoint/bullseye
addStrokeText("FCR_Bearing_range", "000 00", STROKE_FNT_DFLT_8_12, "LeftCenter", {PB_positions[16][1] - 5, PB_positions[16][2] - 7}, nil, {{"FCR_AG_MapRoot"}, {"FCR_AG_FreezeDisable"}, {"FCR_BearingRangeLabel"}})
--
local FCR_NotModeMenu = addPlaceholder("FCR_NotModeMenu_RootAG", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})
local FCR_MapMenu = addPlaceholder("FCR_MapMenu_RootAG", {0, 0}, FCR_NotModeMenu.name, {{"FCR_AG_MapRoot"}})
-- GMT map buttons
local MapRoot = addPlaceholder("Map Root", {PB_positions[17][1] + 10 , (PB_positions[17][2] - PB_positions[16][2]) / 2 + PB_positions[16][2]}, FCR_NotModeMenu.name, {{"FCR_AG_GmtMap"}})
addStrokeText("Map Label", "MAP", STROKE_FNT_DFLT_10_14, "CenterCenter", nil, MapRoot.name)
local MapOffset = 25
local MapSymbolScale = 3.5
addStrokeSymbol("Decrement_Map_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -MapOffset}, MapRoot.name, {{"FCR_AG_GmtShowDecreaseMapSymbol"}}, MapSymbolScale)
local Increment = addStrokeSymbol("Increment_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, MapOffset}, MapRoot.name, {{"FCR_AG_GmtShowIncreaseMapSymbol"}}, MapSymbolScale)
Increment.init_rot = {180}
addSizeClipMask(MapRoot, 2, 72, {{"FCR_AG_GmtMap"}, {"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}}, {-19, 0})
-- AGR
local AgrRoot = addPlaceholder("AGR Root", {0, 0}, nil, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}, {"FCR_AGR_Root"}})
AddAgrRangeIndicator(AgrRoot.name)
addStrokeSymbol("Antenna pointing angle", {"stroke_symbols_MFD", "intercept-cue"}, "FromSet", {0, 0}, AgrRoot.name, {{"FCR_AGR_AntennaPointingAngle", HalfPixelsPerSide}})
-- Menu labels
add_PB_label(1, "GM",  nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GM}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GM}})
add_PB_label(1, "GMT", nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GMT}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GMT}})
add_PB_label(1, "SEA", nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.SEA}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.SEA}})
add_PB_label(1, "BCN", nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.BCN}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.BCN}})
add_PB_label(1, "AGR", nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.AGR}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.AGR}})

add_PB_label(2, "MAN", FCR_MapMenu.name, {{"FCR_AG_AutoRangingLabel", 1}})
add_PB_label(2, "AUTO", FCR_MapMenu.name, {{"FCR_AG_AutoRangingLabel", 0}})
add_PB_label(3, "NORM", FCR_MapMenu.name, {{"FCR_AG_NormExpPbLabel"}}, nil, {"NORM", "EXP", "DBS1", "DBS2"} )

add_PB_label(6, "", FCR_NotModeMenu.name, {{"FCR_AG_BackupBombingSensor"}}, nil, {"B\nA\nR\nO", "P\nR", "R\nA\nL\nT"})
add_Selectable_PB_Label(7, "FZ", FCR_MapMenu.name, {{"FCR_AG_FreezeLabel", 1}}, {{"FCR_AG_FreezeLabel", 0}}, nil, true)
add_Selectable_PB_Label(8, "SP", FCR_MapMenu.name, {{"FCR_AG_SnowPlowEnable", 1}}, {{"FCR_AG_SnowPlowEnable", 0}}, nil, true)
add_PB_label(9, "CZ", FCR_NotModeMenu.name, {{"FCR_AG_CZ_LabelShow"}})
add_PB_label(10, "TGT",	FCR_MapMenu.name, {{"TGP_SPI_Label"}}, nil, {"S\nT\nP", "O\nA\n1", "O\nA\n2", "T\nG\nT", "I\nP", "R\nP"})

add_PB_label(17, "   ", FCR_MapMenu.name, {{"FCR_AG_EgmRbmLabel"}}, nil, {"", "E\nG\nM", "R\nB\nM"} )
add_PB_label(18, "  ", FCR_NotModeMenu.name, {{"FCR_AntennaWidthLabel"}}, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})