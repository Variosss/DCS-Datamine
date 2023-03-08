dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")

local segmentsPerFOVCircle = 64
local FOV_circle_segLen = math.pi * 2 / segmentsPerFOVCircle
local FOV_circle_gapLen = math.pi * 2 / segmentsPerFOVCircle

-- Radar FOVs

-- VACQ lines
local VACQ_line_posX     = DegToDI(5.2 * 0.5) -- 5.2 degrees apart
local VACQ_line_posY     = HUD_TFOV_DI * math.cos(VACQ_line_posX / HUD_TFOV_DI) -- the line beginning is set at the edge of the 20 degrees HUD Total FOV
local VACQ_line_len      = VACQ_line_posY * 2 -- straight up to the edge of the HUD TFOV
local VACQ_line_stroke   = 40
local VACQ_line_gap      = 15

local VACQ_lines_root 	 = addPlaceholder("AA_VACQ_lines_placeholder", nil, nil, {{"HUD_AA_RDR_ACM_FOV", 3}})
local VACQ_line_left     =
	addStrokeLine("VACQ_radar_coverate_left_line", VACQ_line_len, {-VACQ_line_posX, -VACQ_line_posY}, 0, VACQ_lines_root.name, nil, true, VACQ_line_stroke, VACQ_line_gap)
local VACQ_line_right    = Copy(VACQ_line_left)
VACQ_line_right.name     = "VACQ_radar_coverate_right_line"
VACQ_line_right.init_pos = {VACQ_line_posX, -VACQ_line_posY}
Add(VACQ_line_right)

-- GACQ circle (dashed)
local GACQ_radius = DegToDI(20) / 2 -- 20 degrees diameter
local GACQ_circle = addStrokeCircle("GACQ_20deg_circle", GACQ_radius, {0, 0}, nil, {{"HUD_AA_RDR_ACM_FOV", 2}}, nil, FOV_circle_segLen, FOV_circle_gapLen, true)
GACQ_circle.init_rot = {math.deg(FOV_circle_segLen / 2)}

-- BST circle (dashed)
local RDR_boresight_radius = DegToDI(3.3) / 2 -- 3.3 degrees diameter
-- 45 segments
local RDR_boresight_gapLen = math.rad(4)
local RDR_boresight_segLen = math.rad(4)
addStrokeCircle("Radar_boresight_circle", RDR_boresight_radius, {0, waterlineShiftY}, nil, {{"HUD_AA_RDR_ACM_FOV", 1}}, nil, RDR_boresight_segLen, RDR_boresight_gapLen, true)

-- WACQ box and grid
-- TODO: round DIs
local WACQ_gridBoxDegToDI = 1.7 -- DIs per radar scan zone degree

local function WACQ_sz(szDeg)
	return szDeg * WACQ_gridBoxDegToDI
end

-- TODO: correct position
local WACQ_gridBoxPosX = 250
local WACQ_gridBoxPosY = -230
local WACQ_gridBoxPlaceholder = addPlaceholder("AA_WACQ_gridBoxPlaceholder", {WACQ_gridBoxPosX, WACQ_gridBoxPosY}, parent, {{"HUD_AA_RDR_WACQ_GridBoxVisibleState"}, {"HUD_AA_RDR_WACQ_GridBoxRollStabilize"}})
-- WACQ box (radar FOV)
addStrokeBox("AA_WACQ_box", WACQ_sz(60), WACQ_sz(15), nil, nil, WACQ_gridBoxPlaceholder.name, {{"HUD_AA_RDR_WACQ_BoxPos", WACQ_gridBoxDegToDI}})

