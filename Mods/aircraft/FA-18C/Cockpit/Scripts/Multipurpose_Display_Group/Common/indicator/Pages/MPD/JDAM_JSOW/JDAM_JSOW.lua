dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

add_PB_label(2, {"ERASE", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 1}}} , {"JDAM", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_SMS_IAM_TYPE", 0}}})
add_PB_label(2, "", {"JSOW", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_SMS_IAM_TYPE", 1}}})
add_PB_label(3, {"REL", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}} , {"TYPE", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}})
add_PB_label(4, {"MSN",  nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}})
add_PB_label(5, {"MODE", nil, 	{{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}}, {"PP", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}})
add_PB_label(5, "", {"TOO", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 1}}})

add_PB_label(1, {"ACPT",  nil,  {{"MPD_SMS_JDAM_1_5PBLabels", 3, 0}}})
add_PB_label(2, {"CNX",  nil,  {{"MPD_SMS_JDAM_1_5PBLabels", 3, 0}}})

add_PB_label(2, {"FD", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 5, 0}}})
add_PB_label(3, {"AUTO", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 5, 0}}} , {"LOFT", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 5, 0}}})
add_PB_label(4, {"MAN",  nil, {{"MPD_SMS_JDAM_1_5PBLabels", 5, 0}}})

add_PB_label(1, {"15", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 6, 0}}})
add_PB_label(2, {"30", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 6, 0}}})
add_PB_label(3, {"45",  nil, {{"MPD_SMS_JDAM_1_5PBLabels", 6, 0}}})


add_PB_label(6, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 0, 0}}, {{"MPD_SMS_6_10PBLabels", 0, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 0}}})
add_PB_label(7, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 1, 0}}, {{"MPD_SMS_6_10PBLabels", 1, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 1}}})
add_PB_label(8, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 2, 0}}, {{"MPD_SMS_6_10PBLabels", 2, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 2}}})
add_PB_label(9, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 3, 0}}, {{"MPD_SMS_6_10PBLabels", 3, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 3}}})
add_PB_label(10, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 4, 0}}, {{"MPD_SMS_6_10PBLabels", 4, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 4}}})

add_PB_label(11, {"DKLTR", nil, {{"MPD_SMS_JDAM_11_15PBLabels", 0, 0}}, {{"MPD_SMS_JDAM_11_15PBLabels", 0, 0}, {"MPD_SMS_JDAM_DKLTR_HSI"}}} , {"HSI", nil, {{"MPD_SMS_JDAM_11_15PBLabels", 0, 0}}})
add_PB_label(13, {"STEP", nil, {{"MPD_SMS_JDAM_11_15PBLabels", 0, 0}, {"MPD_SMS_STEP_Label"}}})
add_PB_label(15, {"QTY", nil, {{"MPD_SMS_JDAM_11_15PBLabels", 0, 0}}, {{"MPD_SMS_QTY_BOX"}}})


add_PB_label(11, {"STA2", nil, {{"MPD_SMS_JDAM_QTY_MENU", 1, 0}}, {{"MPD_SMS_JDAM_QTY_MENU", 1, 1}}})
add_PB_label(12, {"STA3", nil, {{"MPD_SMS_JDAM_QTY_MENU", 2, 0}}, {{"MPD_SMS_JDAM_QTY_MENU", 2, 1}}})
add_PB_label(13, {"STA7", nil, {{"MPD_SMS_JDAM_QTY_MENU", 6, 0}}, {{"MPD_SMS_JDAM_QTY_MENU", 6, 1}}})
add_PB_label(14, {"STA8", nil, {{"MPD_SMS_JDAM_QTY_MENU", 7, 0}}, {{"MPD_SMS_JDAM_QTY_MENU", 7, 1}}})
add_PB_label(15, {"RTN", nil, {{"MPD_SMS_JDAM_QTY_MENU", 0, 0}}})

add_PB_label(18, {"MENU"})
add_PB_label(19, {"TM"})

