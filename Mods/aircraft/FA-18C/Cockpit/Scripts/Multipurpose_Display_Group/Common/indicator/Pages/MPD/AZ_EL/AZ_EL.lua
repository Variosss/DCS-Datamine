dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_Defs.lua")

addMPD_TDC_diamond()

local backParentId = 
{
    parentForAZ_ELMode = 0,
    parentForUsers = 1,
}

local AOT_zone_posY = tactical_display_sz_half - RDR_AOT_zoneSizeDI -- defined in RadarDefs.lua

local AZ_EL_BLOCK = "AZ_EL_BLOCK"
addPlaceholder(AZ_EL_BLOCK, {0, 0}, nil, {{"MPD_RDR_AZ_EL_Block", backParentId.parentForUsers}})
addStrokeText("Placeholder_AZ/EL", "AZ/EL PAGE\nPLACEHOLDER", STROKE_FNT_DFLT_200, "CenterCenter", nil, AZ_EL_BLOCK)

local AZ_EL_Back_parent = "AZ_EL_Back_parent"
addPlaceholder(AZ_EL_Back_parent, {0, 0}, nil, {{"MPD_RDR_AZ_EL_Block", backParentId.parentForAZ_ELMode}})

-- TDC (Acquisition Cursor), radar positioned
local acqCursPlacehldName = "AcquisitionCursorPlaceholder"
local AcquisitionCursorPlaceholder = addPlaceholder(acqCursPlacehldName, nil, AZ_EL_Back_parent, {{"TDC_assignedDisplay"}, {"MPD_RDR_AZ_EL_TDC_position", InToDI(5) / 2, PB_positions[4][1] + side_PB_shiftX}})
addStrokeLine("Acquisition_cursor_line_left",   RDR_TDC_HeightDI, {-RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, 0, acqCursPlacehldName, {{"MPD_RDR_EADI_SetYellowColor"}})
addStrokeLine("Acquisition_cursor_line_left_1", RDR_TDC_HeightDI, {-1, 0}, nil, "Acquisition_cursor_line_left", {{"MPD_RDR_EADI_SetYellowColor"}})
addStrokeLine("Acquisition_cursor_line_left_2", RDR_TDC_HeightDI, {1,  0}, nil, "Acquisition_cursor_line_left", {{"MPD_RDR_EADI_SetYellowColor"}})
addStrokeLine("Acquisition_cursor_line_right",   RDR_TDC_HeightDI, {RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, 0, acqCursPlacehldName, {{"MPD_RDR_EADI_SetYellowColor"}})
addStrokeLine("Acquisition_cursor_line_right_1", RDR_TDC_HeightDI, {-1, 0}, nil, "Acquisition_cursor_line_right", {{"MPD_RDR_EADI_SetYellowColor"}})
addStrokeLine("Acquisition_cursor_line_right_2", RDR_TDC_HeightDI, {1,  0}, nil, "Acquisition_cursor_line_right", {{"MPD_RDR_EADI_SetYellowColor"}})
    
-- Scan Centering Cross
local scanCenteringCross = addPlaceholder("RDR_AZ_EL_ScanCenteringCross", nil, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_ScanCenteringCross", InToDI(5) / 2}})
addStrokeLine("horLine",   RDR_TDC_HeightDI, {0, -RDR_TDC_HeightDI/2}, 0, scanCenteringCross.name)
addStrokeLine("horLine_1", RDR_TDC_HeightDI, {-1, 0}, nil, "horLine")
addStrokeLine("horLine_2", RDR_TDC_HeightDI, {1,  0}, nil, "horLine")
addStrokeLine("verLine",   RDR_TDC_HeightDI, {-RDR_TDC_HeightDI/2, 0}, 270, scanCenteringCross.name)
addStrokeLine("verLine_1", RDR_TDC_HeightDI, {-1, 0}, nil, "verLine")
addStrokeLine("verLine_2", RDR_TDC_HeightDI, {1,  0}, nil, "verLine")
addStrokeText("RadarAltitudeUpper", "        ", STROKE_FNT_DFLT_100, "RightBottom", {-RDR_TDC_HeightDI/2, RDR_TDC_HeightDI/4}, scanCenteringCross.name,
    {{"MPD_RDR_AZ_EL_ScanCenteringCrossRadarAltitude", 0}})
addStrokeText("RadarAltitudeLower", "        ", STROKE_FNT_DFLT_100, "RightBottom", {-RDR_TDC_HeightDI/2, -RDR_TDC_HeightDI/2}, scanCenteringCross.name,
    {{"MPD_RDR_AZ_EL_ScanCenteringCrossRadarAltitude", 1}})

local operModePosX = -tactical_display_sz_half + 4
local operModePosY = tactical_display_sz_half + RF_channel_shiftY + glyphNominalHeight120 + 5
addStrokeText("Radar_operating_condition", nil, STROKE_FNT_DFLT_120, "RightBottom", {operModePosX, operModePosY}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_OperatingCondition"}})
    
addStrokeText("Radar_mode", nil, STROKE_FNT_DFLT_120, "LeftCenter", {PB_positions[5][1] + side_PB_shiftX, 335}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_OperatingMode"}},
	{"", "RDR\nRWS", "RDR\nVS", "RDR\nTWS", "RDR\nMAP", "RDR\nGMT", "RDR\nSEA", "RDR\nTA", "RDR\nAGR", "RDR\nPVU"})
add_X_Over("Radar_mode_X_Over", 66, 24, {glyphNominalWidth120 * 1.5 + fontIntercharDflt120, 0}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_OperatingModeFail"}})

addStrokeText("AC_heading", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {0, upper_data_block_posY}, AZ_EL_Back_parent,
	{{"MPD_RDR_AC_Heading"}}, {"%03.0f°"})

addStrokeBox("AZ_EL_grid", tactical_display_sz, tactical_display_sz, "CenterCenter", {0, 0}, AZ_EL_Back_parent)
addStrokeLine("EL_axis", tactical_display_sz, {0, -tactical_display_sz_half}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})
addStrokeLine("AZ_axis", tactical_display_sz, {-tactical_display_sz_half, 0}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})

local stepMarkAZ_axis = 30 * tactical_display_sz / 140;
local heightMarkAZ_axis = 40;
local markAZ_posY = -heightMarkAZ_axis / 2
addStrokeLine("AZ_axis_1_0", heightMarkAZ_axis, {-stepMarkAZ_axis, markAZ_posY}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})
addStrokeLine("AZ_axis_1_1", heightMarkAZ_axis, {stepMarkAZ_axis, markAZ_posY}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})
addStrokeLine("AZ_axis_2_0", heightMarkAZ_axis, {-stepMarkAZ_axis * 2, markAZ_posY}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})
addStrokeLine("AZ_axis_2_1", heightMarkAZ_axis, {stepMarkAZ_axis * 2, markAZ_posY}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis"}})

local stepVerticalMark15Degree = 15 * tactical_display_sz / 60;
addStrokeLine("EL_axis_Mark_15_0", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, -stepVerticalMark15Degree}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_60"}})
addStrokeLine("EL_axis_Mark_15_1", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, stepVerticalMark15Degree}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_60"}})

local stepVerticalMark30Degree = 30 * tactical_display_sz / 140;
addStrokeLine("EL_axis_Mark_30_0", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, -stepVerticalMark30Degree}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_140"}})
addStrokeLine("EL_axis_Mark_30_1", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, stepVerticalMark30Degree}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_140"}})
addStrokeLine("EL_axis_Mark_30_2", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, -stepVerticalMark30Degree * 2}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_140"}})
addStrokeLine("EL_axis_Mark_30_3", heightMarkAZ_axis, {-heightMarkAZ_axis / 2, stepVerticalMark30Degree * 2}, 270, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_Elevation_Axis_Marks_140"}})

addStrokeLine("AOT_zone_line", tactical_display_sz, {tactical_display_sz_half, AOT_zone_posY}, 90, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_AOT_ZONE_LINE"}})

addStrokeText("TopScaleValue", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {tactical_display_sz_half, tactical_display_sz_half + 20}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_TopScaleValue"}}, {"%d°"})
addStrokeText("BottomScaleValue", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {tactical_display_sz_half, -tactical_display_sz_half - 40}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_BottomScaleValue"}}, {"%d°"})

addStrokeText("HorizontalCenterPosition", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {0, 0}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_HorizontalCenterPosition", tactical_display_sz_half}}, {"%d°%s"})
addStrokeText("VerticalCenterPosition", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {0, 0}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_VerticalCenterPosition", tactical_display_sz_half}}, {"%d°%s"})

addStrokeText("TargetClosingVelocity", "        ", STROKE_FNT_DFLT_120, "RightBottom", {0, 0}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_TargetClosingVelocity", tactical_display_sz_half}}, {"%d VC"})
addStrokeText("TargetRange", "        ", STROKE_FNT_DFLT_120, "RightBottom", {0, 0}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_TargetRange", tactical_display_sz_half}}, {"%.1f RNG"})
addStrokeText("TargetHeading", "        ", STROKE_FNT_DFLT_120, "RightBottom", {0, 0}, AZ_EL_Back_parent,
    {{"MPD_RDR_AZ_EL_TargetHeading", tactical_display_sz_half}}, {"HD %d°"})

addStrokeText("CIT_RangeCoverage_IFF_Label", "I\nF\nF\n", STROKE_FNT_DFLT_120, "RightCenter", {tactical_display_sz_half + 30, 60}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_RANGE_COVERAGE_IFF_Label"}})
addStrokeText("CIT_RangeCoverage", "", STROKE_FNT_DFLT_120, "RightCenter", {505, 60}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_RANGE_COVERAGE"}})

addStrokeLine("CIT_FOV_left", tactical_display_sz, {0, -tactical_display_sz_half}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_FOV_left"}})
addStrokeLine("CIT_FOV_right", tactical_display_sz, {0, -tactical_display_sz_half}, 0, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_FOV_right"}})

---------------------------------------------------------------- ID Windows (for TUC or L&S) ----------------------------------------------------------------
local function textWidth120(chars_count)
	local space_count = chars_count - 1
	if space_count < 0 then
		space_count = 0
	end
	--return chars_count * glyphNominalWidth120 + space_count * fontIntercharDflt120
	return chars_count * (glyphNominalWidth120 + fontIntercharDflt120)
end

local function addSurvSymbol(name, symbol, pos, parent, controllers)
	local scale = 0.7
	local symbol_upper = addStrokeSymbol(name.."_upper", symbol, "FromSet", pos, parent, controllers, scale)
	local symbol_lower = addStrokeSymbol(name.."_lower", symbol, "FromSet", pos, parent, controllers, scale)
	symbol_lower.init_rot = {180}
end



local linespace = 40
local IDsLowLineY = -tactical_display_sz_half + 80
local MSIWindowData = addPlaceholder("AZ_EL_MSIWindowData", nil, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_Show"}})

-- Left ID Windows
local LeftIDs = addPlaceholder("AZ_EL_MSIWindowDataLeft", {-tactical_display_sz_half + 40, IDsLowLineY}, MSIWindowData.name)
-- LINE 3: SURV
local survIDs = addPlaceholder("AZ_EL_MSIWindowData_survIDs", {0, linespace * 3}, LeftIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_SURV_Show"}})
addStrokeText("IDsWindowLeft_SurvLbl",	"L16",		STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(2), 0}, survIDs.name)
addStrokeText("IDsWindowLeft_SurvType",	"XXXXX",	STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(7), 0}, survIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_SURV_Type"}})
local survSymbolPos = {textWidth120(0.5), 0}
addSurvSymbol("IDsWindowLeft_SurvSymbolFriend",  {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, survSymbolPos, survIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_SURV_Symbol", HAFU_TYPE.FRIENDLY}})
addSurvSymbol("IDsWindowLeft_SurvSymbolHostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},  survSymbolPos, survIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_SURV_Symbol", HAFU_TYPE.HOSTILE}})
addSurvSymbol("IDsWindowLeft_SurvSymbolUnknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},  survSymbolPos, survIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_SURV_Symbol", HAFU_TYPE.UNKNOWN}})
-- LINE 2: not defined
-- LINE 1 and 0: PPLI and IFF
local ppliIDs = addPlaceholder("AZ_EL_MSIWindowData_ppliIDs", {0, linespace * 0}, LeftIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_PPLI_Show"}})
addStrokeText("IDsWindowLeft_IFFM3",	"3-XXXX",	STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(0), linespace * 1}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_IFF_M3"}})
addStrokeText("IDsWindowLeft_IFFM3C",	"C",		STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(7), linespace * 1}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_IFF_M3C"}})
addStrokeText("IDsWindowLeft_PltId",	"^PILOT",	STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(8), linespace * 1}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_PPLI_VCS"}})
addStrokeText("IDsWindowLeft_PPLI",		"P",		STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(0), linespace * 0}, ppliIDs.name)
addStrokeText("IDsWindowLeft_IFFM4",	"4",		STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(2), linespace * 0}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_IFF_M4"}})
addStrokeText("IDsWindowLeft_IFFM1",	"1-XX",		STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(4), linespace * 0}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_IFF_M1"}})
addStrokeText("IDsWindowLeft_IFFM2",	"2-XXXX",	STROKE_FNT_DFLT_120, "LeftCenter", {textWidth120(9), linespace * 0}, ppliIDs.name, {{"MPD_RDR_AZ_EL_MSI_WINDOW_DATA_IFF_M2"}})

------------------------------------------------------------------------- LTWS -----------------------------------------------------------------------------------------------------------------
local RangeTickLen = 55 --60
local trackedTgt_MachAlt_ShiftX		= 27
-- TWS L&S symbology
local TWS_LS_Placeholder = addPlaceholder("TWS_LS_Placeholder", {0, 0}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_TWS_LS_IndicationShow", tactical_display_sz_half}})

local TWS_LS_HAFU_Symbol_Placeholder = addPlaceholder("TWS_LS_HAFU_Symbol_Placeholder", nil, TWS_LS_Placeholder.name, {{"MPD_RDR_AZ_EL_TWS_LS_SymbolPosition", tactical_display_sz_half}})
addStrokeText("TWS_LS_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Mach"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Altitude"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Jamming"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_FLIRTrack"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})

addStrokeSymbol("TWS_LS_HAFU_Symbol_Friendly",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_HAFUSymbol", HAFU_TYPE.FRIENDLY},	{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeSymbol("TWS_LS_HAFU_Symbol_Hostile",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_HAFUSymbol", HAFU_TYPE.HOSTILE},		{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeSymbol("TWS_LS_HAFU_Symbol_Unknown",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_HAFUSymbol", HAFU_TYPE.UNKNOWN},		{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeSymbol("TWS_LS_HAFU_Symbol_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeSymbol("TWS_LS_HAFU_Symbol_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
add_L_S_Symbol( "TWS_LS_", TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
local symbol
symbol = addStrokeSymbol("TWS_LS_HAFU_Symbol_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Offboard", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_LS_HAFU_Symbol_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Offboard", HAFU_TYPE.HOSTILE}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_LS_HAFU_Symbol_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Offboard", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_LS_HAFU_Symbol_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Offboard", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
symbol.init_rot = {180}

-- TWS DT2 symbology
local TWS_DT2_Placeholder = addPlaceholder("TWS_DT2_Placeholder", {0, 0}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_TWS_DT2_IndicationShow", tactical_display_sz_half}})

local TWS_DT2_HAFU_Symbol_Placeholder = addPlaceholder("TWS_DT2_HAFU_Symbol_Placeholder", nil, TWS_DT2_Placeholder.name, {{"MPD_RDR_AZ_EL_TWS_DT2_SymbolPosition", tactical_display_sz_half}})
addStrokeText("TWS_DT2_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Mach"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Altitude"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Jamming"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_FLIRTrack"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})

addStrokeSymbol("TWS_DT2_HAFU_Symbol_Friendly",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_HAFUSymbol", HAFU_TYPE.FRIENDLY},	{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeSymbol("TWS_DT2_HAFU_Symbol_Hostile",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_HAFUSymbol", HAFU_TYPE.HOSTILE},	{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeSymbol("TWS_DT2_HAFU_Symbol_Unknown",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_HAFUSymbol", HAFU_TYPE.UNKNOWN},	{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeSymbol("TWS_DT2_HAFU_Symbol_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeSymbol("TWS_DT2_HAFU_Symbol_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeSymbol(TWS_DT2_HAFU_Symbol_Placeholder.name.."_DT2", {"stroke_symbols_MDI_AMPCD", "SA-DT2"}, "FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
symbol = addStrokeSymbol("TWS_DT2_HAFU_Symbol_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Offboard", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_DT2_HAFU_Symbol_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Offboard", HAFU_TYPE.HOSTILE}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_DT2_HAFU_Symbol_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Offboard", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_DT2_HAFU_Symbol_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Offboard", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
symbol.init_rot = {180}
------------------------------------------

-- tracked target shape
local targetPosScale = InToDI(4) / 2
local trackedTgtPlaceholder 		= addPlaceholder("TrackedTgtPlaceholder", nil, nil, {{"MPD_RDR_AA_TrackedTarget_Show", 1}, {"MPD_RDR_AZ_EL_AA_TrackedTarget_Pos", targetPosScale}})
addStrokeSymbol("TrackedTgt_HAFU_Symbol_Friendly",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_HAFU", HAFU_TYPE.FRIENDLY},		{"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeSymbol("TrackedTgt_HAFU_Symbol_Hostile",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_HAFU", HAFU_TYPE.HOSTILE},		{"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeSymbol("TrackedTgt_HAFU_Symbol_Unknown",		{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_HAFU", HAFU_TYPE.UNKNOWN},		{"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeSymbol("TrackedTgt_HAFU_Symbol_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_HAFU", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeSymbol("TrackedTgt_HAFU_Symbol_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_HAFU", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeText("TrackedTgt_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, trackedTgtPlaceholder.name, {{"MPD_RDR_TWS_AA_TrackedTarget_Jamming"}, {"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeText("TrackedTgt_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, trackedTgtPlaceholder.name, {{"MPD_RDR_TWS_AA_TrackedTarget_FLIRTrack"}, {"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeText("TrackedTgt_Symbol", "A", STROKE_FNT_DFLT_100, "CenterCenter", {0, 0}, trackedTgtPlaceholder.name, {{"MPD_RDR_TWS_AA_TrackedTarget_JammingState"}, {"MPD_RDR_AA_TrackedTarget_Color"}})
local TrackedTgt_L_AND_S_Root = addStrokeSymbol("TrackedTgt_L_And_S", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_LS_Show"}, {"MPD_RDR_AA_TrackedTarget_Color"}})
addStrokeSymbol(TrackedTgt_L_AND_S_Root.name.."_Filler_1", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, TrackedTgt_L_AND_S_Root.name, {{"MPD_RDR_AA_TrackedTarget_Color"}}, 0.8)
addStrokeSymbol(TrackedTgt_L_AND_S_Root.name.."_Filler_2", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, TrackedTgt_L_AND_S_Root.name, {{"MPD_RDR_AA_TrackedTarget_Color"}}, 0.6)
addStrokeSymbol(TrackedTgt_L_AND_S_Root.name.."_Filler_3", {"stroke_symbols_MDI_AMPCD", "SA-LS"}, "FromSet", nil, TrackedTgt_L_AND_S_Root.name, {{"MPD_RDR_AA_TrackedTarget_Color"}}, 0.4)
addStrokeCircle(TrackedTgt_L_AND_S_Root.name.."_Filler_4", 1, nil, TrackedTgt_L_AND_S_Root.name, {{"MPD_RDR_AA_TrackedTarget_Color"}})
symbol = addStrokeSymbol("TrackedTgt_HAFU_Symbol_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_OffboardSymbol", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_AA_TrackedTarget_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TrackedTgt_HAFU_Symbol_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_OffboardSymbol", HAFU_TYPE.HOSTILE}, {"MPD_RDR_AA_TrackedTarget_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TrackedTgt_HAFU_Symbol_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_OffboardSymbol", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_AA_TrackedTarget_Color"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TrackedTgt_HAFU_Symbol_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_OffboardSymbol", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_AA_TrackedTarget_Color"}})
symbol.init_rot = {180}

-- TODO:
-- tracked multiple target shape

-- tracked target Mach
addStrokeText("TrackedTgtMach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_Mach"}, {"MPD_RDR_AA_TrackedTarget_Color"}})

-- tracked target altitude
addStrokeText("TrackedTgtAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_Altitude"}, {"MPD_RDR_AA_TrackedTarget_Color"}})

-- Radar Rectangle
local radarRectLines = 
{
    topLine = 0,
    bottomLine = 1,
    leftLine = 2,
    rightLine = 3,
}
addVarLenStrokeLine("Top_Line_Radar_rect", 0, {0, 0}, 270, AZ_EL_Back_parent, 
                    {{"MPD_RDR_AZ_EL_Radar_rectangle", radarRectLines.topLine, tactical_display_sz, tactical_display_sz_half - AOT_zone_posY}, {"MPD_RDR_AZ_EL_Radar_rectangle_Color"}, {"MPD_RDR_AZ_EL_Radar_rectangle_Intensity"}})
addVarLenStrokeLine("Bottom_Line_Radar_rect", 0, {0, 0}, 270, AZ_EL_Back_parent, 
                    {{"MPD_RDR_AZ_EL_Radar_rectangle", radarRectLines.bottomLine, tactical_display_sz, tactical_display_sz_half - AOT_zone_posY}, {"MPD_RDR_AZ_EL_Radar_rectangle_Color"}, {"MPD_RDR_AZ_EL_Radar_rectangle_Intensity"}})
addVarLenStrokeLine("Left_Line_Radar_rect", 0, {0, 0}, 0, AZ_EL_Back_parent, 
                    {{"MPD_RDR_AZ_EL_Radar_rectangle", radarRectLines.leftLine, tactical_display_sz, tactical_display_sz_half - AOT_zone_posY}, {"MPD_RDR_AZ_EL_Radar_rectangle_Color"}, {"MPD_RDR_AZ_EL_Radar_rectangle_Intensity"}})
addVarLenStrokeLine("Right_Line_Radar_rect", 0, {0, 0}, 0, AZ_EL_Back_parent, 
                    {{"MPD_RDR_AZ_EL_Radar_rectangle", radarRectLines.rightLine, tactical_display_sz, tactical_display_sz_half - AOT_zone_posY}, {"MPD_RDR_AZ_EL_Radar_rectangle_Color"}, {"MPD_RDR_AZ_EL_Radar_rectangle_Intensity"}})
------------------------------------------

-- FLIR
local AZ_EL_Flir_root	= addPlaceholder("AZ_EL_Flir_root", {0, 0}, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_FLIR_ACTIVE"}})
local AZ_EL_Flir_root_L	= addPlaceholder("AZ_EL_Flir_root_L", {0, 0}, AZ_EL_Back_parent, {{"MPD_FLIR_TgpType", LITENING}, {"MPD_RDR_AZ_EL_FLIR_ACTIVE"}})
local AZ_EL_Flir_root_A	= addPlaceholder("AZ_EL_Flir_root_A", {0, 0}, AZ_EL_Back_parent, {{"MPD_FLIR_TgpType", ATFLIR}, {"MPD_RDR_AZ_EL_FLIR_ACTIVE"}})
addStrokeBox("FLIR_LOS_Cue", 80, 80, "CenterCenter", nil, AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 0}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})

local FLIR_Hexagon_line_length = 40;
local FLIR_Hexagon = addPlaceholder("FLIR_Hexagon", {0, 0}, AZ_EL_Back_parent)
addStrokeLine("FLIR_Hexagon_line_1",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 0}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})
addStrokeLine("FLIR_Hexagon_line_2",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 1}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})
addStrokeLine("FLIR_Hexagon_line_3",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 2}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})
addStrokeLine("FLIR_Hexagon_line_4",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 3}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})
addStrokeLine("FLIR_Hexagon_line_5",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 4}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})
addStrokeLine("FLIR_Hexagon_line_6",   FLIR_Hexagon_line_length, nil, 0, FLIR_Hexagon.name, {{"MPD_RDR_AZ_EL_FLIR_LOS_Cue", tactical_display_sz_half, 1, 5}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Color"}, {"MPD_RDR_AZ_EL_FLIR_LOS_Cue_Intensity"}})

addStrokeText("FLIR_SLAVE_Label_A", "S\nL\nA\nV\nE", STROKE_FNT_DFLT_120, "RightCenter", {470, 60}, AZ_EL_Flir_root_A.name)
local sideX = 26
local str_raw = "SLAVE"
local sideY = #str_raw * 32
addStrokeBox("AFLIR_SLAVE_Box_A", sideX, sideY, "RightCenter", {476,	60}, AZ_EL_Flir_root_A.name, {{"MPD_RDR_AZ_EL_AFLIR_SLAVE_Box"}})

------------------------------------------
add_PB_label(1, 	{"AUTO",    AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_CIT_AUTO_INT_PB_Label"}},	{{"MPD_RDR_AZ_EL_CIT_AUTO_INT_PB_Box"}}}, {"INT", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_AUTO_INT_PB_Label"}}})
add_PB_label(2, 	{"L+S",     AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_CIT_LS_INT_PB_Label"}},	{{"MPD_RDR_AZ_EL_CIT_LS_INT_PB_Box"}}},   {"INT", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_LS_INT_PB_Label"}}})
add_PB_label(4,     {"",        AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_STORES_FLIR_DIPLAY_PB_Label", 0}}}, {"", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_STORES_FLIR_DIPLAY_PB_Label", 1}}})
add_PB_label(6, 	{"",        AZ_EL_Flir_root.name,	{{"MPD_RDR_AZ_EL_FLIR_WFOV_NAR_PB_Label"}}})
add_PB_label(7, 	{"", 	    AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_CIT_INTERROGATION_TYPE_PB_Label", 0}}}, {"IFF", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_INTERROGATION_TYPE_PB_Label", 1}}})
add_PB_label(9, 	{" FOV ", 	AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_FOV_PB_Label"}}, {{"MPD_RDR_AZ_EL_FOV_PB_Box"}}})
add_PB_label(10, 	{" ID ",   	AZ_EL_Back_parent,		nil,	{{"MPD_RDR_AZ_EL_ID_PB_Box"}}}, {"",   AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_ID_PB_Label"}}})
add_PB_label(11, 	{"SCALE",   AZ_EL_Back_parent,		{{"MPD_RDR_AZ_EL_SCALE_PB_Label"}}}, {"EL", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_SCALE_PB_Label"}}})
add_PB_symbol(12,   "124-arrow-up", AZ_EL_Back_parent, 	{{"MPD_RDR_AZ_EL_CIT_RANGE_ARROWS"}})
add_PB_symbol(13,   "124-arrow-down", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_RANGE_ARROWS"}})
add_PB_label(12, 	{"L+S", 	AZ_EL_Flir_root_A.name,	nil, {{"MPD_RDR_AZ_EL_AFLIR_L_S_PB_Box"}}})
add_PB_label(13, 	{"     ", 	AZ_EL_Flir_root_L.name,	{{"MPD_RDR_AZ_EL_FLIR_VVSLV_PB_Label"}}, {{"MPD_RDR_AZ_EL_FLIR_VVSLV_PB_Box"}}})
add_PB_label(13, 	{"BST", 	AZ_EL_Flir_root_A.name,	nil, {{"MPD_RDR_AZ_EL_AFLIR_BST_PB_Box"}}})
add_PB_label(15,    {"DCLTR",   AZ_EL_Back_parent,		{{"MPD_AZ_EL_IFF_DCLTR_Label"}},	{{"MPD_AZ_EL_IFF_DCLTR_Box", 1}}}, {"IFF", AZ_EL_Back_parent, {{"MPD_AZ_EL_IFF_DCLTR_Label"}}, {{"MPD_AZ_EL_IFF_DCLTR_Box", 0}}})
add_PB_label(17, 	{"RSET", 	AZ_EL_Back_parent})

addPlaceholder("CITAzimuthCoverage_PH", nil, AZ_EL_Back_parent, {{"MPD_AZ_EL_RDR_CITAzimuthCoverageLayoutShow", 0}})
add_PB_label(19, 	{"",        "CITAzimuthCoverage_PH",		{{"MPD_RDR_AZ_EL_CIT_AZIMUTH_COVERAGE_PB_Label", 0}}}, {"IFF", AZ_EL_Back_parent, {{"MPD_RDR_AZ_EL_CIT_AZIMUTH_COVERAGE_PB_Label", 1}}})
add_PB_label(20, 	{"EXP", 	"CITAzimuthCoverage_PH",		nil,	{{"MPD_RDR_AZ_EL_EXP_PB_Box"}}})
addStrokeText("AzimuthScan_Additional_Layout", "20 40 80 140", PB_TextFont, "CenterCenter", {-256, -488}, AZ_EL_Back_parent, {{"MPD_AZ_EL_RDR_CITAzimuthCoverageLayoutShow", 1}})

addPlaceholder("TWS_Tracks_Keeper", nil, AZ_EL_Back_parent, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.AZ_EL_TRACKS}})