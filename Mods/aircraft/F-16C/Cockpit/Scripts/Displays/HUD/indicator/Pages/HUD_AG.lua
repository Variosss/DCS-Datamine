dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")

local Solution_Line_Len = 10

local parent_RootPH = addPlaceholder("parent_RootPH", {0, 0}, nil, {{"HUD_AG_RootPlaceholder"}})

-- BOMB CCIP
local Bomb_CCIP_Root = addPlaceholder("Bomb_CCIP_Root", {0, 0}, parent_RootPH.name, {{"HUD_Bomb_CCIP_Root"}})
addStrokeSymbol("Bomb_CCIP_Piper", {"stroke_symbols_HUD", "4-impact-point"}, "FromSet", nil, Bomb_CCIP_Root.name, {{"HUD_Bomb_CCIP_Pipper_Pos"}})
addVarLenStrokeLine("Bomb_CCIP_Fall_Line", 50, nil, parent_RootPH.name, "Bomb_CCIP_Piper", {{"HUD_Bomb_CCIP_Fall_Line"}})
local Bomb_CCIP_Time_Delay_Cue_Line_Len = 16
local Bomb_CCIP_Time_Delay_Cue = addPlaceholder("Bomb_CCIP_Time_Delay_Cue", nil, "Bomb_CCIP_Fall_Line", {{"HUD_Bomb_CCIP_TimeDelayCue"}})
addStrokeLine("Bomb_CCIP_Time_Delay_Cue_Line", Bomb_CCIP_Time_Delay_Cue_Line_Len, {Bomb_CCIP_Time_Delay_Cue_Line_Len / 2, 0}, 90, Bomb_CCIP_Time_Delay_Cue.name)
local Bomb_CCIP_Solution_Cue_Root = addPlaceholder("Bomb_CCIP_Solution_Cue_Root", {0, 0}, Bomb_CCIP_Root.name, {{"HUD_Bomb_CCIP_ShowSolution"}, {"HUD_FPM_Pos"}})
addStrokeLine("Bomb_CCIP_Azimuth_Steering_Line_Top", 500, nil, 0, Bomb_CCIP_Solution_Cue_Root.name)
addStrokeLine("Bomb_CCIP_Azimuth_Steering_Line_Down", 500, nil, 180, Bomb_CCIP_Solution_Cue_Root.name)
local Bomb_CCIP_Solution_Cue = addPlaceholder("Bomb_CCIP_Solution_Cue", nil, Bomb_CCIP_Solution_Cue_Root.name, {{"HUD_Bomb_CCIP_SolutionCuePos", 50}})
addStrokeLine("Bomb_CCIP_Solution_Line_1", Solution_Line_Len, {Solution_Line_Len / 2, 0}, 90, Bomb_CCIP_Solution_Cue.name)
addStrokeLine("Bomb_CCIP_Solution_Line_2", Solution_Line_Len, {Solution_Line_Len / 2, 0.5}, 90, Bomb_CCIP_Solution_Cue.name)
addStrokeLine("Bomb_CCIP_Solution_Line_3", Solution_Line_Len, {Solution_Line_Len / 2, 1}, 90, Bomb_CCIP_Solution_Cue.name)

