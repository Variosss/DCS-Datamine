dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/Pages/HUD_EW.lua")

-- debug stuff - all characters test
--local allCharsTest = "ABCDEFGH\nIJKLMNOP\nQRSTUVWX\nYZ012345\n6789-+\'(\n)*%,°./\\\n\"?:#=  H"
--local allCharsTest = "\tEFGH\nI\tNOP\nQRSTUVWX\nYZ012345\n6789-+\'(\n)*%,°./\\\n\"?:#=  H"
--local allCharsTest = "TIME:38:31\nW119°57.13'"
--addStrokeText("all_chars_test", allCharsTest, stringdefs_HUD_norm_120)

-- HUD windows
local rightWindowsBlockPos_X  = CAS_AltBoxEdgeX - gap_alt_hund_tenths - (fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3)
local rightWindowsBlockPos_Y  = 70
local rightWindowsBlockStep_Y = 30

local rightWindowsBlock = addPlaceholder("rightWindowsBlock", {rightWindowsBlockPos_X, rightWindowsBlockPos_Y})

-- HUD Window 2, Sensor Track Status (Designation Cue) (AG and NAV modes) - LST, FLIR, RDR, AGR
local Window2 =
	addStrokeText("Window2_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, 0}, rightWindowsBlock.name, {{"HUD_Window2"}},
	{"", "LST", "FLIR", "RDR", "AGR"})

-- HUD Window 3, AG Delivery mode - MAN ###, AUTO, CCIP, HARM, MAVF, MAV, MAV LKD, WE, HP, THP, FD, WEDL, LOFT
-- Harpoon - BOL, LOS, R/BL
-- SLAM - SLAM, DLSLAM, TSLAM
local rightWindow3Center = fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 2
local Window3 =
	addStrokeText("Window3_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y}, rightWindowsBlock.name, {{"HUD_Window3"}},
	{"", "MAN %d", "AUTO", "CCIP", "HARM", "MAVF", "MAV", "MAV LKD", " WE", "HP", "THP", "FD", "WEDL", "LOFT", "BOL", "LOS", "R/BL", "SLAM", "SLMR", "DLSLAM", "TSLAM", "AUTO LFT", "MAN", "CLAR PP", "CLAR SL"})
add_X_Over("HUD_Window3_X", 60, 36, {rightWindow3Center, 0}, Window3.name, {{"HUD_Window3_X"}})

-- HUD Window 4 - Gun Rounds/Rockets Remaining (0UWPN5), Time to Go (0UHDW4, 0UH3W4)
-- GUN ###, RKT ###, ## PUP, ## REL, ## BURST, ## LASER, ## PUP 1, ## PUP 2, ## TTMR
addStrokeText("Window4_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 2}, rightWindowsBlock.name, {{"HUD_Window4"}},
	{"", "GUN %3d", "RKT %3d", "%2d PUP", "%2d REL", "%2d BURST", "%2d LASER", "%2d PUP %d", "%2d TTMR", "%2d TTI"})

-- Time of Flight Window - ## TOF, ## ACT, ## SL, LOST, AACQ, WACQ, HACQ, LHAQ
addStrokeText("TimeOfFlightWindow_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {162, -78}, nil, {{"HUD_TimeOfFlightWindow"}},
	{"", "%2d TOF", "%2d ACT", "%2d SL", "LOST", "AACQ", "WACQ", "HACQ", "LHAQ"})

-- HUD Window 5
addStrokeText("Window5_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 3}, rightWindowsBlock.name, {{"HUD_Window5"}},
	{"", "10 SEC", "TILT", "DATA", "W/O"})

-- HUD Window 6
addStrokeText("Window6_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 4}, rightWindowsBlock.name, {{"HUD_Window6"}},
	{"", "CPL ASL", "CPL BNK", "CPL SEQ%d", "CPL WYPT", "CPL TCN", "CPLD HDG", "CPLD P/R", "ACL RDY"})
	
-- ATC/NWS cue - probably HUD Window 7
addStrokeText("NWS_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 5}, rightWindowsBlock.name, {{"HUD_ATC_NWS_Cue"}},
	{"", "ATC", "NWS", "NWS HI"})

-- Range and identification - probably HUD Window 8
addStrokeText("HUD_RangeAndIdentification", nil, stringdefs_HUD_norm_120, "LeftCenter", {220, -rightWindowsBlockStep_Y * 6}, nil,
	{{"HUD_SteeringData_RangeAndStationIdentification"}}, {"%5.1f %c%c%c", "%5.1f", "      %c%c%c", "%5.1f W%d", "%5.1f O%d", "%5.1f TGT", "TXA DEGD", "%5.1f M%d"})

