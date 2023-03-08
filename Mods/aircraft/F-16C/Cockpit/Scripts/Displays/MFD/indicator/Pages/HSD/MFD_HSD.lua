dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

local parent = nil
local controllers = nil

local HSD_MENU_LVL =
{
	MAIN		= 0,
	CNTL_P1		= 1,
	CNTL_P2		= 2,
	BDA			= 3,	-- battle damage assessment
}

local HSD_DECLUTTER =
{
	LINE_1				= 1,
	LINE_2				= 2,
	LINE_3				= 4,
	LINE_4				= 8,
	RINGS				= 16,
	NAV_1				= 32,
	NAV_2				= 64,
	NAV_3				= 128,
	AIR_TARGETS			= 256,
	GROUND_TARGETS		= 512,
	SAM					= 1024,	-- friendly and hostile
	SHIPS				= 2048,	-- friendly and hostile
	AA_IDM				= 4096,
	AIR_SURVEILLANCE	= 8192,
	GROUND_FRIENDLIES	= 16384,	-- PPLI and SURV
	LAR					= 32768,	-- JASSM launch acceptability region
	FCR					= 65536,
	PRE					= 131072,
	AIFF				= 262144,
	L16_ENG				= 524288,
	REF_PT				= 1048576,
	PDLT_RNG			= 2097152,
}

local function DeclutterController(item)
	return {"MFD_HSD_Declutter", item}
end


----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
local Expand_layer = addPlaceholder("Expand_layer", nil, parent, {{"HSD_ExpandModes"}})
local HSDCenter = addPlaceholder("HSDCenter", nil, Expand_layer.name, {{"HSD_DisplayCenter", -100}})
addStrokeSymbol("Aircraft_Symbol", {"stroke_symbols_MFD", "Aircraft-symbol"}, "FromSet", {0, 0}, HSDCenter.name, {{"MFD_SetColor_Group_1"}}, 1.0)

