dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

add_PB_symbol(1, "075-arrow-down")
add_PB_symbol(2, "075-arrow-up")
add_PB_label(2, {"     DLY"})
add_PB_symbol(3, "075-arrow-down")
add_PB_symbol(4, "075-arrow-up")
add_PB_label(4, {"     ARM"})

add_PB_label(18, {"MENU"})
add_PB_label(19, {"RETURN"})


addStrokeText("JPF_Caption", "JPF", STROKE_FNT_DFLT_100, "CenterCenter", {0, 430})
addStrokeText("MISSION_Lbl", "MISSION:", STROKE_FNT_DFLT_100, "RightCenter", {50, 400})
addStrokeText("MISSION_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {55, 400}, nil, {{"MPD_MISSION_TYPE_NUM"}})

addStrokeText("Station_JDAM", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 327})
addStrokeText("CurrStation_JDAM", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station_JDAM", {{"MPD_SMS_Curr_Station_Num"}})

addStrokeText("Miss_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 297}, nil, {{"MPD_MISSION_TYPE_NUM"}})

addStrokeText("JDAM_Type", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, 267}, nil, {{"MPD_SMS_JDAM_TYPE"}})

addStrokeText("JPF_Lbl", "JPF", STROKE_FNT_DFLT_100, "LeftCenter", {-280, -240})
addStrokeText("JPF_ARM", "ARM", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -240}, nil, {{"MPD_MIS_DATA_JPF_ARM", 0}})
addStrokeText("JPF_DLY", "DLY", STROKE_FNT_DFLT_100, "LeftCenter", {-100, -270}, nil, {{"MPD_MIS_DATA_JPF_DLY", 0}})

local ARM_lbl = {
"5.5 SEC",
"7 SEC",
"10 SEC",
"14 SEC",
}
addStrokeText("JPF_ARM_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -240}, nil, {{"MPD_MIS_DATA_JPF_ARM", 1}}, ARM_lbl)

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
addStrokeText("JPF_DLY_Val", nil, STROKE_FNT_DFLT_100, "RightCenter", {150, -270}, nil, {{"MPD_MIS_DATA_JPF_DLY", 1}}, DLY_lbl)