-- WACQ grid
local WACQ_gridLineLenX = 140
local WACQ_gridLineLenY = 140
local WACQ_gridPlaceholder = addPlaceholder("AA_WACQ_gridPlaceholder", nil, WACQ_gridBoxPlaceholder.name, {{"HUD_AA_RDR_WACQ_GridShow", 2}})
addStrokeLine("AA_WACQ_gridLineX", WACQ_sz(WACQ_gridLineLenX), {WACQ_sz(WACQ_gridLineLenX / 2), 0}, 90, WACQ_gridPlaceholder.name)
addStrokeLine("AA_WACQ_gridLineY", WACQ_sz(WACQ_gridLineLenY), {0, WACQ_sz(-WACQ_gridLineLenY / 2)}, nil, WACQ_gridPlaceholder.name)

-- WACQ grid - arrow at Y axis end
local WACQ_gridArrowSide = WACQ_sz(8)
local WACQ_gridArrowAngle = 60
local WACQ_gridArrowLineRot = 180 - WACQ_gridArrowAngle / 2
addStrokeLine("AA_WACQ_gridLineArrPieceLeft", WACQ_gridArrowSide, {0, WACQ_sz(WACQ_gridLineLenY / 2)}, WACQ_gridArrowLineRot, WACQ_gridPlaceholder.name)
addStrokeLine("AA_WACQ_gridLineArrPieceRight", WACQ_gridArrowSide, {0, WACQ_sz(WACQ_gridLineLenY / 2)}, -WACQ_gridArrowLineRot, WACQ_gridPlaceholder.name)

-- WACQ grid - 14 and 27 degrees ticks
local WACQ_gridTickLen = WACQ_sz(10)
local WACQ_grid_1st_tickPlace = WACQ_sz(14)
local WACQ_grid_2nd_tickPlace = WACQ_sz(13)
for i = 0, 1 do
	local tickOffset = WACQ_grid_1st_tickPlace + WACQ_grid_2nd_tickPlace * i
	
	local function addTick(name, sign)
		addStrokeLine(name, WACQ_gridTickLen, {WACQ_gridTickLen / 2, tickOffset * sign}, 90, WACQ_gridPlaceholder.name)
	end
	
	addTick("AA_WACQ_gridLineY_tickUpper_"..tickOffset, 1)
	addTick("AA_WACQ_gridLineY_tickLower_"..tickOffset, -1)
end


-- Weapons FOVs

-- AIM-7 (solid, 12 degrees)
local AIM7_FOV_radius = DegToDI(12) / 2 -- 12 degrees diameter
addStrokeCircle("AIM7_FOV_12deg_circle", AIM7_FOV_radius, {0, waterlineShiftY}, nil, {{"HUD_AA_AIM7_FOV_CircleShow"}}, nil, FOV_circle_segLen)

-- AIM-120 (dashed, 15 degrees)
local AIM120_FOV_radius = DegToDI(15) / 2 -- 15 degrees diameter
-- 19 segments
local AIM120_FOV_circle_gapLen = math.rad(5)
local AIM120_FOV_circle_segLen = math.rad(14)
addStrokeCircle("AIM120_FOV_15deg_circle", AIM120_FOV_radius, {0, waterlineShiftY}, nil, {{"HUD_AA_AIM120_FOV_CircleShow"}}, nil, AIM120_FOV_circle_segLen, AIM120_FOV_circle_gapLen, true)


-------------------------------------------------------- Gun -----------------------------------------------------------
local AA_gunRoot = addPlaceholder("AA_Gun_Root")
local AA_gunRootRdrNoTrack = addPlaceholder("AA_gunRootRdrNoTrack", nil, AA_gunRoot.name, {{"HUD_AA_Gun_Kind", 1}})

addGunCross("AA_GunCross", {0, AA_GunCrossPos_Y}, AA_gunRoot.name, {{"HUD_AA_Gun_Show"}})

-- A/A Gun funnel - radar not tracking mode
for i = 1, 6 do
	for j = 1, 2 do
		local nameSuffix
		if j == 1 then
			nameSuffix = "_left"
		else
			nameSuffix = "_right"
		end
		
		line = addVarLenStrokeLine("funnel_"..i..nameSuffix, nil, nil, nil, AA_gunRootRdrNoTrack.name, {{"HUD_AA_FunnelLine", i, j}})
	end
