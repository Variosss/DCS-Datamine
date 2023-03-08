dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

addStrokeText("MPD_HARM_pullup_label", "P\nU\nL\nL\nU\nP", STROKE_FNT_DFLT_120, "LeftCenter", {-450, -277})

addStrokeText("MPD_HARM_PB_InRng",		"", STROKE_FNT_DFLT_120, "RightCenter", {400, 400}, nil, {{"MPD_HARM_PB_RNG", 0}}, {"A/C RNG", "HRM RNG"})
local tofLabel = addStrokeText("MPD_HARM_PB_Tof_Label",	"FLT", STROKE_FNT_DFLT_120, "RightCenter", {250, 303}, nil, {{"MPD_HARM_PB_RNG", 1}})
addStrokeText("MPD_HARM_PB_Ttt_up",		"15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, 34}, tofLabel.name, {{"MPD_HARM_PB_RNG", 1}}, {"%2d:%02d"})
addStrokeText("MPD_HARM_PB_Ttt_dn",		"15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, 0}, tofLabel.name, {{"MPD_HARM_PB_RNG", 2}}, {"%2d:%02d"})
addStrokeText("MPD_HARM_PB_Ttt_diff", 	"-15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, -44}, tofLabel.name, {{"MPD_HARM_PB_RNG", 3}}, {"%s%2d:%02d"})
addStrokeLine("MPD_HARM_PB_Line", 130, {170, -20}, 90, tofLabel.name)

addStrokeText("MPD_HARM_PB_Target", "", STROKE_FNT_DFLT_120, "RightCenter", {350, -194}, nil, {{"MPD_HARM_PB_Target"}})
add_X_Over("MPD_HARM_PB_Target_X", 50, 25, {-25, -15}, "MPD_HARM_PB_Target", {{"MPD_HARM_PB_Target_X"}})

-------------------------------------- Menu --------------------------------------
add_PB_label(1, {"HRM", nil, nil, {{"MPD_HARM_Pullup_Box", 1}}})
add_PB_label(2, {"A/C", nil, nil, {{"MPD_HARM_Pullup_Box", 0}}})

add_PB_label(14, "UFC")
