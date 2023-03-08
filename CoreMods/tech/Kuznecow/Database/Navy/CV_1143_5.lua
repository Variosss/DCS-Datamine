-- Kuznecow 1143.5 CV (OREL Class Carrier) 63 (plugin definition)
GT = {};
dofile(current_mod_path..'/Database/Navy/CV_1143_5_RunwaysAndRoutes.lua')
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape 	 = "CV_1143_5"
GT.visual.shape_dstr = ""

GT.encyclopediaAnimation = { 
	args = {
		[12] = 1, -- radar
		[13] = 1, -- radar
		[17] = -0.5, -- SB fwd AAA/SAM 1 rotation
		[19] = -0.5, -- SB fwd AAA/SAM 2 rotation
		[21] = 0.5, -- PS fwd AAA/SAM 1 rotation
		[23] = 0.5, -- PS fwd AAA/SAM 2 rotation
		[25] = -0.5, -- SB aft AAA/SAM 1 rotation
		[27] = -0.5, -- SB aft AAA/SAM 2 rotation
		[29] = 0.5, -- PS aft AAA/SAM 1 rotation
		[31] = 0.5, -- PS aft AAA/SAM 2 rotation
		[33] = -0.5, -- SB AAA 1 rotation
		[35] = -0.5, -- SB AAA 2 rotation
		[37] = 0.5, -- PS AAA 1 rotation
		[39] = 0.5, -- PS AAA 2 rotation
		[41] = 1, -- SB AAA 3 rotation
		[43] = 1, -- PS AAA 3 rotation
		[326] = 1, -- deck is ready for aircraft operations
	}		
} 

GT.IR_emission_coeff = 0.45

GT.animation_arguments.flight_deck_fences = 326;
GT.animation_arguments.arresting_wires = {400, 401, 402, 403}
GT.animation_arguments.wheel_chocks = {141, 142, 143}

GT.carrierIlluminationStates = { 
								 {{69, 0.0, 0.999}, {149, 0.0, 0.999},},  --NAV_LIGHTS
								 {{150, 0.0, 0.999}, {152, 0.0, 0.999}}, -- AC_LAUNCH_STATE
								 {{150, 0.0, 0.999}, {152, 0.0, 0.999}}, -- AC_RECOVERY_STATE
								}

GT.OLS = {Type = GT_t.OLS_TYPE.Luna, MeatBallArg = 151}

GT.life = 7000
GT.mass = 7.05e+007
GT.max_velocity = 16.4622
GT.race_velocity = 15.4333
GT.economy_velocity = 9.26
GT.economy_distance = 1.4816e+007
GT.race_distance = 4.63e+006
GT.shipLength = 304.5
GT.Width = 42
GT.Height = 53.1
GT.Length = 304.5
GT.DeckLevel = 16.149
GT.X_nose = 164
GT.X_tail = -113.5
GT.Tail_Width = 28
GT.draft = 13
GT.Gamma_max = 1.0
GT.Om = 0.05
GT.speedup = 0.148333
GT.R_min = 609
GT.distFindObstacles = 963.5
GT.RCS = 1500000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.numParking = 3
GT.Plane_Num_ = 24
GT.Helicopter_Num_ = 12

GT.airWeaponDist = 12000
GT.airFindDist = 25000

GT.exhaust =
{
	[1] = { size = 0.75 , pos = {-5,41, 23 } },
 }

GT.ArrestingGears = {
	{
		Left = {	pos = {-71.707,   16.322, -22.229} },
		Right = {	pos = {-68.118,   16.322, 6.93} }
	},
	{	
		Left = {	pos = {-59.712,   16.322, -23.706} },
		Right = {	pos = {-56.123,   16.322, 5.453} }
	},
	{	
		Left = {	pos = {-47.736,   16.322, -25.187} },
		Right = {	pos = {-44.147,   16.322, 3.973} }
	},
	{	
		Left = {	pos = {-35.746,   16.322, -26.659} },
		Right = {	pos = {-32.157,   16.332, 2.501} }
	}
}
GT.ArrestingGears.ArrestingGearsNumber = #GT.ArrestingGears

GT.Landing_Point = {71.0, 16.26,-30.0}

GT.LSOView = {cockpit = "empty", position = {connector = "POINT_LSO_CAMERA", offset = {0.0, 0.0, 0.0, 0.0, 0.0}}}
-- weapon systems