end

-- funnel 1000 ft point
addDot("funnel_1000ft_point", 1.5, nil, AA_gunRootRdrNoTrack.name, {{"HUD_AA_Funnel_1000_2000_ft_point", 0}})
-- funnel 2000 ft point
addDot("funnel_2000ft_point", 1.5, nil, AA_gunRootRdrNoTrack.name, {{"HUD_AA_Funnel_1000_2000_ft_point", 1}})

for i = 0, 15 do
	addDot("FEDS_dot" .. string.format("%i", i+1), 1.5, nil, AA_gunRootRdrNoTrack.name, {{"HUD_AA_FEDS_dot", i}})
end

-- A/A Gun reticle - radar tracking mode
local AA_gunRootRdrTrack = addPlaceholder("AA_gunRootRdrTrack", nil, AA_gunRoot.name, {{"HUD_AA_Gun_Kind", 2}, {"HUD_AA_GunReticlePos"}})
local AA_gunRootRdrTrackReticle = addPlaceholder("AA_gunRootRdrTrackReticle", nil, AA_gunRootRdrTrack.name, {{"HUD_AA_GunReticleFlash"}})
addStrokeCircle("AA_GunRtclRdrTrack", gunRktReticleRadius, nil, AA_gunRootRdrTrackReticle.name)
-- A/A Gun pipper - 1 mil (3 mils per the manual do not look correct)
addDot("AA_GunRtcl_Pipper", MilToDI(0.5), nil, AA_gunRootRdrTrackReticle.name)
-- SHOOT cue over A/A gun reticle
addStrokeText("AA_GunRtcl_SHOOT_cue", "SHOOT", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, gunRktReticleRadius + 5}, AA_gunRootRdrTrack.name, {{"HUD_RDR_SHOOT_IN_LAR_cue", 2, 0}})
-- IN LAR cue over A/A gun reticle
addStrokeText("AA_GunRtcl_IN_LAR_cue", "IN LAR", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, gunRktReticleRadius + 5}, AA_gunRootRdrTrack.name, {{"HUD_RDR_SHOOT_IN_LAR_cue", 2, 1}})

-- All range symbols are rendered by double thickness lines (i.e. rendered twice with a small gap)
local stub_len = 1
local AA_GunRtcl_Range_tick_controller     = {{"HUD_AA_GunReticleRange", 12000, 12000}}
local AA_GunRtcl_Range_arc_mask_controller = {{"HUD_AA_GunReticleRange", 12000, 12000, 0.5}}
local AA_GunRtcl_Range_arc_main_controller = {{"HUD_AA_GunReticleRange", 12000, 12000}}
local AA_GunRtcl_MaxRange_tick_controller  = {{"HUD_AA_GunReticleRMax",  12000, 12000}}

for i = 1, 2 do
	local rootName = AA_gunRootRdrTrackReticle.name
	local deltaPosOrRadius
	local tickNameSufx
	local arcNameSufx
	if i == 1 then
		deltaPosOrRadius = -1
		tickNameSufx   = "left"
		arcNameSufx    = "inner"
	else
		deltaPosOrRadius = 1
		tickNameSufx   = "right"
		arcNameSufx    = "outer"
	end
	
	-- Current range tick
	local tickIndices = {0, 1}
	local AA_GunRtcl_Range_tick    	  = addStrokeLine("AA_GunRtcl_Range_tick_"..tickNameSufx, stub_len, {deltaPosOrRadius, 0}, 0, rootName, AA_GunRtcl_Range_tick_controller)
	AA_GunRtcl_Range_tick.vertices 	  = {{0, gunRktReticleRadius}, {0, gunRktReticleRadius - gunRktReticleRangeTickLen}}
	AA_GunRtcl_Range_tick.indices  	  = tickIndices

	-- Current range arc
	addStrokeVarArc("AA_GunRtcl_range_arc_"..arcNameSufx, gunRktReticleRadius + deltaPosOrRadius, 0, nil, rootName, AA_GunRtcl_Range_arc_mask_controller,
		AA_GunRtcl_Range_arc_main_controller, 0)

	-- Max range tick
	local AA_GunRtcl_MaxRange_tick    = addStrokeLine("AA_GunRtcl_MaxRange_tick_"..tickNameSufx, stub_len, {deltaPosOrRadius, 0}, 0, rootName, AA_GunRtcl_MaxRange_tick_controller)
	AA_GunRtcl_MaxRange_tick.vertices = {{0, gunRktReticleRadius}, {0, gunRktReticleRadius + gunRktReticleRangeTickLen}}
	AA_GunRtcl_MaxRange_tick.indices  = tickIndices
