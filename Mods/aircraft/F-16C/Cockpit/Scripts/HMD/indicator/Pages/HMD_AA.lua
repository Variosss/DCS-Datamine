dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

-- Dynamic Aiming Cross
addStrokeSymbol("HMD_DynamicAimingCross", {"stroke_symbols_HMD", "aiming-cross"}, "FromSet", {0, 0}, hmd_dacPosition.name)
------------------------------------------------------- Missiles ----------------------------------------------------
local AA_Missile =
{
	AIM_9LM	= 1,
	AIM_9X	= 3,
	AIM_120	= 4,
}

--addStrokeLine("HMD_DLZ_Line", 80,  {104, 35}, 0, autoBlank.name)
local dlzWidth = 6
local dlzRange = 74
local DLZ_root = addPlaceholder("HMD_AA_DLZ_root", {104, 35}, autoBlank.name, {{"HMD_AA_DLZ_Show"}})
addStrokeLine("HMD_AA_DLZ_zeroRange", dlzWidth, {0, 0}, -90, DLZ_root.name)

local rmin1_root = addPlaceholder("HMD_AA_DLZ_Rmin1_root",{0, 0}, DLZ_root.name, {{"HMD_AA_DLZ_RMin1"}})
addStrokeLine("HMD_AA_DLZ_Rmin1",		dlzWidth, {0, 0}, -90, rmin1_root.name)
local rmin2_root = addPlaceholder("HMD_AA_DLZ_Rmin2_root", {0, 0}, DLZ_root.name, {{"HMD_AA_DLZ_RMin2"}})
addStrokeLine("HMD_AA_DLZ_Rmin2",		dlzWidth, {0, 0}, -90, rmin2_root.name)
local rmax2_root = addPlaceholder("HMD_AA_DLZ_Rmax2_root", {0, 0}, DLZ_root.name, {{"HMD_AA_DLZ_RMax2"}})
addStrokeLine("HMD_AA_DLZ_Rmax2",		dlzWidth, {0, 0}, -90, rmax2_root.name)
local rmax1_root = addPlaceholder("HMD_AA_DLZ_Rmax1_root", {0, 0}, DLZ_root.name, {{"HMD_AA_DLZ_RMax1"}})
addStrokeLine("HMD_AA_DLZ_Rmax1",		dlzWidth, {0, 0}, -90, rmax1_root.name)

addVarLenStrokeLine("HMD_AA_DLZ_nonManeuv",	0, {0, 0},		  0, DLZ_root.name, {{"HMD_AA_DLZ_nonManeuv"}}, dlzRange)
addVarLenStrokeLine("HMD_AA_DLZ_Maneuv",	0, {dlzWidth, 0}, 0, DLZ_root.name, {{"HMD_AA_DLZ_Maneuv"}}, dlzRange)

--addStrokeText("HMD_AA_DLZ_Selected_TTA", "", STROKE_FNT_DFLT_150, "RightTop", {8, -2}, DLZ_AIM120_root.name, {{"HMD_AA_DLZ_Selected_TTA"}})
--addStrokeText("HMD_AA_DLZ_Launched_TTA", "", STROKE_FNT_DFLT_100_NARROW, "RightCenter", {10, -16}, DLZ_AIM120_root.name, {{"HMD_AA_DLZ_Launched_TTA"}})

addStrokeText("HMD_AA_PreLaunchTOF", "", STROKE_FNT_DFLT_150, "RightCenter", {10, -8}, DLZ_root.name, {{"HMD_AA_PreLaunchTOF", 2}})
addStrokeText("HMD_AA_PostLaunchTOF", "", STROKE_FNT_DFLT_150, "RightCenter", {10, -20}, DLZ_root.name, {{"HMD_AA_PostLaunchTOF", 2}})

-------------------------------------------------------- AIM-9 ------------------------------------------------------
local AIM9LM_root = addPlaceholder("HMD_AA_AIM9_Selected", {0, 0}, autoBlank.name, {{"HMD_AA_MissileSelected", AA_Missile.AIM_9LM}, {"HMD_AA_AIM9_DiamondPos", RadToMil()}})
addStrokeSymbol("HMD_AA_AIM9_DiamondCaged",		{"stroke_symbols_HMD", "aim9lm-caged"},	 "FromSet", {0, 0}, AIM9LM_root.name, {{"HMD_AA_AIM9_Diamond", 0}})
addStrokeSymbol("HMD_AA_AIM9_DiamondUncaged",	{"stroke_symbols_HMD", "aim9lm-uncaged"},"FromSet", {0, 0}, AIM9LM_root.name, {{"HMD_AA_AIM9_Diamond", 1}})
addStrokeSymbol("HMD_AA_AIM9_OutFovCross",		{"stroke_symbols_HMD", "out-fov-cross"}, "FromSet", {0, 0}, AIM9LM_root.name, {{"HMD_AA_AIM9_OutFovCross"}})

local AIM9X_root = addPlaceholder("HMD_AA_AIM9X_Selected", {0, 0}, autoBlank.name, {{"HMD_AA_MissileSelected", AA_Missile.AIM_9X}, {"HMD_AA_AIM9_DiamondPos", RadToMil()}})
addStrokeSymbol("HMD_AA_AIM9X_DiamondCaged",	{"stroke_symbols_HMD", "aim9x-caged"},	 "FromSet", {0, 0}, AIM9X_root.name, {{"HMD_AA_AIM9_Diamond", 0}})
addStrokeSymbol("HMD_AA_AIM9X_DiamondUncaged",	{"stroke_symbols_HMD", "aim9lm-uncaged"},"FromSet", {0, 0}, AIM9X_root.name, {{"HMD_AA_AIM9_Diamond", 1}})
addStrokeSymbol("HMD_AA_AIM9X_OutFovCross",		{"stroke_symbols_HMD", "out-fov-cross"}, "FromSet", {0, 0}, AIM9X_root.name, {{"HMD_AA_AIM9_OutFovCross"}})

------------------------------------------------------- AIM-120 -----------------------------------------------------
local DLZ_AIM120_root = addPlaceholder("HMD_AA_DLZ_AIM120_root", {0, 0}, DLZ_root.name, {{"HMD_AA_MissileSelected", AA_Missile.AIM_120}})
addStrokeSymbol("HMD_AA_DLZ_ActRange", {"stroke_symbols_HMD", "DLZ-Act-range"},	"FromSet", {0, 0}, DLZ_AIM120_root.name, {{"HMD_AA_DLZ_ActRange"}})

local AIM120_root = addPlaceholder("HMD_AA_AIM120_Selected", {0, 0}, autoBlank.name, {{"HMD_AA_MissileSelected", AA_Missile.AIM_120}})
addStrokeSymbol("HMD_AA_AIM120_Diamond",   {"stroke_symbols_HMD", "aim120-diamond"},	"FromSet", {0, 0}, AIM120_root.name, {{"HMD_AA_AIM120_Diamond"}})
