dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

add_PB_label(1, {"JPF", nil, 	{{"MPD_MIS_DATA_1_5PBLabels"}, {"MPD_MIS_DATA_JPF"}}})
add_PB_label(2, {"HDG", nil, {{"MPD_MIS_DATA_1_5PBLabels"}}, {{"MPD_MIS_DATA_HDG_UNDF"}}} , {"UNDF", nil, {{"MPD_MIS_DATA_1_5PBLabels"}}})

add_PB_label(5, {"MODE", nil, 	{{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}}, {"PP", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}})
add_PB_label(5, "", {"TOO", nil, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 1}}})

local pp1 = add_PB_label(6, {"     ", nil, {{"MPD_MIS_DATA_6_11PBLabels", 0, 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 0, 1}}})[1]
local pp2 = add_PB_label(7, {"     ", nil, {{"MPD_MIS_DATA_6_11PBLabels", 1, 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 1, 1}}})[1]
local pp3 = add_PB_label(8, {"     ", nil, {{"MPD_MIS_DATA_6_11PBLabels", 2, 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 2, 1}}})[1]
local pp4 = add_PB_label(9, {"     ", nil, {{"MPD_MIS_DATA_6_11PBLabels", 3, 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 3, 1}}})[1]
local pp5 = add_PB_label(10, {"     ", nil, {{"MPD_MIS_DATA_6_11PBLabels", 4, 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 4, 1}}})[1]
local pp6 = add_PB_label(11, {"PP6", nil, {{"MPD_JDAM_MODE", 0}}, {{"MPD_MIS_DATA_6_11PBLabels", 5, 1}}})[1]

local X_sizeX = 140
local X_sizeY = 36
local X_offsetY = -12 
add_X_Over("PP_1_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pp1.name, {{"MPD_MIS_DATA_PP_X_Breaker", 0}})
add_X_Over("PP_2_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pp2.name, {{"MPD_MIS_DATA_PP_X_Breaker", 1}})
add_X_Over("PP_3_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pp3.name, {{"MPD_MIS_DATA_PP_X_Breaker", 2}})
add_X_Over("PP_4_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pp4.name, {{"MPD_MIS_DATA_PP_X_Breaker", 3}})
add_X_Over("PP_5_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pp5.name, {{"MPD_MIS_DATA_PP_X_Breaker", 4}})
add_X_Over("PP_6_Break_X", X_sizeY, X_sizeX, {X_offsetY/2, 0}, pp6.name, {{"MPD_MIS_DATA_PP_X_Breaker", 5}})

add_PB_label(12, {"UFC", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}, {{"MPD_MIS_DATA_UFC_SELECTED", 3}}} , {"LP", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}})

add_PB_label(13, {"STEP", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}, {"MPD_SMS_STEP_Label"}}})

add_PB_label(14, {"UFC", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}}, {{"MPD_MIS_DATA_UFC_SELECTED", 1}}} , {"TOO", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}, {"MPD_JDAM_MODE", 1}}})
add_PB_label(14, "", {"TGT", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}})
add_PB_label(15, {"UFC", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}}, {{"MPD_MIS_DATA_UFC_SELECTED", 2}}} , {"O/S", nil, {{"MPD_MIS_DATA_12_15PBLabels", 0, 0}}})

add_PB_label(18, {"MENU"})
add_PB_label(19, {"RETURN"})

