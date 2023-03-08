dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")
dofile(LockOn_Options.script_path.."Displays/HUD/device/HUD_config.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

HUD_BlankRoot = addPlaceholder("HUD_BlankRoot_PH_com", {0, 0}, nil, {{"HUD_Blanked"}})
-- HUD boresight cross
local HUD_BoresightRoot = addStrokeSymbol("HUD_Boresight_Cross", {"stroke_symbols_HUD", "1-boresight-cross"}, "FromSet", {0, boresightShiftY}, HUD_BlankRoot.name)

-- Flight Path Marker - FPM
local HUD_FPM_origin = addPlaceholder("HUD_FPM_origin", {0, 0}, HUD_BlankRoot.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_FPM_Pos"}})
addStrokeSymbol("HUD_FPM", {"stroke_symbols_HUD", "2-flightpath-marker"}, "FromSet", {0, 0}, HUD_FPM_origin.name, {{"HUD_FPM_Flash"}})
-- FPM cross
addStrokeSymbol("HUD_FPM_Cross", {"stroke_symbols_HUD", "fpm-cross"}, "FromSet", {0, 0}, HUD_FPM_origin.name, {{"HUD_FPM_Cross"}})

-- AoA bracket
addStrokeSymbol("HUD_AoA_bracket", {"stroke_symbols_HUD", "aoa-bracket"}, "FromSet", {0, 0}, HUD_FPM_origin.name, {{"HUD_AoA_bracket"}})

-- Great steering circle cue "tadpole"
addStrokeSymbol("HUD_Tadpole", {"stroke_symbols_HUD", "3-great-steering-circle"}, "FromSet", nil, HUD_FPM_origin.name, {{"HUD_Tadpole_Pos", 50}})	-- 50 milradians for maximum offset

-- Pitch Ladder (PL)
local PL_origin = addPlaceholder("HUD_PL_origin", {0, boresightShiftY}, HUD_BlankRoot.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_PitchLadder_Show"}, {"HUD_PitchLadder_PosRot"}})

local PL_horizon_line_half_gap		= 16
local PL_long_horizon_line_width	= 170

local PL_pitch_line_half_gap		= 16
local PL_pitch_line_width			= 25
local PL_pitch_line_tick			= 4

-- long line - horizon

add_PL_line("PL_horizon_long_line", PL_long_horizon_line_width, PL_horizon_line_half_gap, 0, 0, 0, {{"HUD_PL_GhostHorizon", 0}}, PL_origin.name)
add_PL_GhostHorizon("PL_GhostHorizon_", PL_long_horizon_line_width, PL_horizon_line_half_gap, {{"HUD_PitchLadder_Show"}, {"HUD_PL_GhostHorizon", 1}}, {0, 0}, HUD_BlankRoot.name)

-- 2.5 degrees
local PL_25_pitch_line_width		= 19
add_PL_25_line("PL_pitch_lint_25", PL_25_pitch_line_width, PL_pitch_line_half_gap, PL_origin.name, {{"HUD_PL_25_Line"}}, {0, DegToMil(-2.5)})

-- -60 to +60 degrees
local counterBegin = -85
local counterEnd   = -counterBegin
for i = counterBegin, counterEnd, 5 do
	if i ~= 0 then
		add_PL_line("PL_pitch_line_"..i, PL_pitch_line_width, PL_pitch_line_half_gap, PL_pitch_line_tick, DegToMil(i), i, {{"HUD_PitchLadder_Limit", DegToMil(10)}}, PL_origin.name)
	end
end

-- Roll Indicator
local HUD_RI_origin	= addPlaceholder("HUD_RI_origin", {0, -60}, HUD_BlankRoot.name, {{"HUD_RI_Pos"}})
addRollIndicator(53, 8, 2, HUD_RI_origin.name)

local RI_Caret_mask_side = 10
local RI_Caret_maskX = 55.5 * math.sin(math.rad(45))
local RI_Caret_maskY = -55.5 * math.cos(math.rad(45))
local RI_Caret_mask_vertices = {{-RI_Caret_mask_side - RI_Caret_maskX,  RI_Caret_mask_side + RI_Caret_maskY},
								{ RI_Caret_mask_side - RI_Caret_maskX,  RI_Caret_mask_side + RI_Caret_maskY},
								{-RI_Caret_mask_side - RI_Caret_maskX, -RI_Caret_mask_side + RI_Caret_maskY},
								{-RI_Caret_mask_side + RI_Caret_maskX,  RI_Caret_mask_side + RI_Caret_maskY},
								{ RI_Caret_mask_side + RI_Caret_maskX,  RI_Caret_mask_side + RI_Caret_maskY},
								{RI_Caret_mask_side + RI_Caret_maskX, -RI_Caret_mask_side + RI_Caret_maskY}}
openMaskArea(0, "RI_Caret_mask_open", RI_Caret_mask_vertices, {0, 1, 2, 3, 4, 5}, nil, HUD_RI_origin.name)
addStrokeSymbol("HUD_Roll_Indicator_Caret", {"stroke_symbols_HUD", "11-roll-caret"}, "FromSet", {0, 0}, HUD_RI_origin.name, {{"HUD_RI_Roll", -55}})
closeMaskArea(1, "RI_Caret_mask_close", RI_Caret_mask_vertices, {0, 1, 2, 3, 4, 5}, nil, HUD_RI_origin.name)

-- Bank Indicator
local HUD_Bnk_origin = addPlaceholder("HUD_Bnk_origin", {0, 0}, HUD_FPM_origin.name, {{"HUD_Bnk_Show"}})
addBankIndicator(15, 5, 1, HUD_Bnk_origin.name)

--
local HUD_Indication_bias = addPlaceholder("HUD_Indication_bias", {0, 0}, HUD_BlankRoot.name, {{"HUD_Indication_Bias"}})

-- Velocity numerics
local HUD_Vel_num_origin	= addPlaceholder("HUD_Vel_num_origin", {-91, -5.5}, HUD_Indication_bias.name)
addStrokeText("HUD_Velocity_num", nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {0, 0}, HUD_Vel_num_origin.name, {{"HUD_Velocity_Num"}})
addStrokeSymbol("HUD_Velocity_box", {"stroke_symbols_HUD", "9-velocity-box"}, "FromSet", {-9, 0}, HUD_Vel_num_origin.name)

-- Velocity scale
local velScale50KnotsStep		= 25
local velScaleLongTickLen		= 5
local velScaleShortTickLen		= 3
local Mil_PerOneKnots			= velScale50KnotsStep / 50

local HUD_VelScale_origin = addPlaceholder("HUD_VelScale_origin", {-85.5 + velScaleLongTickLen, -5.5}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_VelScaleOrigin"}})
local HUD_VelScale_originLong  = addPlaceholder("HUD_VelScale_originLong", {0, 0}, HUD_VelScale_origin.name, {{"HUD_VelScaleVerPos", 0, Mil_PerOneKnots}})
local HUD_VelScale_originShort = {}
for j = 1,4 do
	HUD_VelScale_originShort[j] = addPlaceholder("HUD_VelScale_originShort"..j, {0, 0}, HUD_VelScale_origin.name, {{"HUD_VelScaleVerPos", 10 * j, Mil_PerOneKnots}})
end

for i = 1, 4 do
	local posY = velScale50KnotsStep * (i - 2)-- + velScale50KnotsStep / 2
	addStrokeLine("HUD_VelScaleTickLong_"..i, velScaleLongTickLen, {0, posY}, 90, HUD_VelScale_originLong.name, {{"HUD_VelScaleHide", i, 0}})
	for j = 1,4 do
		addStrokeLine("HUD_VelScaleTickShort_"..j..i, velScaleShortTickLen, {0, posY}, 90, HUD_VelScale_originShort[j].name, {{"HUD_VelScaleHide", i, j}})
	end

	addStrokeText("HUD_VelScaleNumerics_"..i, nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-velScaleLongTickLen - 1, posY}, HUD_VelScale_originLong.name, {{"HUD_VelScaleText", i}})
end
--
addStrokeLine("HUD_Window2_VelScaleLine", 10, {velScaleLongTickLen + 4.5, 0}, 90, HUD_VelScale_origin.name)

-- Altitude numerics
local HUD_Alt_num_origin	= addPlaceholder("HUD_Alt_num_origin", {120, -6}, HUD_Indication_bias.name)
addStrokeText("HUD_Altitude_num_k", nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-20, 0}, HUD_Alt_num_origin.name, {{"HUD_Altitude_Num", 0}})
addStrokeText("HUD_Altitude_num_comma", ",", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {-19.5, 0}, HUD_Alt_num_origin.name)
addStrokeText("HUD_Altitude_num", nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-3, 0}, HUD_Alt_num_origin.name, {{"HUD_Altitude_Num", 1}})
addStrokeSymbol("HUD_Altitude_box", {"stroke_symbols_HUD", "10-altitude-box"}, "FromSet", {-17.5, 0}, HUD_Alt_num_origin.name)

-- Altitude scale
local altScale500FeetStep		= 25
local altScaleLongTickLen		= 5
local altScaleShortTickLen		= 3
local Mil_Per100Feet			= altScale500FeetStep / 50
local HUD_AltScale_X			= 86 - altScaleLongTickLen

local HUD_AltScale_origin = addPlaceholder("HUD_AltScale_origin", {HUD_AltScale_X, -5.5}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_AltScaleOrigin"}})
local HUD_AltScale_originLong  = addPlaceholder("HUD_AltScale_originLong", {0, 0}, HUD_AltScale_origin.name, {{"HUD_AltScaleVerPos", 0, Mil_Per100Feet}})
local HUD_AltScale_originShort = {}
for j = 1,4 do
	HUD_AltScale_originShort[j] = addPlaceholder("HUD_AltScale_originShort"..j, {0, 0}, HUD_AltScale_origin.name, {{"HUD_AltScaleVerPos", 10 * j, Mil_Per100Feet}})
end

for i = 1, 4 do
	local posY = altScale500FeetStep * (i - 2)-- + velScale50KnotsStep / 2
	addStrokeLine("HUD_AltScaleTickLong_"..i, altScaleLongTickLen, {0, posY}, -90, HUD_AltScale_originLong.name, {{"HUD_AltScaleHide", i, 0}})
	for j = 1,4 do
		addStrokeLine("HUD_AltScaleTickShort_"..j..i, altScaleShortTickLen, {0, posY}, -90, HUD_AltScale_originShort[j].name, {{"HUD_AltScaleHide", i, j}})
	end

	addStrokeText("HUD_AltScaleNumericsL_"..i, nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {altScaleLongTickLen + 10.5, posY}, HUD_AltScale_originLong.name, {{"HUD_AltScaleText", i, 0}})
	addStrokeText("HUD_AltScale_comma"..i, ",", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {altScaleLongTickLen + 11.5, posY}, HUD_AltScale_originLong.name, {{"HUD_AltScaleText", i, 1}})
	addStrokeText("HUD_AltScaleNumericsR_"..i, nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {altScaleLongTickLen + 16.5, posY}, HUD_AltScale_originLong.name, {{"HUD_AltScaleText", i, 2}})
end
--
local altScaleLineX = -velScaleLongTickLen - 4.5
addStrokeLine("HUD_AltScaleLine", 10, {altScaleLineX, 0}, -90, HUD_AltScale_origin.name)

-- Vertical Velocity scale
local vvScale500FpmStep		= 8
local vvScaleLongTickLen	= 5
local vvScaleShortTickLen	= 3
local HUD_VvScale_X			= HUD_AltScale_X + altScaleLineX - vvScaleLongTickLen - 2

local HUD_VvScale_origin = addPlaceholder("HUD_VvScale_origin", {HUD_VvScale_X, -5.5}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_VvScaleOrigin"}})

for i = -2, 2 do
	local posY = vvScale500FpmStep * 2*i
	addStrokeLine("HUD_VvScaleTickLong_"..i, vvScaleLongTickLen, {0, posY}, -90, HUD_VvScale_origin.name)
end
for i = -1,2 do
	local posY = vvScale500FpmStep * (2*i - 1)
	addStrokeLine("HUD_VvScaleTickShort_"..i, vvScaleShortTickLen, {0, posY}, -90, HUD_VvScale_origin.name)
end
addStrokeSymbol("HUD_VvScaleIndicator", {"stroke_symbols_HUD", "vv-scale-ind"}, "FromSet", {1, 0}, HUD_VvScale_origin.name, {{"HUD_VvScaleIndPos", vvScale500FpmStep}})

-- Heading numerics
local HUD_Hdg_origin	= addPlaceholder("HUD_Hdg_origin", {0, HDG_origin_pos}, HUD_BlankRoot.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_Heading_Bias"}})
addStrokeText("HUD_Heading_num", nil, STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {0, -12.5}, HUD_Hdg_origin.name, {{"HUD_Heading_Num"}})
addStrokeBox("HUD_Heading_box", 17, 11, "CenterCenter", {0, -12.5}, HUD_Hdg_origin.name)

-- Heading scale
-- heading scale
local hdgScaleTenDegreesStep	= 32
local hdgScaleLongTickLen		= 5
local hdgScaleTextShiftY		= 2
local Mil_PerOneDegree			= hdgScaleTenDegreesStep / 10

local HUD_HdgScale_origin = addPlaceholder("HUD_HdgScale_origin", {0, 0}, HUD_Hdg_origin.name, {{"HUD_HdgScaleOrigin"}})		--  -53
local HUD_HdgScale_originLong  = addPlaceholder("HUD_HdgScale_originLong", {0, 0}, HUD_HdgScale_origin.name, {{"HUD_HdgScaleHorPos", 0, Mil_PerOneDegree}})
local HUD_HdgScale_originShort = addPlaceholder("HUD_HdgScale_originShort", {0, 0}, HUD_HdgScale_origin.name, {{"HUD_HdgScaleHorPos", -5, Mil_PerOneDegree}})

for i = 1, 3 do
	local posX = hdgScaleTenDegreesStep * (i - 2) - hdgScaleTenDegreesStep / 2
	addStrokeLine("HUD_HdgScaleTickLong_"..i, -hdgScaleLongTickLen, {posX, 0}, 0, HUD_HdgScale_originLong.name, {{"HUD_HdgScaleHide", (i - 2), 0}})
	addStrokeLine("HUD_HdgScaleTickShort_"..i, -hdgScaleLongTickLen * 0.5, {posX, 0}, 0, HUD_HdgScale_originShort.name, {{"HUD_HdgScaleHide", (i - 2), 1}})

	addStrokeText("HUD_HdgScaleNumerics_"..i, nil, STROKE_FNT_DFLT_100_NARROW, "CenterTop", {posX, - (hdgScaleLongTickLen + hdgScaleTextShiftY)},
		HUD_HdgScale_originLong.name, {{"HUD_HeadingScaleText", (i - 2)}})
end

-- heading index
addStrokeLine("HUD_HdgScaleIndex", 2 * hdgScaleLongTickLen, {0, 2}, 0, HUD_HdgScale_origin.name, {{"HUD_HdgScaleTrackIndex", 0}})
addStrokeSymbol("HUD_HdgScaleTrackIndex", {"stroke_symbols_HUD", "ground-track-ind"}, "FromSet", {0, 2}, HUD_HdgScale_origin.name, {{"HUD_HdgScaleTrackIndex", 1}})

-- Target Designator Box (NAV and A/A mode)
local boxSide = 25
local dotSz = 1
local dotGap = 2
local TD_box_root		= addPlaceholder("HUD_AA_TD_boxRoot", nil, HUD_BlankRoot.name, {{"HUD_AA_TD_BoxPos"}})
addStrokeBox("HUD_AA_TD_box", boxSide, boxSide, "CenterCenter", {0, 0}, TD_box_root.name)

local TGP_TD_box_root	= addPlaceholder("HUD_TGP_TD_boxRoot", nil, HUD_BlankRoot.name, {{"HUD_TGP_TD_BoxPos"}})
addStrokeBoxDashed("HUD_TGP_TD_box", boxSide, boxSide, dotSz, dotGap, {0, 0}, TGP_TD_box_root.name)

local maskWidth = 20
local maskHeight = 7

-- Target Angle
local fcrTLA = addStrokeText("HUD_TargetAngleReadout", 	nil, STROKE_FNT_DFLT_75, "LeftCenter", {-8, 0}, HUD_BoresightRoot.name, {{"HUD_TLA_pos"}, {"HUD_TargetAngleReadout"}})
local openingMask_tla = openMaskArea(0, "HUD_TLA_Mask", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TLA_pos"}})
set_box_w_h(openingMask_tla, maskWidth, maskHeight)

local tgpTLA = addStrokeText("HUD_TGP_TargetAngleReadout", nil, STROKE_FNT_DFLT_75, "LeftCenter", {-8, 0}, HUD_BoresightRoot.name, {{"HUD_TGP_TLA_pos"}, {"HUD_TGP_TargetAngleReadout"}})
local openingMask_tgp_tla = openMaskArea(0, "HUD_TGP_TLA_Mask", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TGP_TLA_pos"}})
set_box_w_h(openingMask_tgp_tla, maskWidth, maskHeight)

local tgpPDLT = addStrokeText("HUD_PDLT_TLA", nil, STROKE_FNT_DFLT_75, "LeftCenter", {-8, 0}, HUD_BoresightRoot.name, {{"HUD_AA_PDLT_TLA_position"}, {"HUD_AA_PDLT_TLA_angle"}})
local closingMask_tgp_tla = closeMaskArea(1, "HUD_TGP_TLA_Mask_close", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TGP_TLA_pos"}})
set_box_w_h(closingMask_tgp_tla, maskWidth, maskHeight)

local closingMask_tla = closeMaskArea(1, "HUD_TLA_Mask_close", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TLA_pos"}})
set_box_w_h(closingMask_tla, maskWidth, maskHeight)

-- Target Locator Line
local openingMask = openMaskArea(0, "HUD_TLL_Mask", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TLA_pos"}})
set_box_w_h(openingMask, maskWidth, maskHeight)
addStrokeLine("HUD_TLL", 57, {0,0}, 0, HUD_BoresightRoot.name, {{"HUD_TargetLocatorLine"}})
local closingMask = closeMaskArea(1, "HUD_TLL_Mask_close", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TLA_pos"}})
set_box_w_h(closingMask, maskWidth, maskHeight)

local openingMask_tgp = openMaskArea(0, "HUD_TGP_TLL_Mask", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TGP_TLA_pos"}})
set_box_w_h(openingMask_tgp, maskWidth, maskHeight)
addStrokeLine("HUD_TGP_TLL", 57, {0,0}, 0, HUD_BoresightRoot.name, {{"HUD_TGP_TargetLocatorLine"}}, true, dotSz, dotGap)
local closingMask_tgp = closeMaskArea(1, "HUD_TGP_TLL_Mask_close", {}, {}, {0,0}, HUD_BoresightRoot.name, {{"HUD_TGP_TLA_pos"}})
set_box_w_h(closingMask_tgp, maskWidth, maskHeight)

-- Radar ACM Cues
addStrokeLine("HUD_ACM_10", 240, {0,0}, 180, HUD_BoresightRoot.name, {{"HUD_FCR_OperatingMode", FCR_OPERATING_MODE.ACM_10_60}})
addStrokeSymbol("HUD_ACM_BORE", {"stroke_symbols_HUD", "FCR-Boresight-cross"}, "FromSet", {0, -DegToMil(3)}, HUD_BoresightRoot.name, {{"HUD_FCR_OperatingMode", FCR_OPERATING_MODE.ACM_BORE}})

addStrokeSymbol("HUD_ACM_SLEW", {"stroke_symbols_HUD", "FCR-Slew-cross"}, "FromSet", {0, -DegToMil(3)}, HUD_BoresightRoot.name, {{"HUD_FCR_OperatingMode", FCR_OPERATING_MODE.ACM_SLEW}})
local FCR_ACM_Slew = addStrokeSymbol("HUD_ACM_SLEW_SCAN_CENTER", {"stroke_symbols_HUD", "FCR-Slew-Center"}, "FromSet", {0, -DegToMil(3)}, HUD_BoresightRoot.name, {{"HUD_FCR_OperatingMode", FCR_OPERATING_MODE.ACM_SLEW}, {"HUD_FCR_ACM_SlewCenterPosition"}})
addStrokeText("HUD_ACM_SLEW_MAX_ALTITUDE", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {5,  10}, FCR_ACM_Slew.name, {{"HUD_FCR_ACM_SlewMaxAltitude"}})
addStrokeText("HUD_ACM_SLEW_MIX_ALTITUDE", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {5, -10}, FCR_ACM_Slew.name, {{"HUD_FCR_ACM_SlewMinAltitude"}})

-- Range scale
local dlzWidth = 6
local dlzRange = 74
local DLZ_root = addPlaceholder("HUD_AA_DLZ_root", {63, -34}, HUD_BlankRoot.name, {{"HUD_AA_DLZ_Show"}})
local RangeScale_root = addPlaceholder("HUD_RangeScale_root", {0, 0}, DLZ_root.name)--, {{"HUD_RangeScale_Show"}})

addStrokeText("HUD_RangeScale", "", STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {3, dlzRange+3}, RangeScale_root.name, {{"HUD_RangeScale"}})
addStrokeLine("HUD_RangeScale_line", dlzWidth, {0, dlzRange}, -90, RangeScale_root.name)
addStrokeLine("HUD_AA_DLZ_zeroRange", dlzWidth, {0, 0}, -90, RangeScale_root.name)

local dlzRangeCaret = addStrokeSymbol("HUD_AA_DLZ_TgtRange",   {"stroke_symbols_HUD", "AA-DLZ-range"},	"FromSet", {0, 0}, DLZ_root.name, {{"HUD_AA_DLZ_TgtRange"}})
addStrokeText("HUD_AA_DLZ_TgtClosureRate", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-6, 0}, dlzRangeCaret.name, {{"HUD_AA_DLZ_TgtClosureRate"}})
addStrokeText("HUD_AA_AIM120_AF_Pole", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-6, -10}, dlzRangeCaret.name, {{"HUD_AA_AIM120_AF_Pole"}})

--HTS TDOA turn
local TDOA_turn = addPlaceholder("HTS_TDOA_turn", {0,0}, HUD_BlankRoot.name)
addStrokeText("HUD_HTS_TDOA_show", "TDOA", STROKE_FNT_DFLT_100_NARROW, "Center", {-10, 35}, TDOA_turn.name, {{"HUD_HTS_TDOA_show"}})
addStrokeText("HUD_HTS_TDOA_turn", "", STROKE_FNT_DFLT_100_NARROW, "Center", {-10, 35}, TDOA_turn.name, {{"HUD_HTS_TDOA_turn"}})

-- Window 1, Angle-to-target data
--

-- Window 2, Velocity scale mnemonic - C, T, G
addStrokeText("HUD_Window2_VelScaleMnemonic", nil, STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {velScaleLongTickLen - 0.5, 2}, HUD_VelScale_origin.name, {{"HUD_Window2_VelScaleMenomic"}},
	{"", "G", "T", "C"})

-- Window 3, ARM status - ARM, ILS, SIM, blank
addStrokeText("HUD_Window3_Arm_Status", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-80, -52}, HUD_Indication_bias.name, {{"HUD_Window3_Arm_Status"}},
	{"", "ARM", "ILS", "SIM"})

addStrokeText("HUD_Window3_Laser_Status", "L", STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-56, -52}, HUD_Indication_bias.name, {{"HUD_Window3_Laser_Status"}})

-- Window 4, Mach number
local HUD_Mach_num_origin	= addPlaceholder("HUD_Mach_num_origin", {-76, -62}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}})
addStrokeText("HUD_Window4_MachNumber_num", nil, STROKE_FNT_DFLT_100, "RightCenter", {0, 0}, HUD_Mach_num_origin.name, {{"HUD_Window4_MachNumber_Num", 0}})
addStrokeText("HUD_Window4_MachNumber_dot", ".", STROKE_FNT_DFLT_100, "RightCenter", {3, 0}, HUD_Mach_num_origin.name)
addStrokeText("HUD_Window4_MachNumber_tenth", nil, STROKE_FNT_DFLT_100, "RightCenter", {12.5, 0}, HUD_Mach_num_origin.name, {{"HUD_Window4_MachNumber_Num", 1}})

-- Window 5, Normal acceleration
local HUD_NAccel_num_origin	= addPlaceholder("HUD_NAccel_num_origin", {-73, 43}, HUD_Indication_bias.name)
addStrokeText("HUD_Window5_NormalAccel_num", nil, STROKE_FNT_DFLT_100, "RightCenter", {0, 0}, HUD_NAccel_num_origin.name, {{"HUD_Window5_NormalAccel_Num", 0}})
addStrokeText("HUD_Window5_NormalAccel_dot", ".", STROKE_FNT_DFLT_100, "RightCenter", {3, 0}, HUD_NAccel_num_origin.name)
addStrokeText("HUD_Window5_NormalAccel_tenth", nil, STROKE_FNT_DFLT_100, "RightCenter", {6.5, 0}, HUD_NAccel_num_origin.name, {{"HUD_Window5_NormalAccel_Num", 1}})

-- Window 6, Altitude scale mnemonic - R, blank
addStrokeText("HUD_Window6_AltScaleMenomic", "R", STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {-velScaleLongTickLen, 2}, HUD_AltScale_origin.name, {{"HUD_Window6_AltScaleMenomic"}})
--

-- Window 7, 
local HUD_Window7_origin	= addPlaceholder("HUD_Window7_origin", {-92, -72}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}})
-- Alignment status - STBY, ALIGN, MAN
local HUD_AlignStatus_origin	= addPlaceholder("HUD_AlignStatus_origin", {0, 0}, HUD_Window7_origin.name, {{"HUD_Window7_Type", HUD_Window7_Type.ALIGN_STATUS}})
addStrokeText("HUD_Window7_AlignmentStatus", nil, STROKE_FNT_DFLT_100, "LeftCenter", {0, 0}, HUD_AlignStatus_origin.name, {{"HUD_Window7_AlignStatus"}}, {"", "STBY", "MAN", "ALIGN"})
-- MBAL, DRNG
-- System accuracy - SYS M, SYS L, SYS F
-- Maximum G's
local HUD_MaxAccel_num_origin	= addPlaceholder("HUD_MaxAccel_num_origin", {4, 0}, HUD_Window7_origin.name, {{"HUD_Window7_Type", HUD_Window7_Type.MAX_G}})
addStrokeText("HUD_Window7_MaxAccel_num", nil, STROKE_FNT_DFLT_100, "RightCenter", {0, 0}, HUD_MaxAccel_num_origin.name, {{"HUD_Window7_MaxAccel_Txt", 0, 0}})
addStrokeText("HUD_Window7_MaxAccel_dot", ".", STROKE_FNT_DFLT_100, "RightCenter", {3, 0}, HUD_MaxAccel_num_origin.name, {{"HUD_Window7_MaxAccel_Txt", 0, 2}})
addStrokeText("HUD_Window7_MaxAccel_tenth", nil, STROKE_FNT_DFLT_100, "RightCenter", {6.5, 0}, HUD_MaxAccel_num_origin.name, {{"HUD_Window7_MaxAccel_Txt", 0, 1}})
--addStrokeText("HUD_Window7_Text", nil, STROKE_FNT_DFLT_100, "RightCenter", {8, 0}, HUD_MaxAccel_num_origin.name, {{"HUD_Window7_MaxAccel_Txt", 1}})

-- Window 8, Master mode/submode mnemonic - NAV, DGFT, SRM, MSL, MRM, AAM, JETT, DTOS, CCRP, CCIP, EEGS, LCOS, SNAP, LADD, STRF, PRE/?, VIS/?, BORE/?, MAN,
-- FIX, ACAL, VIRCRP, VIPLAD, VIP EO, VRPCRP, VRPLAD, VRP EO, HARM/?, HRMVIP/?, HRMVRP/?
addStrokeText("HUD_Window8_MasterMode", "", STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-92, -82}, HUD_Indication_bias.name, {{"HUD_Window8_MasterMode"}},	AcftSubModeLbl)

-- Window 9, none

-- Window 10, Slant range
addStrokeText("HUD_Window10_SlantRange", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {62, -84}, HUD_Indication_bias.name, {{"HUD_Window10_SlantRange"}})

-- Window 11, WARN mnemonic - WARN
addStrokeText("HUD_Window11_WARN", "WARN", STROKE_FNT_DFLT_200, "CenterBottom", {0, 0}, HUD_BlankRoot.name, {{"HUD_Window11_WARN"}})

-- Window 12, FUEL advisory mnemonic
addStrokeText("HUD_Window12_FuelAdvisory", "FUEL", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {0, -14}, HUD_BlankRoot.name, {{"HUD_Window12_FuelAdvisory"}})

-- Window 13, Closure rate, Time to release, Time to destination
--
addStrokeText("HUD_Window13_TimeToStp", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {62, -94}, HUD_Indication_bias.name, {{"HUD_Window13_TimeToStp"}})

-- Window 14, Steerpoint data - ### up to 999, blank, > number
local HUD_StpData_origin	= addPlaceholder("HUD_StpData_origin", {62, -104}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}})
addStrokeText("HUD_Window14_StpTgtData_RangeNum", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {0, 0}, HUD_StpData_origin.name, {{"HUD_Window14_StpTgtData"}}, {"", "%03d>%03d", "%02d %1.1f", "%02d %3.0f"})
--addStrokeText("HUD_Window14_StpTgtData", ">", STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {16, 0}, HUD_StpData_origin.name)
--addStrokeText("HUD_Window14_StpTgtData_Num", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {24, 0}, HUD_StpData_origin.name, {{"HUD_Window14_StpTgtData", 1, 2}})
-- Range and bearing to target
--local HUD_TgtRnB_origin	= addPlaceholder("HUD_TgtRnB_origin", {62, -74}, nil, {{"HUD_Window14_StpTgtData", 2}})