-- waterline symbol
addStrokeSymbol("waterline", {"stroke_symbols_HUD", "145-waterline"}, "FromSet", nil, waterline_origin.name, {{"HUD_DisplayWaterlineSymbol"}})

-- Airspeed/Altitude numerics
addStrokeBox("CAS_box", CAS_BoxWidth, CAS_AltBoxHeight, "LeftTop", {0, 0}, CAS_BoxOrigin.name, {{"HUD_Display_CAS_AltitudeBoxes"}})
addStrokeBox("altitude_box", Alt_BoxWidth, CAS_AltBoxHeight, "RightTop", {0, 0}, ALT_BoxOrigin.name, {{"HUD_Display_CAS_AltitudeBoxes"}})

-- CAS
addStrokeText("CAS_numerics", nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {CAS_BoxWidth - 9, CAS_AltNumericsShiftY}, CAS_BoxOrigin.name, {{"HUD_EADI_AirspeedNumerics"}})

-- altitude below 1000 ft
addStrokeText("HUD_altitude_below_1000", nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {-5, CAS_AltNumericsShiftY}, ALT_BoxOrigin.name, {{"HUD_EADI_AltitudeNumerics", 0}})
-- altitude above 1000 ft
local shiftX_alt_thousands 	= fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3 + gap_alt_hund_tenths * 1.75
addStrokeText("HUD_altitude_above_1000_thousands", nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {-shiftX_alt_thousands, CAS_AltNumericsShiftY}, ALT_BoxOrigin.name,
	{{"HUD_EADI_AltitudeNumerics", 1}})
addStrokeText("HUD_altitude_above_1000_hund_tenths", nil, STROKE_FNT_DFLT_120_WIDE, "RightCenter", {-gap_alt_hund_tenths, CAS_AltNumericsShiftY}, ALT_BoxOrigin.name,
	{{"HUD_EADI_AltitudeNumerics", 2}})

-- altitude symbol (none, R, flashing B)
addStrokeText("HUD_altitude_symbol", nil, STROKE_FNT_DFLT_150_WIDE, "LeftCenter", {5, CAS_AltNumericsShiftY}, ALT_BoxOrigin.name, {{"HUD_EADI_AltitudeSymbol"}},	{"B", "R", "X"})

-- barometric setting
local baroSettingShiftX = gap_alt_hund_tenths - fontIntercharDflt120_wide
addStrokeText("BarometricSetting", nil, stringdefs_HUD_mid_120, "RightTop", {-baroSettingShiftX, -48}, ALT_BoxOrigin.name, {{"HUD_BarometricSettingNumerics"}})

-- Alpha, Mach number, current and peak G indicators
local alpha_mach_g_pos_Y = 8
local alpha_mach_g_placeholder = addPlaceholder("alpha_mach_g_placeholder", {-CAS_AltBoxEdgeX + 3, alpha_mach_g_pos_Y})

local mach_g_stepY           = -56
local alpha_mach_g_numericsX = 120
local mach_g_shiftX          = 7

-- Alpha
addStrokeSymbol("alpha_symbol", {"stroke_symbols_HUD", "156-alpha"}, "FromSet", {0, 0}, alpha_mach_g_placeholder.name, {{"HUD_AoA_SymbolShow"}}, 1.2)
addStrokeText("alpha_numerics", nil, stringdefs_HUD_norm_120, "RightCenter", {alpha_mach_g_numericsX, 0}, alpha_mach_g_placeholder.name, {{"HUD_AoA_value"}})

-- Mach
addStrokeText("Mach_symbol", "M", stringdefs_HUD_norm_120, "LeftCenter", {mach_g_shiftX, mach_g_stepY}, alpha_mach_g_placeholder.name, {{"HUD_MachLabelShow"}})
addStrokeText("Mach_numerics", nil, stringdefs_HUD_norm_120, "RightCenter", {alpha_mach_g_numericsX + fontIntercharDflt120 + glyphNominalWidth120, mach_g_stepY},
	alpha_mach_g_placeholder.name, {{"HUD_MachNumerics"}})

-- G
addStrokeText("G_symbol", "G", stringdefs_HUD_norm_120, "LeftCenter", {mach_g_shiftX, mach_g_stepY * 2}, alpha_mach_g_placeholder.name, {{"HUD_G_labelShow"}})
addStrokeText("G_numerics", nil, stringdefs_HUD_norm_120, "RightCenter", {alpha_mach_g_numericsX, mach_g_stepY * 2}, alpha_mach_g_placeholder.name, {{"HUD_G_numerics"}})

