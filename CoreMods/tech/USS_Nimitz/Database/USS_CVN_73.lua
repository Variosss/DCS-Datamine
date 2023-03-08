-- USS CVN-73 George Washington

GT = {};
dofile(current_mod_path..'/scripts/USS_Nimitz_RunwaysAndRoutes.lua')
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "Nimitz_CVN_73"
GT.visual.shape_dstr = ""

GT.encyclopediaAnimation = { 
	args = {
		[17] = -0.5, -- SB fwd Phalanxs rotation
		[19] = 0.5, -- PS aft Phalanxs rotation
		[23] = 0.5, -- PS fwd SAM launcher rotation
		[24] = 0.25, -- PS fwd SAM launcher elevation
		[25] = -0.5, -- SB aft SAM launcher rotation
		[26] = 0.25, -- SB aft SAM launcher elevation
		[49] = -0.5, -- SB fwd SAM launcher rotation
		[51] = 0.5, -- PS aft SAM launcher rotation
		[153] = 1, -- SB fwd SAM launcher cover ON
		[154] = 1, -- SB fwd SAM launcher cover ON
		[155] = 1, -- SB fwd SAM launcher cover ON
		[156] = 1, -- SB fwd SAM launcher cover ON
		[157] = 1, -- SB fwd SAM launcher cover ON
		[158] = 1, -- SB fwd SAM launcher cover ON
		[159] = 1, -- SB fwd SAM launcher cover ON
		[160] = 1, -- SB fwd SAM launcher cover ON
		[161] = 1, -- PS aft SAM launcher cover ON
		[162] = 1, -- PS aft SAM launcher cover ON
		[163] = 1, -- PS aft SAM launcher cover ON
		[164] = 1, -- PS aft SAM launcher cover ON
		[165] = 1, -- PS aft SAM launcher cover ON
		[166] = 1, -- PS aft SAM launcher cover ON
		[167] = 1, -- PS aft SAM launcher cover ON
		[168] = 1, -- PS aft SAM launcher cover ON
		[177] = 1, -- PS fwd SAM launcher cover ON
		[178] = 1, -- PS fwd SAM launcher cover ON
		[179] = 1, -- PS fwd SAM launcher cover ON
		[180] = 1, -- PS fwd SAM launcher cover ON
		[181] = 1, -- PS fwd SAM launcher cover ON
		[182] = 1, -- PS fwd SAM launcher cover ON
		[183] = 1, -- PS fwd SAM launcher cover ON
		[184] = 1, -- PS fwd SAM launcher cover ON
		[185] = 1, -- PS fwd SAM launcher cover ON
		[186] = 1, -- PS fwd SAM launcher cover ON
		[187] = 1, -- PS fwd SAM launcher cover ON
		[188] = 1, -- PS fwd SAM launcher cover ON
		[189] = 1, -- PS fwd SAM launcher cover ON
		[190] = 1, -- PS fwd SAM launcher cover ON
		[191] = 1, -- PS fwd SAM launcher cover ON
		[192] = 1, -- PS fwd SAM launcher cover ON
		[193] = 1, -- PS fwd SAM launcher cover ON
		[194] = 1, -- PS fwd SAM launcher cover ON
		[195] = 1, -- PS fwd SAM launcher cover ON
		[196] = 1, -- PS fwd SAM launcher cover ON
		[197] = 1, -- PS fwd SAM launcher cover ON
		[198] = 1, -- SB aft SAM launcher cover ON
		[199] = 1, -- SB aft SAM launcher cover ON
		[200] = 1, -- SB aft SAM launcher cover ON
		[201] = 1, -- SB aft SAM launcher cover ON
		[202] = 1, -- SB aft SAM launcher cover ON
		[203] = 1, -- SB aft SAM launcher cover ON
		[204] = 1, -- SB aft SAM launcher cover ON
		[205] = 1, -- SB aft SAM launcher cover ON
		[206] = 1, -- SB aft SAM launcher cover ON
		[207] = 1, -- SB aft SAM launcher cover ON
		[208] = 1, -- SB aft SAM launcher cover ON
		[209] = 1, -- SB aft SAM launcher cover ON
		[210] = 1, -- SB aft SAM launcher cover ON
		[211] = 1, -- SB aft SAM launcher cover ON
		[212] = 1, -- SB aft SAM launcher cover ON
		[213] = 1, -- SB aft SAM launcher cover ON
		[214] = 1, -- SB aft SAM launcher cover ON
		[215] = 1, -- SB aft SAM launcher cover ON
		[216] = 1, -- SB aft SAM launcher cover ON
		[217] = 1, -- SB aft SAM launcher cover ON
		[218] = 1, -- SB aft SAM launcher cover ON
	}		
}

