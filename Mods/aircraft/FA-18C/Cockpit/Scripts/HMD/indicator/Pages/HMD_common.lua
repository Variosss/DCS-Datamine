--dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")
dofile(LockOn_Options.script_path.."HMD/indicator/Pages/HMD_EW.lua")

-- for debug purpose
--addStrokeCircle("HMD_FOV", DegToDI(10), {0,0}, autoBlank.name)

-- Airspeed/Altitude numerics definitions
local CAS_AltNumericsShiftY 	= -glyphNominalHeight150 / 2 - hmd_CAS_AltBoxGapY

local CAS_AltBoxHeight 		= glyphNominalHeight150 + hmd_CAS_AltBoxGapY * 2
local CAS_BoxWidth 			= 115
local Alt_BoxWidth 			= 141

local gap_alt_hund_tenths 	= 15

-- Airspeed/Altitude
addStrokeBox("HMD_CAS_box", CAS_BoxWidth, CAS_AltBoxHeight, "LeftTop",  {0, 0}, hmd_CAS_BoxOrigin.name, {{"HMD_Alt_AspdBoxes"}})
addStrokeBox("HMD_Alt_box", Alt_BoxWidth, CAS_AltBoxHeight, "RightTop", {0, 0}, hmd_Alt_BoxOrigin.name, {{"HMD_Alt_AspdBoxes"}})
-- CAS
addStrokeText("HMD_CAS_numerics", nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {CAS_BoxWidth - 9, CAS_AltNumericsShiftY}, hmd_CAS_BoxOrigin.name, {{"HMD_CAS_Numerics"}})
-- Altitude below 1000 ft
addStrokeText("HMD_Alt_below_1000", nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {-5, CAS_AltNumericsShiftY}, hmd_Alt_BoxOrigin.name, {{"HMD_Alt_Numerics", 0}})
-- Altitude above 1000 ft
local shiftX_alt_thousands 	= fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3 + gap_alt_hund_tenths * 1.75
addStrokeText("HMD_Alt_above_1000_thousands",	nil, STROKE_FNT_DFLT_150_WIDE, "RightCenter", {-shiftX_alt_thousands, CAS_AltNumericsShiftY}, hmd_Alt_BoxOrigin.name, {{"HMD_Alt_Numerics", 1}})
addStrokeText("HMD_Alt_above_1000_hund_tenths", nil, STROKE_FNT_DFLT_120_WIDE, "RightCenter", {-gap_alt_hund_tenths,  CAS_AltNumericsShiftY}, hmd_Alt_BoxOrigin.name, {{"HMD_Alt_Numerics", 2}})
-- Altitude symbol (none, R, flashing B)
addStrokeText("HMD_Alt_symbol", nil, STROKE_FNT_DFLT_150_WIDE, "LeftCenter", {5, CAS_AltNumericsShiftY}, hmd_Alt_BoxOrigin.name, {{"HMD_Alt_Symbol"}}, {"B", "R", "X"})
-- Vertical Velocity
addStrokeText("HMD_VerticalVelocity", nil, STROKE_FNT_DFLT_100, "RightBottom", {-gap_alt_hund_tenths, 13}, hmd_Alt_BoxOrigin.name, {{"HMD_VV_Numerics"}})