-- BOMB CCRP
local Bomb_CCRP_ASL_Root = addAzimuthSteeringLine("Bomb_CCRP", parent_RootPH.name, {{"HUD_Bomb_CCRP_Root"}, {"HUD_Bomb_CCRP_ASL_Offset"}})
--local Bomb_CCRP_Root = addPlaceholder("Bomb_CCRP_Root", {0, 0}, nil, {{"HUD_FPM_Pos"}, {"HUD_Bomb_CCRP_Root"}, {"HUD_Bomb_CCRP_ASL_Offset"}})
--addStrokeLine("Bomb_CCRP_Azimuth_Steering_Line_Top", 500, nil, 0, Bomb_CCRP_Root.name)
--addStrokeLine("Bomb_CCRP_Azimuth_Steering_Line_Down", 500, nil, 180, Bomb_CCRP_Root.name)
local Bomb_CCRP_MaximumTossAssumptions = addPlaceholder("Bomb_CCRP_MaximumTossAssumptions", nil, Bomb_CCRP_ASL_Root.name, {{"HUD_Bomb_CCRP_MaximumTossAssumptions"}})
local Bomb_CCRP_Solution_Root = addPlaceholder("Bomb_CCRP_Solution_Root", nil, Bomb_CCRP_MaximumTossAssumptions.name, {{"HUD_Bomb_CCRP_Solution_Position", 50}})
addStrokeLine("Bomb_CCRP_Solution_Line_1", Solution_Line_Len, {Solution_Line_Len / 2, 0}, 90, Bomb_CCRP_Solution_Root.name)
addStrokeLine("Bomb_CCRP_Solution_Line_2", Solution_Line_Len, {Solution_Line_Len / 2, 0.5}, 90, Bomb_CCRP_Solution_Root.name)
addStrokeLine("Bomb_CCRP_Solution_Line_3", Solution_Line_Len, {Solution_Line_Len / 2, 1}, 90, Bomb_CCRP_Solution_Root.name)
-- Max TOSS Anticipation Cue
addStrokeCircle("Bomb_Max_TOSS_Anticipation_Cue", 50.0, {0,boresightShiftY - DegToMil(3)}, nil, {{"HUD_Bomb_Max_TOSS_Anticipation_Cue"}}, {0, math.pi * 2})

-- GUN SIGHT
local Gun_Sight_Root = addPlaceholder("Gun_Sight_Root", {0, 0}, parent_RootPH.name, {{"HUD_AG_Gun_Root"}})

local Gun_Sight_Bullet_Fall_Line_Root = addPlaceholder("Gun_Sight_Bullet_Fall_Line_Root", {0, 0}, "Gun_Sight_Root", {{"HUD_AG_Gun_BulletTrackLineAngle"}})
addVarLenStrokeLine("Gun_Sight_Bullet_Fall_Line", 50, {0, 5}, 0, Gun_Sight_Bullet_Fall_Line_Root.name, {{"HUD_AG_Gun_BulletTrackLineLen"}})

addStrokeCircle("Gun_Sight_50mR_Reticle", 25, nil, Gun_Sight_Root.name)
addStrokeCircle("Gun_Sight_Center_2mR", 1, nil, Gun_Sight_Root.name, nil, nil, math.pi * 4 / 8)

local Gun_Moving_Target_Indices_Root = addPlaceholder("Gun_Moving_Target_Indices_Root", {0, 0}, Gun_Sight_Root.name, {{"HUD_AG_Gun_MovingTargetIndices"}})
addStrokeLine("Gun_Moving_Target_Indices_Left", 8, {-15, -4}, 0, Gun_Moving_Target_Indices_Root.name)
addStrokeLine("Gun_Moving_Target_Indices_Right", 8, {15, -4}, 0, Gun_Moving_Target_Indices_Root.name)

addStrokeLine("Gun_Sight_Reticle_Line_Up", 5, {0, 25}, 0, Gun_Sight_Root.name)
addStrokeLine("Gun_Sight_Reticle_Line_Down", 5, {0, -25}, 180, Gun_Sight_Root.name)
addStrokeLine("Gun_Sight_Reticle_Line_Left", 5, {25, 0}, -90, Gun_Sight_Root.name)
addStrokeLine("Gun_Sight_Reticle_Line_Right", 5, {-25, 0}, 90, Gun_Sight_Root.name)

local Gun_Sight_In_Range_Cue_Root = addPlaceholder("Gun_Sight_In_Range_Cue_Root", {0, 0}, Gun_Sight_Root.name, {{"HUD_AG_Gun_inRangeCue"}})
addStrokeCircle("Gun_Sight_In_Range_Cue", 1, {0, 30}, Gun_Sight_In_Range_Cue_Root.name, nil, nil, math.pi * 4 / 8)
addStrokeLine("Gun_Sight_0Ft_Range_Cue", 5, {0, 25}, 180, Gun_Sight_Root.name, {{"HUD_AG_Gun_0FtRangeCue"}})

local Gun_Current_Range_arc_mask_controller = {{"HUD_AG_Gun_CurrentRange_Arc", 12000, 12000, 0.5}}
local Gun_Current_Range_arc_main_controller = {{"HUD_AG_Gun_CurrentRange_Arc", 12000, 12000}}
addStrokeVarArc("Gun_Current_Range_Arc", 20, 0, nil, Gun_Sight_Root.name, Gun_Current_Range_arc_mask_controller, Gun_Current_Range_arc_main_controller, 0)