GT.IR_emission_coeff = 0.4

GT.life = 7300;
GT.mass = 7.2916e+007;
GT.max_velocity = 15.4333;
GT.race_velocity = 15.4333;
GT.economy_velocity = 15.4333;
GT.economy_distance = 7.408e+007;
GT.race_distance = 7.408e+007;
GT.shipLength = 332.9;
GT.Width = 96;
GT.Height = 57.8;
GT.Length = 332.9;
GT.DeckLevel = 20.1494;
GT.X_nose = 141.0;
GT.X_tail = -140.0;
GT.Tail_Width = 22;
GT.draft = 13
GT.Gamma_max = 1.0;
GT.Om = 0.05;
GT.speedup = 0.119249;
GT.R_min = 665.8;
GT.distFindObstacles = 1048.7;
GT.RCS = 2000000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.
GT.TACAN = true;
GT.TACAN_position = {-55.0, 55.0, 29.0}
GT.ICLS = true;
GT.ICLS_Localizer_position = {-153.0, 12.0, 9.4, 189.0}	-- {x [m], y [m], z [m], yaw [deg]}
GT.ICLS_Glideslope_position = {-79.0, 26.5, 32.7, 3.5}	-- {x [m], y [m], z [m], glideslope = 3.5 [deg]}
GT.OLS = {Type = GT_t.OLS_TYPE.IFLOLS, CutLightsArg = 404, DatumAndWaveOffLightsArg = 405, MeatBallArg = 151, GlideslopeBasicAngle = 3.5, VerticalCoverageAngle = 1.7}
GT.LRLS = true;

GT.numParking = 4;
GT.Plane_Num_ = 72;
GT.Helicopter_Num_ = 6;

GT.airWeaponDist = 25000;
GT.airFindDist = 50000;
GT.sensor = {
	max_range_finding_target = 50000,
	min_range_finding_target = 0,
	max_alt_finding_target = 15000,
	min_alt_finding_target = 0,
	pos = {-44.0, 42.0, 30.0} -- search radar position
}

GT.Stations = CVN_7X_STATIONS(73)
GT.LSOView = CVN_7X_LSOView

GT.Landing_Point = {-104.0, 19.6, -33.0}
GT.animation_arguments.arresting_wires = {141, 142, 143, 144}
GT.animation_arguments.catapult_shuttles = {145, 146, 147, 148}
GT.animation_arguments.holdback_bars_pos = {817, 818, 819, 820}
GT.animation_arguments.holdback_bars_angle = {808, 809, 810, 811}
GT.animation_arguments.holdback_bars_color = {812, 813, 814, 815}
GT.animation_arguments.holdback_bars_deck_cleat = {804, 805, 806, 807}
GT.animation_arguments.bubbles = {138, 139}

-- {int ArgumentNo, float OffValue, float OnValue, [float AnimationDuration],  [bool cycleAnimation]}
GT.carrierIlluminationStates = { 
								 {{69, 0.0, 1.0}, {795, 0.0, 1.0}, {797, 0.0, 1.0}, {801, 0.0, 1.0} }, --NAV_LIGHTS
								 {{790, 0.0, 1.0}, {791, 0.0, 1.0}, {792, 0.0, 1.0}, {793, 0.0, 1.0}, {794, 0.0, 1.0}, {795, 0.0, 1.0}, {796, 0.0, 1.0}, {797, 0.0, 1.0}, {801, 0.0, 1.0}}, -- AC_LAUNCH_STATE
								 {{150, 0.0, 1.0}, {152, 0.0, 1.0, 3.0, true}, {790, 0.0, 0.0}, {792, 0.0, 1.0}, {795, 0.0, 0.0}, {797, 0.0, 0.0}, {801, 1.0, 0.0}}, -- AC_RECOVERY_STATE
								}

