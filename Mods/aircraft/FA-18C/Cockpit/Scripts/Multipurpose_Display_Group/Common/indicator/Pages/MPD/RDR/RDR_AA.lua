dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

------------------------------------------------------------------------------
-- AA, non-backup, currently - RWS mode

local CAS_alt_large_placeholder = addPlaceholder("CAS_alt_large_placeholder", {0, 195}, nil, {{"MPD_RDR_ACM_AC_AirspeedAlt_Show"}})
local CAS_large_placeholder 	= addPlaceholder("CAS_large_placeholder", {-146, 0}, CAS_alt_large_placeholder.name)
local alt_large_placeholder 	= addPlaceholder("alt_large_placeholder", {277, 0}, CAS_alt_large_placeholder.name)

-- ACM A/C airspeed in the display center
addStrokeText("ACM_AC_airspeed", nil, STROKE_FNT_DFLT_150_WIDE, "RightBottom", {0, 0}, CAS_large_placeholder.name, {{"MPD_RDR_FLIR_AC_AirspeedNumerics"}})

-- TODO:
--  - different flash rate when altitude warning exists (reference - a SH vid), should be much slower than HUD symbols

-- ACM A/C altitude in the display center
-- altitude below 1000 ft
addStrokeText("ACM_AC_altitude_below_1000", nil, STROKE_FNT_DFLT_150_WIDE, "RightBottom", {-5, 0}, alt_large_placeholder.name, {{"MPD_RDR_FLIR_AC_AltitudeNumerics", 0}})
-- altitude above 1000 ft
local gap_alt_hund_tenths_large = 15
local shiftX_alt_thousands 	= fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3 + gap_alt_hund_tenths_large * 1.75
addStrokeText("ACM_AC_altitude_above_1000_thousands", nil, STROKE_FNT_DFLT_150_WIDE, "RightBottom", {-shiftX_alt_thousands, 0}, alt_large_placeholder.name,
	{{"MPD_RDR_FLIR_AC_AltitudeNumerics", 1}})
addStrokeText("ACM_AC_altitude_above_1000_hund_tenths", nil, STROKE_FNT_DFLT_120_WIDE, "RightBottom", {-gap_alt_hund_tenths_large, 0}, alt_large_placeholder.name,
	{{"MPD_RDR_FLIR_AC_AltitudeNumerics", 2}})

-- altitude symbol (none, R, flashing B)
-- COMMENTED after videos review
--addStrokeText("ACM_AC_altitude_symbol", nil, STROKE_FNT_DFLT_150_WIDE, "LeftBottom", {5, 0}, alt_large_placeholder.name, {{"MPD_RDR_FLIR_AC_AltitudeSymbol"}}, {"B", "R"})

local AOT_zone_posY = tactical_display_sz_half - RDR_AOT_zoneSizeDI -- defined in RadarDefs.lua
addStrokeLine("AOT_zone_line", tactical_display_sz, {tactical_display_sz_half, AOT_zone_posY}, 90, nil, {{"MPD_RDR_AA_AOT_ZoneShow", 1}})

-- Azimuth reference lines
local az_ref_lines_placeholder_cmn = addPlaceholder("az_ref_lines_placeholder_cmn", nil, nil, {{"MPD_RDR_AA_AzimuthRefLinesShow"}})
local az_ref_lines_placeholder_rng = addPlaceholder("az_ref_lines_placeholder_rng", nil, az_ref_lines_placeholder_cmn.name, {{"MPD_RDR_AA_AOT_ZoneShow", 1}})
local az_ref_lines_placeholder_vel = addPlaceholder("az_ref_lines_placeholder_vel", nil, az_ref_lines_placeholder_cmn.name, {{"MPD_RDR_AA_AOT_ZoneShow", 0}})
-- upper lines
add_azimuth_ref_lines("with_AOT", AOT_zone_posY, az_ref_lines_placeholder_rng.name)
add_azimuth_ref_lines("no_AOT", tactical_display_sz_half, az_ref_lines_placeholder_vel.name)
-- lower lines
add_azimuth_ref_lines("lower", -tactical_display_sz_half, az_ref_lines_placeholder_cmn.name)