-- Alpha, Mach number, current and peak G indicators
local amgOrigin = addPlaceholder("HMD_Alpha_Mach_G_origin", {-hmd_CAS_AltBoxEdgeX - 50, 0}, autoBlank.name)
local mach_g_stepY           = -40
local alpha_mach_g_numericsX = 120
local mach_g_shiftX          = 7
-- Alpha
addStrokeSymbol("HMD_Alpha_symbol", {"stroke_symbols_HUD", "156-alpha"}, "FromSet", {0, 0}, amgOrigin.name, {{"HMD_AoA_Symbol"}})
addStrokeText("HMD_Alpha_numerics",	nil, STROKE_FNT_DFLT_100, "RightCenter", {alpha_mach_g_numericsX, 0},				amgOrigin.name, {{"HMD_AoA_Numerics"}})
-- Mach
addStrokeText("HMD_Mach_symbol", "M", STROKE_FNT_DFLT_100, "LeftCenter", {mach_g_shiftX, mach_g_stepY}, amgOrigin.name, {{"HMD_Mach_Symbol"}})
addStrokeText("HMD_Mach_numerics",	nil, STROKE_FNT_DFLT_100, "RightCenter", {alpha_mach_g_numericsX, mach_g_stepY},			amgOrigin.name, {{"HMD_Mach_Numerics"}})
-- G
addStrokeText("HMD_G_symbol", "G", STROKE_FNT_DFLT_100, "LeftCenter", {mach_g_shiftX, mach_g_stepY * 2}, amgOrigin.name, {{"HMD_G_Symbol"}})
addStrokeText("HMD_G_numerics",		nil, STROKE_FNT_DFLT_100, "RightCenter", {alpha_mach_g_numericsX, mach_g_stepY * 2},amgOrigin.name, {{"HMD_G_Numerics"}})
-- Peak (max reached) G
addStrokeText("HMD_Max_G_numerics",	nil, STROKE_FNT_DFLT_100, "RightCenter", {alpha_mach_g_numericsX, mach_g_stepY * 3},amgOrigin.name, {{"HMD_Max_G_Numerics"}})

-- HMD LOS Heading scale
local hdgScaleStep			= 84 * 2		-- 10 Degrees
local hdgScaleLongTickLen	= 14
local hdgScaleTextShiftY	= 9
local DI_PerOneDegree		= hdgScaleStep / 10
local hdgScaleY				= 420

local los_hdgScaleOriginBlank = addPlaceholder("HMD_LOS_HdgScale_origin_blank", {0, hdgScaleY}, autoBlank.name)
local los_hdgScaleOrigin = addPlaceholder("HMD_LOS_HdgScale_origin", {0, hdgScaleY})
local los_hdgScaleHorOriginLong  = addPlaceholder("HMD_LOS_HdgScaleHor_originLong",  {0, 0}, los_hdgScaleOriginBlank.name, {{"HMD_LOS_HdgScaleHorPos",  0, DI_PerOneDegree}})
local los_hdgScaleHorOriginShort = addPlaceholder("HMD_LOS_HdgScaleHor_originShort", {0, 0}, los_hdgScaleOriginBlank.name, {{"HMD_LOS_HdgScaleHorPos", -5, DI_PerOneDegree}})

-- HMD LOS Heading
for i = 1, 3 do
	local posX = hdgScaleStep * (i - 2) - hdgScaleStep / 2
	addStrokeLine("HMD_LOS_HdgTickLong_"..i,  hdgScaleLongTickLen,     {posX, 0},						0, los_hdgScaleHorOriginLong.name)
	addStrokeLine("HMD_LOS_HdgTickShort_"..i, hdgScaleLongTickLen / 2, {posX, hdgScaleLongTickLen / 2}, 0, los_hdgScaleHorOriginShort.name)

	addStrokeText("HMD_LOS_Hdg_numerics_"..i, nil, STROKE_FNT_DFLT_100, "CenterBottom", {posX, hdgScaleLongTickLen + hdgScaleTextShiftY}, los_hdgScaleHorOriginLong.name, {{"HMD_LOS_HdgScaleText", i}})
end

-- HMD LOS Elevation
local los_elevShiftY = fontInterlineDflt100 * 2 + glyphNominalHeight100 + hdgScaleLongTickLen + hdgScaleTextShiftY
addStrokeText("HMD_LOS_Elev_numerics", nil, STROKE_FNT_DFLT_100, "CenterBottom", {0, los_elevShiftY}, los_hdgScaleOrigin.name, {{"HMD_LOS_Elev_Numerics"}})