GT.animation_arguments.elevators = {57, 58, 59, 60};
GT.animation_arguments.elevators_doors = {47, 48, 53, 54};
GT.animation_arguments.elevators_fences_top = {27, 29, 31, 33};
GT.animation_arguments.elevators_fences_bottom = {28, 30, 32, 34};

GT.animation_arguments.radar1_rotation = 2; -- main search radar
GT.animation_arguments.radar2_rotation = 3; -- secondary search radar
GT.animation_arguments.radar3_rotation = 1; -- navigation radar

GT.DM = {
    { area_name = "NOSE_R_01", 				area_arg = 70, area_life = 150},
	{ area_name = "NOSE_R_02", 				area_arg = 94, area_life = 150, area_fire = { connector = "FIRE_NOSE_R_02", size = 0.5}},
	{ area_name = "CENTER_R_01", 			area_arg = 71, area_life = 150, area_fire = { connector = "FIRE_CENTER_R_01", size = 0.5}},
	{ area_name = "CENTER_R_02", 			area_arg = 72, area_life = 150, area_fire = { connector = "FIRE_CENTER_R_02", size = 0.5}},
    { area_name = "BACK_R", 				area_arg = 73, area_life = 150, area_fire = { connector = "FIRE_BACK_R", size = 0.5}},
	
    { area_name = "NOSE_L_01", 				area_arg = 74, area_life = 150},
	{ area_name = "NOSE_L_02", 				area_arg = 95, area_life = 150, area_fire = { connector = "FIRE_NOSE_L_03", size = 0.5}},
    { area_name = "CENTER_L_01", 			area_arg = 75, area_life = 150},
	{ area_name = "CENTER_L_02", 			area_arg = 76, area_life = 150, area_fire = { connector = "FIRE_CENTER_L_01", size = 0.5}},
    { area_name = "BACK_L", 				area_arg = 77, area_life = 150, area_fire = { connector = "FIRE_BACK_L", size = 0.5}},
	
	{ area_name = "BACK_73", 				area_arg = 78, area_life = 150},
	
	{ area_name = "PALUBA_NOSE",			area_arg = 79, area_life = 300, armour = {width = 0.030}, area_fire = { connector = "FIRE_PALUBA_NOSE", size = 0.8}, belongsToRunway = true},
	{ area_name = "PALUBA_MIDLE_01",		area_arg = 80, area_life = 300, armour = {width = 0.030}, area_fire = { connector = "FIRE_PALUBA_MIDLE_01", size = 0.8}, belongsToRunway = true},
	{ area_name = "PALUBA_MIDLE_02",		area_arg = 81, area_life = 300, armour = {width = 0.030}, area_fire = { connector = "FIRE_PALUBA_MIDLE_04", size = 0.8}, belongsToRunway = true},
	{ area_name = "PALUBA_BACK",	 		area_arg = 82, area_life = 300, armour = {width = 0.030}, area_fire = { connector = "FIRE_PALUBA_BACK_01", size = 0.8}, belongsToRunway = true},
	
	{ area_name = "Col_Island_73_Front", 	area_arg = 83, area_life = 75},
	{ area_name = "Col_Island_73_R", 		area_arg = 84, area_life = 75, area_fire = { connector = "FIRE_RUBKA_73_02", size = 0.3}},
	{ area_name = "Col_Island_73_Back", 	area_arg = 85, area_life = 75},
	{ area_name = "Col_Island_73_L", 		area_arg = 86, area_life = 75, area_fire = { connector = "FIRE_RUBKA_73_04", size = 0.3}},
	{ area_name = "Col_Island_73_Top", 		area_arg = 87, area_life = 75, area_fire = { connector = "FIRE_RUBKA_73_05", size = 0.4}},
	
	{ area_name = "MACHTA_73", 				area_arg = 88, area_life = 50},
	{ area_name = "TOWER_73", 				area_arg = 89, area_life = 80},
	
	{ area_name = "ZRK_NR",					area_arg = 96, area_life = 2},
	{ area_name = "ZA_NR",					area_arg = 97, area_life = 2},
	{ area_name = "ZRK_NL",					area_arg = 98, area_life = 2},
	{ area_name = "ZRK_BR",					area_arg = 99, area_life = 2},
	{ area_name = "ZRK_BL",					area_arg = 100, area_life = 2},
	{ area_name = "ZA_BL",					area_arg = 101, area_life = 2},
	--{ area_name = "ZA_BR",					area_arg = 102, area_life = 10},
	
	{ area_name = "ELEVATOR_01",			area_arg = 109, area_life = 50},
	{ area_name = "ELEVATOR_02",			area_arg = 110, area_life = 50},
	{ area_name = "ELEVATOR_03",			area_arg = 111, area_life = 50},
	{ area_name = "ELEVATOR_04",			area_arg = 112, area_life = 50},
	
	{area_name = "Rad_73_4", 				area_life = 2,},
	{area_name = "Rad_73_3", 				area_life = 2,},
	{area_name = "Rad_73_11", 				area_life = 2,},
	{area_name = "Rad_73_13", 				area_life = 2,},
}

