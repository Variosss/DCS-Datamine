dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

local operModePosX = -tactical_display_sz_half + 4
local operModePosY = tactical_display_sz_half + RF_channel_shiftY + glyphNominalHeight120 + 5
addStrokeText("Radar_operating_condition", nil, STROKE_FNT_DFLT_120, "RightBottom", {operModePosX, operModePosY}, nil, {{"MPD_RDR_OperatingCondition"}},
	{"", "RDY", "OPR", "TEST", "STBY", "EMER"})

--add_PB_label_RDR(5, "AGR")
addStrokeText("AGR_5", "AGR", STROKE_FNT_DFLT_120, "LeftCenter", {PB_positions[5][1] + side_PB_shiftX, 335})

local trianglePositionX = 0
local trianglePositionY = 0
local triangleHeight = 25
local triangleAngle = 45

local targetRangeTextStrPositionX = trianglePositionX - 10
local targetRangeTextStrPositionY = trianglePositionY + 40

local targetVelocityTextStrPositionX = trianglePositionX + 30
local targetVelocityTextStrPositionY = trianglePositionY - 10

local targetPosition_PH = addPlaceholder("targetPosition_PH", {PB_positions[7][1] + 60, PB_positions[4][2] + 20})

local deltaSymbol = addStrokeEquilateralTriangle("Delta_Symbol", triangleHeight, triangleAngle, {trianglePositionX, trianglePositionY}, 0, nil, targetPosition_PH.name, {{"MPD_RDR_AG_AGR_Delta_Show"}})
addStrokeText("Target_Range_Value", " ", STROKE_FNT_DFLT_120, "LeftCenter", {targetRangeTextStrPositionX, targetRangeTextStrPositionY}, targetPosition_PH.name, {{"MPD_RDR_AG_AGR_TargetRange"}}, {"RANGE %.0f FT"})
addStrokeText("Target_Velocity_Value", " ", STROKE_FNT_DFLT_120, "LeftCenter", {targetVelocityTextStrPositionX, targetVelocityTextStrPositionY}, targetPosition_PH.name, {{"MPD_RDR_AG_AGR_TargetVelocity"}}, {"VEL %.0f KTS"})

-- Fixed velocity vector symbol and moving horizon line
add_RDR_FLIR_AC_VelVector_HorizonLine({0, rng_speed_refline_space_4_gaps - rng_speed_refline_space_4_gaps / 3}, {{"MPD_RDR_VelocityVectorShow"}}, {{"MPD_RDR_HorizonLine"}})

-- Iron Cross/Large X, radar positioned symbols
local IronCross_LargeX_pos = {-330, -330}
-- Iron cross (Maltese Cross)
local ironCross = addStrokeSymbol("Radar_RF_pwr_stat_Iron_Cross", {"stroke_symbols_MDI_AMPCD", "104-iron-cross"}, "CenterCenter", IronCross_LargeX_pos, nil,
	{{"MPD_RDR_IronCross_LargeX_symbols", 1}})
local flashingIronCross 		= Copy(ironCross)
flashingIronCross.name			= "Radar_RF_pwr_stat_Iron_Cross_flashing"
flashingIronCross.controllers 	= {{"MPD_RDR_IronCross_LargeX_symbols", 2}}
Add(flashingIronCross)
-- Large X
-- TEMP, to change the shape
addStrokeText("Radar_RF_pwr_stat_LargeX", "X", STROKE_FNT_DFLT_200, "CenterCenter", IronCross_LargeX_pos, nil, {{"MPD_RDR_IronCross_LargeX_symbols", 3}})

-- Time to release
addStrokeText("Time to release", nil, STROKE_FNT_DFLT_120, "RightCenter", {400, 430}, nil, {{"MPD_RDR_AG_TimeToRelease"}})