dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

-------------------------------------------------------- Gun --------------------------------------------------------
local AA_gunRoot = addPlaceholder("AA_Gun_Root")
local AA_gunRootRdrNoTrack = addPlaceholder("AA_gunRootRdrNoTrack", nil, AA_gunRoot.name, {{"HUD_AA_Gun_FunnelShow"}})

-- A/A Gun funnel - radar not tracking mode
for i = 1, 6 do
	for j = 1, 2 do
		local nameSuffix
		if j == 1 then
			nameSuffix = "_left"
		else
			nameSuffix = "_right"
		end
		
		line = addVarLenStrokeLine("funnel_"..i..nameSuffix, nil, nil, nil, AA_gunRootRdrNoTrack.name, {{"HUD_AA_Gun_FunnelLine", i, j}})
	end
end
-- AA MRGS
-- Gun boresight is HUD gun elevation in mils. TODO: to check if it is a correct value
local gunBoresightEl = 98
local MRGS_Line_Offset = -(140 + gunBoresightEl)
local MRGS_Root = addPlaceholder("MRGS_Root", {0, gunBoresightEl}, AA_gunRootRdrNoTrack.name, {{"HUD_AA_Gun_MRGS_Show"}})
for i = 1, 5 do
	local AA_MRGS_Line_Root = addPlaceholder("AA_MRGS_Line_Root_"..i, nil, MRGS_Root.name, {{"HUD_AA_Gun_MRGS_Angle", i - 1}})
	addVarLenStrokeLine("AA_MRGS_Line_"..i, nil, {0, MRGS_Line_Offset}, 0, AA_MRGS_Line_Root.name, {{"HUD_AA_Gun_MRGS_Length", i - 1}})
end

-- AA GUN Tracked
local AA_gunRootRdrTrack = addPlaceholder("AA_gunRootRdrTrack", nil, AA_gunRoot.name, {{"HUD_AA_Gun_TrackedRoot"}})
-- AA Gun Target designator (TD)
local AA_Gun_TD = addPlaceholder("AA_Gun_TD", nil, AA_gunRootRdrTrack.name, {{"HUD_AA_Gun_TD_Pos"}})
local segments = 64
local segLen = math.pi * 2 / segments
local gapLen = math.pi * 2 / segments
local TD_Radius = 20

addStrokeText("HUD_Window_VelScaleMnemonic_AA_And_DGFT", nil, STROKE_FNT_DFLT_100_NARROW, "CenterBottom", {-84, -9.0}, AA_gunRoot.name, {{"HUD_AA_Gun_ShowIfActive"}, {"HUD_Window2_VelScaleMenomic"}}, {"", "G", "T", "C"})

local TAAC_Root = addPlaceholder("Target_Aspect_Angle_Caret_Root", nil, AA_Gun_TD.name, {{"HUD_AA_Gun_TargetAspectAngle"}})
addStrokeSymbol("Target_Aspect_Angle_Caret",   {"stroke_symbols_HUD", "ASE-aspect"}, "FromSet", {0, -TD_Radius}, TAAC_Root.name)

local InRange_Root = addPlaceholder("In_Range_Cue_Root", nil, AA_Gun_TD.name, {{"HUD_AA_Gun_InRangeCue"}})
addStrokeSymbol("In_Range_Cue",   {"stroke_symbols_HUD", "In-Range-Cue"},	"FromSet", {0, TD_Radius + 5}, InRange_Root.name)

addStrokeVarArcFilledDashArc("Gun_Current_Range_Arc", TD_Radius, 0, nil, AA_Gun_TD.name, {{"HUD_AA_Gun_CurrentRange_Arc", 12000}}, segLen, gapLen, 0)

local Gun_Sight_Current_Range_Root = addPlaceholder("Gun_Sight_Current_Range_Root", {0, 0}, AA_Gun_TD.name, {{"HUD_AA_Gun_CurrentRange_Cue"}})
addStrokeLine("Gun_Sight_Current_Range_Cue", 5, {0, TD_Radius}, 180, Gun_Sight_Current_Range_Root.name)

addStrokeSymbol("Level_V_Pipper",   {"stroke_symbols_HUD", "circle-1mr-rad"}, "FromSet", nil, AA_gunRoot.name, {{"HUD_AA_Gun_LevelVPipperPos"}}, 2.0)