-- Window 15, Fuel, Home bingo status, Trapped fuel - TRP FUEL, Ownship Bull's-Eye data
addStrokeText("HUD_Window15_Bullseye_Data", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-103, -92}, HUD_Indication_bias.name, {{"HUD_Window15_BullseyeData"}}, {"", "%03d  %03d", "FUEL", "FUEL %03d", "TRP FUEL"})

-- Window 16, none
-- Window 17, none
-- Window 18, none

-- Window 19, Movable window - LOW (in AG, adjacent FPM), AIM-120 LOSE cue, AGM-88 solution >< (centered around azimuth steering line), NO RAD (in the center slightly above boresight)
addStrokeText("HUD_Window19_NoRad", "NO RAD", STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {0, boresightShiftY + 10}, HUD_BlankRoot.name, {{"HUD_Window19_NoRad"}})
--

-- Window 20, DED/PFLD data repeat
-- Window 21, DED/PFLD data repeat
-- Window 22, DED/PFLD data repeat
-- Window 23, DED/PFLD data repeat
-- Window 24, DED/PFLD data repeat

-- Window 25, Altitude low setting - AL ###/?
local HUD_Alt_low_origin	= addPlaceholder("HUD_Alt_low_origin", {62, -74}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_Window25_Altitude_Low", 0}})
addStrokeText("HUD_Window25_Altitude_Low", "AL", STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {0, 0}, HUD_Alt_low_origin.name)
addStrokeText("HUD_Window25_Altitude_Low_num", nil, STROKE_FNT_DFLT_100_NARROW, "RightCenter", {37, 0}, HUD_Alt_low_origin.name, {{"HUD_Window25_Altitude_Low", 1}})

-- Window 26, Radar altitude
local HUD_RadarAlt_origin	= addPlaceholder("HUD_RadarAlt_origin", {81, -61}, HUD_Indication_bias.name, {{"HUD_AA_Gun_HideIfActive"}, {"HUD_Window26_RadarAlt", 0}})
addStrokeText("HUD_RadarAlt_Mnemonic", "R", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-15, 0}, HUD_RadarAlt_origin.name, {{"HUD_Window26_RadarAlt", 1}})
addStrokeBox("HUD_RadarAlt_box", 30, 11, "CenterCenter", {1, 0}, HUD_RadarAlt_origin.name)
addStrokeText("HUD_RadarAlt_num_k", "56", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-2, 0}, HUD_RadarAlt_origin.name, {{"HUD_Window26_RadarAlt", 2}})
addStrokeText("HUD_RadarAlt_comma", ",", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {-1.5, 0}, HUD_RadarAlt_origin.name)
addStrokeText("HUD_RadarAlt_num", "537", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {15, 0}, HUD_RadarAlt_origin.name, {{"HUD_Window26_RadarAlt", 3}})