-- Range/Speed reference lines
local rng_speed_ref_lines_placeholder_4_gaps = addPlaceholder("rng_speed_ref_lines_placeholder_4_gaps", nil, nil, {{"MPD_RDR_AA_RngSpeedRefLinesKind", 0}})
local rng_speed_ref_lines_placeholder_5_gaps = addPlaceholder("rng_speed_ref_lines_placeholder_5_gaps", nil, nil, {{"MPD_RDR_AA_RngSpeedRefLinesKind", 1}})
-- right lines
add_range_speed_ref_lines("4_gaps", tactical_display_sz_half, true, rng_speed_ref_lines_placeholder_4_gaps.name)
add_range_speed_ref_lines("5_gaps", tactical_display_sz_half, false, rng_speed_ref_lines_placeholder_5_gaps.name)
-- left lines
add_range_speed_ref_lines("4_gaps", -tactical_display_sz_half, true, rng_speed_ref_lines_placeholder_4_gaps.name)
add_range_speed_ref_lines("5_gaps", -tactical_display_sz_half, false, rng_speed_ref_lines_placeholder_5_gaps.name)

-- Auto acquisition legend - AACQ/WACQ
addStrokeText("AutoAcquisitionLegend", nil, STROKE_FNT_DFLT_120, "LeftBottom", {-tactical_display_sz_half + 25, upper_data_block_posY}, nil, {{"MPD_RDR_AA_AutoAcquisitionLegend"}},
	{"", "AACQ", "WACQ"})
	
-- RF channel
addStrokeText("RF_channel", "C11", STROKE_FNT_DFLT_120, "RightBottom", {-tactical_display_sz_half - 2, tactical_display_sz_half + RF_channel_shiftY})
	
-- Sensitivity Indicator
addStrokeText("Radar_sensitivity", nil, STROKE_FNT_DFLT_150, "RightBottom", {-tactical_display_sz_half - 10, -tactical_display_sz_half}, nil, {{"MPD_RDR_AA_SensitivityIndicator"}})

local AcquisitionCursorPlaceholder = addAcqusitionCursor()

-- TDC scan altitude limits
local scanAltLimPosX = glyphNominalWidth100 + fontIntercharDflt100 / 2
addStrokeText("ScanAltitudeLimitUpper", nil, STROKE_FNT_DFLT_100, "RightBottom", {scanAltLimPosX, RDR_TDC_HeightDI / 2 + 5}, AcquisitionCursorPlaceholder.name, {{"MPD_RDR_AA_ScanAltitudeLimit", 0}, {"MPD_RDR_EADI_SetYellowColor"}})
addStrokeText("ScanAltitudeLimitLower", nil, STROKE_FNT_DFLT_100, "RightTop", {scanAltLimPosX, -RDR_TDC_HeightDI / 2 - 9}, AcquisitionCursorPlaceholder.name, {{"MPD_RDR_AA_ScanAltitudeLimit", 1}, {"MPD_RDR_EADI_SetYellowColor"}})

local TDC_Tgt_MachAlt_ShiftX = RDR_TDC_WidthDI / 2 + 10

