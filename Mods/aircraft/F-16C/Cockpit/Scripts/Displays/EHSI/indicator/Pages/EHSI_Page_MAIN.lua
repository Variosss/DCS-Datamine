dofile(LockOn_Options.script_path.."Displays/EHSI/indicator/EHSI_Page_defs.lua")


function setMaterialAndFont( material, font )
    if material ~= nil then
		default_material = material
	end
    if font ~= nil then
		stroke_font = font
	end
end

function setDefaultMaterialAndFont()
    setMaterialAndFont("EHSI_WHITE", "font_stroke_EHSI")
end

local function getPosOnRose(radius, angle)
	return { radius * math.sin(math.rad(angle)), radius * math.cos(math.rad(angle)) }
end


-----------------------------------------------------------------------------------------------
-- Main Placeholder ---------------------------------------------------------------------------
local CompasRoseBase = addPlaceholder("CompasRose _plaseholder", {0, 0}, nil, {{"EHSI_Heading"}})

-----------------------------------------------------------------------------------------------
-- Bearing Pointer ----------------------------------------------------------------------------
local BearingPointer_PH = addPlaceholder("BearingPointer _plaseholder", {0, 0}, nil, {{"EHSI_Bearing"}})

local BearingPointerRadius = 131
local BearingPointerArrowHeight = 13
local BearingPointerTailRadius = 137
local BearingPointerTailLen = 19

addMaskedTriangle("BearingPointer Arrow Triangle", 15, BearingPointerArrowHeight, "CenterBottom", {0, BearingPointerRadius}, nil, BearingPointer_PH.name, nil, "EHSI_BLUE")
addMaskedFatLine("BearingPointer Arrow", BearingPointerArrowHeight, 4, {0, BearingPointerRadius}, 180, BearingPointer_PH.name, nil, "EHSI_BLUE")
addMaskedFatLine("BearingPointer Tail", BearingPointerTailLen, 4, {0, -BearingPointerTailRadius}, nil, BearingPointer_PH.name, nil, "EHSI_BLUE")

-----------------------------------------------------------------------------------------------
-- Heading Marker -----------------------------------------------------------------------------
local HeadingMarker_PH = addPlaceholder("HeadingMarker _plaseholder", {0, 0}, CompasRoseBase.name, {{"EHSI_ManualHeading"}})
local HeadingMarkerRadius = 130
local HeadingMarkerSize = 10
local HeadingMarkerSize05 = HeadingMarkerSize / 2
addMaskedBox("HeadingMarker Flag L", HeadingMarkerSize, HeadingMarkerSize, nil, {-2 - HeadingMarkerSize05, HeadingMarkerRadius}, nil, HeadingMarker_PH.name, nil, "EHSI_GOLD")
addMaskedBox("HeadingMarker Flag R", HeadingMarkerSize, HeadingMarkerSize, nil, { 2 + HeadingMarkerSize05, HeadingMarkerRadius}, nil, HeadingMarker_PH.name, nil, "EHSI_GOLD")

-----------------------------------------------------------------------------------------------
-- Course Pointer -----------------------------------------------------------------------------
local CoursePointer_PH = addPlaceholder("CoursePointer _plaseholder", {0, 0}, CompasRoseBase.name, {{"EHSI_ManualCourse"}})

local CoursePointerArrowRadius = 81
local CoursePointerArrowHeight = 11
local CoursePointerArrowLen = 20
local CoursePointerTailRadius = CoursePointerArrowRadius + CoursePointerArrowHeight
local CoursePointerTailLen = CoursePointerArrowHeight + CoursePointerArrowLen

addTriangle("CoursePointer Arrow Triangle", 17, CoursePointerArrowHeight, "CenterBottom", {0, CoursePointerArrowRadius}, nil, CoursePointer_PH.name, nil, "EHSI_BLUE")
addFatLine("CoursePointer Arrow", CoursePointerArrowLen, 4, {0, CoursePointerArrowRadius}, 180, CoursePointer_PH.name, nil, "EHSI_BLUE")
addFatLine("CoursePointer Tail", CoursePointerTailLen, 4, {0, -CoursePointerTailRadius}, nil, CoursePointer_PH.name, nil, "EHSI_BLUE")

-----------------------------------------------------------------------------------------------
-- compase rose notches -----------------------------------------------------------------------
local CompasRoseRadius = 131
local CompasRoseNotchLen = 15
local CompasRoseNotchShortLen = 8
local CompasRoseNotchLongLen = 16