----------------------------------------------------------------------------------------------------------------------------------------------
-- RINGS -------------------------------------------------------------------------------------------------------------------------------------
local RingsPH = addPlaceholder("RingsPH", nil, HSDCenter.name, {DeclutterController(HSD_DECLUTTER.RINGS), {"HSD_ShowElementAt_ExpandModes"}})
local RangeRingRadius = 100
addStrokeCircle("Range_Ring_1", RangeRingRadius * 1, nil, RingsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeCircle("Range_Ring_2", RangeRingRadius * 2, nil, RingsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeCircle("Range_Ring_3", RangeRingRadius * 3, nil, RingsPH.name, {{"HSD_HideDecenteredIndication"}, {"MFD_SetColor_Group_5"}})

local DirectionIndicatorsPH = addPlaceholder("DirectionIndicatorsPH", nil, RingsPH.name, {{"HSD_Heading"}})
addStrokeSymbol("DirectionIndicator_North", {"stroke_symbols_MFD", "HSD_North"}, "FromSet", {3, RangeRingRadius+8}, DirectionIndicatorsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeLine("DirectionIndicator_South", 15, {0, -RangeRingRadius - 5}, 0, DirectionIndicatorsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeLine("DirectionIndicator_East",  10, {RangeRingRadius, 0}, 90, DirectionIndicatorsPH.name, {{"MFD_SetColor_Group_5"}})
addStrokeLine("DirectionIndicator_West",  10, {-RangeRingRadius, 0}, -90, DirectionIndicatorsPH.name, {{"MFD_SetColor_Group_5"}})

----------------------------------------------------------------------------------------------------------------------------------------------
-- FCR Cone ----------------------------------------------------------------------------------------------------------------------------------
local FcrConePH = addPlaceholder("FcrConePH", nil, HSDCenter.name, {DeclutterController(HSD_DECLUTTER.FCR), {"MFD_HSD_RadarConeRot"}})
addVarLenStrokeLine("Azimuth_Scan_Limits_Left", RangeRingRadius * 2, nil, 0, FcrConePH.name, {{"HSD_ScanLimitLine", RangeRingRadius, 1}, {"MFD_SetColor_Group_1"}})
addVarLenStrokeLine("Azimuth_Scan_Limits_Right", RangeRingRadius * 2, nil, 0, FcrConePH.name, {{"HSD_ScanLimitLine", RangeRingRadius, -1}, {"MFD_SetColor_Group_1"}})
addStrokeCircle("Azimuth_Scan_Limits_Circle", 20, nil, FcrConePH.name, {{"HSD_ScanLimitCircle", RangeRingRadius}, {"MFD_SetColor_Group_1"}})

-- Heading PH
local Heading_PH = addPlaceholder("HSD_Heading_PH", nil, HSDCenter.name, {{"HSD_Heading"}})

---------------------------------------------------------------- LIGHT BLUE COLOR ----------------------------------------------------------------
local CicledCirleRoot = addPlaceholder("Bullseye_Root", nil, Heading_PH.name, {{"HSD_BullseyePosition", RangeRingRadius}})
local CicledCirleRadius = 1
addStrokeCircle("Bullseye_Cirle_First", CicledCirleRadius, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Second", CicledCirleRadius * 5, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})
addStrokeCircle("Bullseye_Cirle_Third", CicledCirleRadius * 10, nil, CicledCirleRoot.name, {{"MFD_SetColor_Group_1"}})


local Bullseye_LOS = addPlaceholder("Bullseye_LOS", {-213, -185}, parent, {{"HSD_BullseyeLOS_VisibleState", 1}})
local Bullseye_LOS_Radius = 17
addStrokeCircle("Bullseye_LOS_Cirle", Bullseye_LOS_Radius, nil, Bullseye_LOS.name, {{"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Range", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", nil, Bullseye_LOS.name, {{"HSD_BullseyeLOS_Range"}, {"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Bearing", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", {0, -Bullseye_LOS_Radius * 1.8}, Bullseye_LOS.name, {{"HSD_BullseyeLOS_Bearing"}, {"MFD_SetColor_Group_1"}})
local Bullseye_LOS_Pointer = addPlaceholder("Bullseye_LOS_Pointer", nil, Bullseye_LOS.name, {{"HSD_Heading"}, {"HSD_BullseyeLOS_PointerRotation"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_1", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.8)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_2", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.6)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_3", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.4)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_4", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.2)

local Aircraft_reference_symbol_Root = addPlaceholder("Aircraft_reference_symbol_Root", {0,0}, parent, {{"HSD_BullseyeLOS_VisibleState", 0}})
-- A/C Reference symbol
local AC_Reference_PH = addPlaceholder("AC_Reference_root", {-215, -210}, Aircraft_reference_symbol_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("Aircraft_reference_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_PH.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("Azimuth_Steering_Bar", 40, {0, -20}, 0, AC_Reference_PH.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_PH.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

---------------------------------------------------------------- END LIGHT BLUE COLOR ----------------------------------------------------------------

-------------------------------------------------------------------- YELLOW COLOR --------------------------------------------------------------------
 -- own markpoints
 for index = 0, 4 do
    local MARK_Root = addPlaceholder("MARK_Own_Root_"..index, nil, Heading_PH.name, {{"HSD_MarkpointPosition", RangeRingRadius, index}})
	local MARK_Root_rotation = addPlaceholder("MARK_Root_rotation"..index, nil, MARK_Root.name, {{"HSD_MarkpointRotation", index}})
	addStrokeLine("MARK_Own_Mark1"..index, 11, { 3,  -4},   30,     MARK_Root_rotation.name,     {{"MFD_SetColor_Yellow"}})
    addStrokeLine("MARK_Own_Mark2"..index, 11, {-3,  -4},  -30,     MARK_Root_rotation.name,     {{"MFD_SetColor_Yellow"}})
 end
---------------------------------------------------------------- END YELLOW COLOR --------------------------------------------------------------------

---------------------------------------------------------------- WHITE COLOR ----------------------------------------------------------------

addStrokeSymbol("HSD cursor", {"stroke_symbols_MFD", "HSD-Cursor"}, "FromSet", {0, 0}, parent, {{"HSD_Cursor"}, {"MFD_SetColor_Group_2"}})

addStrokeSymbol("HSD ghost AG cursor", {"stroke_symbols_MFD", "HSD-Ghost-AG-Cursor"}, "FromSet", {0, 0}, Heading_PH.name, {{"HSD_Ghost_AG_Cursor", RangeRingRadius}, {"MFD_SetColor_Group_2"}})

local CursorRoot = addPlaceholder("HSD_Cursor_Root", {0, 0}, parent, {{"HSD_AA_GostCursor"}, {"MFD_SetColor_Group_2"}})
addStrokeLine("HSD_Cursor_Line_Left", 30, {15, -15}, 0, CursorRoot.name, {{"MFD_SetColor_Group_2"}})
addStrokeLine("HSD_Cursor_Line_Right", 30, {-15, -15}, 0, CursorRoot.name, {{"MFD_SetColor_Group_2"}})

local circleRadius = 4
for i = 0, 24 do

    local STPT_Root = addPlaceholder("NavRoute_1_WYPT_Root_"..i, nil, Heading_PH.name, {{"HSD_WaypointPosition", RangeRingRadius, i}})

    addStrokeCircle("NavRoute_1_WYPT_circle_"..i, circleRadius, nil, STPT_Root.name, {{"HSD_WaypointType", WPT_Types.STPT, i}, {"MFD_SetColor_Group_2"}})

    for j = 1, 4 do
        addStrokeCircle("NavRoute_1_Selected_STPT_circle_"..i.."_"..j, j, nil, STPT_Root.name, {{"HSD_WaypointType", WPT_Types.STPT_SELECTED, i}, {"MFD_SetColor_Group_2"}})
    end
end

for i = 0, 23 do
    addVarLenStrokeLine("NavRoute_1_Line_"..i, 80, nil, nil, Heading_PH.name, {{"HSD_NavRouteLine", RangeRingRadius, i, circleRadius}, {"MFD_SetColor_Group_2"}})
 end

 -- bearing and range from steerpoint/bullseye
addStrokeText("HSD_Bearing_range", "000 00", STROKE_FNT_DFLT_8_12, "LeftCenter", {PB_positions[17][1] - 5, PB_positions[17][2] - 35}, nil, {{"HSD_BearingRangeLabel"}})
addStrokeText("HSD_Bearing_range_HSD_cursor", "000 00", STROKE_FNT_DFLT_8_12, "RightCenter", {PB_positions[9][1] - 5, PB_positions[9][2] - 35}, nil, {{"HSD_BearingRangeCursorLabel"}})

-- DL markpoints
 for index = 0, 199 do
    local DL_MARK_Root = addPlaceholder("DL_MARK_Own_Root_"..index, nil, Heading_PH.name, {{"HSD_DL_MarkpointPosition", RangeRingRadius, index}})
	local DL_MARK_Root_rotation = addPlaceholder("DL_MARK_Root_rotation"..index, nil, DL_MARK_Root.name, {{"HSD_DL_MarkpointRotation", index}})
	addStrokeText("DL_MARK"..index, "X", STROKE_FNT_DFLT_8_12, "CenterCenter", {0,0}, DL_MARK_Root_rotation.name, {{"MFD_SetColor_Group_2"}})
 end
---------------------------------------------------------------- END WHITE COLOR ----------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------
-- MENU --------------------------------------------------------------------------------------------------------------------------------------
local HSD_MENU_PH_MAIN		= addPlaceholder("HSD_Main_Menu_PH",	nil, nil, {{"MFD_HSD_MenuShow", HSD_MENU_LVL.MAIN}})
local HSD_MENU_PH_CNTL_P1	= addPlaceholder("HSD_CNTL_P1_Menu_PH",	nil, nil, {{"MFD_HSD_MenuShow", HSD_MENU_LVL.CNTL_P1}})
local HSD_MENU_PH_CNTL_P2	= addPlaceholder("HSD_CNTL_P2_Menu_PH",	nil, nil, {{"MFD_HSD_MenuShow", HSD_MENU_LVL.CNTL_P2}})
local HSD_MENU_PH_BDA		= addPlaceholder("HSD_BDA_Menu_PH",		nil, nil, {{"MFD_HSD_MenuShow", HSD_MENU_LVL.BDA}})

-- MAIN MENU --------------------------------------------------------------------
-- upper
add_PB_label(1, "   ",	HSD_MENU_PH_MAIN.name, {{"HSD_CenteredPBLabel"}, {"HSD_ShowElementAt_ExpandModes"}, {"HSD_ShowElementAt_ZoomFunction"}})
add_PB_label(2, "DCPL",	HSD_MENU_PH_MAIN.name, {{"HSD_DCPL_PB_Label"}, {"HSD_ShowElementAt_ExpandModes"}, {"HSD_ShowElementAt_ZoomFunction"}})
add_PB_label(3, 			"NORM",		HSD_MENU_PH_MAIN.name, {{"HSD_DecluttEXP", 2}})
add_Selectable_PB_Label(3, 	"EXP1", 	HSD_MENU_PH_MAIN.name, {{"HSD_DecluttEXP", 1, 0, 0}}, {{"HSD_DecluttEXP", 1, 1, 0}})
add_Selectable_PB_Label(3, 	"EXP2", 	HSD_MENU_PH_MAIN.name, {{"HSD_DecluttEXP", 1, 0, 1}}, {{"HSD_DecluttEXP", 1, 1, 1}})
add_Selectable_PB_Label(3, 	"ZOOM", 	HSD_MENU_PH_MAIN.name, {{"HSD_ZOOM_Label", 1, 0}}, {{"HSD_ZOOM_Label", 1, 1}})
add_PB_label(4, "MSG",	HSD_MENU_PH_MAIN.name, {{"HSD_ShowElementAt_ZoomFunction"}})
add_PB_label(5, "CNTL",	HSD_MENU_PH_MAIN.name, {{"HSD_ShowElementAt_ZoomFunction"}})
-- right
add_Simple_PB_label(6, "XMT\nOFF", HSD_MENU_PH_MAIN.name, {{"MFD_HSD_MenuLabel_XMT"}, {"HSD_ShowElementAt_ZoomFunction"}}, nil, {"", "XMT\nOFF", "XMT\nL16", "XMT\nIDM"})
add_Selectable_PB_Label(6, "XMT\nL16", HSD_MENU_PH_MAIN.name, {{"MFD_HSD_MenuLabel_XMT_Highlighted", 0}}, {{"MFD_HSD_MenuLabel_XMT_Highlighted", 1}})
add_PB_label(7, "FZ", HSD_MENU_PH_MAIN.name, {{"HSD_ShowElementAt_ZoomFunction"}})
--add_PB_label(8, "NOGO", HSD_MENU_PH_MAIN.name)
add_Simple_PB_label(9, "FR\nON", HSD_MENU_PH_MAIN.name, {{"MFD_HSD_MenuLabel_DecluttFR"}, {"HSD_ShowElementAt_ZoomFunction"}}, nil, {"", "FR\nON", "FL\nON", "FR\nOFF"})
add_Simple_PB_label(10, "C\nZ", HSD_MENU_PH_MAIN.name, {{"HSD_AG_CZ_LabelShow"}})
-- left
--add_PB_label(18, "WLCO")
local RangeScaleRoot = addPlaceholder("Range_Scale_Root", {PB_positions[20][1] + 10 , (PB_positions[20][2] - PB_positions[19][2]) / 2 + PB_positions[19][2]}, HSD_MENU_PH_MAIN.name)
addStrokeText("Range_Scale_Value", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-12, 0}, RangeScaleRoot.name, {{"HSD_Scale"}, {"HSD_ShowElementAt_ExpandModes"}})
local DecrementSymbol = addStrokeSymbol("Decrement_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -25}, RangeScaleRoot.name, {{"HSD_ShowDecreaseScaleSymbol"}, {"HSD_ShowElementAt_ExpandModes"}, {"HSD_ShowElementAt_ZoomFunction"}}, 3.5)
local IncrementSymbol = addStrokeSymbol("Increment_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, 25}, RangeScaleRoot.name, {{"HSD_ShowIncreaseScaleSymbol"}, {"HSD_ShowElementAt_ExpandModes"}, {"HSD_ShowElementAt_ZoomFunction"}}, 3.5)
IncrementSymbol.init_rot = {180}
addSizeClipMask(RangeScaleRoot, 2, 72, {{"HSD_ShowElementAt_ExpandModes", RangeScaleRoot.name}, {"HSD_ShowElementAt_ZoomFunction"}}, {-19, 0})

local RangeScaleRootZoom = addPlaceholder("Range_Scale_RootZoom", {PB_positions[20][1] + 10 , (PB_positions[20][2] - PB_positions[19][2]) / 2 + PB_positions[19][2]}, HSD_MENU_PH_MAIN.name)
addSizeClipMask(RangeScaleRootZoom, 2, 20, {{"HSD_ShowScaleMask"}}, {-19, 0})

-- CNTL MENU -----------------------------------------------------------------------
local function addDeclutterPB(pb_num, text, parent, item)
	add_Selectable_PB_Label(pb_num, text, parent, {{"MFD_HSD_SelectedDeclutter", 0, item}},	{{"MFD_HSD_SelectedDeclutter", 1, item}})
end

-- CNTL MENU P1 --------------------------------------------------------------------
-- upper
addDeclutterPB(1, "FCR",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.FCR)
addDeclutterPB(2, "PRE",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.PRE)
addDeclutterPB(3, "AIFF",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.AIFF)
add_PB_label(5, "CNTL",				HSD_MENU_PH_CNTL_P1.name)
-- right
addDeclutterPB(6, "LINE1",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.LINE_1)
addDeclutterPB(7, "LINE2",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.LINE_2)
addDeclutterPB(8, "LINE3",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.LINE_3)
addDeclutterPB(9, "LINE4",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.LINE_4)
add_Simple_PB_label(10, "PAGE\n1",	HSD_MENU_PH_CNTL_P1.name)



-- left
--add_Simple_PB_label(16, "RPT",	HSD_MENU_PH_CNTL_P1.name)
addDeclutterPB(17, "RINGS",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.RINGS)
addDeclutterPB(18, "NAV3",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.NAV_3)
addDeclutterPB(19, "NAV2",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.NAV_2)
addDeclutterPB(20, "NAV1",			HSD_MENU_PH_CNTL_P1.name, HSD_DECLUTTER.NAV_1)

-- CNTL MENU P2 --------------------------------------------------------------------
-- upper
addDeclutterPB(1, "L16\nENG",		HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.L16_ENG)
addDeclutterPB(2, "REF\nPT ",		HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.REF_PT)
addDeclutterPB(4, "PDLT\nRNG ",		HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.PDLT_RNG)
add_PB_label(5, "CNTL",				HSD_MENU_PH_CNTL_P2.name)
-- right
addDeclutterPB(6, "A SURV",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.AIR_SURVEILLANCE)
addDeclutterPB(7, "G FRND",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.GROUND_FRIENDLIES)
addDeclutterPB(8, "LAR",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.LAR)
add_Simple_PB_label(9, "MP  ",		HSD_MENU_PH_CNTL_P2.name)
add_Simple_PB_label(10, "PAGE\n2",	HSD_MENU_PH_CNTL_P2.name)
-- left
addDeclutterPB(16, "A IDM",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.AA_IDM)
addDeclutterPB(17, "SHIP",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.SHIPS)
addDeclutterPB(18, "SAM",			HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.SAM)
addDeclutterPB(19, "G TGTS",		HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.GROUND_TARGETS)
addDeclutterPB(20, "A TGTS",		HSD_MENU_PH_CNTL_P2.name, HSD_DECLUTTER.AIR_TARGETS)

-- BDA MENU --------------------------------------------------------------------
-- upper
add_PB_label(5, "RPT",					HSD_MENU_PH_BDA.name)
-- right
add_Simple_PB_label(6, "TGT\nDSTR",		HSD_MENU_PH_BDA.name)
add_Simple_PB_label(7, "PRTLY\nDSTR",	HSD_MENU_PH_BDA.name)
add_Simple_PB_label(8, "DIS\nENG",		HSD_MENU_PH_BDA.name)


----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
local Bullseye_LOS_Mask_PH = addPlaceholder("Bullseye_LOS_Mask_PH", {-220, -195})
addSizeClipMask(Bullseye_LOS_Mask_PH, 2, 70, nil, {-19, 0})

----------------------------------------------------------------------------------------------------------------------------------------------
-- dynamic symbols ---------------------------------------------------------------------------------------------------------------------------
local PosValidPH = addPlaceholder("HSD_AircraftPosValid_PH", nil, nil, {{"MFD_HSD_AircraftPosValid"}})
addPlaceholder("Link16_DefenseZones_Keeper", nil, PosValidPH.name, {DeclutterController(HSD_DECLUTTER.SAM), {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.HSD_DEFENSE_ZONES}})
addPlaceholder("System_AirTracks_Keeper", nil, PosValidPH.name, {{"MFD_HSD_SystemAirTracksShow"}, {"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.HSD_SYSTEM_TRACKS}})