addStrokeSymbol("BATR",   {"stroke_symbols_HUD", "circle-1mr-rad"}, "FromSet", nil, AA_gunRoot.name, {{"HUD_AA_Gun_BATR"}}, 3.0)
addStrokeSymbol("BATR_Center",   {"stroke_symbols_HUD", "circle-1mr-rad"}, "FromSet", nil, "BATR", nil, 0.4)

add_X_Over("AA_Gun_TD_Is_Limited", TD_Radius / 2, TD_Radius / 2, nil, AA_Gun_TD.name, {{"HUD_AA_Gun_TrackedIsLimit"}})

local Gun_AAA_Root = addPlaceholder("HUD_AA_Gun_AttitudeAwarenessArc_Root", nil, AA_gunRoot.name, {{"HUD_AA_Gun_AttitudeAwarenessArcRoll"}})
local Attitude_Awareness_arc_main_controller = {{"HUD_AA_Gun_AttitudeAwarenessArcPitch", 90}}
local AAA_Radius = 78
addStrokeArcIndicator("Attitude_Awareness_Arc", AAA_Radius, 0, nil, Gun_AAA_Root.name, Attitude_Awareness_arc_main_controller, 0)
local AAA_LineLen = 6
local Gun_AAA_Line_Root_Right = addPlaceholder("Gun_AAA_Line_Root_Right", nil, Gun_AAA_Root.name,  {{"HUD_AA_Gun_AttitudeAwarenessArcPitch_Lines", 90, 0}})
addStrokeLine("Gun_AAA_Line_Right", AAA_LineLen, {AAA_Radius, 0}, -90, Gun_AAA_Line_Root_Right.name)
local Gun_AAA_Line_Root_Left = addPlaceholder("Gun_AAA_Line_Root_Left", nil, Gun_AAA_Root.name,  {{"HUD_AA_Gun_AttitudeAwarenessArcPitch_Lines", 90, 1}})
addStrokeLine("Gun_AAA_Line_Left", AAA_LineLen, {-AAA_Radius, 0}, 90, Gun_AAA_Line_Root_Left.name)

local Gun_T_Symbol_1G_Root = addPlaceholder("Gun_T_Symbol_1G_Root", nil, AA_gunRoot.name, {{"HUD_AA_Gun_T_Symbol_1G"}})
local Gun_T_Symbol_1G_Cross_Size = 4
addStrokeLine("Gun_T_Symbol_1G_Cross_Vertical_Line", Gun_T_Symbol_1G_Cross_Size, {0, -Gun_T_Symbol_1G_Cross_Size / 2}, 0, Gun_T_Symbol_1G_Root.name)
addStrokeLine("Gun_T_Symbol_1G_Cross_Horisontal_Line", Gun_T_Symbol_1G_Cross_Size, {-Gun_T_Symbol_1G_Cross_Size / 2, 0}, -90, Gun_T_Symbol_1G_Root.name)
addVarLenStrokeLine("Gun_T_Symbol_1G_Line_Left", 10, nil, 90, Gun_T_Symbol_1G_Root.name, {{"HUD_AA_Gun_T_Symbol_AnglesOutOfPlane"}})
addVarLenStrokeLine("Gun_T_Symbol_1G_Line_Right", 10, nil, -90, Gun_T_Symbol_1G_Root.name, {{"HUD_AA_Gun_T_Symbol_AnglesOutOfPlane"}})
local Gun_T_Symbol_9G_Root = addPlaceholder("Gun_T_Symbol_9G_Root", nil, Gun_T_Symbol_1G_Root.name, {{"HUD_AA_Gun_T_Symbol_9G"}})
addStrokeLine("Gun_T_Symbol_9G_Cross_Horisontal_Line", Gun_T_Symbol_1G_Cross_Size, {-Gun_T_Symbol_1G_Cross_Size / 2, 0}, -90, Gun_T_Symbol_9G_Root.name)

------------------------------------------------------- Missiles ----------------------------------------------------
local AA_Missile =
{
	AIM_9LM	= 1,
	AIM_9X	= 3,
	AIM_120	= 4,
}

local dlzWidth = 6
local dlzRange = 74
local DLZ_root = addPlaceholder("HUD_AA_DLZ_root", {63, -34}, nil, {{"HUD_AA_DLZ_Show"}})
addStrokeLine("HUD_AA_DLZ_zeroRange", dlzWidth, {0, 0}, -90, DLZ_root.name)