for i = 0,350,10 do
	local j = i + 5
	addStrokeLine("CompaseRose x0 deg notch at "..i,		CompasRoseNotchLongLen, getPosOnRose(CompasRoseRadius, i), 180 - i, CompasRoseBase.name, nil, false, nil, nil, "EHSI_WHITE")
	addStrokeLine("CompaseRose x5 deg notch at "..i.."+5",	CompasRoseNotchShortLen, getPosOnRose(CompasRoseRadius, j), 180 - j, CompasRoseBase.name, nil, false, nil, nil, "EHSI_WHITE")
end

-----------------------------------------------------------------------------------------------
-- compase rose labels ------------------------------------------------------------------------
local CompasRoseLabelsArr = {"N", "3", "6", "E", "|2", "|5", "S", "2|", "24", "W", "30", "33"} -- '|' = '1' without bottom line
local CompasRoseLblRadius = 103

for i = 1,12,1 do
	local angle = (i - 1) * 30
	local Lbl_PH = addRotPlaceholder("CompaseRose Label "..i.."_plaseholder", getPosOnRose(CompasRoseLblRadius, angle), -angle, CompasRoseBase.name)
	addStrokeText("CompaseRose Label "..i, CompasRoseLabelsArr[i], STROKE_FNT_DFLT_ROSE, "CenterCenter", {0, 0}, Lbl_PH.name)
end

-----------------------------------------------------------------------------------------------
-- static outer notches -----------------------------------------------------------------------
local CompaseRoseOutRadius = CompasRoseRadius + 2
local CompasRoseNotchOutLen = 15

for i = 0,315,45 do
	addStrokeLine("CompaseRose 45deg segment line at "..i.."c", CompasRoseNotchOutLen, getPosOnRose(CompaseRoseOutRadius, i), -i, nil, nil, false, nil, nil, "EHSI_WHITE")
end

-----------------------------------------------------------------------------------------------
-- plane symbol -------------------------------------------------------------------------------
local PS_WingLen = 25
local PS_FuselageLen = 23
local PS_TailLen = 13

local PlaneSymb_PH = addPlaceholder("Plane Symbol _plaseholder", {0, 7})

addStrokeLine("Plane Symbol F", PS_FuselageLen, {0, 4}, 180, PlaneSymb_PH.name, nil, false, nil, nil, "EHSI_WHITE")
addStrokeLine("Plane Symbol W", PS_WingLen, {PS_WingLen / 2, 0}, 90, PlaneSymb_PH.name, nil, false, nil, nil, "EHSI_WHITE")
addStrokeLine("Plane Symbol T", PS_TailLen, {PS_TailLen / 2, -13}, 90, PlaneSymb_PH.name, nil, false, nil, nil, "EHSI_WHITE")

-----------------------------------------------------------------------------------------------
-- knob labels --------------------------------------------------------------------------------
local KnobLabelShift_x = 9
local KnobLabelShift_y = 9
local KnobLabelRadius = 157

-- HDG knob labels
local HDG_lbl_pos_x = KnobLabelRadius * math.sin(math.rad(225))
local HDG_lbl_pos_y = KnobLabelRadius * math.cos(math.rad(225))

local HDG_lbl_pos_H = {HDG_lbl_pos_x - KnobLabelShift_x, HDG_lbl_pos_y + KnobLabelShift_y}
local HDG_lbl_pos_D = {HDG_lbl_pos_x, HDG_lbl_pos_y}
local HDG_lbl_pos_G = {HDG_lbl_pos_x + KnobLabelShift_x, HDG_lbl_pos_y - KnobLabelShift_y}

addStrokeText("HDG Knob label H", "H", STROKE_FNT_DFLT_LBL, "CenterCenter", HDG_lbl_pos_H)
addStrokeText("HDG Knob label D", "D", STROKE_FNT_DFLT_LBL, "CenterCenter", HDG_lbl_pos_D)
addStrokeText("HDG Knob label G", "G", STROKE_FNT_DFLT_LBL, "CenterCenter", HDG_lbl_pos_G)

-- CRS knob labels
local CRS_lbl_pos_x = KnobLabelRadius * math.sin(math.rad(135))
local CRS_lbl_pos_y = KnobLabelRadius * math.cos(math.rad(135))

local CRS_lbl_pos_C = {CRS_lbl_pos_x - KnobLabelShift_x, CRS_lbl_pos_y - KnobLabelShift_y}
local CRS_lbl_pos_R = {CRS_lbl_pos_x, CRS_lbl_pos_y}
local CRS_lbl_pos_S = {CRS_lbl_pos_x + KnobLabelShift_x, CRS_lbl_pos_y + KnobLabelShift_y}