end

local AA_gunForesightVertTickLen = 8
local AA_gunForesight_1g_HorTickLen = AA_gunForesightVertTickLen
local AA_gunForesight_1g_HorGapLen = 25

local AA_gunForesight_1g_root = addPlaceholder("AA_gunForesight_1g_root", nil, nil, {{"HUD_AA_Gun_Kind", 2}, {"HUD_AA_GunForesightFlash"}, {"HUD_AA_GunForesight_1g_Pos"}})
-- 1g pipper
addStrokeLine("AA_gunForesight_1g_vertTick", AA_gunForesightVertTickLen, {0, -AA_gunForesightVertTickLen / 2}, 0, AA_gunForesight_1g_root.name)
addStrokeLine("AA_gunForesight_1g_HorTick", AA_gunForesight_1g_HorTickLen, {AA_gunForesight_1g_HorTickLen / 2, 0}, 90, AA_gunForesight_1g_root.name)

-- 1g pipper - 9g out-of-plane maneuver potential line
local potentialLineShiftX = AA_gunForesight_1g_HorTickLen / 2 + AA_gunForesight_1g_HorGapLen
addVarLenStrokeLine("AA_gunForesight_9g_PotentialLeft", 100, {-potentialLineShiftX, 0}, 90, AA_gunForesight_1g_root.name, {{"HUD_AA_GunForesight_9g_potential"}})
addVarLenStrokeLine("AA_gunForesight_9g_PotentialRight", 100, {potentialLineShiftX, 0}, -90, AA_gunForesight_1g_root.name, {{"HUD_AA_GunForesight_9g_potential"}})

local AA_gunForesight_9g_root = addPlaceholder("AA_gunForesight_9g_root", nil, AA_gunForesight_1g_root.name, {{"HUD_AA_GunForesight_9g_shift"}})
-- 9g pipper
addStrokeLine("AA_gunForesight_9g_vertTick", AA_gunForesightVertTickLen, {0, -AA_gunForesightVertTickLen / 2}, 0, AA_gunForesight_9g_root.name)
-- 9g pipper - 9g out-of-plane maneuver potential line (short)
addVarLenStrokeLine("AA_gunForesight_9g_PotentialShort", 100, nil, 90, AA_gunForesight_9g_root.name, {{"HUD_AA_GunForesight_potential_short"}})

addStrokeCircle("Gun_Batr_Cue", 12, nil, AA_gunRoot.name, {{"HUD_AA_Gun_BATR_cue"}})

-- TODO: to make position common with other AA weapon types
-- NOTE: docs say about 200% font, but it does look rather like 150% font on videos
addStrokeText("GUN_AA_label", "GUN", STROKE_FNT_DFLT_150, "CenterCenter", {0, -205}, AA_gunRoot.name, {{"HUD_AA_Gun_Show"}})
addStrokeText("GUN_AA_Round_Data", nil, STROKE_FNT_DFLT_150, "RightCenter", {34, -240}, AA_gunRoot.name, {{"HUD_AA_Gun_Show"}, {"HUD_AA_GunDataRound"}})

add_X_Over("AA_Gun_X", 86, 30, {0, -205}, AA_gunRoot.name, {{"HUD_AA_Show_X"}})