-- Window 27, none
-- Window 28, none
-- Window 29, none

-- Window 30, manual reticle depression
-- see in HUD_AG

-- Window 31, none

-- Window 32, Missile time of flight, Predicted altitude ar weapon release
-- see in HUD_AA
-- for AGM-88 see in HUD_AG

-- Window 33, Closure rate, Predicted climb angle at weapon release
--

-- Window 34, Dynamic launch zone scale
--

-- Window 35, none
-- Window 36, none

-- Window 37, Time remaining AIM-120 longest flight/bugged target/? - blank, ### (last launched AIM-9), A### (to active), T### (to impact), L### (to termination)
-- see in HUD_AA
-- for AGM-88 see in HUD_AG

-- Window 38, DL message - DATA
local HUD_DL_DATA_PH = addPlaceholder("HUD_DL_DATA_PH", {0, 0}, HUD_Indication_bias.name, {{"HUD_Window38_DL_message"}})
	addStrokeText("HUD_DL_DATA_MKPT_NUMBER", "MKPT71", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {0, 0}, HUD_DL_DATA_PH.name, {{"HUD_Window38_mkptNumber"}})
	addStrokeText("HUD_DL_DATA", "DATA", STROKE_FNT_DFLT_100_NARROW, "CenterCenter", {0, -10}, HUD_DL_DATA_PH.name)