-- weapon systems
GT.WS = {}
GT.WS.maxTargetDetectionRange = GT.airFindDist+10000;
GT.WS.radar_type = 104
GT.WS.searchRadarMaxElevation = math.rad(50);
-- 1
local ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].area = 'ZA_NR'
GT.WS[ws].angles = {
					 {math.rad(10), math.rad(0), math.rad(7), math.rad(85)},
					 {math.rad(0), math.rad(-150), math.rad(-5), math.rad(85)},
					 {math.rad(-150), math.rad(10), math.rad(19), math.rad(85)}
				   }
GT.WS[ws].center = 'CENTER_TOWER_ZA_FR'
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_GUN_ZA_FR';
GT.WS[ws].LN[1].fireAnimationArgument = 119;
GT.WS[ws].LN[1].createMuzzleFlashEffect = true;
-- 2
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].area = 'ZA_BL'
GT.WS[ws].angles = {
					 {math.rad(-135), math.rad(-140), math.rad(-5), math.rad(45)},
					 {math.rad(-140), math.rad(45), math.rad(-5), math.rad(85)},
				   }
GT.WS[ws].center = 'CENTER_TOWER_ZA_BL'
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].reference_angle_Y = math.rad(180)
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_GUN_ZA_BL';
GT.WS[ws].LN[1].fireAnimationArgument = 121;
GT.WS[ws].LN[1].createMuzzleFlashEffect = true;
-- 3
-- Mk 95 radars
ws = GT_t.inc_ws();
local first_MK95_tracker_id = ws;
GT.WS[ws] = {
	omegaY = 1,
	omegaZ = 1,
	pidY = {p=100, i=0.05, d=12, inn = 50},
	pidZ = {p=100, i=0.05, d=12, inn = 50},
	area = 'Rad_73_4',
	center = 'CENTER_RADAR_73_02',
	drawArgument1 = 8,
	drawArgument2 = 9,
	reference_angle_Y = math.rad(45),
	angles = { 
				{math.rad(110), math.rad(45), math.rad(20), math.rad(80)},
				{math.rad(45), math.rad(-170), math.rad(-10), math.rad(80)}
			},
	LN = {
		[1] = {
			type = 102,
			frequencyRange = {0.5e9, 0.58e9},
			distanceMin = 400,
			distanceMax = GT.airFindDist,
			reactionTime = 2.5,
			reflection_limit = 0.1,
			ECM_K = 0.65,
			min_trg_alt = 5,
			max_trg_alt = 25000,
			max_number_of_missiles_channels = 1,
			beamWidth = math.rad(90);
		}
	}
};
local MK95_TRACKERS = {{{'self', ws}}}
-- 4
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
GT.WS[ws].area = 'Rad_73_3'
GT.WS[ws].center = 'CENTER_RADAR_73_01'
GT.WS[ws].drawArgument1 = 6
GT.WS[ws].drawArgument2 = 7
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].angles = {
						{math.rad(90), math.rad(-170), math.rad(-10), math.rad(80)},
					}
