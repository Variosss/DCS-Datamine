dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

------------------------------------------------------------------------------
-- Symbology common for AA/AG, non-backup

addMPD_TDC_diamond()

-- Radar operating condition
-- none, Not ready (RDY with a line through it), OPR, TEST, STBY, EMER
local operModePosX = -tactical_display_sz_half + 4
local operModePosY = tactical_display_sz_half + RF_channel_shiftY + glyphNominalHeight120 + 5
addStrokeText("Radar_operating_condition", nil, STROKE_FNT_DFLT_120, "RightBottom", {operModePosX, operModePosY}, nil, {{"MPD_RDR_OperatingCondition"}},
	{"", "RDY", "OPR", "TEST", "STBY", "EMER"})
addLineThroughAString("Radar_operating_condition_NOT_RDY_line", {operModePosX, operModePosY}, nil, {{"MPD_RDR_OperatingCondition", 1}}, 3, "RightBottom")

-- A/C airspeed
local airspeedBlockPosX = -323
local airspeedBlockPosY = -tactical_display_sz_half - 4 - glyphNominalHeight120 / 2
add_RDR_FLIR_AC_Airspeed({airspeedBlockPosX, airspeedBlockPosY}, {{"MPD_RDR_AC_AirspeedNumerics_Show"}})

-- A/C Mach
local MachBlockPosX = airspeedBlockPosX - 5
local MachBlockPosY = airspeedBlockPosY - 28
add_RDR_FLIR_AC_Mach({MachBlockPosX, MachBlockPosY}, {{"MPD_RDR_AC_MachNumerics"}}, {{"MPD_RDR_AC_MachSymbolShow"}})

-- A/C altitude
add_RDR_FLIR_AC_Altitude({tactical_display_sz_half, -tactical_display_sz_half - glyphNominalHeight150 / 2 - 8}, {{"MPD_RDR_AC_AirspeedNumerics_Show"}})

-- A/C heading (magnetic/true)
-- TODO: Angle Off Track in AG EXP1 mode
addStrokeText("AC_heading", "    ", STROKE_FNT_DFLT_120, "CenterBottom", {0, upper_data_block_posY}, nil,
	{{"MPD_RDR_AC_Heading"}}, {"%03.0f°"})

-- Elevation bar reference lines
local ElevLinesPH = addPlaceholder("ElevationLines_PH", nil, nil, {{"MPD_RDR_ElevationLines_Show"}})
add_elevation_ref_lines(ElevLinesPH.name)

-- Fixed velocity vector symbol and moving horizon line
add_RDR_FLIR_AC_VelVector_HorizonLine({0, rng_speed_refline_space_4_gaps - rng_speed_refline_space_4_gaps / 3}, {{"MPD_RDR_VelocityVectorShow"}}, {{"MPD_RDR_HorizonLine"}})