-- TDC target Mach
addStrokeText("TDC_TgtMach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-TDC_Tgt_MachAlt_ShiftX, 0}, AcquisitionCursorPlaceholder.name, {{"MPD_RDR_AA_TDC_Target_Mach"}, {"MPD_RDR_EADI_SetYellowColor"}})

-- TDC target altitude
addStrokeText("TDC_TgtAltitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {TDC_Tgt_MachAlt_ShiftX, 0}, AcquisitionCursorPlaceholder.name, {{"MPD_RDR_AA_TDC_Target_Altitude"}, {"MPD_RDR_EADI_SetYellowColor"}})

-- TDC SPOT X symbol
local TDS_SpotlightModeXSymbolPlaceholder = addPlaceholder("TDS_SpotlightModeXSymbolPlaceholder", nil, AcquisitionCursorPlaceholder.name, {{"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol"}})
addStrokeLine("TDC_XLeft", 76, {-RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, -45, TDS_SpotlightModeXSymbolPlaceholder.name, {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})
addStrokeLine("TDC_XLeft_1", 76, {-1, 0}, nil, "TDC_XLeft", {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})
addStrokeLine("TDC_XLeft_2", 76, {1,  0}, nil, "TDC_XLeft", {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})
addStrokeLine("TDC_XRight", 76, {RDR_TDC_WidthDI / 2, -RDR_TDC_HeightDI / 2}, 45, TDS_SpotlightModeXSymbolPlaceholder.name, {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})
addStrokeLine("TDC_XRight_1", 76, {-1, 0}, nil, "TDC_XRight", {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})
addStrokeLine("TDC_XRight_2", 76, {1,  0}, nil, "TDC_XRight", {{"MPD_RDR_EADI_SetYellowColor"}, {"MPD_RDR_AA_TDC_SPOT_MODE_X_Symbol_Intensity"}})

-- TODO:
-- HAFU, TWS, MSI L & S symbols

local RangeTickLen = 55 --60
local trackedTgt_MachAlt_ShiftX		= 27

--------------------------------------------------- EW DATA ---------------------------------------------------
local ewRootName = "RDR_AA_EW_Root"
addPlaceholder(ewRootName, {0, AOT_zone_posY - 25}, nil, {{"MPD_RDR_AA_EW_Show"}})
local EW_Symbol_Scale = 1.65

local function AddEwSymbol(num, level)
	local EW_Symbol_Root = "EW_Symbol_Root"..num
	local clippedObject
	addPlaceholder(EW_Symbol_Root, {0, 0}, ewRootName, {{"MPD_RDR_AA_EW_Symbol_Pos", num, tactical_display_sz_half}})
	clippedObject = addStrokeSymbol("RDR_AA_EW_Symbol_Main"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol"}, "FromSet", nil, EW_Symbol_Root, {{"MPD_RDR_EADI_SetYellowColor"}}, EW_Symbol_Scale)
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeText("RDR_AA_EW_ThreatSymbol"..num, "", STROKE_FNT_DFLT_100, "CenterCenter", nil, EW_Symbol_Root, {{"MPD_RDR_AA_EW_ThreatSymbol", num}, {"MPD_RDR_EADI_SetYellowColor"}})
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeSymbol("RDR_AA_EW_Symbol_SecondLine"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol-Second-Line"}, "FromSet", nil, "RDR_AA_EW_Symbol_Main"..num, {{"MPD_RDR_AA_EW_PriorityLine", num, 2}, {"MPD_RDR_EADI_SetYellowColor"}}, EW_Symbol_Scale)
	setClipLevel(clippedObject, level)
	clippedObject = addStrokeSymbol("RDR_AA_EW_Symbol_ThirdLine"..num, {"stroke_symbols_MDI_AMPCD", "SA-EW-Symbol-Third-Line"}, "FromSet", nil, "RDR_AA_EW_Symbol_Main"..num, {{"MPD_RDR_AA_EW_PriorityLine", num, 1}, {"MPD_RDR_EADI_SetYellowColor"}}, EW_Symbol_Scale)
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

local openingMaskEW = openMaskArea(0, "EW_Mask", EW_Vertices, EW_Indices, {0, -5 * EW_Symbol_Scale }, ewRootName, {{"MPD_RDR_AA_EW_Symbol_Pos", 0, tactical_display_sz_half}})
for i = 1, 4 do
	local num = i-1
	local level = 0
	if i == 1 then
		level = 1
	end

	AddEwSymbol(num, level)
end
closeMaskArea(1, "EW_Mask_Close", openingMaskEW.vertices, openingMaskEW.indices, openingMaskEW.init_pos)

------------------------------------------------------------------------- LTWS -----------------------------------------------------------------------------------------------------------------
-- TWS L&S symbology
local TWS_LS_Placeholder = addPlaceholder("TWS_LS_Placeholder", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_TWS_LS_IndicationShow", tactical_display_sz_half}})

local TWS_LS_LaunchZones = addPlaceholder("TWS_LS_LaunchZones", nil, TWS_LS_Placeholder.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}})
addRDRTick("TWS_LS_R_min", TWS_LS_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_LS_Rmin_Pos", tactical_display_sz}, {"MPD_RDR_TWS_LS_Intensity"}}, {{"MPD_RDR_TWS_LS_Intensity"}})
addRDRTick("TWS_LS_R_max", TWS_LS_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_LS_Rmax_Pos", tactical_display_sz}, {"MPD_RDR_TWS_LS_Intensity"}}, {{"MPD_RDR_TWS_LS_Intensity"}})
addRDRTick("TWS_LS_RNE", TWS_LS_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_LS_Rne_Pos", tactical_display_sz}, {"MPD_RDR_TWS_LS_Intensity"}}, {{"MPD_RDR_TWS_LS_Intensity"}})
addVarLenStrokeLine("TWS_LS_SteeringLine", nil, {0, RangeTickLen / 2}, -90, "TWS_LS_R_min", {{"MPD_RDR_TWS_LS_SteeringLineLen", tactical_display_sz}, {"MPD_RDR_TWS_LS_Intensity"}})

local TWS_LS_HAFU_Symbol_Placeholder = addPlaceholder("TWS_LS_HAFU_Symbol_Placeholder", nil, TWS_LS_Placeholder.name, {{"MPD_RDR_TWS_LS_SymbolPosition", tactical_display_sz}})
addStrokeText("TWS_LS_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Mach"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Altitude"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_Jamming"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
addStrokeText("TWS_LS_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_FLIRTrack"}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})
--addStrokeCircle("TWS_LS_Ase_Circle", 144, {0, 0}, nil, {{"MPD_RDR_TWS_LS_IndicationShow"}})

addStrokeLine("TWS_LS_Course_Line", 20, {0, 0}, 0, TWS_LS_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_LS_AspectAngle", 20}, {"MPD_RDR_TWS_LS_Color"}, {"MPD_RDR_TWS_LS_Intensity"}})

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

addStrokeCircle("AIM7_Max_Seeker_Rng", 25,  {0, 0}, TWS_LS_Placeholder.name, {{"MPD_RDR_AA_AIM7_MAX_SEEKER_RNG", tactical_display_sz_half * 2}})

local AA_MSL_Symb_Mode = {
"",
"TTG",
"ACT",
"SL",
"LOST",
"A",
"TTA",
}

for i = 1,8 do
	addPlaceholder("MissileSymbol"..i, {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_AA_MissilePos", tactical_display_sz, i}})--, {"MPD_RDR_TWS_LS_Intensity"}})
	addRDRTick("MissileSymbol_HorLine"..i, "MissileSymbol"..i, RangeTickLen, {RangeTickLen / 2, 0}, 90)
	addRDRTick("MissileSymbol_Line1"..i, "MissileSymbol"..i, RangeTickLen, {RangeTickLen / 2, 0}, 30)
	addRDRTick("MissileSymbol_Line2"..i, "MissileSymbol"..i, RangeTickLen, {-RangeTickLen / 2, 0}, -30)

	addStrokeText("MissileTTG"..i, nil, STROKE_FNT_DFLT_100, "RightCenter", {5, -20}, "MissileSymbol"..i, {{"TOF_TTG_Val", 2, i}})--, {"MPD_RDR_TWS_LS_Intensity"}})

	addStrokeText("AA_MSL_Symb_Mode"..i, nil, STROKE_FNT_DFLT_100, "LeftCenter", {0, 0}, "MissileTTG"..i, {{"AA_MSL_MODE", 2, i}}, AA_MSL_Symb_Mode)--, {"MPD_RDR_TWS_LS_Intensity"}}, AA_MSL_Symb_Mode)
end



-- TWS DT2 symbology
local TWS_DT2_Placeholder = addPlaceholder("TWS_DT2_Placeholder", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_TWS_DT2_IndicationShow", tactical_display_sz_half}})

local TWS_DT2_LaunchZones = addPlaceholder("TWS_DT2_LaunchZones", nil, TWS_DT2_Placeholder.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}})
addRDRTick("TWS_DT2_R_min", TWS_DT2_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_DT2_Rmin_Pos", tactical_display_sz}, {"MPD_RDR_TWS_DT2_Intensity"}}, {{"MPD_RDR_TWS_DT2_Intensity"}})
addRDRTick("TWS_DT2_R_max", TWS_DT2_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_DT2_Rmax_Pos", tactical_display_sz}, {"MPD_RDR_TWS_DT2_Intensity"}}, {{"MPD_RDR_TWS_DT2_Intensity"}})
addRDRTick("TWS_DT2_RNE", TWS_DT2_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_DT2_Rne_Pos", tactical_display_sz}, {"MPD_RDR_TWS_DT2_Intensity"}}, {{"MPD_RDR_TWS_DT2_Intensity"}})
addVarLenStrokeLine("TWS_DT2_SteeringLine", nil, {0, RangeTickLen / 2}, -90, "TWS_DT2_R_min", {{"MPD_RDR_TWS_DT2_SteeringLineLen", tactical_display_sz}, {"MPD_RDR_TWS_DT2_Intensity"}})

local TWS_DT2_HAFU_Symbol_Placeholder = addPlaceholder("TWS_DT2_HAFU_Symbol_Placeholder", nil, TWS_DT2_Placeholder.name, {{"MPD_RDR_TWS_DT2_SymbolPosition", tactical_display_sz}})
addStrokeText("TWS_DT2_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Mach"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Altitude"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_Jamming"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeText("TWS_DT2_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_FLIRTrack"}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
addStrokeLine("TWS_DT2_Course_Line", 20, {0, 0}, 0, TWS_DT2_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_DT2_AspectAngle", 20}, {"MPD_RDR_TWS_DT2_Color"}, {"MPD_RDR_TWS_DT2_Intensity"}})
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

-- TWS TUC symbology
local TWS_TUC_Placeholder = addPlaceholder("TWS_TUC_Placeholder", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_TWS_TUC_IndicationShow", tactical_display_sz_half}})
local TWS_TUC_HAFU_Symbol_Placeholder = addPlaceholder("TWS_TUC_HAFU_Symbol_Placeholder", nil, TWS_TUC_Placeholder.name, {{"MPD_RDR_TWS_TUC_SymbolPosition", tactical_display_sz}})
addStrokeText("TWS_TUC_Mach", nil, STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Mach"}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeText("TWS_TUC_Altitude", nil, STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Altitude"}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeText("TWS_TUC_Jamming", "J", STROKE_FNT_DFLT_100, "RightCenter", {-trackedTgt_MachAlt_ShiftX, 0}, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Jamming"}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeText("TWS_TUC_FLIRTrack", "F", STROKE_FNT_DFLT_100, "LeftCenter", {trackedTgt_MachAlt_ShiftX, 0}, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_FLIRTrack"}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeLine("TWS_TUC_Course_Line", 20, {0, 0}, 0, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_AspectAngle", 20}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeSymbol("TWS_TUC_HAFU_Symbol_Friendly",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"},			"FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_HAFUSymbol", HAFU_TYPE.FRIENDLY},	{"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeSymbol("TWS_TUC_HAFU_Symbol_Hostile",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"},			"FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_HAFUSymbol", HAFU_TYPE.HOSTILE},	{"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeSymbol("TWS_TUC_HAFU_Symbol_Unknown",			{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_HAFUSymbol", HAFU_TYPE.UNKNOWN},	{"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeSymbol("TWS_TUC_HAFU_Symbol_Ambiguous_sqr",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"},			"FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeSymbol("TWS_TUC_HAFU_Symbol_Ambiguous_top",	{"stroke_symbols_MDI_AMPCD", "SA-FF-Sensor-Ambiguous"},	"FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_HAFUSymbol", HAFU_TYPE.AMBIGUOUS},	{"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
addStrokeText(TWS_TUC_HAFU_Symbol_Placeholder.name.."_Ranked", nil, STROKE_FNT_DFLT_100, "CenterCenter", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Rang"}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
symbol = addStrokeSymbol("TWS_TUC_HAFU_Symbol_OffBoard_Friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Offboard", HAFU_TYPE.FRIENDLY}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_TUC_HAFU_Symbol_OffBoard_Hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Offboard", HAFU_TYPE.HOSTILE}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_TUC_HAFU_Symbol_OffBoard_Unknown", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Offboard", HAFU_TYPE.UNKNOWN}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
symbol.init_rot = {180}
symbol = addStrokeSymbol("TWS_TUC_HAFU_Symbol_OffBoard_Ambiguous", {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, TWS_TUC_HAFU_Symbol_Placeholder.name, {{"MPD_RDR_TWS_TUC_Offboard", HAFU_TYPE.AMBIGUOUS}, {"MPD_RDR_TWS_TUC_Color"}, {"MPD_RDR_TWS_TUC_Intensity"}})
symbol.init_rot = {180}

local TWS_TUC_LaunchZones = addPlaceholder("TWS_TUC_LaunchZones", nil, TWS_TUC_Placeholder.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_TWS_TUC_ShowLaunchZones"}})
addRDRTick("TWS_TUC_R_min", TWS_TUC_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_TUC_Rmin_Pos", tactical_display_sz}, {"MPD_RDR_TWS_TUC_Intensity"}}, {{"MPD_RDR_TWS_TUC_Intensity"}})
addRDRTick("TWS_TUC_R_max", TWS_TUC_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_TUC_Rmax_Pos", tactical_display_sz}, {"MPD_RDR_TWS_TUC_Intensity"}}, {{"MPD_RDR_TWS_TUC_Intensity"}})
addRDRTick("TWS_TUC_RNE", TWS_TUC_LaunchZones.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_TWS_TUC_Rne_Pos", tactical_display_sz}, {"MPD_RDR_TWS_TUC_Intensity"}}, {{"MPD_RDR_TWS_TUC_Intensity"}})
addVarLenStrokeLine("TWS_TUC_SteeringLine", nil, {0, RangeTickLen / 2}, -90, "TWS_TUC_R_min", {{"MPD_RDR_TWS_TUC_SteeringLineLen", tactical_display_sz}, {"MPD_RDR_TWS_TUC_Intensity"}})

-- ACQ point cue
local ACQ_Point_cue_Placeholder = addPlaceholder("ACQ_Point_cue_Placeholder", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_ACQ_PointCue_IndicationShow", tactical_display_sz_half}})
addStrokeSymbol("ACQ_Point_cue_Symbol", {"stroke_symbols_MDI_AMPCD", "135-ACQ-Point-Cue"}, "FromSet", nil, ACQ_Point_cue_Placeholder.name)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- tracked target shape
local targetPosScale = InToDI(4) / 2
local trackedTgtPlaceholder 		= addPlaceholder("TrackedTgtPlaceholder", nil, nil, {{"MPD_RDR_AA_TrackedTarget_Show", 1}, {"MPD_RDR_AA_TrackedTarget_Pos", targetPosScale}})
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

-- tracked target, aspect angle pointer (fixed size)
local trackedTgtAspectAngPtrLen = 20
local trackedTgtAspectAnglePointer =
	addStrokeLine("TrackedTgtAspectAnglePointer", trackedTgtAspectAngPtrLen, nil, 0, trackedTgtPlaceholder.name, {{"MPD_RDR_AA_TrackedTarget_Aspect", 20}, {"MPD_RDR_AA_TrackedTarget_Color"}})

-- tracked target, acceleration vector
addStrokeLine("TrackedTgtAccelerationVector", 20, {0, trackedTgtAspectAngPtrLen}, 0, trackedTgtAspectAnglePointer.name, {{"MPD_RDR_AA_TrackedTarget_AccelerationVec"}, {"MPD_RDR_AA_TrackedTarget_Color"}})

-- tracked target, differential altitude
-- elevation caret position is used for differential altitude
local diffAltitudeShiftX = 130
addStrokeText("TrackedTgtDifferentialAltitude", nil, STROKE_FNT_DFLT_100, "RightCenter", {-tactical_display_sz_half + diffAltitudeShiftX, 0}, nil,
	{{"MPD_RDR_ElevationCaret", tactical_display_sz_half}, {"MPD_RDR_AA_TrackedTarget_DiffAltitude"}})

-- tracked target, range and closing rate
local trackedTgtRangeCaret = add_RDR_caret("Range_caret", {tactical_display_sz_half, 0}, 90, nil, {{"MPD_RDR_AA_TrackedTarget_RangeCaret", targetPosScale}})
local rangeRateShiftX = -30
addStrokeText("TrackedTgtRangeRate", nil, STROKE_FNT_DFLT_100, "RightCenter", {rangeRateShiftX, 0}, trackedTgtRangeCaret.name, {{"MPD_RDR_AA_TrackedTarget_RangeRate"}})

local STT_LAR_PH = addPlaceholder("STT LAR PH", {0, -tactical_display_sz_half}, nil, {{"MPD_RDR_AA_LAR_Show"}, {"MPD_RDR_AA_B_SweepPos", tactical_display_sz_half}})
addRDRTick("R_min", STT_LAR_PH.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_AA_Rmin_Pos", tactical_display_sz_half * 2}})
addRDRTick("R_max", STT_LAR_PH.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_AA_Rmax_Pos", tactical_display_sz_half * 2}})
addRDRTick("RNE", STT_LAR_PH.name, RangeTickLen, {RangeTickLen / 2, 0}, 90, {{"MPD_RDR_AA_RNE_Pos", tactical_display_sz_half * 2}})

local AseCircleRadius = DegToDI(3.0)
local ASE_circle = addStrokeCircle("Ase_Circle_DDI", AseCircleRadius, {0, 0}, nil, {{"Ase_Circle", 2}, {"ASE_Circle_Raduis"}})

-- Break X
add_X_Over("breakX_placeholder", 352, 352,  nil, nil, {{"HUD_Break_X"}})

-- TODO: to remove this offset, and to split MDG controllers for HUD and RDR Steering Dots
-- Steering Dot
addSteeringDot("SteeringDot", nil, ASE_circle, {{"Steering_Dot_Pos", 1}})

addStrokeText("SHOOT_DDI", "SHOOT", STROKE_FNT_DFLT_150, "CenterCenter", {-24, -tactical_display_sz_half + 75}, nil, {{"HUD_RDR_SHOOT_IN_LAR_cue", 1, 0}})
addStrokeText("IN_LAR_DDI", "IN LAR", STROKE_FNT_DFLT_150, "CenterCenter", {-24, -tactical_display_sz_half + 75}, nil, {{"HUD_RDR_SHOOT_IN_LAR_cue", 1, 1}})
addStrokeText("ASPECT_DDI", nil, STROKE_FNT_DFLT_100, "CenterCenter", {-170, -tactical_display_sz_half - 15}, nil, {{"MPD_RDR_AA_TARGET_ASPECT_cue", 1}})
addStrokeText("TOF_DDI", nil, STROKE_FNT_DFLT_100, "CenterCenter", {90, -tactical_display_sz_half - 15}, nil, {{"MPD_RDR_AA_TOF_ACT_Val"}})

-- Name of the priority weapon and the quantity of the weapon remaining
addStrokeText("Current_AA_Weapon", " ", STROKE_FNT_DFLT_100, "CenterCenter", {370, 435}, nil, {{"MPD_RDR_AA_SelectedWeaponInfo"}})
add_X_Over("Current_AA_Weapon_X", 65, 22,  {370, 435}, nil, {{"MPD_RDR_AA_X_OverSelectedWeaponShow"}})

-- Flood
addStrokeText("FLOOD_cue", "FLOOD", STROKE_FNT_DFLT_150, "CenterCenter", {0, 300}, nil, {{"MPD_RDR_AA_FLOOD_Cue"}})
addStrokeLine("FLOOD_antenna_Pos", tactical_display_sz + 5, {0, -tactical_display_sz_half - 300}, 0, "FLOOD_cue")

-- MEM label
addStrokeText("MEMLabel", "MEM", STROKE_FNT_DFLT_150, "CenterCenter", {0, -tactical_display_sz_half + 30}, nil, {{"MPD_RDR_AA_MemoryTrack"}})

-- Bullseye
local BullseyeDataPH = addPlaceholder("BullseyeDataPH", nil, nil, {{"MPD_RDR_ShowBullseyeData"}})
addStrokeText("BullseyeTopLeftData", "", STROKE_FNT_DFLT_120, "LeftCenter", {-350, 440}, BullseyeDataPH.name, {{"MPD_RDR_BullseyeData"}}, {"%3d°/%.1f"})
addStrokeText("BullseyeBRAData", "", STROKE_FNT_DFLT_120, "LeftCenter", {-365, -340}, BullseyeDataPH.name, {{"MPD_RDR_BRAData"}}, {"BRA %3d°/%.1f"})
addStrokeText("BullseyeOwnshipData", "", STROKE_FNT_DFLT_120, "CenterCenter", {0, -445}, BullseyeDataPH.name, {{"MPD_RDR_OwnshipData"}}, {"%3d°/%.1f"})
local BullseyeCursor = addPlaceholder("BullseyeCursor_Root", {0, -tactical_display_sz_half}, BullseyeDataPH.name, {{"MPD_RDR_BullseyeSymbolPosition", tactical_display_sz}})
addStrokeCircle("BullseyeData_DOT", 1, nil, BullseyeCursor.name, {{"TDC_assignedDisplay"}})
addStrokeSymbol("BullseyeSymbol_undesignated", {"stroke_symbols_MDI_AMPCD", "Bullseye-symbol"}, "FromSet", nil, BullseyeCursor.name, {{"MPD_RDR_BullseyeSymbolType", 0}})
addStrokeSymbol("BullseyeSymbol_designated", {"stroke_symbols_MDI_AMPCD", "Bullseye-symbol-designate"}, "FromSet", nil, BullseyeCursor.name, {{"MPD_RDR_BullseyeSymbolType", 1}})

local BullseyeCursorOutOfRange = addPlaceholder("BullseyeCursorOutOfRange_Root", {-370, 440}, BullseyeDataPH.name, {{"MPD_RDR_BullseyeSymbolOutOfRange"}})
addStrokeCircle("BullseyeDataOutOfRange_DOT", 1, nil, BullseyeCursorOutOfRange.name, {{"TDC_assignedDisplay"}})
addStrokeSymbol("BullseyeSymbolOutOfRange_undesignated", {"stroke_symbols_MDI_AMPCD", "Bullseye-symbol"}, "FromSet", nil, BullseyeCursorOutOfRange.name, {{"MPD_RDR_BullseyeSymbolType", 0}})
addStrokeSymbol("BullseyeSymbolOutOfRange_designated", {"stroke_symbols_MDI_AMPCD", "Bullseye-symbol-designate"}, "FromSet", nil, BullseyeCursorOutOfRange.name, {{"MPD_RDR_BullseyeSymbolType", 1}})

addStrokeText("TargetHeading", "", STROKE_FNT_DFLT_120, "LeftCenter", {-305, 335}, nil, {{"MPD_RDR_AA_TrackedTargetHeading"}}, {"%3d°"})

addStrokeText("STT_RAID_TargetMuchNumber", "", STROKE_FNT_DFLT_120, "LeftCenter", {-210, 335}, nil, {{"MPD_RDR_AA_STT_RAID_TargetMuchNumber"}})
addStrokeText("STT_RAID_TargetDifferentialAltitude", "", STROKE_FNT_DFLT_120, "LeftCenter", {-tactical_display_sz_half + 50, 0}, nil, {{"MPD_RDR_AA_STT_RAID_TargetDifferentialAltitude"}})
addStrokeText("STT_RAID_TargetRangeRate", "", STROKE_FNT_DFLT_120, "RightCenter", {tactical_display_sz_half - 50, 0}, nil, {{"MPD_RDR_AA_STT_RAID_TargetRangeRate"}})

local TWS_PH = addPlaceholder("TWS_PH", nil, nil, {{"MPD_RDR_TWS_LabelsRoot"}})
addStrokeText("SCAN RAID", "SCAN RAID", STROKE_FNT_DFLT_120, "CenterCenter", {0, -395}, TWS_PH.name, {{"MPD_RDR_AA_RDR_RAID_BoxShow"}})

local RDR_STT_RAID_PH = addPlaceholder("RDR_STT_RAID_PH", nil, nil, {{"MPD_RDR_STT_RAID_LabelsRoot"}})
addStrokeText("RAID", "RAID", STROKE_FNT_DFLT_120, "CenterCenter", {0, -395}, RDR_STT_RAID_PH.name)

local RDR_AOT_PH = addPlaceholder("RDR_AOT_PH", nil, nil, {{"MPD_RDR_RDR_AOT_LabelRootShow", 1}})
addStrokeText("RDR_AOT", "RDR AOT", STROKE_FNT_DFLT_120, "CenterCenter", {0, -355}, RDR_AOT_PH.name)

local RDR_SPOT_PH = addPlaceholder("RDR_SPOT_PH", nil, nil, {{"MPD_RDR_SPOT_LabelRootShow"}})
addStrokeText("RDR_SPOT", "SPOT", STROKE_FNT_DFLT_120, "CenterCenter", {0, -355}, RDR_SPOT_PH.name)
----------------------------------------------- MSI Dynamic Symbols -----------------------------------------------
addPlaceholder("RDR_PPLI_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RDR_PPLI}})
addPlaceholder("RDR_FF_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RDR_FF}})
addPlaceholder("RDR_SURVEILLANCE_Keeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RDR_SURVEILLANCE}})