table.insert(MK95_TRACKERS, {{'self', ws}})
-- 5
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
GT.WS[ws].area = 'Rad_73_11'
GT.WS[ws].center = 'CENTER_RADAR_73_08'
GT.WS[ws].drawArgument1 = 10
GT.WS[ws].drawArgument2 = 11
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].angles = { {math.rad(-165), math.rad(13.5), math.rad(-10), math.rad(80)} }
table.insert(MK95_TRACKERS, {{'self', ws}})
-- 6
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
GT.WS[ws].area = 'Rad_73_13'
GT.WS[ws].center = 'CENTER_RADAR_73_10'
GT.WS[ws].drawArgument1 = 12
GT.WS[ws].drawArgument2 = 13
GT.WS[ws].reference_angle_Y = math.rad(135)
GT.WS[ws].angles = { {math.rad(-155), math.rad(30), math.rad(-10), math.rad(80)} }
table.insert(MK95_TRACKERS, {{'self', ws}})
-- 7
--Mk 57 Mod3 Sea Sparrow
--forward right
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.seasparrow)
GT.WS[ws].area = 'ZRK_NR'
GT.WS[ws].center = 'CENTER_TOWER_ZRK_FR'
GT.WS[ws].angles = {
					 {math.rad(-170), math.rad(40), math.rad(45), math.rad(80)},
					 {math.rad(40), math.rad(10), math.rad(25), math.rad(80)},
					 {math.rad(10), math.rad(-170), math.rad(-5), math.rad(80)},
				   }
GT.WS[ws].drawArgument1 = 49
GT.WS[ws].drawArgument2 = 50
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR = {
						{connector_name = 'Rocket_Point_01', drawArgument = 153},
						{connector_name = 'Rocket_Point_06', drawArgument = 158},
						{connector_name = 'Rocket_Point_02', drawArgument = 154},
						{connector_name = 'Rocket_Point_05', drawArgument = 157},
						{connector_name = 'Rocket_Point_03', drawArgument = 155},
						{connector_name = 'Rocket_Point_08', drawArgument = 160},
						{connector_name = 'Rocket_Point_04', drawArgument = 156},
						{connector_name = 'Rocket_Point_07', drawArgument = 159},
					}
GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS
-- 8
--back left
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.seasparrow)
GT.WS[ws].area = 'ZRK_BL'
GT.WS[ws].center = 'CENTER_TOWER_ZRK_BL'
GT.WS[ws].angles = {
					 {math.rad(-165), math.rad(45), math.rad(-5), math.rad(80)},
					 {math.rad(45), math.rad(0), math.rad(10), math.rad(80)},
				   }
GT.WS[ws].drawArgument1 = 51
GT.WS[ws].drawArgument2 = 52
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR = {
						{connector_name = 'Rocket_Point_09', drawArgument = 161},
						{connector_name = 'Rocket_Point_14', drawArgument = 166},
						{connector_name = 'Rocket_Point_10', drawArgument = 162},
						{connector_name = 'Rocket_Point_13', drawArgument = 165},
						{connector_name = 'Rocket_Point_11', drawArgument = 163},
						{connector_name = 'Rocket_Point_16', drawArgument = 168},
						{connector_name = 'Rocket_Point_12', drawArgument = 164},
						{connector_name = 'Rocket_Point_15', drawArgument = 167},
						
					}
GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS
-- 9
-- RIM-116 Rolling Airframe Missile
-- Front Left
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.RIM_116)
GT.WS[ws].area = 'ZRK_NL'
GT.WS[ws].angles = {
					 {math.rad(16), math.rad(-10), math.rad(6), math.rad(80)},
					 {math.rad(148), math.rad(16), math.rad(-5), math.rad(80)},
					 {math.rad(180), math.rad(148), math.rad(18), math.rad(80)},
				   }