addStrokeText("Station_JDAM", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 327})
addStrokeText("CurrStation_JDAM", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station_JDAM", {{"MPD_SMS_Curr_Station_Num"}})

addStrokeText("Station_RDY", "RDY", STROKE_FNT_DFLT_100, "LeftCenter", {-290, 327}, nil, {{"MPD_SMS_AG_RDY_Label", 0}})

addStrokeText("TimingJDAMpage", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, nil, {{"MPD_SMS_JDAM_Timing"}}, {"TIMING %d:%.2d"})

addStrokeText("Miss_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 297}, nil, {{"MPD_MISSION_TYPE_NUM"}})

addStrokeText("JDAM_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 267}, nil, {{"MPD_SMS_JDAM_TYPE"}})

addStrokeText("TOT_PP_JDAM_page", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-290, 267}, nil, {{"MPD_SMS_JDAM_TOT_PP", 0}}, {"TOT-PP %.2d:%.2d:%.2d", "TOT-PP"})
add_X_Over("AG_TOT_PP_X", 70, 26, {40, 0}, "TOT_PP_JDAM_page", {{"MPD_SMS_JDAM_TOT_PP", 1}})

local IN_RNG_ZONE = 
{
	"%.2d TMR",
	"IN RNG",
	"IN ZONE",
}

addStrokeText("JDAMInRng_page", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"HUD_AG_JDAM_IN_RNG", 99}}, IN_RNG_ZONE)

addStrokeText("JDAMPreLaunchTOF", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 327}, nil, {{"MPD_SMS_JDAM_TOF", 1}})
addStrokeText("JDAMPostLaunchTOF", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 297}, nil, {{"MPD_SMS_JDAM_TOF", 2}})

addStrokeText("JDAMDiffTOF", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 267}, nil, {{"MPD_SMS_JDAM_TOF", 3}})
addStrokeLine("JDAMFltLine_page", 70, {-65, 17}, -90, "JDAMDiffTOF")

addStrokeText("JDAMFlt_page", "FLT", STROKE_FNT_DFLT_100, "RightCenter", {290, 297}, nil, {{"MPD_SMS_JDAM_TOF", 0}})

addStrokeText("TOF_JDAM", nil, STROKE_FNT_DFLT_100, "RightCenter", {0, 130}, nil, {{"MPD_SMS_JDAM_TOF", 4}}, {"TOF %.2d:%.2d"})

local ALGN_QUAL1 = 
{
	"01 GOOD",
	"02 GOOD",
	"03 GOOD",
	"04 MARG",
	"05 MARG",
	"06 MARG",
	"07 UNST",
	"08 UNST",
	"09 UNST",
	"10 UNST",
}
addStrokeText("ALGN_QUAL_JDAM", "ALN QUAL", STROKE_FNT_DFLT_100, "RightCenter", {-10, 100}, nil, {{"ALGN_QUAL", 0}})
addStrokeText("ALGN_QUAL_JDAM_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, 100}, nil, {{"ALGN_QUAL", 1}}, ALGN_QUAL1)

addStrokeText("ON_TIME_JDAM", "ON TIME ", STROKE_FNT_DFLT_100, "RightCenter", {-10, 70}, nil)
addStrokeText("ON_TIME_JDAM_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, 70}, nil, {{"MPD_SMS_JDAM_ON_TIME"}}, {"%d:%.2d:%.2d"})


local REL_MODE = 
{
	"LOFT",
	"  FD",
	"    ",
	" MAN",
}

local LOFT_DEG = 
{
	"15",
	"30",
	"45",
}

addStrokeText("RELEASE", "RELEASE ", STROKE_FNT_DFLT_100, "RightCenter", {-10, -20}, nil)
addStrokeText("MODE", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, -20}, nil, {{"JDAM_REL_MODE"}}, REL_MODE)
addStrokeText("LOFT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {85, -20}, nil, {{"JDAM_LOFT_DEG"}}, LOFT_DEG)

addStrokeText("QTY", "QTY", STROKE_FNT_DFLT_100, "LeftCenter", {150, -20}, nil)
addStrokeText("QTY_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {210, -20}, nil, {{"JDAM_QTY"}})