-- SOI symbol
addStrokeSymbol("HUD_SOI", {"stroke_symbols_HUD", "12-SOI"}, "FromSet", {-82, 52}, HUD_BlankRoot.name, {{"HUD_SOI_Symbol"}})

-- Breakaway Cue X
local BreakawayCue_L = 50
local BreakawayCue_2L = BreakawayCue_L * 2
local BreakawayCue_LEN = math.sqrt(BreakawayCue_2L * BreakawayCue_2L * 2)
local BreakawayCue_PH = addPlaceholder("HUD_BreakawayCue_X_PH", {0,0}, HUD_BlankRoot.name, {{"HUD_BreakawayCue_X"}})
addStrokeLine("HUD_BreakawayCue_/",		BreakawayCue_LEN, {-BreakawayCue_L, -BreakawayCue_L}, -45, BreakawayCue_PH.name, nil, false)
addStrokeLine("HUD_BreakawayCue_\\",	BreakawayCue_LEN, { BreakawayCue_L, -BreakawayCue_L},  45, BreakawayCue_PH.name, nil, false)

-- ILS
local ILS_PH = addPlaceholder("HUD_ILS_PH", {0,0}, HUD_FPM_origin.name, {{"HUD_ILS_EnableAndRot"}})
local ILS_LOC_PH = addPlaceholder("HUD_ILS_LOC_PH", {0,0}, ILS_PH.name, {{"HUD_ILS_LocPos", 25}})
local ILS_GS_PH = addPlaceholder("HUD_ILS_GS_PH", {0,0}, ILS_PH.name, {{"HUD_ILS_GsPos", 25}})