addStrokeText("CRS Knob label C", "C", STROKE_FNT_DFLT_LBL, "CenterCenter", CRS_lbl_pos_C)
addStrokeText("CRS Knob label R", "R", STROKE_FNT_DFLT_LBL, "CenterCenter", CRS_lbl_pos_R)
addStrokeText("CRS Knob label S", "S", STROKE_FNT_DFLT_LBL, "CenterCenter", CRS_lbl_pos_S)

-----------------------------------------------------------------------------------------------
-- Currently Selected Instrument Mode ---------------------------------------------------------
local SelectedModeLineY = -143

addStrokeText("Mode Left", "PLS", STROKE_FNT_DFLT_MODE, "LeftBottom", {-75, SelectedModeLineY}, nil, {{"EHSI_Mode", 0}}, {"", "PLS"})
addStrokeText("Mode Right", "NAV", STROKE_FNT_DFLT_MODE, "RightBottom", {75, SelectedModeLineY}, nil, {{"EHSI_Mode", 1}}, {"", "TCN", "NAV"})

-----------------------------------------------------------------------------------------------
-- Momentary New Mode Label -------------------------------------------------------------------
addStrokeText("Momentary New Mode Label", "PLS/NAV", STROKE_FNT_DFLT_MODE, "CenterBottom", {0, 17}, nil, {{"EHSI_MomentaryNewMode"}}, {"", "TCN", "PLS/TCN", "NAV", "PLS/NAV", "BRT", "ADJ HDG"})

-----------------------------------------------------------------------------------------------
-- Course Indicator ---------------------------------------------------------------------------
local CrsInd_PH = addPlaceholder("Course Indicator _plaseholder", {144, 142})
addStrokeText("Course Indicator Value", "000", STROKE_FNT_DFLT_IND, "RightTop", {0, 0}, CrsInd_PH.name, {{"EHSI_ManualCourseDigits"}})
addStrokeText("Course Indicator Label", "CRS", STROKE_FNT_DFLT_LBL, "RightTop", {0, -21}, CrsInd_PH.name)

-----------------------------------------------------------------------------------------------
-- Range Indicator ----------------------------------------------------------------------------
local RngInd_PH = addPlaceholder("Range Indicator _plaseholder", {-144, 142})

local InvalidRng_PH = addPlaceholder("InvalidRange Flag _plaseholder", {-2, -2}, RngInd_PH.name)
local InvalidRangeFlagW = 50
local InvalidRangeFlagH = 9
addMaskedBox("InvalidRange Flag", InvalidRangeFlagW, InvalidRangeFlagH, "LeftTop", {0, -1}, nil, InvalidRng_PH.name, {{"EHSI_RangeFlag"}}, "EHSI_RED")

addStrokeText("Range Indicator Value", "000", STROKE_FNT_DFLT_IND, "LeftTop", {0, 0}, RngInd_PH.name, {{"EHSI_Range", 0}})
addStrokeText("Range Indicator Label", "NM", STROKE_FNT_DFLT_LBL, "LeftTop", {0, -21}, RngInd_PH.name)

local RngIndDigit_PH = addPlaceholder("Range Indicator Digit _plaseholder", {37, 0}, RngInd_PH.name)

addBox("Range Indicator BCKGD", 14, 22, "LeftTop", {-3, 3}, RngIndDigit_PH.name, nil, "EHSI_GRAY")

setMaterialAndFont("EHSI_BLACK", "font_stroke_EHSI_BLACK")
addStrokeText("Range Indicator DIGIT", "0", STROKE_FNT_DFLT_IND, "LeftTop", {0, 0}, RngIndDigit_PH.name, {{"EHSI_Range", 1}})
setDefaultMaterialAndFont()

-----------------------------------------------------------------------------------------------
-- Warning Labels -----------------------------------------------------------------------------
local WarnLbl_PH = addPlaceholder("Warning Labels _plaseholder", {-140, 100}, nil, {{"EHSI_WarningShow"}})

for i=1,16 do
	addStrokeLine("Warning Label background"..i, 51, {-5 + i * 1.0, 3}, 180, WarnLbl_PH.name, {{"EHSI_WarningBackgroundColor"}}, false, nil, nil, "EHSI_WHITE")
