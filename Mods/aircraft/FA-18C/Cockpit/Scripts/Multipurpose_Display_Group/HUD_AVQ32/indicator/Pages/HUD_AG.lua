dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")

-------------------------------------------------------- Gun/Rocket Sight ----------------------------------------------
local gunRktSightRootName = "GunRktSightRoot"
addPlaceholder(gunRktSightRootName, nil, nil, {{"HUD_AG_reticlePos"}})

-- A/G Gun/Rockets pipper - 1 mil
addDot("GunRkt_Pipper", MilToDI(0.5), nil, gunRktSightRootName)

for i = 0, 11 do
	local posAngle = math.rad(i * 30)
	addStrokeLine("GunRkt_tick"..i * 30, gunRktReticleTickLen, {gunRktReticleRadius * math.sin(posAngle), gunRktReticleRadius * math.cos(posAngle)}, i * -30, gunRktSightRootName)
end

-- All range symbols are rendered by double thickness lines (i.e. rendered twice with a small gap)
local stub_len = 1
local GunRkt_Range_tick_controller     = {{"HUD_AG_reticleRange", 23000, 12000}}
local GunRkt_Range_arc_mask_controller = {{"HUD_AG_reticleRange", 12000, 12000, 0.5}}
local GunRkt_Range_arc_main_controller = {{"HUD_AG_reticleRange", 12000, 12000}}
local GunRkt_MaxRange_tick_controller  = {{"HUD_AG_reticleRMax", 23000, 12000}}

for i = 1, 2 do
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
	local GunRkt_Range_tick            = addStrokeLine("GunRkt_Range_tick_"..tickNameSufx, stub_len, {deltaPosOrRadius, 0}, 0, gunRktSightRootName, GunRkt_Range_tick_controller)
	GunRkt_Range_tick.vertices         = {{0, gunRktReticleRadius}, {0, gunRktReticleRadius - gunRktReticleRangeTickLen}}
	GunRkt_Range_tick.indices          = tickIndices

	-- Current range arc
	addStrokeVarArc("GunRkt_range_arc_"..arcNameSufx, gunRktReticleRadius + deltaPosOrRadius, 0, nil, gunRktSightRootName, GunRkt_Range_arc_mask_controller,
		GunRkt_Range_arc_main_controller, 0)

	-- Max range tick
	local GunRkt_MaxRange_tick  	  = addStrokeLine("GunRkt_MaxRange_tick_"..tickNameSufx, stub_len, {deltaPosOrRadius, 0}, 0, gunRktSightRootName, GunRkt_MaxRange_tick_controller)
	GunRkt_MaxRange_tick.vertices     = {{0, gunRktReticleRadius}, {0, gunRktReticleRadius + gunRktReticleRangeTickLen}}
	GunRkt_MaxRange_tick.indices      = tickIndices
end


local IN_RNG_SHOOT_pos_Y = gunRktReticleRadius + 10
addStrokeText("GunRkt_IN_RNG_cue", "IN RNG", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, IN_RNG_SHOOT_pos_Y}, gunRktSightRootName, {{"HUD_AG_reticle_IN_RNG_SHOOT_cue", 1}})
addStrokeText("GunRkt_SHOOT_cue", "SHOOT", STROKE_FNT_DFLT_120_WIDE, "CenterBottom", {0, IN_RNG_SHOOT_pos_Y}, gunRktSightRootName, {{"HUD_AG_reticle_IN_RNG_SHOOT_cue", 2}})

-- 4 dergees from the HUD optical ceter, plus 2 degrees of gun installation angle, minus fixed slant range (3000 ft) depression (15 mils)
local HotGunPos_Y = waterlineShiftY + DegToDI(2) - MilToDI(15)
addGunCross("AG_HotGunCross", {0, HotGunPos_Y}, nil, {{"HUD_AG_HotGunCross_Show"}})

------------------------------------------------------------------------------------------------------------------------
addStrokeSymbol("AG_PullupCue", {"stroke_symbols_HUD", "144-Pullup-Cue"}, "FromSet", {0, 0}, nil, {{"HUD_AG_PullupCue"}})

-- TAS

local openingTDMask = openMaskArea(0, "TDArea", {}, {}, nil, nil, {{"HUD_DesignatedWaypointMarkerShow"}})
set_box_w_h(openingTDMask, 41, 41)

-- Bombs
addStrokeText("Bombs_AUTO_Mode_Altitude_Source", nil, STROKE_FNT_DFLT_120_WIDE, "CenterCenter", {226, 145}, nil, {{"HUD_AG_Bombs_AUTO_AltitudeSource"}})
--AUTO mode
addPlaceholder("Bombs_AUTO_Mode_PH", {0, 0}, nil, {{"HUD_AG_Bombs_AUTO_Root"}})