-- Peak (max reached) G
addStrokeText("Max_G_numerics", nil, stringdefs_HUD_norm_120, "RightCenter", {alpha_mach_g_numericsX, mach_g_stepY * 3}, alpha_mach_g_placeholder.name, {{"HUD_Max_G_numerics"}})

-- Velocity vector
local VelVecPos_controller = {{"HUD_VelVecPos", 0}}

local VelVec_origin = addPlaceholder("VelVec_origin", {0, 0}, nil, VelVecPos_controller)
local VelVec_symbol = addStrokeSymbol("velocity_vector", {"stroke_symbols_HUD", "125-velocity-vector"}, "FromSet", {0, 0}, VelVec_origin.name, {{"HUD_VelVecFlash", 0}}, 1.5)
addDot("TDC_priority_symbol", 1.5, nil, VelVec_symbol.name, {{"TDC_assignedDisplay"}, {"HUD_TDC_to_HMD"}})

-- Ghost velocity vector
local GhostVelVec_mask_side = DegToDI(2)
local GhostVelVec_mask_vertices = {{-GhostVelVec_mask_side,  GhostVelVec_mask_side},
								   { GhostVelVec_mask_side,  GhostVelVec_mask_side},
								   { GhostVelVec_mask_side, -GhostVelVec_mask_side},
								   {-GhostVelVec_mask_side, -GhostVelVec_mask_side}}
local GhostVelVec_mask = openMaskArea(0, "GhostVelVec_mask_open", GhostVelVec_mask_vertices, {0, 1, 2, 0, 2, 3}, nil, nil, VelVecPos_controller)
addStrokeSymbol("ghost_velocity_vector", {"stroke_symbols_HUD", "127-ghost-velocity-vector"}, "FromSet", {0, 0}, nil, {{"HUD_VelVecPos", 1}, {"HUD_VelVecFlash", 1}}, 1.5)
closeMaskArea(1, "GhostVelVec_mask_close", GhostVelVec_mask.vertices, GhostVelVec_mask.indices, nil, nil, VelVecPos_controller)

-- E bracket
addStrokeSymbol("E_bracket", {"stroke_symbols_HUD", "146-E-bracket"}, "FromSet", {-60, 0}, VelVec_origin.name, {{"HUD_E_bracket"}, {"HUD_E_bracket_limit", DegToDI(10)}}, 1.2)

-- heading scale
local hdgScaleTenDegreesStep = 84 * 2
local hdgScaleLongTickLen    = 14
local hdgScaleTextShiftY     = 9
local DI_PerOneDegree        = hdgScaleTenDegreesStep / 10

-- The heading scale y pos difference in NAV and AA/AG modes is 1.25 degrees.
local hdgScaleY_WEAP = DegToDI(7) + 4
local hdgScaleY_NAV  = hdgScaleY_WEAP - DegToDI(1.25)
local heading_scale_origin_controllers = {{"HUD_HeadingScaleOrigin", hdgScaleY_NAV, hdgScaleY_WEAP}}

local headingScaleOrigin = addPlaceholder("headingScaleOrigin", {0, 0}, nil, heading_scale_origin_controllers)
local headingScaleHorizonalOriginLong = addPlaceholder("headingScaleHorizonalOriginLong", {0, 0},
	headingScaleOrigin.name, {{"HUD_HeadingScaleHorizonalPos", 0, DI_PerOneDegree}})
local headingScaleHorizonalOriginShort = addPlaceholder("headingScaleHorizonalOriginShort", {0, 0},
	headingScaleOrigin.name, {{"HUD_HeadingScaleHorizonalPos", -5, DI_PerOneDegree}})

for i = 1, 3 do
	local posX = hdgScaleTenDegreesStep * (i - 2) - hdgScaleTenDegreesStep / 2
	addStrokeLine("HeadingTickLong_"..i, hdgScaleLongTickLen, {posX, 0}, 0, headingScaleHorizonalOriginLong.name)
	addStrokeLine("HeadingTickShort_"..i, hdgScaleLongTickLen / 2, {posX, 0}, 0, headingScaleHorizonalOriginShort.name)

	addStrokeText("HeadingNumerics_"..i, nil, stringdefs_HUD_norm_120, "CenterBottom", {posX, hdgScaleLongTickLen + hdgScaleTextShiftY},
		headingScaleHorizonalOriginLong.name, {{"HUD_HeadingScaleText", i}})
end