end
addStrokeText("Warning Label INU", "I\nN\nU", STROKE_FNT_DFLT_LBL, "LeftTop", {0, 0}, WarnLbl_PH.name, {{"EHSI_WarningString", 1}})

setMaterialAndFont("EHSI_BLACK", "font_stroke_EHSI_BLACK")
addStrokeText("Warning Label ATT", "A\nT\nT", STROKE_FNT_DFLT_LBL, "LeftTop", {0, 0}, WarnLbl_PH.name, {{"EHSI_WarningString", 2}})
setDefaultMaterialAndFont()

-----------------------------------------------------------------------------------------------
-- Course Deviation Scale ---------------------------------------------------------------------
local CourseDeviationScale_PH = addPlaceholder("CourseDeviationScale _plaseholder", {0, 0}, CoursePointer_PH.name)

local CourseDeviationScaleNotchLen = 32
for i=1,2 do
	addCircle("CourseDeviationIndicator L"..i, 5, 0, 360, 16, {-i * CourseDeviationScaleNotchLen, 0}, CourseDeviationScale_PH.name, nil, "EHSI_WHITE")
	addCircle("CourseDeviationIndicator R"..i, 5, 0, 360, 16, { i * CourseDeviationScaleNotchLen, 0}, CourseDeviationScale_PH.name, nil, "EHSI_WHITE")
end

-----------------------------------------------------------------------------------------------
-- Course Deviation Indicator -----------------------------------------------------------------
local CourseDeviation_PH = addPlaceholder("CourseDeviation _plaseholder", {0, 0}, CoursePointer_PH.name, {{"EHSI_CDI", CourseDeviationScaleNotchLen * 2}})

CourseDeviationIndicatorRadius = CoursePointerArrowRadius - CoursePointerArrowLen - 1

-- valid indicator
local CDI_Valid_PH = addPlaceholder("CDI_Valid _plaseholder", {0, 0}, CourseDeviation_PH.name, {{"EHSI_CDI_Type", 1}})
addFatLine("CourseDeviationValidIndicator", CourseDeviationIndicatorRadius * 2, 4, {0, -CourseDeviationIndicatorRadius}, nil, CDI_Valid_PH.name, nil, "EHSI_BLUE")

-- invalid indicator
local CDI_Invalid_PH = addPlaceholder("CDI_Invalid _plaseholder", {0, 0}, CourseDeviation_PH.name, {{"EHSI_CDI_Type", 0}})
local CDI_gap = 9
addFatDashedLine("CourseDeviationInvalidIndicator Up", CourseDeviationIndicatorRadius, CDI_gap, CDI_gap, 4, {0, -CourseDeviationIndicatorRadius}, nil, CDI_Invalid_PH.name, nil, "EHSI_BLUE")
addFatDashedLine("CourseDeviationInvalidIndicator Dn", CourseDeviationIndicatorRadius, CDI_gap, CDI_gap, 4, {0,  CourseDeviationIndicatorRadius}, 180, CDI_Invalid_PH.name, nil, "EHSI_BLUE")

-- course deviation valid flag
local CDI_ValidFlag_PH = addPlaceholder("CDI_ValidFlag _plaseholder", {-13, CourseDeviationIndicatorRadius}, CoursePointer_PH.name, {{"EHSI_CDI_Valid"}})
addBox("CDI_ValidFlag", 34, 17, "RightTop", {0, 0}, CDI_ValidFlag_PH.name, nil, "EHSI_RED")

-----------------------------------------------------------------------------------------------
-- Tacan To-From Indicator --------------------------------------------------------------------
local TacanToFromArrowHeight = 14
local TacanToFromPosX = CourseDeviationScaleNotchLen * 1.5
local TacanToFromPosY = CourseDeviationIndicatorRadius - TacanToFromArrowHeight

local TacanTo_PH = addPlaceholder("TacanTo _plaseholder", {TacanToFromPosX, TacanToFromPosY}, CoursePointer_PH.name, {{"EHSI_To"}})
addTriangle("TacanTo Arrow Triangle", 21, TacanToFromArrowHeight, "CenterBottom", {0, 0}, nil, TacanTo_PH.name, nil, "EHSI_WHITE")

local TacanFrom_PH = addRotPlaceholder("TacanFrom _plaseholder", {TacanToFromPosX, -TacanToFromPosY}, 180, CoursePointer_PH.name, {{"EHSI_From"}})
addTriangle("TacanFrom Arrow Triangle", 21, TacanToFromArrowHeight, "CenterBottom", {0, 0}, nil, TacanFrom_PH.name, nil, "EHSI_WHITE")
