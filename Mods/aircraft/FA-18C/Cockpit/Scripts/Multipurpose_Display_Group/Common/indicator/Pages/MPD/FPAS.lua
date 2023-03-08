dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local FPAS_BaseName = "FPAS_PAGE_"
--addStrokeText("Placeholder_FPAS", "FPAS PAGE\nPLACEHOLDER", STROKE_FNT_DFLT_200, "CenterCenter")

--addStrokeLine(name, length, pos, rot, parent, controllers, dashed, stroke, gap, material)
--addStrokeText(name, value, stringdef, align, pos, parent, controllers, formats)
--add_PB_label(PB number, string or table of strings or tables ({"Text", parent, controller, inBox (true or false) or box controller}))

local function getTextWidth(symbol_num)
	return glyphNominalWidth120 * symbol_num + fontIntercharDflt120 * (symbol_num - 1)
end

local function addUnderlinedText(name, text, pos)
	local length = getTextWidth(string.len(text)) + fontIntercharDflt120
	addStrokeText(FPAS_BaseName..name..text.."_TXT", text, STROKE_FNT_DFLT_120, "CenterBottom", pos)
	pos[1] = pos[1] - length * 0.5
	pos[2] = pos[2] - fontInterlineDflt120
	addStrokeLine(FPAS_BaseName..name..text.."_LINE", length, pos, -90)
end

local lineCurrentY = 413
local lineCurrentTableColumnNamesY = 364
local lineCurTblLine1Y = 316
local lineCurTblLine2Y = 220
local lineCurTblLine3Y = 171
local FFArea_NamesY = 111
local FFArea_ValueY = FFArea_NamesY - 50

local CurTblCol1X = 36
local CurTblCol2X = 358

addUnderlinedText("CURRENT", "CURRENT", {0, lineCurrentY})

addUnderlinedText("CURRENT", "RANGE",		{ 10,	lineCurrentTableColumnNamesY})
addUnderlinedText("CURRENT", "ENDURANCE",	{328,	lineCurrentTableColumnNamesY})

addStrokeText(FPAS_BaseName.."CURRENT_LINE_1_NAME_TXT", "TO       LB",	STROKE_FNT_DFLT_120, "LeftBottom", {-425, lineCurTblLine1Y})
addStrokeText(FPAS_BaseName.."CURRENT_LINE_2_NAME_TXT", "BEST MACH",	STROKE_FNT_DFLT_120, "LeftBottom", {-428, lineCurTblLine2Y})
addStrokeText(FPAS_BaseName.."CURRENT_LINE_3_NAME_TXT", "TO       LB",	STROKE_FNT_DFLT_120, "LeftBottom", {-412, lineCurTblLine3Y})

addStrokeText(FPAS_BaseName.."CURRENT_LINE_1_NAME_TARGET_FUEL_REMAIN_TXT", "2000", STROKE_FNT_DFLT_120, "RightBottom", {-425 + getTextWidth(8), lineCurTblLine1Y}, nil, {{"MPD_FPAS_TargetFuelRemaining"}})
addStrokeText(FPAS_BaseName.."CURRENT_LINE_3_NAME_TARGET_FUEL_REMAIN_TXT", "2000", STROKE_FNT_DFLT_120, "RightBottom", {-412 + getTextWidth(8), lineCurTblLine3Y}, nil, {{"MPD_FPAS_TargetFuelRemaining"}})