addStrokeSymbol("HUD_LocLineValid", {"stroke_symbols_HUD", "ILS_line_solid"}, "FromSet", {0, 0}, ILS_LOC_PH.name, {{"HUD_ILS_LocValid", 1}})
addStrokeSymbol("HUD_LocLineInvalid", {"stroke_symbols_HUD", "ILS_line_dashed"}, "FromSet", {0, 0}, ILS_LOC_PH.name, {{"HUD_ILS_LocValid", 0}})

local GS_LineValid = addStrokeSymbol("HUD_GsLineValid", {"stroke_symbols_HUD", "ILS_line_solid"}, "FromSet", {0, 0}, ILS_GS_PH.name, {{"HUD_ILS_GsValid", 1}})
GS_LineValid.init_rot	= {90}
local GS_LineInvalid = addStrokeSymbol("HUD_GsLineInvalid", {"stroke_symbols_HUD", "ILS_line_dashed"}, "FromSet", {0, 0}, ILS_GS_PH.name, {{"HUD_ILS_GsValid", 0}})
GS_LineInvalid.init_rot	= {90}

-- ILS CMD STRG
local function addIlsCmdStrg(name, parent, controllers)
	local ILS_CMD_STRG_PH = addPlaceholder(name.."_PH", {0,0}, parent, controllers)
	addStrokeCircle(name.."_Circle", 2.5, {0,0}, ILS_CMD_STRG_PH.name, nil, nil, math.pi * 2 / 4, math.pi * 2 / 4)
	local ILS_TIC_MARK_PH = addPlaceholder(name.."_TIC_MARK_PH", {0,0}, ILS_CMD_STRG_PH.name, {{"HUD_ILS_TIC_MARK_Enable"}})
	addStrokeLine(name.."_Line1",	5, { -0.5, 2.5}, nil, ILS_TIC_MARK_PH.name)
	addStrokeLine(name.."_Line2",	5, {  0.0, 2.5}, nil, ILS_TIC_MARK_PH.name)
	addStrokeLine(name.."_Line3",	5, {  0.5, 2.5}, nil, ILS_TIC_MARK_PH.name)
	add_X_Over(name.."_X", 5, 5, {0.0, 7.5}, ILS_TIC_MARK_PH.name, {{"HUD_ILS_TIC_MARK_X"}})
