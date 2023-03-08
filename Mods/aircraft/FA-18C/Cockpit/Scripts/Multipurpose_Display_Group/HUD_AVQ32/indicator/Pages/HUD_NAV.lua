dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")

-- Bank scale
local bankScaleRadius = DegToDI(11) - 5
local cardinTickLen = 20

local BankScale_origin = addPlaceholder("BankScale_origin", {0, waterlineShiftY}, nil, {{"HUD_BankScale_Show"}})

-- Cardinal bank angle ticks - 45, 30, 15, 0 degrees. Symmetrical about vertical axis.
for i = 0, 6 do
	local posAngle = math.rad(135 + i * 15)
	addStrokeLine("BankScaleCardinalTick_"..i, cardinTickLen, {-bankScaleRadius * math.sin(posAngle), bankScaleRadius * math.cos(posAngle)}, 135 + i * 15, BankScale_origin.name)
end

-- Short bank angle ticks - 5 degrees. Symmetrical about vertical axis.
for i = 0, 1 do
	local posAngle = math.rad(175 + i * 10)
	addStrokeLine("BankScaleShortTick_"..i, cardinTickLen / 2, {-bankScaleRadius * math.sin(posAngle), bankScaleRadius * math.cos(posAngle)}, 175 + i * 10, BankScale_origin.name)
end

-- Bank index
addStrokeEquilateralTriangle("BankTriangle", 17, 60, {0, 0}, 180, {0, -bankScaleRadius + 2}, BankScale_origin.name, {{"HUD_BankAngle"}})

-- Vertical Velocity
addStrokeText("VerticalVelocity", nil, STROKE_FNT_DFLT_120_WIDE, "RightBottom", {-gap_alt_hund_tenths, 23}, ALT_BoxOrigin.name, {{"HUD_EADI_VertVelocityNumerics"}})
-- Climb Air Speed Prompt
addStrokeText("ClimbAirSpeed", "XXXX", STROKE_FNT_DFLT_120_WIDE, "LeftBottom", {gap_alt_hund_tenths, 23}, CAS_BoxOrigin.name, {{"HUD_FPAS_ClimbAirSpeedNumerics"}})