local headingScaleIndexOrigin = addPlaceholder("headingScaleIndexOrigin", {0, 0}, headingScaleOrigin.name)
local headingScaleIndexType1_Origin = addPlaceholder("headingScaleIndexType1_Origin", nil, headingScaleIndexOrigin.name, {{"HUD_HeadingScaleIndexType", 0}})

-- 'normal' heading index - magnetic heading
addCaretByWidthHeight("headingScaleIndex", 20, 24, nil, 180, headingScaleIndexType1_Origin.name)

-- T symbol - true heading
addStrokeText("headingScaleT", "T", STROKE_FNT_DFLT_120, "CenterTop", nil, headingScaleIndexOrigin.name, {{"HUD_HeadingScaleIndexType", 1}})

-- Flight Path/Pitch ladder
-- FPPL is masked by the heading scale
local FPPL_mask_half_width = hdgScaleTenDegreesStep * 1.5
local FPPL_mask_height_down = 0
local FPPL_mask_height_up = 56
local FPPL_mask_vertices = {{-FPPL_mask_half_width, FPPL_mask_height_up},
						    { FPPL_mask_half_width, FPPL_mask_height_up},
							{ FPPL_mask_half_width, FPPL_mask_height_down},
							{-FPPL_mask_half_width, FPPL_mask_height_down}}
local FPPL_mask = openMaskArea(0, "FPPL_mask_open", FPPL_mask_vertices, {0, 1, 2, 0, 2, 3}, nil, nil, heading_scale_origin_controllers)

local FPPL_origin = addPlaceholder("FPPL_origin", {0, waterlineShiftY}, nil, {{"HUD_FlightPath_PitchLadder_Show"}, {"HUD_FlightPath_PitchLadder_PosRot"}})

local FPPL_line_half_gap     		 = 60
local FPPL_short_horizon_line_width  = 130
local FPPL_long_horizon_line_width   = 450
local FPPL_horizon_line_tick         = 40

local FPPL_pitch_line_width          = 75
local FPPL_pitch_line_tick           = 24

-- negative pitch line is dashed
local FPPL_negline_stroke            = 9
local FPPL_negline_gap               = 7

-- text shift (x, y) from the horizontal line end
local FPPL_text_shift_x              = 15
local FPPL_text_shift_y              = 8

-- limits each FPPL element in HUD TFOV - 10 degrees radius
local limiter 						 = {"HUD_FlightPath_PitchLadderLimit", DegToDI(10)}

local function add_FPPL_line(name, width, half_gap, tick, shift_y, pitch, controllers)
	
	local lineOrigin = addPlaceholder(name.."_origin", {0, shift_y}, FPPL_origin.name, controllers)
	
	-- 0 - left side of the pitch line, 1 - right side respectively
	for i = 0, 1 do
		local side
		local side_name
		if i == 0 then
			side = -1
			side_name = "left"
		else
			side = 1
			side_name = "right"
		end

		local tick_rot
		if shift_y < 0 then
			-- negative pitch
			tick_rot = 0
		else
			-- positive pitch
			tick_rot = 180
		end
		
		local pitchLimited
		if pitch > 90 then
			-- above 90 degrees
			pitchLimited = pitch - 180
			tick_rot = 0
		elseif pitch < -90 then
			-- below -90 degrees
			pitchLimited = pitch + 180
			tick_rot = 180
		else
			pitchLimited = pitch
		end
		
		local length
		local tick_shift_y
		-- each pitch line is rotated by the pitch / 2 angle
		local lineRot = pitchLimited / 2
		if lineRot ~= 0 then
			length     = width / math.cos(math.rad(lineRot))
			tick_shift_y = length * math.sin(math.rad(lineRot))
		else
			length     = width
			tick_shift_y = 0
		end
		
		addStrokeLine(name.."_hor_"..side_name, length, {half_gap * side, 0}, (lineRot - 90) * side, lineOrigin.name, nil, shift_y < 0, FPPL_negline_stroke, FPPL_negline_gap)
		addStrokeLine(name.."_tick_"..side_name, tick, {(half_gap + width) * side, tick_shift_y}, tick_rot, lineOrigin.name)
		
		if shift_y ~= 0 then
			
			local text_shift_y
			-- pitch numerics text is inverted below -90 and above 90 degrees
			local inverted
			if shift_y < 0 then
				if pitch > -90 then
					inverted = false
					text_shift_y = FPPL_text_shift_y
				else
					inverted = true
					text_shift_y = -FPPL_text_shift_y
				end
			else
				if pitch < 90 then
					inverted = false
					text_shift_y = -FPPL_text_shift_y
				else
					inverted = true
					text_shift_y = FPPL_text_shift_y
				end
			end
			
			local textAlign
			if side < 0 then
				if inverted == false then
					textAlign = "RightCenter"
				else
					textAlign = "LeftCenter"
				end
			else
				if inverted == false then
					textAlign = "LeftCenter"
				else
					textAlign = "RightCenter"
				end
			end
			
			local pitchToPrint
			if pitchLimited < 0 then
				pitchToPrint = -pitchLimited
			else
				pitchToPrint = pitchLimited
			end
			
			local text = addStrokeText(name.."_numerics_"..side_name, ""..pitchToPrint, stringdefs_HUD_norm_120, textAlign, {(half_gap + width + FPPL_text_shift_x) * side, tick_shift_y + text_shift_y}, lineOrigin.name)
			
			if inverted == true then
				text.init_rot = {180}
			end
			
		end
	end