end

-- CMD STRG on horizon line
addIlsCmdStrg("HUD_ILS_CMD_STRG_PH", "PL_horizon_long_line_origin", {{"HUD_ILS_CMD_STRG_EnableAndPos", 13}})
-- CMD STRG on FPM with TIC MARK
addIlsCmdStrg("HUD_ILS_TIC_MARK_PH", HUD_FPM_origin.name, {{"HUD_ILS_TIC_MARK_EnableAndPos", 13}})

local PDLT_symbol_root = addPlaceholder("HUD_AA_PDLT_symbol_root", nil, nil, {{"HUD_AA_PDLT_symbol_position"}})
addStrokeSymbol("HUD_PDLT_symbol", {"stroke_symbols_HUD", "pdlt_symbol"}, "FromSet", {0, 0}, PDLT_symbol_root.name)
addStrokeText("HUD_PDLT_altitude", "00", STROKE_FNT_DFLT_100, "CenterCenter", {0, -17}, PDLT_symbol_root.name, {{"HUD_AA_PDLT_altitude"}})

local PDLT_TLL_symbol_root = addPlaceholder("HUD_AA_PDLT_TLL_symbol_root", {0, boresightShiftY}, nil, {{"HUD_AA_PDLT_TLL_symbol_position"}, {"HUD_AA_PDLT_TLL_symbol_rotation"}})
addStrokeSymbol("HUD_PDLT_TLL_symbol", {"stroke_symbols_HUD", "pdlt-TLL"}, "FromSet", {0, 0}, PDLT_TLL_symbol_root.name)

