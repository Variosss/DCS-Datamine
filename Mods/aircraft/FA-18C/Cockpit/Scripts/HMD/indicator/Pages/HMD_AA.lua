dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

-- AA
local YPosWeaponType = -330

-- TODO: to make position common with GUN+count
-- NOTE: docs say about 200% font, but it does look rather like 150% font on videos
local weapon_Type_Count = addPlaceholder("HMD_AA_Weapon_Count", {0, 0}, nil, {{"HMD_AA_Show_Weapon_Count"}})
addStrokeText("HMD_AA_Weapon_type", nil, STROKE_FNT_DFLT_150, "RightCenter", {0, YPosWeaponType - 85}, weapon_Type_Count.name, {{"HMD_AA_WeaponType"}})
addStrokeText("HMD_AA_Weapon_count", nil, STROKE_FNT_DFLT_150, "CenterCenter", {33, YPosWeaponType - 85}, weapon_Type_Count.name, {{"HMD_AA_WeaponCount"}})

local gun_Type_Count = addPlaceholder("HMD_AA_Gun_Count", {0, 0}, nil, {{"HMD_AA_Gun_Show"}})
addStrokeText("HMD_GUN_AA_label",	 "GUN", STROKE_FNT_DFLT_150, "CenterCenter", {0, YPosWeaponType - 85}, gun_Type_Count.name)
addStrokeText("HMD_GUN_AA_Round_Data", nil, STROKE_FNT_DFLT_150, "RightCenter", {34, YPosWeaponType - 120}, gun_Type_Count.name, {{"HMD_AA_GunDataRound"}})

addStrokeText("LAUNCH_MODE", "AUTO", STROKE_FNT_DFLT_150, "CenterCenter", {0, YPosWeaponType - 120}, weapon_Type_Count.name, {{"HMD_AIM7_Launch_Mode"}}, AIM7_Mode)
add_X_Over("HMD_AA_Weapon_type_X", 86, 30, {0, YPosWeaponType - 85}, nil, {{"HMD_AA_Show_X"}})

--------------------------------------------------- AIM-9 Sidewinder ---------------------------------------------------
local ASEsegments = 12
local ASE_circle_segLen = math.pi * 2 / 18
local ASE_circle_gapLen = math.pi * 2 / 36

local AIM9FOVCircleRadius = DegToDI(4.0) / 2
local AIM9TrackCircleRadius = DegToDI(1.5) / 2 --35

local aim9ShpiPosition = addPlaceholder("HMD_Aim9ShpiPosition", {0, 0}, hmd_waterline_origin.name, {{"HMD_AA_AIM9_SeekerPos", RadToDI()}})
addStrokeCircle("HMD_AIM9_Track_Circle", AIM9TrackCircleRadius, {0, 0}, aim9ShpiPosition.name, {{"HMD_AA_AIM9_Track_Circle"}})
addStrokeCircle("HMD_AIM9_FOV_Circle",	 AIM9FOVCircleRadius,	{0, 0}, aim9ShpiPosition.name, {{"HMD_AA_AIM9_FOV_Circle"}})
-----------------------------------------------------------------------------------------------------------------------------

--NIRD
local AseCircleRadius = 144 --DegToDI(3.0)

local HMD_ASE_locked = addStrokeCircle("HMD_Ase_Circle_Locked", AseCircleRadius, {0, 0}, hmd_waterline_origin.name, {{"HMD_ASE_Circle", 2}})
addStrokeCircle("HMD_Ase_Circle_Locked_Arc", AseCircleRadius - 2, {0, 0}, HMD_ASE_locked.name, {{"HMD_Range_Arc"}}, {math.pi /2, -125/180 * math.pi})

local HMD_ASE_RangeTabStartPH = addPlaceholder("HMD_ASE_Range_Tab_Start_Line_Root", {0, 0}, HMD_ASE_locked.name)
addStrokeLine("HMD_ASE_Range_Tab_Start_Line", 10, {0, AseCircleRadius}, 180, HMD_ASE_RangeTabStartPH.name)