addStrokeText(FPAS_BaseName.."CURRENT_TABLE_11_TXT", "XXX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol1X, lineCurTblLine1Y}, nil, {{"MPD_FPAS_CurrentRange"}})
addStrokeText(FPAS_BaseName.."CURRENT_TABLE_12_TXT", ".XX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol1X, lineCurTblLine2Y}, nil, {{"MPD_FPAS_CurrentRangeArea"}, {"MPD_FPAS_CurrentRangeBestMach"}})
addStrokeText(FPAS_BaseName.."CURRENT_TABLE_13_TXT", "XXX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol1X, lineCurTblLine3Y}, nil, {{"MPD_FPAS_CurrentRangeArea"}, {"MPD_FPAS_CurrentBestRange"}})
addStrokeText(FPAS_BaseName.."CURRENT_TABLE_21_TXT", ":XX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol2X, lineCurTblLine1Y}, nil, {{"MPD_FPAS_CurrentEndurance"}})
addStrokeText(FPAS_BaseName.."CURRENT_TABLE_22_TXT", ".XX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol2X, lineCurTblLine2Y}, nil, {{"MPD_FPAS_CurrentEnduranceArea"}, {"MPD_FPAS_CurrentEnduranceBestMach"}})
addStrokeText(FPAS_BaseName.."CURRENT_TABLE_23_TXT", ":XX", STROKE_FNT_DFLT_120, "RightBottom", {CurTblCol2X, lineCurTblLine3Y}, nil, {{"MPD_FPAS_CurrentEnduranceArea"}, {"MPD_FPAS_CurrentBestEndurance"}})


addUnderlinedText("CURRENT", "NAV TO",		{-333, FFArea_NamesY})
addUnderlinedText("CURRENT", "TIME",		{-108, FFArea_NamesY})
addUnderlinedText("CURRENT", "FUEL REMAIN",	{ 132, FFArea_NamesY})
addUnderlinedText("CURRENT", "LB/NM",		{ 403, FFArea_NamesY})

addStrokeText(FPAS_BaseName.."CURRENT_STEERING_1_TXT",	"WYPT XX",	STROKE_FNT_DFLT_120, "RightBottom", {-321 + getTextWidth(3), FFArea_ValueY}, nil, {{"MPD_FPAS_Steering"}, {"MPD_FPAS_SteeringName"}})
addStrokeText(FPAS_BaseName.."CURRENT_STEERING_2_TXT",	":XX:XX",	STROKE_FNT_DFLT_120, "RightBottom", {-108 + getTextWidth(3), FFArea_ValueY}, nil, {{"MPD_FPAS_Steering"}, {"MPD_FPAS_SteeringArrivalTime"}})
addStrokeText(FPAS_BaseName.."CURRENT_STEERING_3_TXT",	"XXXX",		STROKE_FNT_DFLT_120, "RightBottom", { 132 + getTextWidth(2), FFArea_ValueY}, nil, {{"MPD_FPAS_SteeringFuelRemainingValid"}, {"MPD_FPAS_SteeringFuelRemaining"}})
addStrokeText(FPAS_BaseName.."CURRENT_FF_TXT",			"XX",		STROKE_FNT_DFLT_120, "RightBottom", { 403 + getTextWidth(1), FFArea_ValueY}, nil, {{"MPD_FPAS_FuelFlowRateValidity"}, {"MPD_FPAS_FuelFlowRate"}})



addStrokeLine(FPAS_BaseName.."DEVIDER_LINE", 1024, {-512, 22}, -90)

local lineOptimumY = -51
local lineOptimumTableColumnNamesY = -93
local lineOptTblLine1Y = -139
local lineOptTblLine2Y = -189
local lineOptTblLine3Y = -241
local lineDefaultY = -314

local OptTblColNamesX = -434
local OptTblCol1X = 54
local OptTblCol2X = 386

addUnderlinedText("OPTIMUM", "OPTIMUM", {0, lineOptimumY})

addUnderlinedText("OPTIMUM", "RANGE",		{ 10,	lineOptimumTableColumnNamesY})
addUnderlinedText("OPTIMUM", "ENDURANCE",	{333,	lineOptimumTableColumnNamesY})

addStrokeText(FPAS_BaseName.."OPTIMUM_LINE_1_NAME_TXT", "ALTITUDE",		STROKE_FNT_DFLT_120, "LeftBottom", {OptTblColNamesX, lineOptTblLine1Y})
addStrokeText(FPAS_BaseName.."OPTIMUM_LINE_2_NAME_TXT", "MACH",			STROKE_FNT_DFLT_120, "LeftBottom", {OptTblColNamesX, lineOptTblLine2Y})
addStrokeText(FPAS_BaseName.."OPTIMUM_LINE_3_NAME_TXT", "TO       LB",	STROKE_FNT_DFLT_120, "LeftBottom", {OptTblColNamesX, lineOptTblLine3Y})

addStrokeText(FPAS_BaseName.."OPTIMUM_LINE_3_NAME_TARGET_FUEL_REMAIN_TXT", "2000", STROKE_FNT_DFLT_120, "RightBottom", {OptTblColNamesX + getTextWidth(8), lineOptTblLine3Y}, nil, {{"MPD_FPAS_TargetFuelRemaining"}})

addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_11_TXT", "XXXXX",	STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol1X, lineOptTblLine1Y}, nil, {{"MPD_FPAS_OptimumRangeArea"}, {"MPD_FPAS_OptimumRangeAltitude"}})
addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_12_TXT", ".XX",		STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol1X, lineOptTblLine2Y}, nil, {{"MPD_FPAS_OptimumRangeArea"}, {"MPD_FPAS_OptimumRangeMach"}})
addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_13_TXT", "XXX",		STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol1X, lineOptTblLine3Y}, nil, {{"MPD_FPAS_OptimumRangeArea"}, {"MPD_FPAS_OptimumRangeMax"}})
addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_21_TXT", "XXXXX",	STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol2X, lineOptTblLine1Y}, nil, {{"MPD_FPAS_OptimumEnduranceArea"}, {"MPD_FPAS_OptimumEnduranceAltitude"}})
addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_22_TXT", ".XX",		STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol2X, lineOptTblLine2Y}, nil, {{"MPD_FPAS_OptimumEnduranceArea"}, {"MPD_FPAS_OptimumEnduranceMach"}})
addStrokeText(FPAS_BaseName.."OPTIMUM_TABLE_23_TXT", "X:XX",	STROKE_FNT_DFLT_120, "RightBottom", {OptTblCol2X, lineOptTblLine3Y}, nil, {{"MPD_FPAS_OptimumEnduranceArea"}, {"MPD_FPAS_OptimumEnduranceMax"}})

addStrokeText(FPAS_BaseName.."INVALID_TXT",			"DEFAULT:",		STROKE_FNT_DFLT_120, "LeftBottom", {OptTblColNamesX, lineDefaultY})
addStrokeText(FPAS_BaseName.."INVALID_LIST_TXT",	"TEMP DRAG FF",	STROKE_FNT_DFLT_120, "LeftBottom", {OptTblColNamesX + getTextWidth(9), lineDefaultY}, nil, {{"MPD_FPAS_Default"}})


add_PB_label(20, 	{"CLIMB", 	nil, {{"MPD_FPAS_CLIMB_Label"}}, {{"MPD_FPAS_CLIMB_Box"}}})

addStrokeText(FPAS_BaseName.."HOME_TXT", "HOME", STROKE_FNT_DFLT_120, "CenterBottom", {255, -500})
addStrokeText(FPAS_BaseName.."HOME_VALUE", "0", STROKE_FNT_DFLT_120, "RightBottom", {272, -455}, nil, {{"MPD_FPAS_HomeWypt"}})
add_X_Over(FPAS_BaseName.."HOME_VALUE_X", 64, 30, {255, -442}, nil, {{"MPD_FPAS_HomeWypt_X"}})
add_PB_symbol(16, "075-arrow-up", nil, {{"MPD_FPAS_CanCalculateHomeFuelCaution"}})
add_PB_symbol(17, "075-arrow-down", nil, {{"MPD_FPAS_CanCalculateHomeFuelCaution"}})