local CRUS_PH = addPlaceholder("CRUS_PH", {0,0}, HUD_Indication_bias.name) 
local lenght = 80
local CRUS_VELOCITY_PH = addPlaceholder("CRUS_VELOCITY_PH", {-78, -45.5}, CRUS_PH.name, {{"HUD_CRUS_Velocity_Caret_Show"}}) 
	local HUD_CRUS_Velocity_Caret = addStrokeSymbol("HUD_CRUS_Velocity_Caret",   {"stroke_symbols_HUD", "AA-DLZ-range"}, "FromSet", {0,0} , CRUS_VELOCITY_PH.name, {{"HUD_CRUS_Velocity_Caret", lenght}})
	HUD_CRUS_Velocity_Caret.init_rot	= {180}
local CRUS_ALTITUDE_PH = addPlaceholder("CRUS_ALTITUDE_PH", {78, -45.5}, CRUS_PH.name, {{"HUD_CRUS_Altitude_Caret_Show"}}) 	
	local HUD_CRUS_Altitude_Caret = addStrokeSymbol("HUD_CRUS_Altitude_Caret",   {"stroke_symbols_HUD", "AA-DLZ-range"}, "FromSet", {0,0} , CRUS_ALTITUDE_PH.name, {{"HUD_CRUS_Altitude_Caret", lenght}})
	