-- Aircraft Heading
local acHdg_ShiftY = - fontInterlineDflt100 - hdgScaleTextShiftY
addStrokeText("HMD_AC_Hdg_numerics", nil, STROKE_FNT_DFLT_100, "CenterTop", {0, acHdg_ShiftY}, los_hdgScaleOriginBlank.name, {{"HMD_AC_Hdg_Numerics"}})
-- TODO:

-- Command Heading Mark
-- TODO:
 
-- HARM Window - Altitude warning, HARM, UPLOOK
addStrokeText("HMD_HARM_Window_cue", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, -65}, autoBlank.name, {{"HMD_HARM_Window"}}, {"", "ALTITUDE", "HARM", "PLBK", "UPLOOK"})
add_X_Over("HUD_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, "HMD_HARM_Window_cue", {{"HMD_HARM_Window_X"}})

local break_X_lineLength 	= DegToDI(18)
local break_X_angle 		= 45
local break_X_posX 			= break_X_lineLength / 2 * math.sin(math.rad(break_X_angle))
local break_X_posY 			= break_X_posX

local break_X_placeholder = addPlaceholder("HMD_break_X_placeholder", nil, autoBlank.name, {{"HMD_Break_X"}})
addStrokeLine("HMD_break_X_line_1", break_X_lineLength, {-break_X_posX, -break_X_posY}, -45, break_X_placeholder.name)
addStrokeLine("HMD_break_X_line_2", break_X_lineLength, {break_X_posX, -break_X_posY}, 45, break_X_placeholder.name)

-- Required ground speed
addStrokeSymbol("HMD_RequireGroundSpeedCaret", {"stroke_symbols_HUD", "Requred-Ground-Speed-Caret"}, "FromSet", {0, -CAS_AltBoxHeight}, hmd_CAS_BoxOrigin.name, {{"HMD_RequiredGrndSpeedCaret", CAS_BoxWidth}})
addStrokeLine("HMD_RequireGroundSpeedTickmark", CAS_AltBoxHeight, {CAS_BoxWidth / 2, -CAS_AltBoxHeight}, 180, hmd_CAS_BoxOrigin.name, {{"HMD_RequiredGrndSpeedTickmark"}})

-- HUD windows
local rightWindowsBlockPos_X  = hmd_CAS_AltBoxEdgeX - gap_alt_hund_tenths - (fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3)
local rightWindowsBlockPos_Y  = 120
local rightWindowsBlockStep_Y = 40
local rightWindowsBlock = addPlaceholder("HMD_rightWindowsBlock", {rightWindowsBlockPos_X, rightWindowsBlockPos_Y}, autoBlank.name)

-- HUD Window 1
--addStrokeText("HMD_Window1_cue", "WINDOW 1", STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, 0}, rightWindowsBlock.name, {{"HMD_Window1"}})

-- HUD Window 2, Sensor Track Status (Designation Cue) (AG and NAV modes) - LST, FLIR, RDR, AGR
addStrokeText("HMD_Window2_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y}, rightWindowsBlock.name,
	{{"HMD_Window2"}}, {"", "LST", "FLIR", "RDR", "AGR"})

-- HUD Window 3, AG Delivery mode - MAN ###, AUTO, CCIP, HARM, IMAV, MAV, WE, HP, THP, FD, WEDL, LOFT
-- Harpoon - BOL, LOS, R/BL
-- SLAM - SLAM, DLSLAM, TSLAM
local rightWindow3Center = fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 2
addStrokeText("HMD_Window3_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 2}, rightWindowsBlock.name,
	{{"HMD_Window3"}}, {"", "MAN %d", "AUTO", "CCIP", "HARM", "MAVF", "MAV", "MAV LKD", " WE", "HP", "THP", "FD", "WEDL", "LOFT", "BOL", "LOS", "R/BL", "SLAM", "SLMR", "DLSLAM", "TSLAM", "AUTO LFT", "MAN", "CLAR PP", "CLAR SL"})
add_X_Over("HMD_Window3_X", 60, 36, {rightWindow3Center, 0}, "HMD_Window3_cue", {{"HMD_Window3_X"}})