end

-- short line - with LDG up
add_FPPL_line("FPPL_horizon_short_line", FPPL_short_horizon_line_width, FPPL_line_half_gap, FPPL_horizon_line_tick, 0, 0, {{"HUD_FlightPath_PitchLadderHorizonLineKind", 0}, limiter})
-- long line - with LDG down and locked
add_FPPL_line("FPPL_horizon_long_line", FPPL_long_horizon_line_width, FPPL_line_half_gap, FPPL_horizon_line_tick, 0, 0, {{"HUD_FlightPath_PitchLadderHorizonLineKind", 1}, limiter})

local FPPL_line_common_name_part = "FPPL_pitch_line_"

-- -85 to +85 degrees
local counterBegin = -85 / 5
local counterEnd   = -counterBegin
for i = counterBegin, counterEnd do
	local name
	local pitch = i * 5
	if i > 0 then
		name = FPPL_line_common_name_part.."positive_"..pitch
	else
		name = FPPL_line_common_name_part.."negative_"..pitch
	end

	if i ~= 0 then
		add_FPPL_line(name, FPPL_pitch_line_width, FPPL_line_half_gap, FPPL_pitch_line_tick, DegToDI(pitch), pitch, {limiter})
	end
end

local zenith_nadir_radius = 28
local zenith_shift_y = DegToDI(90)

local function add_zenith_nadir_circle(name, shift_y)
	return addStrokeCircle(name, zenith_nadir_radius, {0, shift_y}, FPPL_origin.name, {limiter})
end

-- zenith
add_zenith_nadir_circle("Zenith_circle", zenith_shift_y)

-- nadir
local nadir_circle = add_zenith_nadir_circle("Nadir_circle", -zenith_shift_y)

local nadir_cross_X = zenith_nadir_radius * math.sin(math.rad(45))
local nadir_cross_Y = -nadir_cross_X

local nadir_cross_1 = addStrokeLine("Nadir_cross_1", zenith_nadir_radius * 2, {nadir_cross_X, nadir_cross_Y}, 45, nadir_circle.name)
nadir_cross_2 = Copy(nadir_cross_1)
nadir_cross_2.init_pos = {-nadir_cross_X, nadir_cross_Y}
nadir_cross_2.init_rot = {-45}
Add(nadir_cross_2)

-- FPPL beyond zenith - +85 to +70
counterBegin = (180 - 85) / 5
counterEnd   = (180 - 70) / 5
for i = counterBegin, counterEnd do
	local pitch = i * 5
	local name = FPPL_line_common_name_part.."positive_"..pitch
	add_FPPL_line(name, FPPL_pitch_line_width, FPPL_line_half_gap, FPPL_pitch_line_tick, DegToDI(pitch), pitch, {limiter})
end

-- FPPL beyond nadir - -85 to -70
counterBegin = (70 - 180) / 5
counterEnd   = (85 - 180) / 5
for i = counterBegin, counterEnd do
	local pitch = i * 5
	local name = FPPL_line_common_name_part.."negative_"..pitch
	add_FPPL_line(name, FPPL_pitch_line_width, FPPL_line_half_gap, FPPL_pitch_line_tick, DegToDI(pitch), pitch, {limiter})
end

closeMaskArea(1, "FPPL_mask_close", FPPL_mask.vertices, FPPL_mask.indices, nil, nil, heading_scale_origin_controllers)

