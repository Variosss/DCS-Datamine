dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/WALLEYE/WALLEYE_tools.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

AddRender()
WallEyeEmbeddedIndication(false)

add_PB_label(4, {"DLY", nil, {}, {{"MPD_SMS_WALLEYE_FUZE", 0}}})
add_PB_label(5, {"INST", nil, {}, {{"MPD_SMS_WALLEYE_FUZE", 1}}})

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

add_PB_label(13, {"STEP", nil, {{"MPD_SMS_STEP_Label"}}})
add_PB_label(18, {"MENU"})
add_PB_label(19, {"CRAB", nil, {{"MPD_SMS_WALLEYE_CRAB"}}})

add_Harm_Ovrd_PB16()


local OffsetBetweenColumn = 130
local OffsetBetweenStr = 28

addStrokeText("Station", "STA", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 385})
addStrokeText("CurrStation", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn / 2, 0.0}, "Station", {{"MPD_SMS_Curr_Station_Num"}})

local WALLEYE_CAGE = {
"",
"CAGED",
"UNCAGED",
}

addStrokeText("CagedStatus", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 385}, nil, {{"MPD_SMS_WALLEYE_Caged"}}, WALLEYE_CAGE)
addStrokeText("InRng", "IN RNG", STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"HUD_AG_WALLEYE_IN_RNG", 0}})
addStrokeText("TTMR", "TTMR", STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, nil, {{"HUD_AG_WALLEYE_IN_RNG", 1}})
addStrokeText("TTMR_val", nil, STROKE_FNT_DFLT_100, "RightCenter", {-70, 0}, "TTMR", {{"HUD_AG_WALLEYE_IN_RNG", 2}})

-- Designated waypoint marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", {400, 450}, nil, {{"TDC_assignedDisplay"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name)

addStrokeText("WAL_HARM_SP_PB_Indication", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, 50}, nil, {{"MPD_HARM_SP_PB_Indication"}})
add_X_Over("WAL_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, "WAL_HARM_SP_PB_Indication", {{"MPD_HARM_SP_PB_Indication_X"}})