-- HUD Window 4 - Gun Rounds/Rockets Remaining (0UWPN5), Time to Go (0UHDW4, 0UH3W4)
-- GUN ###, RKT ###, ## PUP, ## REL, ## BURST, ## LASER, ## PUP 1, ## PUP 2, ## TTMR
addStrokeText("HMD_Window4_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 3}, rightWindowsBlock.name,
	{{"HMD_Window4"}}, {"", "GUN %3d", "RKT %3d", "%2d PUP", "%2d REL", "%2d BURST", "%2d LASER", "%2d PUP %d", "%2d TTMR", "%2d TTI"})

-- HUD Window 5 - D/L Symbology
addStrokeText("HMD_Window5_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 4}, rightWindowsBlock.name, {{"HMD_Window5"}},
	{"", "10 SEC", "TILT", "DATA", "W/O"})

-- HUD Window 6 - D/L Symbology
addStrokeText("HMD_Window6_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 5}, rightWindowsBlock.name, {{"HMD_Window6"}},
	{"", "CPL ASL", "CPL BNK", "CPL SEQ%d", "CPL WYPT", "CPL TCN", "CPLD HDG", "CPLD P/R", "ACL RDY"})

-- HUD Window 7 - ATC/NWS cue
addStrokeText("HMD_Window7_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {0, -rightWindowsBlockStep_Y * 6},  rightWindowsBlock.name,
	{{"HMD_Window7"}}, {"", "ATC", "NWS", "NWS HI"})

-- HUD Window 8 - Range and identification
addStrokeText("HMD_RangeAndIdentification", nil, STROKE_FNT_DFLT_120, "LeftCenter", {0, -rightWindowsBlockStep_Y * 7}, rightWindowsBlock.name,
	{{"HMD_Window8"}}, {"%5.1f %c%c%c", "%5.1f", "      %c%c%c", "%5.1f W%d", "%5.1f O%d", "%5.1f TGT", "TXA DEGD", "%5.1f M%d"})

-- Time of Flight Window - ## TOF, ## ACT, ## SL, LOST, AACQ, WACQ, HACQ, LHAQ
addStrokeText("TimeOfFlightWindow_cue", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {162, -78}, autoBlank.name,
	{{"HMD_TimeOfFlightWindow"}}, {"", "%2d TOF", "%2d ACT", "%2d SL", "LOST", "AACQ", "WACQ", "HACQ", "LHAQ"})

-- A/A (radar) target range rate - ####Vc
local targetRangeRatePosX = hmd_CAS_AltBoxEdgeX - (fontIntercharDflt120 + glyphNominalWidth120)
local targetRangeRatePosY = -200 - roundDI(glyphNominalHeight120 * 1.8)
local targetRangeRate = addStrokeText("HMD_AA_targetRangeRate", nil, STROKE_FNT_DFLT_120, "RightCenter", {targetRangeRatePosX, targetRangeRatePosY}, autoBlank.name,
	{{"HMD_AA_TargetRangeRate"}}, {"%4.0f V"})
addStrokeText("HMD_AA_targetRangeRate_c_subscript", "C", STROKE_FNT_DFLT_100, "LeftCenter", {3, -glyphNominalHeight120 / 2}, targetRangeRate.name)

-- A/A target range/FLOOD
local targetRangePosX = hmd_CAS_AltBoxEdgeX
local targetRangePosY = targetRangeRatePosY - rightWindowsBlockStep_Y
local targetRange_FLOOD = addStrokeText("HMD_AA_targetRange_FLOOD", nil, STROKE_FNT_DFLT_120, "RightCenter", {targetRangePosX, targetRangePosY}, autoBlank.name,
	{{"HMD_AA_TargetRange_FLOOD"}}, {"", "%4.0f FT ", "%2.1f RNG", "FLOOD"})
addStrokeText("HMD_AA_targetRangeUncertainty", nil, STROKE_FNT_DFLT_120, "LeftCenter", {fontIntercharDflt120 * 2 + glyphNominalWidth120, 0}, targetRange_FLOOD.name,
	{{"HMD_AA_TargetRangeUncertainty"}})