GT.DM = {
    { area_name = "Collision_70", 				area_arg = 70, area_life = 150, area_fire = { connector = "FIRE_POS_70", size = 0.5}},
	{ area_name = "Collision_71", 				area_arg = 71, area_life = 150, area_fire = { connector = "FIRE_POS_71", size = 0.3}},
	{ area_name = "Collision_72", 				area_arg = 72, area_life = 150, area_fire = { connector = "FIRE_POS_72", size = 0.5}},
	{ area_name = "Collision_73", 				area_arg = 73, area_life = 150, area_fire = { connector = "FIRE_POS_73", size = 0.3}},
	{ area_name = "Collision_74", 				area_arg = 74, area_life = 150, area_fire = { connector = "FIRE_POS_74", size = 0.2}},
	{ area_name = "Collision_75", 				area_arg = 75, area_life = 150, area_fire = { connector = "FIRE_POS_75_2", size = 0.3}},
	{ area_name = "Collision_PALUBA_76", 				area_arg = 76, area_life = 100, area_fire = { connector = "FIRE_POS_76", size = 0.5}, belongsToRunway = true}, -- deck front
	{ area_name = "Collision_PALUBA_77", 				area_arg = 77, area_life = 100, belongsToRunway = true}, -- deck middle
	{ area_name = "Collision_PALUBA_78", 				area_arg = 78, area_life = 100, area_fire = { connector = "FIRE_POS_78", size = 0.4}, belongsToRunway = true}, -- deck back
	{ area_name = "Collision_79", 				area_arg = 79, area_life = 150}, -- back
	{ area_name = "Collision_80", 				area_arg = 80, area_life = 100}, -- tower front right
	{ area_name = "Collision_81", 				area_arg = 81, area_life = 100, area_fire = { connector = "FIRE_POS_81", size = 0.3}}, -- tower middle right
	{ area_name = "Collision_82", 				area_arg = 82, area_life = 100}, -- tower back right
	{ area_name = "Collision_83", 				area_arg = 83, area_life = 100}, -- tower front left
	{ area_name = "Collision_84", 				area_arg = 84, area_life = 100, area_fire = { connector = "FIRE_POS_84", size = 0.4}}, -- tower middle left
	{ area_name = "Collision_85", 				area_arg = 85, area_life = 100}, -- tower back left
	{ area_name = "Collision_91", 				area_arg = 91, area_life = 8}, -- klinok radar front right CENTER_RADAR_07
	{ area_name = "Collision_92", 				area_arg = 92, area_life = 8}, -- klinok radar front left CENTER_RADAR_08
	{ area_name = "Collision_93", 				area_arg = 93, area_life = 8}, -- klinok radar back right CENTER_RADAR_09
	{ area_name = "Collision_94", 				area_arg = 94, area_life = 8}, -- klinok radar back left CENTER_RADAR_10
	{ area_name = "Collision_99", 				area_arg = 99, area_life = 8}, -- kortik_01
	{ area_name = "Collision_100", 				area_arg = 100, area_life = 8}, -- kortik_02
	{ area_name = "Collision_101", 				area_arg = 101, area_life = 8}, -- kortik_05
	{ area_name = "Collision_102", 				area_arg = 102, area_life = 8}, -- kortik_06
	{ area_name = "Collision_103", 				area_arg = 103, area_life = 8}, -- kortik_03
	{ area_name = "Collision_104", 				area_arg = 104, area_life = 8}, -- kortik_04
	{ area_name = "Collision_105", 				area_arg = 105, area_life = 8}, -- kortik_07
	{ area_name = "Collision_106", 				area_arg = 106, area_life = 8}, -- kortik_08
	{ area_name = "Collision_107", 				area_arg = 107, area_life = 6}, -- AK-630_01
	{ area_name = "Collision_108", 				area_arg = 108, area_life = 6}, -- AK-630_02
	{ area_name = "Collision_109", 				area_arg = 109, area_life = 6}, -- AK-630_03
	{ area_name = "Collision_110", 				area_arg = 110, area_life = 6}, -- AK-630_04
	{ area_name = "Collision_111", 				area_arg = 111, area_life = 6}, -- AK-630_05
	{ area_name = "Collision_112", 				area_arg = 112, area_life = 6}, -- AK-630_06
}

GT.WS = {}
GT.WS.maxTargetDetectionRange = 550000;
GT.WS.radar_type = 104
GT.WS.searchRadarMaxElevation = math.rad(50);

local ws = 0;