-- BOMB MAN
local Bomb_MAN_Reticle_Pos = addPlaceholder("Bomb_MAN_Reticle_Pos_PH", {0,0}, nil, {{"HUD_Bomb_MAN_RETICLE_Pos"}}) 
local Bomb_MAN_PRI_Reticle = addPlaceholder("Bomb_MAN_PRI_Reticle_PH", {0,0}, Bomb_MAN_Reticle_Pos.name, {{"HUD_Bomb_MAN_PRI_RETICLE_SHOW"}}) 
	addStrokeCircle("Bomb_MAN_PRI_Reticle_dot", 1, nil, Bomb_MAN_PRI_Reticle.name)
	addStrokeCircle("Bomb_MAN_PRI_Reticle_dot_1", 0.5, nil, Bomb_MAN_PRI_Reticle.name)	
	local Bomb_MAN_PRI_Reticle_circle_1 = addStrokeCircle("Bomb_MAN_PRI_Reticle_circle_1", 25, {0,0}, Bomb_MAN_PRI_Reticle.name, nil, {0, math.pi * 2}, math.pi * 2 / 8 + 0.2, math.pi * 2 / 8 - 0.2, true)
		Bomb_MAN_PRI_Reticle_circle_1.init_rot = {-28.5}
	addStrokeCircle("Bomb_MAN_PRI_Reticle_circle_2", 50, {0,0}, Bomb_MAN_PRI_Reticle.name, nil, {0, math.pi * 2})
	
--Window 30
addStrokeText("HUD_Window30_Reticle_Depression", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-80, -42}, nil, {{"HUD_Window30_Reticle_Depression"}})