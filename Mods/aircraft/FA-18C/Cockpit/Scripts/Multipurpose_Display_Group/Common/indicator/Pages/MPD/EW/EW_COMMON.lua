dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

--------------------------- Countermeasures Counters -----------------------------
addStrokeText("EW_Chaff_Counter", "", STROKE_FNT_DFLT_120, "CenterCenter", {-390, 400}, nil, {{"MPD_EW_CmCounter", 0}}, {"C\n%3d"})
addStrokeBox("EW_Chaff_Counter_box", 64, 30, "CenterTop", {0,0}, "EW_Chaff_Counter", {{"MPD_EW_CmCounterBox", 0}})
addStrokeText("EW_Flare_Counter", "", STROKE_FNT_DFLT_120, "CenterCenter", {-320, 400}, nil, {{"MPD_EW_CmCounter", 1}}, {"F\n%3d"})
addStrokeBox("EW_Flare_Counter_box", 64, 30, "CenterTop", {0,0}, "EW_Flare_Counter", {{"MPD_EW_CmCounterBox", 1}})

addStrokeText("EW_O1_Counter", "", STROKE_FNT_DFLT_120, "CenterCenter", {390, 400}, nil, {{"MPD_EW_CmCounter", 2}}, {"O1\n%3d"})
addStrokeBox("EW_O1_Counter_box", 64, 30, "CenterTop", {0,0}, "EW_Chaff_Counter", {{"MPD_EW_CmCounterBox", 2}})
addStrokeText("EW_O2_Counter", "", STROKE_FNT_DFLT_120, "CenterCenter", {320, 400}, nil, {{"MPD_EW_CmCounter", 3}}, {"O2\n%3d"})
addStrokeBox("EW_O2_Counter_box", 64, 30, "CenterTop", {0,0}, "EW_Chaff_Counter", {{"MPD_EW_CmCounterBox", 3}})

-------------------------------------- Menu --------------------------------------
local aspjModeLabel = add_PB_label(6, {"", nil, {{"MPD_EW_ASPJ_MODE_label"}}})[1]
aspjModeLabel.formats = {"ASPJ\nOFF",
						 "ASPJ\nSTBY",
						 "ASPJ\nBIT",
						 "ASPJ\nREC",
						 "ASPJ\nXMIT"}

local alr67ModeLabel = add_PB_label(7, {"", nil, {{"MPD_EW_ALR67_MODE_label"}}})[1]
alr67ModeLabel.formats = {"ALR-67\nOFF",
						  "ALR-67\nRCV",
						  "ALR-67"}

local ale47ModeLabel = add_PB_label(8, {"ALE-47", nil, {{"MPD_EW_ALE47_MODE_label", 0}}, {{"MPD_EW_ALE47_MODE_label", 1}}})[1]
ale47ModeLabel.formats = {"ALE-47\nOFF",
						  "ALE-47\nSF TEST",
						  "ALE-47\nPBIT GO",
						  "ALE-47",
						  "ALE-47\nSTBY",
						  "ALE-47\nS/A %d",
						  "ALE-47\nAUTO %d",
						  "ALE-47\nMAN %d"}
add_X_Over("EW_ALE47_MODE_label_cross", 154, 60, {0, -30}, ale47ModeLabel.name, {{"MPD_EW_ALE47_MODE_label", 2}})
addStrokeLine("EW_ALE47_MODE_label_dash", 154, {77, -12}, 90, ale47ModeLabel.name, {{"MPD_EW_ALE47_MODE_label", 3}})

add_Harm_Ovrd_PB16()

add_PB_label(20, {"STEP", nil, {{"MPD_EW_STEP_label"}}})