local Gun_Sight_Current_Range_Root = addPlaceholder("Gun_Sight_Current_Range_Root", {0, 0}, Gun_Sight_Root.name, {{"HUD_AG_Gun_CurrentRangeCue"}})
addStrokeLine("Gun_Sight_Current_Range_Cue", 5, {0, 25}, 180, Gun_Sight_Current_Range_Root.name)

-- ROCKET CCIP
local Rocket_CCIP_Root = addPlaceholder("Rocket_CCIP_Root", {0, 0}, parent_RootPH.name, {{"HUD_Rocket_CCIP_Root"}})
addStrokeSymbol("Rocket_CCIP_Piper", {"stroke_symbols_HUD", "4-impact-point"}, "FromSet", nil, Rocket_CCIP_Root.name, {{"HUD_Rocket_CCIP_Pipper_Pos"}})
local Rocket_CCIP_In_Range_Cue_Line_Len = 12
addStrokeLine("Rocket_CCIP_In_Range_Cue_Line", Rocket_CCIP_In_Range_Cue_Line_Len, {Rocket_CCIP_In_Range_Cue_Line_Len / 2, 6}, 90, "Rocket_CCIP_Piper", {{"HUD_Rocket_CCIP_InRange"}})
add_X_Over("Rocket_CCIP_Is_Limit", 12, 12, nil, "Rocket_CCIP_Piper", {{"HUD_Rocket_CCIP_IsLimit"}})

-- PUAC (pull-up anticipation cue)
local HUD_FPM_origin = addPlaceholder("HUD_FPM_origin", {0, 0}, parent_RootPH.name, {{"HUD_FPM_Pos"}})
local PUAC_PH = addPlaceholder("HUD PUAC PH", {0,0}, HUD_FPM_origin.name, {{"HUD_PUAC_Show"}})
addStrokeSymbol("HUD_PUAC", {"stroke_symbols_HUD", "puac"}, "FromSet", {0, 0}, PUAC_PH.name, {{"HUD_PUAC_Pos", 150}})
addStrokeText("HUD_PUAC_LOW", "LOW", STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {20, 0}, HUD_FPM_origin.name, {{"HUD_PUAC_LOW_Show"}})

-- Vertical steering cue
local Bomb_CCRP_Vertical_Steering_Cue_Root = addPlaceholder("Bomb_CCRP_Vertical_Steering_Cue_Root", nil, HUD_FPM_origin.name, {{"HUD_Bomb_CCRP_Vertical_Steering_Cue", 50}})
addStrokeLine("Bomb_CCRP_Vertical_Steering_Cue", 25, {25 / 2, 0}, 90, Bomb_CCRP_Vertical_Steering_Cue_Root.name)

-- HARM HAS
local HUD_HARM_HAS_FOV = addPlaceholder("HUD_HARM_HAS_FOV_placer", {0,0}, parent_RootPH.name, {{"HUD_HARM_HAS_FOV_Show"}})
addStrokeBox("HUD_HARM_HAS_FOV_Box", 140, 26, "CenterCenter", {0, -75}, "HUD_HARM_HAS_FOV_placer","INDICATION_COMMON_GREEN")

local HUD_HARM_POS_EOM_FOV = addPlaceholder("HUD_HARM_POS_EOM_FOV_placer", {0,0}, parent_RootPH.name, {{"HUD_HARM_POS_EOM_FOV_Show"}})
addStrokeBox("HUD_HARM_POS_EOM_FOV_Box", 70, 26, "CenterCenter", {0, -75}, "HUD_HARM_POS_EOM_FOV_placer","INDICATION_COMMON_GREEN")

--HARM POS
--local Bomb_CCRP_ASL_Root = addAzimuthSteeringLine("Bomb_CCRP", nil, {{"HUD_Bomb_CCRP_Root"}, {"HUD_Bomb_CCRP_ASL_Offset"}})
local HUD_HARM_POS_ASL_Root = addAzimuthSteeringLine("HUD_HARM_POS", parent_RootPH.name, {{"HUD_HARM_POS_ASL_Offset"}})
	addStrokeLine("HUD_HARM_POS_MinCue", 10, {5,0}, 90, HUD_HARM_POS_ASL_Root.name, {{"HUD_HARM_POS_MinCue_Position"}})
	addStrokeLine("HUD_HARM_POS_MaxCue", 20, {10,0}, 90, HUD_HARM_POS_ASL_Root.name, {{"HUD_HARM_POS_MaxCue_Position"}})