local function AddCommandHeadingMark ( name, pos, parent, controller )
	local Len = 20
	local offset = 2
	local Root = addPlaceholder(name.."_Root", pos, parent, controller)
	addStrokeLine(name.."_Line_1", Len, {pos[1], pos[2]}, 180, Root.name)
	addStrokeLine(name.."_Line_2", Len, {pos[1] + offset, pos[2]}, 180, Root.name)
	addStrokeLine(name.."_Line_3", Len, {pos[1] - offset, pos[2]}, 180, Root.name)
end

local function AddSteeringSymbol ( name, pos, parent, controllerRoot, controllerDot, controllerArrow, DegInDI )
	local CircleRadius = 5
	local _4DegreesInDI = DegInDI * 4
	local Root = addPlaceholder(name.."_Root", pos, parent, controllerRoot)
	local DotRoot = addPlaceholder(name.."_Dot", nil, Root.name, controllerDot)

	addStrokeSymbol(name.."_Arrow", {"stroke_symbols_MDI_AMPCD", "124-arrow-up"}, "FromSet", nil, Root.name, controllerArrow)

	addStrokeCircle(name.."_4_degrees", CircleRadius, {-_4DegreesInDI, 0}, 		DotRoot.name, nil, nil, math.pi * 2 / 4)
	addStrokeCircle(name.."_8_degrees", CircleRadius, {-_4DegreesInDI * 2, 0}, 	DotRoot.name, nil, nil, math.pi * 2 / 4)
end

local DIInOneDegForSteering = 19
AddCommandHeadingMark("CommandHeadingMark", {0, -5}, headingScaleIndexOrigin.name, {{"HUD_SteeringData_CommandHeading", DI_PerOneDegree, 0}})
AddSteeringSymbol("SteeringSymbol", nil, VelVec_origin.name, {{"HUD_SteeringData_SymbolEnable"}}, {{"HUD_SteeringData_SymbolDots"}}, {{"HUD_SteeringData_SymbolArrow", DIInOneDegForSteering}}, DIInOneDegForSteering)
addStrokeSymbol("TargetDesignateDiamond_Heading", {"stroke_symbols_HUD", "114-Designated-Mark-Heading"}, "FromSet", {0, -9}, headingScaleIndexOrigin.name, {{"HUD_SteeringData_CommandHeading", DI_PerOneDegree, 1}})

addArrowContour("TAWS_HUD_Visual_Recovery_Cue", 450, 140, 150, 250, {0, 0}, -90, nil, {{"HUD_RecoveryCue"}}, true, 90)

local ILSLineLen = 202
addPlaceholder("ILS_Vert_Root", {0, 0}, VelVec_origin.name, {{"Common_IndicatorLandingSystem", 0, 51}})
addStrokeLine("ILS_Vert", ILSLineLen, {0, ILSLineLen / 2}, 180, "ILS_Vert_Root")
addPlaceholder("ILS_Hor_Root", {0, 0}, VelVec_origin.name, {{"Common_IndicatorLandingSystem", 1, 51}})
addStrokeLine("ILS_Hor",  ILSLineLen, {-ILSLineLen / 2, 0}, -90, "ILS_Hor_Root")

local CenterHUDIndication =
	addStrokeText("CenterHUDIndication_cue", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, -45}, nil, {{"HUD_CenterIndication"}})