local rmin1_root = addPlaceholder("HUD_AA_DLZ_Rmin1_root",{0, 0}, DLZ_root.name, {{"HUD_AA_DLZ_RMin1"}})
addStrokeLine("HUD_AA_DLZ_Rmin1",		dlzWidth, {0, 0}, -90, rmin1_root.name)
local rmin2_root = addPlaceholder("HUD_AA_DLZ_Rmin2_root", {0, 0}, DLZ_root.name, {{"HUD_AA_DLZ_RMin2"}})
addStrokeLine("HUD_AA_DLZ_Rmin2",		dlzWidth, {0, 0}, -90, rmin2_root.name)
local rmax2_root = addPlaceholder("HUD_AA_DLZ_Rmax2_root", {0, 0}, DLZ_root.name, {{"HUD_AA_DLZ_RMax2"}})
addStrokeLine("HUD_AA_DLZ_Rmax2",		dlzWidth, {0, 0}, -90, rmax2_root.name)
local rmax1_root = addPlaceholder("HUD_AA_DLZ_Rmax1_root", {0, 0}, DLZ_root.name, {{"HUD_AA_DLZ_RMax1"}})
addStrokeLine("HUD_AA_DLZ_Rmax1",		dlzWidth, {0, 0}, -90, rmax1_root.name)

addVarLenStrokeLine("HUD_AA_DLZ_nonManeuv",	0, {0, 0},		  0, DLZ_root.name, {{"HUD_AA_DLZ_nonManeuv"}}, dlzRange)
addVarLenStrokeLine("HUD_AA_DLZ_Maneuv",	0, {dlzWidth, 0}, 0, DLZ_root.name, {{"HUD_AA_DLZ_Maneuv"}}, dlzRange)

-- Window 32, Missile time of flight, Predicted altitude ar weapon release
addStrokeText("HUD_W32_PreLaunchTOF", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {10, -6}, DLZ_root.name, {{"HUD_W32_PreLaunchTOF", 2}})

-- Window 37, Time remaining AIM-120 longest flight/bugged target/? - blank, ### (last launched AIM-9), A### (to active), T### (to impact), L### (to termination)
addStrokeText("HUD_W37_PostLaunchTOF", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {10, -16}, DLZ_root.name, {{"HUD_W37_PostLaunchTOF", 2}})

-------------------------------------------------------- AIM-9 ------------------------------------------------------
--local AIM9_DLZ_root = addPlaceholder("HUD_AA_DLZ_AIM9_root", {0, 0}, DLZ_root.name)--, {{"HUD_AA_DLZ_ShowMissile", AA_Missile.AIM_9LM}})

local AIM9LM_root = addPlaceholder("HUD_AA_AIM9LM_Selected", {0, boresightShiftY}, nil, {{"HUD_AA_MissileSelected", AA_Missile.AIM_9LM}})
local spotCrl = addStrokeCircle("HUD_AA_AIM9_SpotReticle", 65/2, {0, -DegToMil(3)}, AIM9LM_root.name, {{"HUD_AA_AIM9_Reticle", 0}})
addStrokeSymbol("HUD_AA_AIM9_SpotReticleAspect", {"stroke_symbols_HUD", "ASE-aspect"},	"FromSet", {0, 0}, spotCrl.name, {{"HUD_AA_AIM9_ReticleAspect", 65/2}})
local scanCrl = addStrokeCircle("HUD_AA_AIM9_ScanReticle", 100/2, {0, -DegToMil(3)}, AIM9LM_root.name, {{"HUD_AA_AIM9_Reticle", 1}})
addStrokeSymbol("HUD_AA_AIM9_ScanReticleAspect", {"stroke_symbols_HUD", "ASE-aspect"},	"FromSet", {0, 0}, scanCrl.name, {{"HUD_AA_AIM9_ReticleAspect", 100/2}})

addStrokeSymbol("HUD_AA_AIM9_DiamondCaged",   {"stroke_symbols_HUD", "aim9lm-caged"},	"FromSet", {0, 0}, AIM9LM_root.name, {{"HUD_AA_AIM9_Diamond", 0}})
addStrokeSymbol("HUD_AA_AIM9_DiamondUuncaged", {"stroke_symbols_HUD", "aim9lm-uncaged"},	"FromSet", {0, 0}, AIM9LM_root.name, {{"HUD_AA_AIM9_Diamond", 1}})

