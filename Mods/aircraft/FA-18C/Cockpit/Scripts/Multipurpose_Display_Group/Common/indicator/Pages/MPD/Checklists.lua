dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local count = 0
local function counter()
	count = count + 1
	return count
end

local BaseSize = glyphNominalHeight150
local FontSize = STROKE_FNT_DFLT_150	-- Remove after debug
local OffsetOnOneLetter = BaseSize - 5
local OffsetBetweenString = BaseSize * 1.55

local LandXPos = BaseSize * -9.65
local LandYPos = BaseSize * 13.6

local XPosLeftCollum = LandXPos + OffsetOnOneLetter

local TOXPos = BaseSize * 2
local XPosRightCollum = TOXPos + OffsetOnOneLetter

local function getVerticalOffset()
	return LandYPos - OffsetBetweenString * counter()
end

-- Left collum
addStrokeText("Land", "LAND", FontSize, "LeftCenter", {LandXPos, LandYPos})
addStrokeText("Wheels", "WHEELS", FontSize, "LeftCenter", {XPosLeftCollum, getVerticalOffset()})
addStrokeText("Flaps", "FLAPS", FontSize, "LeftCenter", {XPosLeftCollum,  getVerticalOffset()})
addStrokeText("Hook", "HOOK", FontSize, "LeftCenter", {XPosLeftCollum,  getVerticalOffset()})
addStrokeText("AntiSkid", "ANTI SKID", FontSize, "LeftCenter", {XPosLeftCollum,  getVerticalOffset()})
addStrokeText("Harness", "HARNESS", FontSize, "LeftCenter", {XPosLeftCollum,  getVerticalOffset()})
addStrokeText("Dispenser", "DISPENSER", FontSize, "LeftCenter", {XPosLeftCollum,  getVerticalOffset()})
count = count + 2	-- skip 2 lines
local weightYoffset = getVerticalOffset()
addStrokeText("AC_WEIGHT_label", "A/C WT", FontSize, "LeftCenter", {LandXPos,  weightYoffset})
addStrokeText("AC_WEIGHT", "", FontSize, "LeftCenter", {LandXPos + 7 * BaseSize,  weightYoffset}, nil, {{"MPD_CHECKLIST_Weight"}})
count = count + 2	-- skip 2 lines
addStrokeText("MAX", "MAX NZ", FontSize, "LeftCenter", {LandXPos,  getVerticalOffset()})
count = count + 1	-- skip 1 line
local stabPosYoffset = getVerticalOffset()
addStrokeText("StabPos_label", 	"STAB POS", FontSize, "CenterCenter", {0, stabPosYoffset})
addStrokeText("StabPos_left", 	"", FontSize, "LeftCenter", {XPosLeftCollum, stabPosYoffset}, nil, {{"MPD_CHECKLIST_Stabs", 0}}, {"%2d° NU", "%2d° ND", "%2d°  "})
addStrokeText("StabPos_right",	"", FontSize, "LeftCenter", {XPosRightCollum + BaseSize, stabPosYoffset}, nil, {{"MPD_CHECKLIST_Stabs", 1}}, {"%2d° NU", "%2d° ND", "%2d°  "})

-- Right collum
count = 0

addStrokeText("TO", "T.O.", FontSize, "LeftCenter", {TOXPos, LandYPos})
addStrokeText("Controls", "CONTROLS", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("Wings", "WINGS", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("Trim", "TRIM", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("Flaps_", "FLAPS", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("Hook_", "HOOK", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("Harness_", "HARNESS", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("WarnLites", "WARN LITES", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("NwsLo", "NWS LO", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})
addStrokeText("SeatArm", "SEAT ARM", FontSize, "LeftCenter", {XPosRightCollum, getVerticalOffset()})