local DashedLength = 35	--TODO correct length
addVarLenStrokeLine("Bombs_AUTO_Mode_DIL", nil, nil, nil, "GunRktSightRoot", {{"HUD_AG_Bombs_AUTO_DIL"}}, true, DashedLength, DashedLength)
addPlaceholder("Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {0, 0}, "Bombs_AUTO_Mode_PH", {{"HUD_AG_Bombs_AUTO_AzimuthSteringLine"}})
addStrokeLine("Bombs_AUTO_Mode_AzimuthSteeringLine_Up", 1000, {0, 0}, 0, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_Bombs_AUTO_ASL_Dashed", 0}})
addStrokeLine("Bombs_AUTO_Mode_AzimuthSteeringLine_Down", 1000, {0, 0}, 180, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_Bombs_AUTO_ASL_Dashed", 0}})
local ReleaseCueLen = 150
addStrokeLine("Bombs_AUTO_Mode_Release_Cue", ReleaseCueLen, {-ReleaseCueLen / 2, 0}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_Up", {{"HUD_AG_Bombs_AUTO_ReleaseCue", 200}})

addStrokeLine("Bombs_AUTO_Mode_AzimuthSteeringLine_Up_Dashed", 1000, {0, -DashedLength/2.0}, 0, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_Bombs_AUTO_ASL_Dashed", 1}}, true, DashedLength, DashedLength)
addStrokeLine("Bombs_AUTO_Mode_AzimuthSteeringLine_Down_Dashed", 1000, {0, DashedLength/2.0}, 180, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_Bombs_AUTO_ASL_Dashed", 1}}, true, DashedLength, DashedLength)

closeMaskArea(1, "TDAreaClose", openingTDMask.vertices, openingTDMask.indices, openingTDMask.init_pos, nil, {{"HUD_DesignatedWaypointMarkerShow"}})

addSteeringDot("GBU24_DLZ_POS_Circle", {0, 126}, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue", 250}})
addStrokeLine("GBU24_DLZ_Min_Cue", 70, {-35, 125}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})
addStrokeLine("GBU24_DLZ_Min_Cue1", 70, {-35, 127}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})
addStrokeLine("GBU24_DLZ_Min_Cue2", 70, {-35, 129}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})

addStrokeLine("GBU24_DLZ_Max_Cue", 40, {-20, -125}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})
addStrokeLine("GBU24_DLZ_Max_Cue1", 40, {-20, -127}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})
addStrokeLine("GBU24_DLZ_Max_Cue2", 40, {-20, -129}, -90, "Bombs_AUTO_Mode_AzimuthSteeringLine_PH", {{"HUD_AG_GBU24_DLZ_Cue"}})


addPlaceholder("GBU24_CROSS_RNG1", {0, 330}, nil, {{"HUD_AG_GBU24_CROSS_RNG_Cue", 1, 2.8}})
addStrokeLine("GBU24_CROSS_RNG1_1", 30, {0, 0}, 0, "GBU24_CROSS_RNG1")
addStrokeLine("GBU24_CROSS_RNG1_2", 21, {0, 0}, -45, "GBU24_CROSS_RNG1")
addStrokeLine("GBU24_CROSS_RNG1_3", 21, {0, 30}, -135, "GBU24_CROSS_RNG1")

addPlaceholder("GBU24_CROSS_RNG2", {0, 330}, nil, {{"HUD_AG_GBU24_CROSS_RNG_Cue", 0, 2.8}})
addStrokeLine("GBU24_CROSS_RNG2_1", 30, {0, 0}, 0, "GBU24_CROSS_RNG2")
addStrokeLine("GBU24_CROSS_RNG2_2", 21, {0, 0}, 45, "GBU24_CROSS_RNG2")
addStrokeLine("GBU24_CROSS_RNG2_3", 21, {0, 30}, 135, "GBU24_CROSS_RNG2")


--CCIP mode
addPlaceholder("Bombs_CCIP_Mode_PH", {0, 0}, nil, {{"HUD_AG_Bombs_CCIP_Root"}})
addStrokeSymbol("AG_CCIP_Cross", {"stroke_symbols_HUD", "132-AG-CCIP-Cross"}, "FromSet", {0, 0}, "Bombs_CCIP_Mode_PH", {{"HUD_AG_Bombs_CCIP_Cross"}})
addPlaceholder("Bombs_CCIP_PH_DIL_TTG", {0, 0}, "Bombs_CCIP_Mode_PH", {{"HUD_AG_Bombs_CCIP_Root_DIL_TTG", -15}})
addVarLenStrokeLine("AG_DIL_CCIP", nil, nil, nil, "Bombs_CCIP_PH_DIL_TTG", {{"HUD_AG_Bombs_CCIP_DIL"}})
addStrokeSymbol("AG_CCIP_Time_To_Go_Cue", {"stroke_symbols_HUD", "155-Time-To-Go"}, "FromSet", {0, 0}, "Bombs_CCIP_PH_DIL_TTG", {{"HUD_AG_Bombs_CCIP_TimeToGoCue"}}, 1.5)

local rightWindowsBlockPos_X  = CAS_AltBoxEdgeX - gap_alt_hund_tenths - (fontIntercharDflt120_wide * 2 + glyphNominalWidth120 * 3)
local rightWindowsBlockPos_Y  = 70
local rightWindowsBlockStep_Y = 30
addStrokeText("DUD_Cue", "DUD", STROKE_FNT_DFLT_120_WIDE, "RightCenter", {rightWindowsBlockPos_X - 20, rightWindowsBlockPos_Y - rightWindowsBlockStep_Y * 2}, nil, {{"HUD_AG_Bombs_CCIP_DUDCue", 0}})

--MAN mode
addStrokeText("Bombs_MAN_Mode_True_Airspeed", nil, STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {-341, 100}, nil, {{"HUD_AG_Bombs_MAN_TrueAirspeed"}})

addPlaceholder("AIM65_Seeker", {0, 0}, nil, {{"HUD_AG_AGM65_Seeker"}})
addStrokeLine("AIM65_Seeker1", 50, {-25, 0}, -90, "AIM65_Seeker")
addStrokeLine("AIM65_Seeker2", 35, {-25, 0}, -135, "AIM65_Seeker")
addStrokeLine("AIM65_Seeker3", 35, {25, 0}, 135, "AIM65_Seeker")

addPlaceholder("AIM65_Seeker_AGR", {0, 0}, "AIM65_Seeker", {{"HUD_AG_AGM65_AGR_Seeker", 0}})
addStrokeLine("AIM65_Seeker1_AGR", 76, {-38, 5}, -90, "AIM65_Seeker_AGR")
addStrokeLine("AIM65_Seeker2_AGR", 54, {-38, 5}, -135, "AIM65_Seeker_AGR")
addStrokeLine("AIM65_Seeker3_AGR", 54, {38, 5}, 135, "AIM65_Seeker_AGR")

addPlaceholder("AIM65_Seeker_AGR_dashed", {0, 0}, "AIM65_Seeker", {{"HUD_AG_AGM65_AGR_Seeker", 1}})
addStrokeLine("AIM65_Seeker1_AGR_dashed", 76, {-38, 5}, -90, "AIM65_Seeker_AGR", {}, true, 20, 15)
addStrokeLine("AIM65_Seeker2_AGR_dashed", 54, {-38, 5}, -135, "AIM65_Seeker_AGR", {}, true, 20, 15)
addStrokeLine("AIM65_Seeker3_AGR_dashed", 54, {38, 5}, 135, "AIM65_Seeker_AGR", {}, true, 20, 15)

addStrokeText("IN_RNG", "IN RNG", stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_AGM65_IN_RNG", 0}})
addStrokeText("TTMR", "TTMR", stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, nil, {{"HUD_AG_AGM65_IN_RNG", 1}})
addStrokeText("TTMR_val", nil, stringdefs_HUD_norm_120, "RightCenter", {-90, 0}, "TTMR", {{"HUD_AG_AGM65_IN_RNG", 2}})

addStrokeText("HUD_JDAM_TYPE", "J-84", stringdefs_HUD_norm_120, "LeftCenter", {280, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, nil, {{"HUD_JDAM_TYPE"}})
add_X_Over("AG_JDAM_Not_Ready_X", 70, 26, {30, 0}, "HUD_JDAM_TYPE", {{"HUD_AG_JDAM_NotReadyX"}})
addStrokeText("HUD_JDAM_MISSION_MODE", "TOO", stringdefs_HUD_norm_120, "LeftCenter", {380, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, nil, {{"HUD_MISSION_TYPE"}})

local IN_RNG_ZONE = 
{
	"%d:%.2d TMR",
	"IN RNG",
	"IN ZONE",
}
addStrokeText("JDAMInRng", nil, stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_JDAM_IN_RNG", 600}}, IN_RNG_ZONE)

addStrokeText("TimeOnTarget", nil, stringdefs_HUD_norm_120, "LeftCenter", {rightWindowsBlockPos_X, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 3}, nil, {{"HUD_JDAM_TOT"}}, {"%.2d:%.2d:%.2d TOT"})

addStrokeText("DUD_Cue_JDAM", "DUD", STROKE_FNT_DFLT_120_WIDE, "RightCenter", {rightWindowsBlockPos_X - 20, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 3}, nil, {{"HUD_AG_Bombs_CCIP_DUDCue", 1}})

addStrokeText("SLAMInRng", nil, stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_SLAM_IN_RNG", 600}}, IN_RNG_ZONE)


addStrokeText("GBU24InRng", nil, stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_GBU24_IN_RNG", 600}}, IN_RNG_ZONE)
addStrokeText("GBU24TOT", nil, stringdefs_HUD_norm_120, "LeftCenter", {rightWindowsBlockPos_X, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 3}, nil, {{"HUD_GBU24_TOT"}}, {"%.2d:%.2d:%.2d TOT"})


local HARPOON_STATUS = 
{
	"IN RNG",
	"IN ZONE",
	"INV SRCH",
	"INV TGT",
	"ALT",
	"OFF AXIS",
	"HPTP ANG",
	"A/C HPTP",
	"TGT/HPTP",
	"SCH/DSTR",
	"DSTR RNG",
	"TTMR %.2d",
	
}
addStrokeText("HarpoonInRng", "IN ZONE", stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_HARPOON_STATUS", 99}}, HARPOON_STATUS)

local HARPOON_MODE = 
{
	"HP R/BL",
	"HP BOL",
}
addStrokeText("HarpoonMODE", nil, stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y}, nil, {{"HUD_AG_HARPOON_MODE"}}, HARPOON_MODE)


addStrokeText("IN_RNG_WALLEYE", "IN RNG", stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y + rightWindowsBlockStep_Y}, nil, {{"HUD_AG_WALLEYE_IN_RNG", 0}})
addStrokeText("TTMR_WALLEYE", "TTMR", stringdefs_HUD_norm_120, "RightCenter", {400, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, nil, {{"HUD_AG_WALLEYE_IN_RNG", 1}})
addStrokeText("TTMR_WALLEYE_val", nil, stringdefs_HUD_norm_120, "RightCenter", {-90, 0}, "TTMR_WALLEYE", {{"HUD_AG_WALLEYE_IN_RNG", 2}})

--HARM

local HarmAzimuthSteeringLine_placeholder = addPlaceholder("HarmAzimuthSteeringLine_PH",{0,0},nil,{{"HUD_HARM_PB_AzimuthSteeringLine_SHOW"}})
	addStrokeLine("Azimuth_Steering_Line_Top", 500, nil, 0, HarmAzimuthSteeringLine_placeholder.name)
	addStrokeLine("Azimuth_Steering_Line_Down", 500, nil, 180, HarmAzimuthSteeringLine_placeholder.name)
	addPlaceholder("AC_pullup",{0,0},HarmAzimuthSteeringLine_placeholder.name,{{"HUD_HARM_PB_AC_pullup_line_position"}})
		addStrokeLine("AC_pullup_line", 200,{-100,0},-90,"AC_pullup")
	addPlaceholder("HARM_pullup",{0,0},HarmAzimuthSteeringLine_placeholder.name,{{"HUD_HARM_PB_HARM_pullup_line_position"}})
		addStrokeLine("HARM_pullup_line1", 50,{40,0},-60,"HARM_pullup")
		addStrokeLine("HARM_pullup_line2", 50,{40,0},-120,"HARM_pullup")
		addStrokeLine("HARM_pullup_line3", 50,{-40,0},60,"HARM_pullup")
		addStrokeLine("HARM_pullup_line4", 50,{-40,0},120,"HARM_pullup")
	addPlaceholder("Min_range",{0,0},HarmAzimuthSteeringLine_placeholder.name,{{"HUD_HARM_PB_Min_range_line_position"}})
		addStrokeLine("Min_range_line", 150,{-75,0},-90,"Min_range")

local Harm_PB_indication_placeholder = addPlaceholder("Harm_PB_indication_PH",{0,0},nil,{{"Harm_PB_indication_SHOW"}})
	addStrokeText("HARM_Launch_method", "", STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {250, 110},Harm_PB_indication_placeholder.name,{{"HUD_HARM_PB_Launch_method"}})
	addStrokeText("HARM_RNG", "", STROKE_FNT_DFLT_120_WIDE, "LeftCenter", {350, 110},Harm_PB_indication_placeholder.name,{{"HUD_HARM_PB_IS_IN_RANGE"}})

-- TGP
-- Laser Status
addStrokeText("MPD_FLIR_LaserStatus_label", "", STROKE_FNT_DFLT_120, "CenterCenter", {0, 300}, nil, {{"HUD_FLIR_LaserStatus"}},
		{"", "L ARM", "M ARM", "LTD/R", "MARK", "LTD", "LTD/R", "MARK"})

-- CODE warning
addStrokeText("FLIR_CodeWarn", "CODE", stringdefs_HUD_norm_150, "RightCenter", {230, 40}, nil, {{"HUD_FLIR_CodeWarning"}})
addStrokeBox("FLIR_CodeWarn_Box", 102, 42, "RightCenter", {6, 0}, "FLIR_CodeWarn")