GT.WS[ws].reference_angle_Z = math.rad(30)
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].center = 'CENTER_TOWER_ZRK_FL'
GT.WS[ws].drawArgument1 = 23
GT.WS[ws].drawArgument2 = 24
local LN_ = GT.WS[ws].LN[1]
LN_.BR = {
	{connector_name = 'Rocket_Point_17', drawArgument = 177},
	{connector_name = 'Rocket_Point_18', drawArgument = 178},
	{connector_name = 'Rocket_Point_19', drawArgument = 179},
	{connector_name = 'Rocket_Point_20', drawArgument = 180},
	{connector_name = 'Rocket_Point_21', drawArgument = 181},
	{connector_name = 'Rocket_Point_22', drawArgument = 182},
	{connector_name = 'Rocket_Point_23', drawArgument = 183},
	{connector_name = 'Rocket_Point_24', drawArgument = 184},
	{connector_name = 'Rocket_Point_25', drawArgument = 185},
	{connector_name = 'Rocket_Point_26', drawArgument = 186},
	{connector_name = 'Rocket_Point_27', drawArgument = 187},
	{connector_name = 'Rocket_Point_28', drawArgument = 188},
	{connector_name = 'Rocket_Point_29', drawArgument = 189},
	{connector_name = 'Rocket_Point_30', drawArgument = 190},
	{connector_name = 'Rocket_Point_31', drawArgument = 191},
	{connector_name = 'Rocket_Point_32', drawArgument = 192},
	{connector_name = 'Rocket_Point_33', drawArgument = 193},
	{connector_name = 'Rocket_Point_34', drawArgument = 194},
	{connector_name = 'Rocket_Point_35', drawArgument = 195},
	{connector_name = 'Rocket_Point_36', drawArgument = 196},
	{connector_name = 'Rocket_Point_37', drawArgument = 197},
}
-- 10
-- RIM-116 Rolling Airframe Missile
-- Back Right
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.RIM_116)
GT.WS[ws].area = 'ZRK_BR'
GT.WS[ws].angles = {
					 {math.rad(180), math.rad(-45), math.rad(45), math.rad(80)},
					 {math.rad(-45), math.rad(-180), math.rad(-5), math.rad(80)}
				   }
GT.WS[ws].reference_angle_Z = math.rad(30)
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].center = 'CENTER_TOWER_ZRK_BR'
GT.WS[ws].drawArgument1 = 25
GT.WS[ws].drawArgument2 = 26
local LN_ = GT.WS[ws].LN[1]
LN_.BR = {
	{connector_name = 'Rocket_Point_38', drawArgument = 198},
	{connector_name = 'Rocket_Point_39', drawArgument = 199},
	{connector_name = 'Rocket_Point_40', drawArgument = 200},
	{connector_name = 'Rocket_Point_41', drawArgument = 201},
	{connector_name = 'Rocket_Point_42', drawArgument = 202},
	{connector_name = 'Rocket_Point_43', drawArgument = 203},
	{connector_name = 'Rocket_Point_44', drawArgument = 204},
	{connector_name = 'Rocket_Point_45', drawArgument = 205},
	{connector_name = 'Rocket_Point_46', drawArgument = 206},
	{connector_name = 'Rocket_Point_47', drawArgument = 207},
	{connector_name = 'Rocket_Point_48', drawArgument = 208},
	{connector_name = 'Rocket_Point_49', drawArgument = 209},
	{connector_name = 'Rocket_Point_50', drawArgument = 210},
	{connector_name = 'Rocket_Point_51', drawArgument = 211},
	{connector_name = 'Rocket_Point_52', drawArgument = 212},
	{connector_name = 'Rocket_Point_53', drawArgument = 213},
	{connector_name = 'Rocket_Point_54', drawArgument = 214},
	{connector_name = 'Rocket_Point_55', drawArgument = 215},
	{connector_name = 'Rocket_Point_56', drawArgument = 216},
	{connector_name = 'Rocket_Point_57', drawArgument = 217},
	{connector_name = 'Rocket_Point_58', drawArgument = 218},
}
					
GT.Name = "CVN_73"
GT.DisplayName = _("CVN-73 George Washington")
GT.DisplayNameShort = _("CVN-73")
GT.Rate = 5500.000000

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV"},
                RADAR = {
                    "seasparrow tr",
                    "carrier search radar",
                },
            };

GT.DetectionRange	= GT.airFindDist;
GT.ThreatRange		= GT.airWeaponDist;
GT.Singleton		= "yes";
GT.mapclasskey		= "P0091000065";
GT.attribute		= {wsType_Navy, wsType_Ship, wsType_AirCarrier, WSTYPE_PLACEHOLDER,
						"Aircraft Carriers",
						"Arresting Gear", "catapult",
						"RADAR_BAND1_FOR_ARM",
						"RADAR_BAND2_FOR_ARM",		
						"Datalink", "Link4", "ACLS",
					};
GT.Categories		= {
						{name = "AircraftCarrier"},
						{name = "AircraftCarrier With Catapult"},
						{name = "Armed Ship"},
						{name = "AircraftCarrier With Arresting Gear"}
					};
GT.tags  =
{
	"Carrier",
}
GT.Countries		= {"USA"};

GT.carrier_crew_config_name = './CoreMods/tech/USS_Nimitz/scripts/GroundCrew.lua';