addPlaceholder("HUD_HARM_POS_OptimalLoft",{0,0},HUD_HARM_POS_ASL_Root.name,{{"HUD_HARM_POS_OptimalLoft_line_position"}})
	addStrokeLine("HUD_HARM_POS_OptimalLoft_line1", 10,{10,0},-60,"HUD_HARM_POS_OptimalLoft")
	addStrokeLine("HUD_HARM_POS_OptimalLoft_line2", 10,{10,0},-120,"HUD_HARM_POS_OptimalLoft")
	addStrokeLine("HUD_HARM_POS_OptimalLoft_line3", 10,{-10,0},60,"HUD_HARM_POS_OptimalLoft")
	addStrokeLine("HUD_HARM_POS_OptimalLoft_line4", 10,{-10,0},120,"HUD_HARM_POS_OptimalLoft")

-- Window 32, altitude at release
addStrokeText("HUD_W32_AltitudeAtRelease", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {73, -40}, parent_RootPH.name, {{"HUD_Window32_AltitudeAtRelease"}})
-- Window 37, required turn
addStrokeText("HUD_W37_RequiredTurn", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {73, -50}, parent_RootPH.name, {{"HUD_Window37_RequiredTurn"}})

-- Maverick
-- LOS reticle
local HUD_MAV_Reticle_root = addPlaceholder("HUD_MAV_Reticle_root", {0, boresightShiftY}, parent_RootPH.name)
local HUD_MAV_Reticle = addStrokeCircle("HUD_MAV_Reticle", 5, {0,0}, HUD_MAV_Reticle_root.name, {{"HUD_MAV_Reticle", 0}})
addStrokeText("HUD_MAV_Reticle_lbl", "1", STROKE_FNT_DFLT_75, "LeftCenter", {7, 0}, HUD_MAV_Reticle.name, {{"HUD_MAV_ReticleSec_Show"}})
addStrokeBox("HUD_MAV_Reticle_Box_1", 4, 4, "CenterTop", {0, -5}, HUD_MAV_Reticle.name, {{"HUD_MAV_Reticle_handoff", 0}})
local HUD_MAV_ReticleSec = addStrokeCircle("HUD_MAV_ReticleSec", 5, {0,0}, HUD_MAV_Reticle_root.name, {{"HUD_MAV_ReticleSec_Show"}, {"HUD_MAV_ReticleSec_Pos"}})
addStrokeText("HUD_MAV_ReticleSec_lbl", "2", STROKE_FNT_DFLT_75, "LeftCenter", {7, 0}, HUD_MAV_ReticleSec.name, {{"HUD_MAV_ReticleSec_Show"}})
addStrokeBox("HUD_MAV_Reticle_Box_2", 4, 4, "CenterTop", {0, -5}, HUD_MAV_ReticleSec.name, {{"HUD_MAV_Reticle_handoff", 1}})

-- EO reticle
local HUD_MAV_Boresight_root = addPlaceholder("HUD_MAV_Boresight_root", {0, boresightShiftY}, parent_RootPH.name)
local HUD_MAV_BoresightReticle_root = addPlaceholder("HUD_MAV_BoresightReticle_root", {0, 0}, HUD_MAV_Boresight_root.name, {{"HUD_MAV_Reticle", 1}})
local small_cross_size = 15
addStrokeLine("Small_Cross1", small_cross_size, {0, 2}, 0, HUD_MAV_BoresightReticle_root.name)
addStrokeLine("Small_Cross2", small_cross_size, {-2, 0}, 90, HUD_MAV_BoresightReticle_root.name)
addStrokeLine("Small_Cross3", small_cross_size, {0, -2}, 180, HUD_MAV_BoresightReticle_root.name)
addStrokeLine("Small_Cross4", small_cross_size, {2, 0}, -90, HUD_MAV_BoresightReticle_root.name)

-- EO Azimuth Steering line
addAzimuthSteeringLine("MAV_ASL", parent_RootPH.name, {{"HUD_MAV_ASL_Offset"}})

