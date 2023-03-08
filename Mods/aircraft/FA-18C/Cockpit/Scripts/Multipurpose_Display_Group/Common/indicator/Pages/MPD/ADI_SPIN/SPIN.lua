dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local PosXForArrow = -400
addStrokeText("Left_Arrow_Label", "LEFT", STROKE_FNT_DFLT_150, "CenterCenter", {PosXForArrow, 0}, nil, {{"MPD_FCS_SpinStickCue", 0}})
addArrowContour("Left_Arrow", 250, 60, 50, 100, {PosXForArrow, 0}, 0, nil, {{"MPD_FCS_SpinStickCue", 0}})
addStrokeText("Right_Arrow_Label", "RIGHT", STROKE_FNT_DFLT_150, "CenterCenter", {-PosXForArrow - 20, 0}, nil, {{"MPD_FCS_SpinStickCue", 1}})
addArrowContour("Right_Arrow", 250, 60, 50, 100, {-PosXForArrow, 0}, 180, nil, {{"MPD_FCS_SpinStickCue", 1}})

local PosYStickLabel = 100
addStrokeText("Left_Stick_Label", "STICK", STROKE_FNT_DFLT_150, "CenterCenter", {PosXForArrow, PosYStickLabel}, nil, {{"MPD_FCS_SpinStickCue", 0}})
addStrokeText("Right_Stick_Label", "STICK", STROKE_FNT_DFLT_150, "CenterCenter", {-PosXForArrow - 20, PosYStickLabel}, nil, {{"MPD_FCS_SpinStickCue", 1}})

addStrokeText("Angle_Of_Attack_Label", "    ", STROKE_FNT_DFLT_150, "CenterCenter", {0, -315}, nil, {{"MPD_FCS_SpinAoaLabel"}})

addStrokeText("Spin_Mode", "SPIN MODE", STROKE_FNT_DFLT_150, "CenterCenter", {0, 310})
addStrokeText("Spin_Mode_Engaged", "ENGAGED", STROKE_FNT_DFLT_150, "CenterCenter", {0, 270}, nil, {{"MPD_FCS_SpinModeEngaged"}})