addStrokeText("MISSION_Lbl", "MISSION:", STROKE_FNT_DFLT_100, "RightCenter", {50, 400})
addStrokeText("MISSION_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {55, 400}, nil, {{"MPD_MISSION_TYPE_NUM"}})

addStrokeText("Station_JDAM", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 327})
addStrokeText("CurrStation_JDAM", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station_JDAM", {{"MPD_SMS_Curr_Station_Num"}})

addStrokeText("Miss_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 297}, nil, {{"MPD_MISSION_TYPE_NUM"}})

addStrokeText("JDAM_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 267}, nil, {{"MPD_SMS_JDAM_TYPE"}})


addStrokeText("OS_Tgt_Lbl", "O/S TARGET", STROKE_FNT_DFLT_100, "CenterCenter", {0, 60}, nil, {{"MPD_JDAM_MODE", 1}})

addStrokeText("TGT_Lbl", "TGT", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 0}, nil, {{"MPD_JDAM_MODE", 0}})
addStrokeText("ORP_Lbl", "ORP", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 0}, nil, {{"MPD_JDAM_MODE", 1}})

local LAT_lbl = {
"N",
"S",
}

local LONG_lbl = {
"E",
"W",
}

addStrokeText("LAUNCH_PT", "LAUNCH POINT", STROKE_FNT_DFLT_100, "LeftCenter", {-100, 327}, nil, {{"MPD_JDAM_MODE", 0}})
addStrokeText("LP_LAT_N_S", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-100, 280}, nil, {{"MPD_MIS_DATA_LAT", 0, 1}}, LAT_lbl)
addStrokeText("LP_LAT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-70, 280}, nil, {{"MPD_MIS_DATA_LAT", 1, 1}}, {"%d° %.2d' %2.2f\""})

addStrokeText("LP_LONG_W_E", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-100, 250}, nil, {{"MPD_MIS_DATA_LONG", 0, 1}}, LONG_lbl)
addStrokeText("LP_LONG_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-70, 250}, nil, {{"MPD_MIS_DATA_LONG", 1, 1}}, {"%d° %.2d' %2.2f\""})

addStrokeText("LP_ALT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-100, 220}, nil, {{"MPD_MIS_DATA_LP_ALT"}})


addStrokeText("LAT_N_S", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -30}, nil, {{"MPD_MIS_DATA_LAT", 0, 0}}, LAT_lbl)
addStrokeText("LAT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-350, -30}, nil, {{"MPD_MIS_DATA_LAT", 1, 0}}, {"%d° %.2d' %2.2f\""})

addStrokeText("LONG_W_E", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -60}, nil, {{"MPD_MIS_DATA_LONG", 0, 0}}, LONG_lbl)
addStrokeText("LONG_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-350, -60}, nil, {{"MPD_MIS_DATA_LONG", 1, 0}}, {"%d° %.2d' %2.2f\""})

addStrokeText("ELEV_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -90}, nil, {{"MPD_MIS_DATA_ELEV"}})

addStrokeText("OS_Lbl", "O/S", STROKE_FNT_DFLT_100, "CenterCenter", {50, 0})


addStrokeText("TERM_Lbl", "TERM", STROKE_FNT_DFLT_100, "LeftCenter", {-280, -150})
addStrokeText("TERM_HDG", "HDG", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -150}, nil, {{"MPD_MIS_DATA_TERM_HDG", 0}})
addStrokeText("TERM_ANG", "ANG", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -180}, nil, {{"MPD_MIS_DATA_TERM_ANG", 0}})
addStrokeText("TERM_HT", "HT", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -180}, nil, {{"MPD_MIS_DATA_TERM_HT", 0}})
addStrokeText("TERM_VEL", "VEL", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -210}, nil, {{"MPD_MIS_DATA_TERM_VEL", 0}})
addStrokeText("TERM_HDG_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -150}, nil, {{"MPD_MIS_DATA_TERM_HDG", 1}}, {"%d° T"})
addStrokeText("TERM_ANG_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -180}, nil, {{"MPD_MIS_DATA_TERM_ANG", 1}}, {"%d°"})
addStrokeText("TERM_HT_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -180}, nil, {{"MPD_MIS_DATA_TERM_HT", 1}}, {"%d FT"})
addStrokeText("TERM_VEL_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -210}, nil, {{"MPD_MIS_DATA_TERM_VEL", 1}}, {"%d FT/SEC"})

addStrokeText("JPF_Lbl", "JPF", STROKE_FNT_DFLT_100, "LeftCenter", {-280, -240}, nil, {{"MPD_MIS_DATA_JPF"}})
addStrokeText("JPF_ARM", "ARM", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -240}, nil, {{"MPD_MIS_DATA_JPF"}, {"MPD_MIS_DATA_JPF_ARM", 0}})
addStrokeText("JPF_DLY", "DLY", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -270}, nil, {{"MPD_MIS_DATA_JPF"}, {"MPD_MIS_DATA_JPF_DLY", 0}})

local ARM_lbl = {
"5.5 SEC",
"7 SEC",
"10 SEC",
"14 SEC",
}
addStrokeText("JPF_ARM_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -240}, nil, {{"MPD_MIS_DATA_JPF"}, {"MPD_MIS_DATA_JPF_ARM", 1}}, ARM_lbl)


local DLY_lbl = {
"INST",
"5 MS",
"15 MS",
"25 MS",
"35 MS",
"45 MS",
"60 MS",
"90 MS",
"180 MS",
"5 MIN",
"30 MIN",
"45 MIN",
"1 HR",
"4 HR",
"8 HR",
"16 HR",
"20 HR",
"24 HR",
}
addStrokeText("JPF_DLY_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -270}, nil, {{"MPD_MIS_DATA_JPF"}, {"MPD_MIS_DATA_JPF_DLY", 1}}, DLY_lbl)