local HMD_ASE_MaxGunRangePH = addPlaceholder("HMD_ASE_MaxGun_Range", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_MaxGun_Range"}})
addStrokeLine("HMD_ASE_MaxGun_Range_Mark", 10, {0, AseCircleRadius}, 0, HMD_ASE_MaxGunRangePH.name)

local HMD_ASE_TgtRangePH = addPlaceholder("HMD_ASE_Tgt_Range", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_TGT_Range"}})
addStrokeLine("HMD_ASE_TGT_Range_Tab_Line", 10, {0, AseCircleRadius}, 180, HMD_ASE_TgtRangePH.name)

local HMD_ASE_RMinPH = addPlaceholder("HMD_ASE_R_min", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_R_min"}})
addStrokeSymbol("HMD_ASE_R_min_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, HMD_ASE_RMinPH.name)

local HMD_ASE_RNEPH = addPlaceholder("HMD_ASE_RNE", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_RNE"}})
addStrokeSymbol("HMD_ASE_RNE_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, HMD_ASE_RNEPH.name)

local HMD_ASE_RMaxPH = addPlaceholder("HMD_ASE_R_Max", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_R_Max"}})
addStrokeSymbol("HMD_ASE_R_Max_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, HMD_ASE_RMaxPH.name)

local HMD_ASE_RAeroPH = addPlaceholder("HMD_ASE_R_Aero", {0, 0}, HMD_ASE_locked.name, {{"HMD_ASE_R_Aero"}})
local box = addStrokeBox("HMD_ASE_R_Aero_Mark", 13, 13, "CenterCenter", {0, AseCircleRadius + 10}, HMD_ASE_RAeroPH.name)
box.init_rot = {45}

-- A/A target Aspect Cue
addArrow("HMD_AA_TargetAspectCue", 40, 10, 70, AseCircleRadius, nil, nil, HMD_ASE_locked.name, {{"HMD_AA_TargetAspectCue"}})

--------------------------------------------------- AIM-7 Sparrow ---------------------------------------------------
local AIM7SeekerCircleRadius = DegToDI(12) / 2
addStrokeCircle("HMD_AIM7_Circle", AIM7SeekerCircleRadius, {0, 0}, hmd_waterline_origin.name, {{"HMD_AA_AIM7_FOV"}})
---------------------------------------------------------------------------------------------------------------------

--------------------------------------------------- AIM-120 AMRAAM ---------------------------------------------------
local AIM120SeekerCircleRadius = DegToDI(15) / 2
addStrokeCircle("HMD_AIM120_Circle_Dashed", AIM120SeekerCircleRadius, {0, 0}, hmd_waterline_origin.name, {{"HMD_AA_AIM120_FOV"}}, nil, ASE_circle_segLen, ASE_circle_gapLen, true)

-- RADAR
-- BST circle (dashed)
local HMD_RDR_boresight_radius = DegToDI(3.3) / 2 -- 3.3 degrees diameter
-- 45 segments
local HMD_RDR_boresight_gapLen = math.rad(4)
local HMD_RDR_boresight_segLen = math.rad(4)
addStrokeCircle("HMD_Radar_boresight_circle", HMD_RDR_boresight_radius, {0, 0}, hmd_dacPosition.name, {{"HMD_AA_RDR_ACM_FOV", 4, RadToDI()}}, nil, HMD_RDR_boresight_segLen, HMD_RDR_boresight_gapLen, true)

-- Up-look reticles
local HMD_retLineLength = MilToDI(8)
local HMD_retLinePos	= MilToDI(3)
local HMD_retdAngle	= 90
local HMD_retdAngleRad	= math.rad(HMD_retdAngle)
local HMD_retPosY = RadToDI(math.tan(math.rad(30.0)))

local function addUplookReticle(retID)
	local HMD_retPosX = RadToDI(math.tan(math.rad(27.5 * (62.0/55.0))))		-- magic coefficient to match angular position by V.Timoshenko aka cofcorpse
	if retID == 1 then		-- left
		HMD_retPosX = -HMD_retPosX
	end
	local HMD_retPlaceholder = addPlaceholder("HMD_RetPH_"..retID, {HMD_retPosX, HMD_retPosY}, nil, {{"HMD_Uplook_Reticle", retID}})
	for i = 0, 3 do
		addStrokeLineLeveled("HMD_AIMING_CROSS_"..retID..i, HMD_retLineLength, {HMD_retLinePos * math.sin(HMD_retdAngleRad * i), HMD_retLinePos * math.cos(HMD_retdAngleRad * i)},
			-HMD_retdAngle * i, HMD_retPlaceholder.name)
	end
end

addUplookReticle(1)		-- left
addUplookReticle(2)		-- right