--------------------------------------------------- AIM-9 Sidewinder ---------------------------------------------------

local ASEsegments = 12
local ASE_circle_segLen = math.pi * 2 / 18
local ASE_circle_gapLen = math.pi * 2 / 36

local SidewinderRootName = "AIM9_Sidewinder_Root"
local AIM9FOVCircleRadius = DegToDI(4.0) / 2
local AIM9SeekerCircleRadius = DegToDI(1.5) / 2 --35
local AseCircleRadius = DegToDI(3.0)
-- TODO: to rename the "HUD_AA_AIM9_Search_Circle" controller
addStrokeCircle("AIM9_AIM9_Seeker_Circle", AIM9SeekerCircleRadius,  {0, 0}, nil, {{"HUD_AA_AIM9_Search_Circle"}, {"HUD_AA_SidewinderSeekerPos"}})
-- TODO: correct sizes and positions for this symbology
addPlaceholder(SidewinderRootName, {0, 0}, waterline_origin.name, {{"HUD_AA_AIM9_Search_Circle"}})
--addStrokeCircle("AIM9_FOV_Circle", AIM9FOVCircleRadius, {0, 0}, SidewinderRootName, {{"HUD_AA_SidewinderFOV"}})
--addStrokeCircle("AIM9_Ase_Circle_Dashed", AseCircleRadius - 2, {0, 0}, SidewinderRootName, {{"Ase_Circle", 1}}, nil, ASE_circle_segLen, ASE_circle_gapLen, true)

--NIRD
local ASE_locked = addStrokeCircle("Ase_Circle_Locked", AseCircleRadius, {0, 0}, waterline_origin.name, {{"Ase_Circle", 2}})
addStrokeCircle("Ase_Circle_Locked_Arc", AseCircleRadius - 2, {0, 0}, "Ase_Circle_Locked", {{"Range_Arc"}}, {math.pi /2, -125/180 * math.pi})

addPlaceholder("ASE_Range_Tab_Start_Line_Root", {0, 0}, ASE_locked.name, {{"ASE_Range_Tab"}})
addStrokeLine("ASE_Range_Tab_Start_Line", 10, {0, AseCircleRadius}, 180, "ASE_Range_Tab_Start_Line_Root")

local ASE_MaxGunRange = addPlaceholder("ASE_MaxGun_Range", {0, 0}, ASE_locked.name, {{"ASE_MaxGun_Range"}})
addStrokeLine("ASE_MaxGun_Range_Mark", 20, {0, AseCircleRadius}, 0, "ASE_MaxGun_Range")

local ASE_TgtRange = addPlaceholder("ASE_Tgt_Range", {0, 0}, ASE_locked.name, {{"ASE_TGT_Range"}})
addStrokeLine("ASE_TGT_Range_Tab_Line", 20, {0, AseCircleRadius}, 180, "ASE_Tgt_Range")