-- MLE
local mleWidth = 6
local mleRange = 74
local MLE_root = addPlaceholder("HUD_AG_MLE_root", {63, -34}, parent_RootPH.name, {{"HUD_AG_MLE_Show"}})

addStrokeText("HUD_AG_MLE_RangeScale", "", STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {3, mleRange+3}, MLE_root.name, {{"HUD_AG_MLE_RangeScale"}})
addStrokeLine("HUD_AG_MLE_RangeScale_line", mleWidth, {0, mleRange}, -90, MLE_root.name)
addStrokeLine("HUD_AG_MLE_zeroRange", mleWidth, {0, 0}, -90, MLE_root.name)

local mleRangeCaret = addStrokeSymbol("HUD_AG_MLE_TgtRange_Caret",   {"stroke_symbols_HUD", "AA-DLZ-range"}, "FromSet", {0, 0}, MLE_root.name, {{"HUD_AG_MLE_TgtRange_Caret", mleRange}})
addStrokeText("HUD_AG_MLE_TgtRange", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {-6, 0}, mleRangeCaret.name, {{"HUD_AG_MLE_TgtRange"}})

local rmin_root = addPlaceholder("HUD_AG_MLE_Rmin_root",{0, 0}, MLE_root.name, {{"HUD_AG_MLE_RMin", mleRange}})
addStrokeLine("HUD_AG_MLE_Rmin",		mleWidth, {0, 0}, -90, rmin_root.name)
local rmax_root = addPlaceholder("HUD_AG_MLE_Rmax_root", {0, 0}, MLE_root.name, {{"HUD_AG_MLE_RMax", mleRange}})
addStrokeLine("HUD_AG_MLE_Rmax",		mleWidth, {0, 0}, -90, rmax_root.name)
local ropt_root = addPlaceholder("HUD_AG_MLE_Ropt_root", {0, 0}, MLE_root.name, {{"HUD_AG_MLE_ROpt", mleRange}})
addStrokeLine("HUD_AG_MLE_Ropt",		mleWidth, {0, 0}, -90, ropt_root.name)
addVarLenStrokeLine("HUD_AG_MLE_Range",	0, {0, 0},		  0, MLE_root.name, {{"HUD_AG_MLE_Range", mleRange}}, mleRange)

-- MLE Preplanned
local MLE_PRE_root = addPlaceholder("HUD_AG_MLE_PRE_root", {69, -34}, parent_RootPH.name, {{"HUD_AG_MLE_PRE_Show"}})

local rmin_root = addPlaceholder("HUD_AG_MLE_PRE_Rmin_root",{0, 0}, MLE_PRE_root.name, {{"HUD_AG_MLE_PRE_RMin", mleRange}})
addStrokeLine("HUD_AG_MLE_PRE_Rmin",		mleWidth, {0, 0}, 90, rmin_root.name)
local rmax_root = addPlaceholder("HUD_AG_MLE_PRE_Rmax_root", {0, 0}, MLE_PRE_root.name, {{"HUD_AG_MLE_PRE_RMax", mleRange}})
addStrokeLine("HUD_AG_MLE_PRE_Rmax",		mleWidth, {0, 0}, 90, rmax_root.name)
addVarLenStrokeLine("HUD_AG_MLE_PRE_Range",	0, {0, 0},		  0, MLE_PRE_root.name, {{"HUD_AG_MLE_PRE_Range", mleRange}}, mleRange)
--GBU-24 CUE Range
local CueRngGBU24_root = addPlaceholder("CueRngGBU24_root", {0, 0}, MLE_root.name, {{"HUD_AG_MLE_PRE_Show"}})
addStrokeSymbol("HUD_AG_GBU24_CueRange", {"stroke_symbols_HUD", "DLZ-Act-range"},	"FromSet", {0, 0}, CueRngGBU24_root.name, {{"HUD_AG_GBU24_CueRange", mleRange}})
--GBU24
local HUD_DataTime	= addPlaceholder("HUD_DataTime", {62, -104}, parent_RootPH.name)
addStrokeText("HUD_AG_GBU24_Time", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {0, 0}, HUD_DataTime.name, {{"HUD_AG_GBU24_Time"}})

-- SPI Symbols must bee last in file. All elements above will be hided by masks on SPI symbols
addSpiSymbols()