local AIM9X_root = addPlaceholder("HUD_AA_AIM9X_Selected", {0, boresightShiftY}, nil, {{"HUD_AA_MissileSelected", AA_Missile.AIM_9X}})
local spotCrlX = addStrokeCircle("HUD_AA_AIM9X_SpotReticle", 65/2, {0, -DegToMil(3)}, AIM9X_root.name, {{"HUD_AA_AIM9_Reticle", 0}})
addStrokeSymbol("HUD_AA_AIM9X_SpotReticleAspect",   {"stroke_symbols_HUD", "ASE-aspect"},	"FromSet", {0, 0}, spotCrlX.name, {{"HUD_AA_AIM9_ReticleAspect", 65/2}})
local scanCrlX = addStrokeCircle("HUD_AA_AIM9X_ScanReticle", 100/2, {0, -DegToMil(3)}, AIM9X_root.name, {{"HUD_AA_AIM9_Reticle", 1}})
addStrokeSymbol("HUD_AA_AIM9X_ScanReticleAspect",   {"stroke_symbols_HUD", "ASE-aspect"},	"FromSet", {0, 0}, scanCrlX.name, {{"HUD_AA_AIM9_ReticleAspect", 100/2}})

addStrokeSymbol("HUD_AA_AIM9X_DiamondCaged",   {"stroke_symbols_HUD", "aim9x-caged"},	"FromSet", {0, 0}, AIM9X_root.name, {{"HUD_AA_AIM9_Diamond", 0}})
addStrokeSymbol("HUD_AA_AIM9X_DiamondUuncaged", {"stroke_symbols_HUD", "aim9lm-uncaged"},	"FromSet", {0, 0}, AIM9X_root.name, {{"HUD_AA_AIM9_Diamond", 1}})

------------------------------------------------------- AIM-120 -----------------------------------------------------
local DLZ_AIM120_root = addPlaceholder("HUD_AA_DLZ_AIM120_root", {0, 0}, DLZ_root.name, {{"HUD_AA_MissileSelected", AA_Missile.AIM_120}})

addStrokeLine("HUD_AA_DLZ_Rmax1_Aim120_1",	dlzWidth, {0, 0}, -90, rmax1_root.name, {{"HUD_AA_AIM120_DLZ_RMax1_ThickLine", 1}})
addStrokeLine("HUD_AA_DLZ_Rmax1_Aim120_2",	dlzWidth, {0, 0}, -90, rmax1_root.name, {{"HUD_AA_AIM120_DLZ_RMax1_ThickLine", 2}})

addStrokeLine("HUD_AA_DLZ_RMin1_Aim120_1",	dlzWidth, {0, 0}, -90, rmin1_root.name, {{"HUD_AA_AIM120_DLZ_RMin1_ThickLine", 1}})
addStrokeLine("HUD_AA_DLZ_RMin1_Aim120_2",	dlzWidth, {0, 0}, -90, rmin1_root.name, {{"HUD_AA_AIM120_DLZ_RMin1_ThickLine", 2}})

addStrokeSymbol("HUD_AA_DLZ_Ropt", {"stroke_symbols_HUD", "DLZ-Act-range"},	"FromSet", {0, 0}, DLZ_AIM120_root.name, {{"HUD_AA_DLZ_Ropt"}})
addStrokeSymbol("HUD_AA_DLZ_Raero", {"stroke_symbols_HUD", "DLZ-Raero"}, "FromSet", {3, 0}, DLZ_root.name,  {{"HUD_AA_DLZ_RAero"}})

local AIM120_root = addPlaceholder("HUD_AA_AIM120_Selected", {0, 0}, nil, {{"HUD_AA_MissileSelected", AA_Missile.AIM_120}})
local aim120_ShiftY = boresightShiftY - DegToMil(6)
addStrokeCircle("HUD_AA_AIM120_Reticle", 262/2, {0, aim120_ShiftY}, AIM120_root.name, {{"HUD_AA_AIM120_Reticle"}})
addStrokeSymbol("HUD_AA_AIM120_ScanReticleAspect",   {"stroke_symbols_HUD", "ASE-aspect"},	"FromSet", {0, aim120_ShiftY}, AIM120_root.name, {{"HUD_AA_AIM120_ReticleAspect"}})

addStrokeSymbol("HUD_AA_AIM120_Diamond",   {"stroke_symbols_HUD", "aim120-diamond"},	"FromSet", {0, 0}, AIM120_root.name, {{"HUD_AA_AIM120_Diamond"}})

addStrokeSymbol("HUD_AA_AIM120_SteeringCue",   {"stroke_symbols_HUD", "steering-cue"},	"FromSet", {0, 0}, AIM120_root.name, {{"HUD_AA_AIM120_SteeringCue"}})

-- SPI Symbols must bee last in file. All elements above will be hided by masks on SPI symbols
addSpiSymbols()