add_X_Over("HUD_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, CenterHUDIndication.name, {{"HUD_HARM_SP_PB_Indication_X"}})

-- Real Time Clock
addStrokeText("HUD_RTC", nil, stringdefs_HUD_norm_120, "LeftCenter", {-367, -255}, nil, {{"HUD_RTC"}})

-- Target Locator Line (A/A and A/G master modes)
-- TODO: to check if present in NAV master mode
addArrow("HUD_targetLocatorLine", 115, 20, 25, 0, {0, 0}, 0, waterline_origin.name, {{"HUD_TargetLocatorLine", AA_GunBoresight_Y}})

-- Target Angle Readout (A/A and A/G master modes)
-- TODO: to check if present in NAV master mode
local TAR_posShiftX = glyphNominalWidth100 + fontIntercharDflt100 / 2
addStrokeText("HUD_TargetAngleReadout", nil, STROKE_FNT_DFLT_100, "RightCenter", {TAR_posShiftX, 0}, waterline_origin.name, {{"HUD_TargetAngleReadout", 20}})

local Gun_Rtcl_mask_vertices = {{-gunRktReticleRadius, gunRktReticleRadius},
								{ gunRktReticleRadius, gunRktReticleRadius},
								{ gunRktReticleRadius, -gunRktReticleRadius},
								{-gunRktReticleRadius, -gunRktReticleRadius}}
local Gun_Rtcl_mask = openMaskArea(0, "Gun_Rtcl_mask_open", Gun_Rtcl_mask_vertices, {0, 1, 2, 0, 2, 3}, nil, nil, {{"HUD_AA_GunReticleMaskActive"}, {"HUD_AA_GunReticlePos"}})

-- Target Designator Box (A/A and NAV master modes)
local TD_box_root = addPlaceholder("HUD_TD_boxRoot", nil, nil, {{"HUD_AA_TD_BoxPos"}})

closeMaskArea(1, "Gun_Rtcl_mask_close", Gun_Rtcl_mask.vertices, Gun_Rtcl_mask.indices, nil, nil, {{"HUD_AA_GunReticleMaskActive"}, {"HUD_AA_GunReticlePos"}})

local TD_boxSz = MilToDI(25)
local TD_boxSegmentedGap = MilToDI(8)
-- basic box
local HUD_TD_box = addStrokeBox("HUD_TD_box", TD_boxSz, TD_boxSz, "CenterCenter", nil, TD_box_root.name, {{"HUD_AA_TD_BoxKind", 1}})
-- segmented box
addStrokeBoxSegmented("HUD_TD_boxSegmented", TD_boxSz, TD_boxSz, TD_boxSegmentedGap, TD_boxSegmentedGap, "CenterCenter", nil, TD_box_root.name, {{"HUD_AA_TD_BoxKind", 2}})
-- rotated box - hostile
local HUD_TD_box_hostile 		= Copy(HUD_TD_box)
HUD_TD_box_hostile.name 		= "HUD_TD_box_hostile"
HUD_TD_box_hostile.init_rot 	= {45}
HUD_TD_box_hostile.controllers = {{"HUD_AA_TD_BoxKind", 3}}
Add(HUD_TD_box_hostile)
-- hostile caret on top of the diamond
addStrokeSymbol("HUD_TD_box_caret_hostile", {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", {0, TD_boxSz * 0.7}, TD_box_root.name, {{"HUD_AA_TD_BoxCaretShow", 3}}, 1.0)
addStrokeSymbol("HUD_TD_box_caret_friendly", {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", {0, TD_boxSz * 0.7}, TD_box_root.name, {{"HUD_AA_TD_BoxCaretShow", 2}}, 1.0)
-- none, F, C label
addStrokeText("HUD_AA_TD_Lower_label", " ", STROKE_FNT_DFLT_100, "CenterTop", {0, -TD_boxSz*0.5 - 16}, TD_box_root.name, {{"HUD_AA_TD_Lower_label"}},
	{"", "F", "C"})
-- FLIR uncorrelated target
local flirTgtCross = addPlaceholder("HUD_AA_FLIR_Cross", nil, nil, {{"HUD_AA_FLIR_Cross"}})
local crossL = 25*0.5
local crossX = crossL * math.cos(math.rad(45))
local crossY = crossL * math.sin(math.rad(45))
local flirTgt_1 = addStrokeLine("HUD_AA_flirTgt_1", crossL*2, {crossX, -crossY}, 45, flirTgtCross.name)
flirTgt_2 = Copy(flirTgt_1)
flirTgt_2.init_pos = {-crossX, -crossY}
flirTgt_2.init_rot = {-45}
Add(flirTgt_2)


-- HARM TD Box
local harmTdBox = addStrokeBox("HUD_HARM_TD_box", TD_boxSz, TD_boxSz, "CenterCenter", nil, nil, {{"HUD_HARM_TD_Box", 0}})
addStrokeText("HUD_HARM_TD_Hoff", "H-OFF", STROKE_FNT_DFLT_100, "CenterBottom", {0, TD_boxSz * 0.5 + 5}, harmTdBox.name, {{"HUD_HARM_TD_Box", 1}})

-- SHOOT cue over Target Designator Box
addStrokeText("HUD_AA_TD_box_SHOOT_cue", "SHOOT", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, TD_boxSz / 2 + 25}, TD_box_root.name, {{"HUD_RDR_SHOOT_IN_LAR_cue", 1, 0}})
-- IN LAR cue over Target Designator Box
addStrokeText("HUD_AA_TD_box_IN_LAR_cue", "IN LAR", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, TD_boxSz / 2 + 25}, TD_box_root.name, {{"HUD_RDR_SHOOT_IN_LAR_cue", 1, 1}})
-- GO STT cue under Target Designator Box
addStrokeText("HUD_AA_TD_box_GO_STT_cue", "GOSTT", STROKE_FNT_DFLT_120_WIDE, "CenterTop", {0, -TD_boxSz / 2 - 25}, TD_box_root.name, {{"HUD_RDR_SHOOT_GO_STT_cue"}})
-- FRIEND cue under Target Designator Box
addStrokeText("HUD_AA_TD_box_FRIEND_cue", "FRIEND", STROKE_FNT_DFLT_120_WIDE, "CenterTop", {0, -TD_boxSz / 2 - 25}, TD_box_root.name, {{"HUD_RDR_SHOOT_FRIEND_cue"}})
		
-- A/A (radar) target range rate - ####Vc
local targetRangeRatePosX = CAS_AltBoxEdgeX - Alt_BoxWidth + (glyphNominalWidth120 * 2 + fontIntercharDflt120) + 1
local targetRangeRatePosY = alpha_mach_g_pos_Y + roundDI(glyphNominalHeight120 * 1.8)
local targetRangeRate = addStrokeText("HUD_AA_targetRangeRate", nil, stringdefs_HUD_norm_120, "RightCenter", {targetRangeRatePosX, targetRangeRatePosY}, nil,
	{{"HUD_AA_targetRangeRate"}}, {"%4.0fV"})
addStrokeText("HUD_TargetRangeRate_c_subscript", "C", STROKE_FNT_DFLT_100, "LeftCenter", {3, -glyphNominalHeight120 / 2}, targetRangeRate.name)

-- A/A target range/FLOOD
local targetRangePosX = targetRangeRatePosX + fontIntercharDflt120 + glyphNominalWidth120
local targetRangePosY = alpha_mach_g_pos_Y
local targetRange_FLOOD = addStrokeText("HUD_AA_targetRange_FLOOD", nil, stringdefs_HUD_norm_120, "RightCenter", {targetRangePosX, targetRangePosY}, nil,
	{{"HUD_AA_targetRange_FLOOD"}}, {"", "%4.0f FT ", "%2.1fRNG", "FLOOD"})
addStrokeText("HUD_AA_targetRangeUncertainty", nil, stringdefs_HUD_norm_120, "LeftCenter", {fontIntercharDflt120 * 2 + glyphNominalWidth120, 0}, targetRange_FLOOD.name,
	{{"HUD_AA_targetRangeUncertainty"}})

-- Break X
local break_X_lineLength 	= 352
local break_X_angle 		= 45
local break_X_posX 			= break_X_lineLength / 2 * math.sin(math.rad(break_X_angle))
local break_X_posY 			= break_X_posX

local break_X_placeholder = addPlaceholder("break_X_placeholder", nil, nil, {{"HUD_Break_X"}})
addStrokeLine("break_X_line_1", break_X_lineLength, {-break_X_posX, -break_X_posY}, -45, break_X_placeholder.name)
addStrokeLine("break_X_line_2", break_X_lineLength, {break_X_posX, -break_X_posY}, 45, break_X_placeholder.name)

-- Required ground speed
addStrokeSymbol("RequireGroundSpeedCaret", {"stroke_symbols_HUD", "Requred-Ground-Speed-Caret"}, "FromSet", {0, -CAS_AltBoxHeight}, CAS_BoxOrigin.name, {{"HUD_RequireGroundSpeedCaret", CAS_BoxWidth}})
addStrokeLine("RequireGroundSpeedTickmark", CAS_AltBoxHeight, {CAS_BoxWidth / 2, -CAS_AltBoxHeight}, 180, CAS_BoxOrigin.name, {{"HUD_RequireGroundSpeedTickmark"}})

-- Designated waypoint marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", nil, nil, {{"HUD_DesignatedWaypointMarkerShow"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name, {{"HUD_DesignatedWaypointMarkerType", 0}}, 1.5)
addStrokeSymbol("SegmentDiamond_Marker", {"stroke_symbols_HUD", "Segment-Diamond_NO_DOT"}, "FromSet", nil, TD_DiamondPlaceholder.name, {{"HUD_DesignatedWaypointMarkerType", 1}}, 1.5)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name, {{"TDC_assignedDisplay"}})

-- DT2 Symbol
local DT2_SymbolPlaceholder = addPlaceholder("DT2_SymbolPlaceholder", nil, nil, {{"HUD_AA_DT2_Symbol"}})
add_X_Over("DT2_Symbol", 50, 50, nil, DT2_SymbolPlaceholder.name)

-- ACL D/L Tadpole
addStrokeSymbol("HUD_ACL_Tadpole", {"stroke_symbols_HUD", "tadpole"}, "FromSet", nil, VelVec_origin.name, {{"HUD_ACL_Tadpole", 0}}, 1.5)