-- TOF - TODO:???
local tofPosX = hmd_CAS_AltBoxEdgeX
local tofPosY = targetRangeRatePosY - rightWindowsBlockStep_Y * 2
addStrokeText("HMD_AA_TOF", nil, STROKE_FNT_DFLT_120, "RightCenter", {tofPosX, tofPosY}, autoBlank.name, {{"HMD_AA_TOF"}})

-- Aiming Cross
local HMD_dac_lineLength = MilToDI(8)
local function addAimingCross()
	local linePos	= MilToDI(3)
	local dAngle	= 90
	local dAngleRad	= math.rad(dAngle)
	for i = 0, 3 do
		addStrokeLine("HMD_AIMING_CROSS_"..i, HMD_dac_lineLength, {linePos * math.sin(dAngleRad * i), linePos * math.cos(dAngleRad * i)}, -dAngle * i, hmd_dacPosition.name)
	end
end
addAimingCross()

-- Target Locator Line (A/A and A/G master modes)
addVarLenArrow("HMD_targetLocatorLine", 10, 20, 25, 0, {0, 0}, 0, hmd_waterline_origin.name, {{"HMD_TargetLocatorLine"}}, {{"HMD_TargetLocatorLineLen"}}, {{"HMD_TargetLocatorLineArrowsPos"}})

-- Target Angle Readout (A/A and A/G master modes)
local HMD_TAR_posShiftX = glyphNominalWidth100 + fontIntercharDflt100 / 2
addStrokeText("HMD_TargetAngleReadout", nil, STROKE_FNT_DFLT_100, "RightCenter", {HMD_TAR_posShiftX, 0}, hmd_waterline_origin.name, {{"HMD_TargetAngleReadout", MilToDI(15.5)}})

-- Target Designator Box (A/A and NAV master modes)
local HMD_TD_box_root = addPlaceholder("HMD_TD_boxRoot", nil, nil, {{"HMD_AA_TD_BoxPos", RadToDI()}})
-- basic box
local HMD_TD_boxSz = MilToDI(25)
local HMD_TD_boxSegmentedGap = MilToDI(8)
local HMD_TD_box = addStrokeBox("HMD_TD_box", HMD_TD_boxSz, HMD_TD_boxSz, "CenterCenter", nil, HMD_TD_box_root.name, {{"HMD_AA_TD_BoxKind", 1}})
-- segmented box
addStrokeBoxSegmented("HMD_TD_boxSegmented", HMD_TD_boxSz, HMD_TD_boxSz, HMD_TD_boxSegmentedGap, HMD_TD_boxSegmentedGap, "CenterCenter", nil, HMD_TD_box_root.name, {{"HMD_AA_TD_BoxKind", 2}})
-- rotated box - hostile
local HMD_TD_box_hostile 		= Copy(HMD_TD_box)
HMD_TD_box_hostile.name 		= "HMD_TD_box_hostile"
HMD_TD_box_hostile.init_rot 	= {45}
HMD_TD_box_hostile.controllers = {{"HMD_AA_TD_BoxKind", 3}}
Add(HMD_TD_box_hostile)

-- SHOOT and IN LAR cue over Target Designator Box
addStrokeText("HMD_AA_TD_box_SHOOT_cue", "", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, HMD_TD_boxSz / 2 + 25}, HMD_TD_box_root.name, {{"HMD_AA_SHOOT_IN_LAR_cue", 1}}, {"SHOOT", "IN LAR"})

-- DT2 Symbol
local DT2_SymbolPlaceholder = addPlaceholder("HMD_DT2_SymbolPlaceholder", nil, nil, {{"HMD_AA_DT2_Symbol", RadToDI()}})
add_X_Over("HMD_DT2_Symbol", 50, 50, nil, DT2_SymbolPlaceholder.name)

-- EW
addEwSymbols()

-- MIDS
addMidsSymbols()