--left center
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_04"
GT.WS[ws].area = 'Collision_110'
GT.WS[ws].angles = {{math.rad(170), math.rad(10), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 37
GT.WS[ws].drawArgument2 = 38
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_04"

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_05"
GT.WS[ws].area = 'Collision_111'
GT.WS[ws].angles = {{math.rad(170), math.rad(10), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 39
GT.WS[ws].drawArgument2 = 40
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_05"
--right center
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_01"
GT.WS[ws].area = 'Collision_107'
GT.WS[ws].angles = {{math.rad(10), math.rad(-170), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 33
GT.WS[ws].drawArgument2 = 34
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_01"

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_02"
GT.WS[ws].area = 'Collision_108'
GT.WS[ws].angles = {{math.rad(5), math.rad(-175), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 35
GT.WS[ws].drawArgument2 = 36
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_02"

--left back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_06"
GT.WS[ws].area = 'Collision_112'
GT.WS[ws].angles = {{math.rad(-150), math.rad(45), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(180);
GT.WS[ws].drawArgument1 = 43
GT.WS[ws].drawArgument2 = 44
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_06"

--right back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_TOWER_AK630_03"
GT.WS[ws].area = 'Collision_109'
GT.WS[ws].angles = {{math.rad(-45), math.rad(150), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(180);
GT.WS[ws].drawArgument1 = 41
GT.WS[ws].drawArgument2 = 42
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].BR[1].connector_name = "Point_AK630_03"

-- left front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_03"
GT.WS[ws].area = 'Collision_103'
GT.WS[ws].angles = {{math.rad(140), math.rad(-4.5), math.rad(-12), math.rad(88)},
					{math.rad(-4.5), math.rad(-30), math.rad(35), math.rad(88)},
					{math.rad(-150), math.rad(140), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 21
GT.WS[ws].drawArgument2 = 22
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_03_MISSILE_01'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_02'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_03'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_04'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_05'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_06'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_07'},
					{connector_name = 'POINT_KORTIK_03_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_03_GUN_01'},
						{connector_name = 'POINT_KORTIK_03_GUN_02'},}

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_04"
GT.WS[ws].area = 'Collision_104'
GT.WS[ws].angles = {{math.rad(130), math.rad(45), math.rad(-12), math.rad(88)},
					{math.rad(45), math.rad(-30), math.rad(35), math.rad(88)},
					{math.rad(-150), math.rad(130), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 23
GT.WS[ws].drawArgument2 = 24
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_04_MISSILE_01'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_02'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_03'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_04'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_05'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_06'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_07'},
					{connector_name = 'POINT_KORTIK_04_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_04_GUN_01'},
						{connector_name = 'POINT_KORTIK_04_GUN_02'},}

--left back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_07"
GT.WS[ws].area = 'Collision_105'
GT.WS[ws].angles = {{math.rad(130), math.rad(53), math.rad(-12), math.rad(88)},
					{math.rad(53), math.rad(-30), math.rad(35), math.rad(88)},
					{math.rad(-150), math.rad(130), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 29
GT.WS[ws].drawArgument2 = 30
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_07_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_07_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_07_GUN_01'},
					   {connector_name = 'POINT_KORTIK_07_GUN_02'},}

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_08"
GT.WS[ws].area = 'Collision_106'
GT.WS[ws].angles = {{math.rad(143), math.rad(56), math.rad(-12), math.rad(88)},
					{math.rad(56), math.rad(-30), math.rad(35), math.rad(88)},
					{math.rad(-150), math.rad(143), math.rad(35), math.rad(88)},
};
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 31
GT.WS[ws].drawArgument2 = 32
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_08_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_08_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_08_GUN_01'},
					   {connector_name = 'POINT_KORTIK_08_GUN_02'},}

--right front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_01"
GT.WS[ws].area = 'Collision_99'
GT.WS[ws].angles = {{math.rad(0), math.rad(-120), math.rad(-12), math.rad(88)},
					{math.rad(-120), math.rad(150), math.rad(35), math.rad(88)},
					{math.rad(30), math.rad(0), math.rad(35), math.rad(88)},
};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_01_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_01_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_01_GUN_01'},
					   {connector_name = 'POINT_KORTIK_01_GUN_02'},}

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_02"
GT.WS[ws].area = 'Collision_100'
GT.WS[ws].angles = {{math.rad(-35), math.rad(-150), math.rad(-12), math.rad(88)},
					{math.rad(-150), math.rad(150), math.rad(35), math.rad(88)},
					{math.rad(30), math.rad(-35), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_02_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_02_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_02_GUN_01'},
					   {connector_name = 'POINT_KORTIK_02_GUN_02'},}

--right back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_05"
GT.WS[ws].area = 'Collision_101'
GT.WS[ws].angles = {{math.rad(-45), math.rad(-150), math.rad(-12), math.rad(88)},
					{math.rad(-150), math.rad(150), math.rad(35), math.rad(88)},
					{math.rad(30), math.rad(-45), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 25
GT.WS[ws].drawArgument2 = 26
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_05_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_05_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_05_GUN_01'},
					   {connector_name = 'POINT_KORTIK_05_GUN_02'},}

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.kortik)
GT.WS[ws].center = "CENTER_TOWER_KORTIK_06"
GT.WS[ws].area = 'Collision_102'
GT.WS[ws].angles = {{math.rad(-45), math.rad(-140), math.rad(-12), math.rad(88)},
					{math.rad(-140), math.rad(150), math.rad(35), math.rad(88)},
					{math.rad(30), math.rad(-45), math.rad(35), math.rad(88)}
};
GT.WS[ws].reference_angle_Y = math.rad(-90);
GT.WS[ws].drawArgument1 = 27
GT.WS[ws].drawArgument2 = 28
GT.WS[ws].LN[1].BR = { {connector_name = 'POINT_KORTIK_06_MISSILE_01'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_02'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_03'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_04'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_05'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_06'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_07'},
					   {connector_name = 'POINT_KORTIK_06_MISSILE_08'},}
GT.WS[ws].LN[2].BR = { {connector_name = 'POINT_KORTIK_06_GUN_01'},
					   {connector_name = 'POINT_KORTIK_06_GUN_02'},}


-- left front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_klinok)
GT.WS[ws].center = "CENTER_RADAR_08"
GT.WS[ws].area = 'Collision_92'
GT.WS[ws].moveable = true;
GT.WS[ws].drawArgument1 = 11
GT.WS[ws].angles = {{math.rad(170), math.rad(-40), math.rad(-12), math.rad(88)}};
GT.WS[ws].LN[1].reactionTime = 3;
GT.WS[ws].LN[1].PL[1].ammo_capacity = 8 * 6; -- 6 VLU
GT.WS[ws].LN[1].BR[1].connector_name = "POINT_KINJAL_15"
GT.WS[ws].LN[1].connectorFire = false;

-- right front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_klinok)
GT.WS[ws].center = "CENTER_RADAR_07"
GT.WS[ws].area = 'Collision_91'
GT.WS[ws].moveable = true;
GT.WS[ws].drawArgument1 = 10
GT.WS[ws].angles = {{math.rad(40), math.rad(-170), math.rad(-12), math.rad(88)}};
GT.WS[ws].LN[1].reactionTime = 3;
GT.WS[ws].LN[1].PL[1].ammo_capacity = 8 * 6; -- 6 VLU
GT.WS[ws].LN[1].BR[1].connector_name = "POINT_KINJAL_03"
GT.WS[ws].LN[1].connectorFire = false;

-- left back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_klinok)
GT.WS[ws].center = "CENTER_RADAR_10"
GT.WS[ws].area = 'Collision_94'
GT.WS[ws].moveable = true;
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].angles = {{math.rad(-170), math.rad(5), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(180);
GT.WS[ws].LN[1].reactionTime = 3;
GT.WS[ws].LN[1].PL[1].ammo_capacity = 8 * 6; -- 6 VLU
GT.WS[ws].LN[1].BR[1].connector_name = "POINT_KINJAL_22"
GT.WS[ws].LN[1].connectorFire = false;

-- right back
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_klinok)
GT.WS[ws].center = "CENTER_RADAR_09"
GT.WS[ws].area = 'Collision_93'
GT.WS[ws].moveable = true;
GT.WS[ws].drawArgument1 = 12
GT.WS[ws].angles = {{math.rad(-5), math.rad(170), math.rad(-12), math.rad(88)}};
GT.WS[ws].reference_angle_Y = math.rad(180);
GT.WS[ws].LN[1].reactionTime = 3;
GT.WS[ws].LN[1].PL[1].ammo_capacity = 8 * 6; -- 6 VLU
GT.WS[ws].LN[1].BR[1].connector_name = "POINT_KINJAL_10"
GT.WS[ws].LN[1].connectorFire = false;

-- ASM Granit (SS-N-19 Shipwreck)
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_granit)
GT.WS[ws].pos = {125.2,11.4,0}
GT.WS[ws].LN[1].PL[1].ammo_capacity = 12;
GT.WS[ws].LN[1].max_number_of_missiles_channels = 12;
GT.WS[ws].LN[1].BR = {  { connector_name = "POINT_GRANIT_02", recoilArgument = 178, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_01", recoilArgument = 179, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_04", recoilArgument = 180, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_03", recoilArgument = 181, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_06", recoilArgument = 182, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_05", recoilArgument = 183, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_08", recoilArgument = 184, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_07", recoilArgument = 185, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_10", recoilArgument = 186, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_09", recoilArgument = 187, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_12", recoilArgument = 188, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{ connector_name = "POINT_GRANIT_11", recoilArgument = 189, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}

GT.Name = "CV_1143_5"
GT.DisplayName = _("CV 1143.5 Admiral Kuznetsov(2017)")
GT.DisplayNameShort = _("CV Kuznetsov")
GT.Rate = 5500

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV"},
                RADAR = {
                            "Tor 9A331",
                            "2S6 Tunguska",
                            "carrier search radar",
                        }
            }

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="yes";
GT.mapclasskey = "P0091000065";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_AirCarrier,WSTYPE_PLACEHOLDER,
                    "Aircraft Carriers",
                    "Arresting Gear",
                    "ski_jump",
                    "RADAR_BAND1_FOR_ARM",
					"DetectionByAWACS",
					"Straight_in_approach_type"
				};
GT.Categories = {
					{name = "AircraftCarrier"},
					{name = "AircraftCarrier With Tramplin"},
					{name = "Armed Ship"},
					{name = "AircraftCarrier With Arresting Gear"}
				};
GT.tags  =
{
	"Carrier",
}
GT.Countries = {"Russia"}
--[[
local deck_crew_names = {
				"tug_3913",
				"sailor_01",
				"sailor_01a",
				"sailor_02",
				"sailor_02a",
				"sailor_03",
				"tech_01",
				"tech_02",
				"tech_03",
				"tech_03a",
				"tech_04a",
				"tech_05",
				"tech_05a",
				"tech_06",
				"tech_07",
				"tech_07a",
			}

local deck_crew_points = {{-61.801476,	16.259766,	16.965755},
{-50.237778,	16.259766,	9.254064},
{-39.958954,	16.259766,	11.567554},
{-28.395269,	16.259766,	6.426416},
{-15.032796,	16.259766,	12.595793},
{10.664286,	16.259766,	2.056450},
{-14.004911,	16.259766,	5.398204},
{23.512829,	16.259766,	0.514106},
{37.646210,	16.259766,	11.310513},
{48.182014,	16.259766,	21.592787},
{55.377193,	16.259766,	10.796379},
{60.002678,	16.259766,	-5.655257},
{72.337265,	16.259766,	15.680478},
{79.789421,	16.259766,	-18.765156},
{78.761536,	16.259766,	-22.621016},
{79.532440,	16.259766,	17.736927},
{-108.540375,	13.396484,	24.070667},
{-98.713036,	13.376953,	-23.295298},
{-46.383213,	16.259766,	-30.075665},
{-71.309380,	16.259766,	-29.304489},
{-78.247604,	16.259766,	12.852858},
{-7.066702,	16.259766,	1.799410},
{41.243797,	16.259766,	5.912309},
{99.576141,	16.259766,	19.022202},
{110.111946,	16.259766,	18.508099},
{-21.200090,	16.259766,	-31.360947},
{-39.188038,	16.259766,	-31.360945},
{-72.337273,	16.259766,	11.824618},
{-102.916794,	16.259766,	12.852859},
{-48.952923,	16.259766,	26.219820},
{-2.184259,	16.259766,	2.827622},
{30.708008,	16.259766,	2.056450},
{30.451038,	16.259766,	2.056450},
{44.584427,	16.259766,	5.398203},
{63.343281,	16.259766,	8.482890},
{52.293541,	16.259766,	26.990988},
}


GT.deck_crew = {}

local shapes_size = #deck_crew_names

for i,pnt in ipairs(deck_crew_points) do
	GT.deck_crew[i] = 
	{
		pos   = pnt,
		shape = deck_crew_names[math.fmod (i,shapes_size) + 1]
	}
	

end
--]]
