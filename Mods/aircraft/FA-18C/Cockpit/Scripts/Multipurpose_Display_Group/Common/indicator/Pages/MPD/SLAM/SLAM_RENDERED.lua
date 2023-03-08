dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/SLAM/SLAM_tools.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

step = 15
AddRender()


add_PB_label(2, {"ERASE", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 1}}})
add_PB_label(3, {"REL", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}} , {"TYPE", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}})
add_PB_label(4, {"MSN",  nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}})
add_PB_label(5, {"MODE", nil, 	{{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}}, {"PP", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}, {"MPD_SLAM_MODE", 0}}})
add_PB_label(5, "", {"TOO", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}, {"MPD_SLAM_MODE", 1}}})

add_PB_label(1, {"ACPT",  nil,  {{"MPD_SMS_SLAM_1_5PBLabels", 1, 0}}})
add_PB_label(2, {"CNX",  nil,  {{"MPD_SMS_SLAM_1_5PBLabels", 1, 0}}})

add_PB_label(2, {"FD", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 3, 0}}})
add_PB_label(3, {"AUTO", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 3, 0}}} , {"LOFT", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 3, 0}}})
add_PB_label(4, {"MAN",  nil, {{"MPD_SMS_SLAM_1_5PBLabels", 3, 0}}})

add_PB_label(1, {"15", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 4, 0}}})
add_PB_label(2, {"30", nil, {{"MPD_SMS_SLAM_1_5PBLabels", 4, 0}}})
add_PB_label(3, {"45",  nil, {{"MPD_SMS_SLAM_1_5PBLabels", 4, 0}}})

add_PB_label(6, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 0}}})
add_PB_label(7, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 1}}})
add_PB_label(8, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 2}}})
add_PB_label(9, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 3}}})
add_PB_label(10, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 4}}})

add_PB_label(6, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 0, 0}}, {{"MPD_SMS_6_10PBLabels", 0, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 0}}})
add_PB_label(7, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 1, 0}}, {{"MPD_SMS_6_10PBLabels", 1, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 1}}})
add_PB_label(8, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 2, 0}}, {{"MPD_SMS_6_10PBLabels", 2, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 2}}})
add_PB_label(9, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 3, 0}}, {{"MPD_SMS_6_10PBLabels", 3, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 3}}})
add_PB_label(10, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 4, 0}}, {{"MPD_SMS_6_10PBLabels", 4, 1}}}, "", {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 4}}})

add_X_Over("BP_6_Break_X", 	154, 36, {-336, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 0}})
add_X_Over("BP_7_Break_X", 	154, 36, {-167, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 1}})
add_X_Over("BP_8_Break_X", 	154, 36, {2, 488}, 		nil, {{"MPD_SMS_AG_X_Breaker", 2}})
add_X_Over("BP_9_Break_X", 	154, 36, {171, 488},	nil, {{"MPD_SMS_AG_X_Breaker", 3}})
add_X_Over("BP_10_Break_X", 154, 36, {340, 488}, 	nil, {{"MPD_SMS_AG_X_Breaker", 4}})

add_PB_label(11, {"DKLTR", nil, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}}, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}, {"MPD_SMS_SLAM_DKLTR_HSI"}}} , {"HSI", nil, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}}})
add_PB_label(13, {"STEP", nil, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}, {"MPD_SMS_STEP_Label"}}})
add_PB_label(14, {"UFC", nil, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}}, {{"MPD_SMS_SLAM_11_15PBLabels", 0, 0}, {"MPD_SMS_UFC_Label", 1, 5}}})

add_PB_label(18, {"MENU"})
add_PB_label(19, {"TM"})

add_Harm_Ovrd_PB16()
--add_PB_label(17, {"LST"})
add_PB_label(18, {"MENU"})
--add_PB_label(20, {"CCM"})

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

addStrokeText("Station", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 385})
addStrokeText("CurrStation", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station", {{"MPD_SMS_Curr_Station_Num"}})

addStrokeText("TimingSLAM", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, nil, {{"MPD_SMS_SLAM_Timing"}}, {"TIMING %d:%.2d"})
addStrokeText("Miss_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 297}, nil, {{"MPD_MISSION_TYPE_NUM"}})
addStrokeText("SLAM_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 267}, nil, {{"MPD_SMS_JDAM_TYPE"}})

-- Designated waypoint marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", {400, 450}, nil, {{"TDC_assignedDisplay"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name)

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
addStrokeText("ALGN_QUAL_SLAM", "ALN QUAL", STROKE_FNT_DFLT_100, "RightCenter", {-10, 100}, nil, {{"MPD_SLAM_ALGN_QUAL", 0}})
addStrokeText("ALGN_QUAL_SLAM_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, 100}, nil, {{"MPD_SLAM_ALGN_QUAL", 1}}, ALGN_QUAL1)

addStrokeText("ON_TIME_SLAM", "ON TIME ", STROKE_FNT_DFLT_100, "RightCenter", {-10, 70}, nil)
addStrokeText("ON_TIME_SLAM_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, 70}, nil, {{"MPD_SMS_SLAM_ON_TIME"}}, {"%d:%.2d:%.2d"})


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
addStrokeText("MODE", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, -20}, nil, {{"MPD_SMS_SLAM_REL_MODE"}}, REL_MODE)
addStrokeText("LOFT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {85, -20}, nil, {{"MPD_SMS_SLAM_LOFT_DEG"}}, LOFT_DEG)

local IN_RNG_ZONE = 
{
	"%.2d TMR",
	"IN RNG",
	"IN ZONE",
}

addStrokeText("SLAMInRng", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"HUD_AG_SLAM_IN_RNG", 99}}, IN_RNG_ZONE)