local ASE_RMinPH = addPlaceholder("ASE_R_min", {0, 0}, ASE_locked.name, {{"ASE_R_min"}})
addStrokeSymbol("ASE_R_min_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, "ASE_R_min")

local ASE_RNEPH = addPlaceholder("ASE_RNE", {0, 0}, ASE_locked.name, {{"ASE_RNE"}})
addStrokeSymbol("ASE_RNE_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, "ASE_RNE")

local ASE_RMaxPH = addPlaceholder("ASE_R_Max", {0, 0}, ASE_locked.name, {{"ASE_R_Max"}})
addStrokeSymbol("ASE_R_Max_Mark", {"stroke_symbols_HUD", "137-triangle"}, "FromSet", {0, AseCircleRadius + 7}, "ASE_R_Max")

local ASE_RAeroPH = addPlaceholder("ASE_R_Aero", {0, 0}, ASE_locked.name, {{"ASE_R_Aero"}})
local box = addStrokeBox("ASE_R_Aero_Mark", 13, 13, "CenterCenter", {0, AseCircleRadius + 10}, "ASE_R_Aero")
box.init_rot = {45}

-- A/A target Aspect Cue
addArrow("HUD_AA_TargetAspectCue", 40, 10, 70, AseCircleRadius, nil, nil, ASE_locked.name, {{"HUD_AA_TargetAspectCue"}})

-- A/A Steering Dot
addSteeringDot("SteeringDot", nil, waterline_origin.name, {{"Steering_Dot_Pos", 0}})

local YPosWeaponType = -260

-- temporarily commented

--addPlaceholder("AIM9_Range_Tab_Circle_Root", {0, 140}, nil, {{"HideElement"}})
--addStrokeArcWithMask("AIM9_Range_Tab_Circle_R", AseCircleRadius - 2, 180, 0, {0, 0}, "AIM9_Range_Tab_Circle_Root")
--addStrokeArcWithMask("AIM9_Range_Tab_Circle_L", AseCircleRadius - 2, 180, 180, {0, 0}, "AIM9_Range_Tab_Circle_Root")
-----------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------- AIM-7 Sparrow ---------------------------------------------------
local SparrowRootName = "AIM7_Root"
local AIM7SeekerCircleRadius = DegToDI(12) / 2
addPlaceholder(SparrowRootName, {0, 0}, waterline_origin.name, {{"HUD_AA_AIM7_Search_Circle"}})
addStrokeCircle("AIM7_Seeker_Circle", AIM7SeekerCircleRadius, {0, 0}, SparrowRootName)
---------------------------------------------------------------------------------------------------------------------

--------------------------------------------------- AIM-120 AMRAAM ---------------------------------------------------
local AIM120RootName = "AIM120_Root"
local AIM120SeekerCircleRadius = DegToDI(15) / 2
addPlaceholder(AIM120RootName, {0, 0}, waterline_origin.name, {{"HUD_AA_AIM120_Search_Circle"}})
addStrokeCircle("AIM120_Ase_Circle_Dashed", AIM120SeekerCircleRadius, {0, 0}, AIM120RootName, {}, nil, ASE_circle_segLen, ASE_circle_gapLen, true)

addStrokeText("AIM120_VISUAL", "VISUAL", STROKE_FNT_DFLT_150, "CenterCenter", {0, -240}, nil, {{"HUD_AA_AIM120_Search_Circle"}})
---------------------------------------------------------------------------------------------------------------------

-- TODO: to make position common with GUN+count
-- NOTE: docs say about 200% font, but it does look rather like 150% font on videos
addPlaceholder("AA_Weapon_Count", {0, 140}, nil, {{"HUD_AA_Show_Weapon_Count"}})
addStrokeText("AA_Weapon_type", nil, STROKE_FNT_DFLT_150, "RightCenter", {0, YPosWeaponType - 85}, "AA_Weapon_Count", {{"HUD_AA_WeaponType"}})
addStrokeText("AA_Weapon_count", nil, STROKE_FNT_DFLT_150, "CenterCenter", {33, YPosWeaponType - 85}, "AA_Weapon_Count", {{"HUD_AA_WeaponCount"}})

local AIM7_Mode = {
"LOFT",
"NORM",
"HELO",
"HOJ"
}
addStrokeText("AIM7_LAUNCH_MODE", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, YPosWeaponType - 125}, "AA_Weapon_Count", {{"HUD_AIM7_Launch_Mode"}}, AIM7_Mode)

--------------------------------------------------------------------------------------------------------
--TOF TTG

local AA_MSL_Mode = {
"",
"TTG",
"ACT",
"SL",
"LOST",
}
addStrokeText("TOF_TTG_VAL", nil, stringdefs_HUD_norm_120, "RightCenter", {200, -112}, nil, {{"TOF_TTG_Val", 1, 0}})
addStrokeText("AA_MSL_label", nil, stringdefs_HUD_norm_120, "LeftCenter", {5, 0}, "TOF_TTG_VAL", {{"AA_MSL_MODE", 1, 0}}, AA_MSL_Mode)

