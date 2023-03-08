----------------
-- LHA TARAWA --
----------------

GT = {};
dofile(current_mod_path..'/TarawaRunwaysAndRoutes.lua')
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "LHA_Tarawa"
GT.visual.shape_dstr = ""

--------------------------------------------------------------------------------
-- SHIP DESCRIPTION
--------------------------------------------------------------------------------
GT.life						= 7300;
GT.mass						= 38900000;	--7.2916e+007; 72916000
GT.max_velocity				= 15.4333;
GT.race_velocity			= 15.4333;
GT.economy_velocity			= 15.4333;
GT.economy_distance			= 7.408e+007;
GT.race_distance			= 7.408e+007;
GT.shipLength				= 233;
GT.Width					= 48;
GT.Height					= 64.36;
GT.Length					= 250; 
GT.draft					= 7.5;
GT.DeckLevel				= 19.98;
GT.X_nose					= 108.728
GT.X_tail					= -124.096
GT.Tail_Width				= 31.753
GT.Gamma_max				= 0.35;
GT.Om						= 0.05;
GT.speedup					= 0.119249;
GT.R_min					= 665.8;
GT.distFindObstacles		= 1048.7;
GT.RCS						= 700000  --estimated RCS in square meters / оценочная ЭПР в кв.м.
GT.TACAN 					= true;
GT.TACAN_position 			= {-37.969, 56.996, -10.786}
GT.ICLS						= true;
GT.ICLS_Localizer_position	= {-153.0, 12.0, 9.4, 189.0}	-- {x [m], y [m], z [m], yaw [deg]}
GT.ICLS_Glideslope_position	= {-79.0, 26.5, 32.7, 3.5}	-- {x [m], y [m], z [m], glideslope = 3.5 [deg]}
GT.OLS = {
	Type = GT_t.OLS_TYPE.IFLOLS, 
	CutLightsArg = 404, 
	DatumAndWaveOffLightsArg = 405, 
	MeatBallArg = 151, 
	GlideslopeBasicAngle = 3.5, 
	VerticalCoverageAngle = 1.7
}

--------------------------------------------------------------------------------
--     X         Y          Z
-- Front/Rear, Up/Down, Left/Right
--   +   -      +  -      -    +
--------------------------------------------------------------------------------
-- Engine
GT.exhaust = {
	[1] = { size = 0.20 , pos = { -3.838, 39.823, 14.787 } },
	[2] = { size = 0.20 , pos = {-26.204, 39.823, 14.787 } },
}

-- Aviation Facilities
GT.Landing_Point	= {-71.0, 19.9, -8.0} 
GT.LSOView = {
	cockpit = "empty", 
	position = {
		--[[connector = "",]] 
		offset = {-69.0, 19.9, -10.75, 0.0, 0.0}
	}
}

-- Aircraft complement
GT.numParking		= 4;
GT.Plane_Num_		= 40;	-- Real value = 51 (45 Helicopters + 6 Harriers)
GT.Helicopter_Num_	= 36;	-- Real value = 45 Helicopters

--------------------------------------------------------------------------------
-- DAMAGE MODEL AREAS
--------------------------------------------------------------------------------
GT.DM = {
    { area_name = "NOSE_R_01", 				area_arg = 70, area_life = 150, area_fire = { connector = "FIRE_NOSE_R_01", size = 0.5}},
	{ area_name = "NOSE_R_02", 				area_arg = 94, area_life = 150, area_fire = { connector = "FIRE_NOSE_R_02", size = 0.5}},
	{ area_name = "CENTER_R_01", 			area_arg = 71, area_life = 150, area_fire = { connector = "FIRE_CENTER_R_01", size = 0.5}},
	{ area_name = "CENTER_R_02", 			area_arg = 96, area_life = 150, area_fire = { connector = "FIRE_CENTER_R_02", size = 0.5}},
    { area_name = "BACK_R", 				area_arg = 72, area_life = 300, area_fire = { connector = "FIRE_BACK_R", size = 0.5}},
	
    { area_name = "NOSE_L_01", 				area_arg = 73, area_life = 150, area_fire = { connector = "FIRE_NOSE_L_01", size = 0.5}},
	{ area_name = "NOSE_L_02", 				area_arg = 95, area_life = 150, area_fire = { connector = "FIRE_NOSE_L_02", size = 0.5}},
    { area_name = "CENTER_L_01", 			area_arg = 74, area_life = 150, area_fire = { connector = "FIRE_CENTER_L_01", size = 0.5}},
	{ area_name = "CENTER_L_02", 			area_arg = 97, area_life = 150, area_fire = { connector = "FIRE_CENTER_L_02", size = 0.5}},
    { area_name = "BACK_L", 				area_arg = 75, area_life = 300, area_fire = { connector = "FIRE_BACK_L", size = 0.5}},
	
	{ area_name = "PALUBA_NOSE",			area_arg = 76, area_life = 100, area_fire = { connector = "FIRE_PALUBA_NOSE", size = 0.8}},
	{ area_name = "PALUBA_MIDLE_01",		area_arg = 77, area_life = 100, area_fire = { connector = "FIRE_PALUBA_MIDLE_01", size = 0.8}},
	{ area_name = "PALUBA_MIDLE_02",		area_arg = 92, area_life = 100, area_fire = { connector = "FIRE_PALUBA_MIDLE_02", size = 0.8}},
	{ area_name = "PALUBA_BACK_01", 		area_arg = 78, area_life = 100, area_fire = { connector = "FIRE_PALUBA_BACK_01", size = 0.8}},
	{ area_name = "PALUBA_BACK_02", 		area_arg = 93, area_life = 100, area_fire = { connector = "FIRE_PALUBA_BACK_02", size = 0.8}},
	
	{ area_name = "BACK", 					area_arg = 79, area_life = 100},
	{ area_name = "RUBKA",					area_arg = 80, area_life = 100, area_fire = { connector = "FIRE_RUBKA", size = 0.8}},
	{ area_name = "MACHTA",					area_arg = 81, area_life = 100},
	{ area_name = "TOWER",					area_arg = 82, area_life = 100},

	{ area_name = "ZA_NR",					area_arg = 99, area_life = 30},
	{ area_name = "ZA_BR",					area_arg = 100, area_life = 30},
	{ area_name = "ZA_BL",					area_arg = 101, area_life = 30},
	{ area_name = "NADSTROYKA_NR",			area_arg = 102, area_life = 30},
	{ area_name = "NADSTROYKA_BL",			area_arg = 103, area_life = 30},
	{ area_name = "NADSTROYKA_NL",			area_arg = 104, area_life = 30},
	{ area_name = "ZRK_BR",					area_arg = 105, area_life = 30},
	--{ area_name = "ZRK_NR",					area_arg = 105, area_life = 30},
	
	
	{ area_name = "LIFT_01",				area_arg = 109, area_life = 50},
	{ area_name = "LIFT_02",				area_arg = 110, area_life = 50},
}

--------------------------------------------------------------------------------
-- LIGHTS
--------------------------------------------------------------------------------
GT.animation_arguments.luna_lights = 405;

--------------------------------------------------------------------------------
-- SURFACE RADARS
--------------------------------------------------------------------------------
GT.animation_arguments.radar1_rotation = 11;
GT.radar1_period = 3;
GT.animation_arguments.radar2_rotation = 12;
GT.radar2_period = 20;
GT.animation_arguments.radar3_rotation = 13;
GT.radar2_period = 45;

GT.airFindDist		= 150000;	-- Max detenction range air threats (meters)
GT.airWeaponDist	=  20000;	-- Max engagement range air threats (meters)

GT.sensor =	{
				max_range_finding_target = 150000,
				min_range_finding_target = 0,
				max_alt_finding_target = 20000,
				min_alt_finding_target = 0,
				pos = {-15.0, 30.0, 10.0} -- search radar position
			};
			
GT.WS = {}
GT.WS.maxTargetDetectionRange = 300000;
GT.WS.radar_type = 104
GT.WS.searchRadarMaxElevation = math.rad(50);

--------------------------------------------------------------------------------
-- TAS - Target Acquisition System x 2
--------------------------------------------------------------------------------
-- FWD
ws = GT_t.inc_ws();
local first_MK23_tracker_id = ws;
GT.WS[ws]	= {
	omegaY	= 1,
	omegaZ	= 1,
	pidY	= {p=100, i=0.05, d=12, inn = 50},
	pidZ	= {p=100, i=0.05, d=12, inn = 50},
	area	= 'RUBKA',
	center	= 'CENTER_RADAR_9',	-- Radar mount center
	drawArgument1	= 27,
	drawArgument2	= 28,
	reference_angle_Y	= math.rad(45),
	reference_angle_Z	= math.rad(45),
	angles	= { {math.rad(150), math.rad(-60), math.rad(-5), math.rad(90)} },
	LN		= {
				[1] = {
						type = 102,
						frequencyRange = {0.5e9, 0.58e9},
						distanceMin = 400,
						distanceMax = 30000,
						reactionTime = 2.5,
						reflection_limit = 0.1,
						ECM_K = 0.65,
						min_trg_alt = 5,
						max_trg_alt = 15000,
						max_number_of_missiles_channels = 1,
						beamWidth = math.rad(90);
					}
			}
};

local MK23_TRACKERS_FWD = {{{'self', ws}}}

-- AFT
ws = GT_t.inc_ws();
GT.WS[ws]	= {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK23_tracker_id]);
GT.WS[ws].center			= 'CENTER_RADAR_10'
GT.WS[ws].drawArgument1		= 29
GT.WS[ws].drawArgument2		= 30
GT.WS[ws].reference_angle_Y	= math.rad(-135)
GT.WS[ws].reference_angle_Z	= math.rad(45)
GT.WS[ws].angles	= { {math.rad(-10), math.rad(140), math.rad(-5), math.rad(90)} }

local MK23_TRACKERS_AFT = {{{'self', ws}}}

-- Adds both trackers
table.insert(MK23_TRACKERS_FWD, MK23_TRACKERS_AFT)

--------------------------------------------------------------------------------
-- ARMAMENT
--------------------------------------------------------------------------------
local ws = GT_t.inc_ws();

--------------------------------------------------------------------------------
-- CIWS Phalanx x 2 
--------------------------------------------------------------------------------
-- FWD Starboard
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].angles		= { {math.rad(90), math.rad(-160), math.rad(-5), math.rad(80)} }
GT.WS[ws].center			= 'Gun_Center_lha_01' 
GT.WS[ws].drawArgument1 	= 17
GT.WS[ws].drawArgument2		= 18
GT.WS[ws].reference_angle_Y	= math.rad(0)
GT.WS[ws].LN[1].BR[1].connector_name	= 'Gun_Point_lha_01';
GT.WS[ws].LN[1].fireAnimationArgument	= 119;
GT.WS[ws].LN[1].createMuzzleFlashEffect	= true;

-- AFT Port
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].angles		= { {math.rad(-135), math.rad(45), math.rad(-5), math.rad(80)} }
GT.WS[ws].center			= 'Gun_Center_lha_02'
GT.WS[ws].drawArgument1		= 19
GT.WS[ws].drawArgument2		= 20
GT.WS[ws].reference_angle_Y	= math.rad(180)
GT.WS[ws].LN[1].BR[1].connector_name	= 'Gun_Point_lha_02';
GT.WS[ws].LN[1].fireAnimationArgument	= 120;
GT.WS[ws].LN[1].createMuzzleFlashEffect	= true;

--------------------------------------------------------------------------------
-- RIM-116 RAMs x 2
--------------------------------------------------------------------------------
-- FWD Starboard
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.RIM_116)
GT.WS[ws].area		= 'NADSTROYKA_NR'												-- Collision Model Zone
GT.WS[ws].center	= 'RAM_Center_lha_01'											-- Launcher centerpoint
GT.WS[ws].angles	= { {math.rad(150), math.rad(-60), math.rad(0), math.rad(90)} }	-- Mount rotation angles
GT.WS[ws].drawArgument1		= 23	-- Traverse
GT.WS[ws].drawArgument2		= 24	-- Elevation
GT.WS[ws].reference_angle_Z	= math.rad(45)	-- At rest elevation
GT.WS[ws].reference_angle_Y	= math.rad(45)	-- At rest traverse
GT.WS[ws].LN[1].BR = {
						{connector_name = 'Rocket_Point_001', drawArgument = 158},
						{connector_name = 'Rocket_Point_002', drawArgument = 159},
						{connector_name = 'Rocket_Point_003', drawArgument = 160},
						{connector_name = 'Rocket_Point_004', drawArgument = 161},
						{connector_name = 'Rocket_Point_005', drawArgument = 162},
						{connector_name = 'Rocket_Point_006', drawArgument = 163},
						{connector_name = 'Rocket_Point_007', drawArgument = 164},
						{connector_name = 'Rocket_Point_008', drawArgument = 165},
						{connector_name = 'Rocket_Point_009', drawArgument = 166},
						{connector_name = 'Rocket_Point_010', drawArgument = 167},
						{connector_name = 'Rocket_Point_011', drawArgument = 168},
						{connector_name = 'Rocket_Point_012', drawArgument = 169},
						{connector_name = 'Rocket_Point_013', drawArgument = 170},
						{connector_name = 'Rocket_Point_014', drawArgument = 171},
						{connector_name = 'Rocket_Point_015', drawArgument = 172},
						{connector_name = 'Rocket_Point_016', drawArgument = 173},
						{connector_name = 'Rocket_Point_017', drawArgument = 174},
						{connector_name = 'Rocket_Point_018', drawArgument = 175},
						{connector_name = 'Rocket_Point_019', drawArgument = 176},
						{connector_name = 'Rocket_Point_020', drawArgument = 177},
						{connector_name = 'Rocket_Point_021', drawArgument = 178},
					}
GT.WS[ws].LN[1].depends_on_unit = MK23_TRACKERS_FWD

-- AFT Port
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.RIM_116)
GT.WS[ws].area		= 'NADSTROYKA_BL'													-- Collision Model Zone
GT.WS[ws].center	= 'RAM_Center_lha_02'												-- Launcher centerpoint
GT.WS[ws].angles	= { {math.rad(-10), math.rad(140), math.rad(0), math.rad(90)} }		-- Launcher rotation angles
GT.WS[ws].drawArgument1	= 25					-- Traverse
GT.WS[ws].drawArgument2	= 26					-- Elevation
GT.WS[ws].reference_angle_Z	= math.rad(0)		-- At rest elevation
GT.WS[ws].reference_angle_Y	= math.rad(180)		-- At rest traverse
GT.WS[ws].LN[1].BR = {
						{connector_name = 'Rocket_Point_022', drawArgument = 180},
						{connector_name = 'Rocket_Point_023', drawArgument = 181},
						{connector_name = 'Rocket_Point_024', drawArgument = 182},
						{connector_name = 'Rocket_Point_025', drawArgument = 183},
						{connector_name = 'Rocket_Point_026', drawArgument = 184},
						{connector_name = 'Rocket_Point_027', drawArgument = 185},
						{connector_name = 'Rocket_Point_028', drawArgument = 186},
						{connector_name = 'Rocket_Point_029', drawArgument = 187},
						{connector_name = 'Rocket_Point_030', drawArgument = 188},
						{connector_name = 'Rocket_Point_031', drawArgument = 189},
						{connector_name = 'Rocket_Point_032', drawArgument = 190},
						{connector_name = 'Rocket_Point_033', drawArgument = 191},
						{connector_name = 'Rocket_Point_034', drawArgument = 192},
						{connector_name = 'Rocket_Point_035', drawArgument = 193},
						{connector_name = 'Rocket_Point_036', drawArgument = 194},
						{connector_name = 'Rocket_Point_037', drawArgument = 195},
						{connector_name = 'Rocket_Point_038', drawArgument = 196},
						{connector_name = 'Rocket_Point_039', drawArgument = 197},
						{connector_name = 'Rocket_Point_040', drawArgument = 198},
						{connector_name = 'Rocket_Point_041', drawArgument = 199},
						{connector_name = 'Rocket_Point_042', drawArgument = 200},
					}
GT.WS[ws].LN[1].depends_on_unit = MK23_TRACKERS_AFT

--------------------------------------------------------------------------------
-- SHIP VALUES
--------------------------------------------------------------------------------
GT.Name				= "LHA_Tarawa"
GT.DisplayName		= _("LHA-1 Tarawa")
GT.DisplayNameShort	= _("Tarawa")

GT.Rate				= 5500.000000;
GT.mapclasskey		= "P0091000067";
GT.attribute		= {wsType_Navy, wsType_Ship, wsType_AirCarrier, WSTYPE_PLACEHOLDER,
						"Aircraft Carriers",
						"ski_jump",
						"RADAR_BAND1_FOR_ARM",
						"RADAR_BAND2_FOR_ARM",
						"DetectionByAWACS",
					};
GT.Categories		= {
						{name = "AircraftCarrier"},
						{name = "AircraftCarrier With Tramplin"},
						{name = "Armed Ship"}
					};

GT.Sensors 			= {  
						OPTIC = {"long-range naval optics", "long-range naval LLTV"},
						RADAR = {"seasparrow tr","carrier search radar",},
					};
GT.DetectionRange	= GT.airFindDist;
GT.ThreatRange		= GT.airWeaponDist;
GT.Singleton		= "yes";

GT.Countries		= { "USA",};
GT.tags 			= { "Carrier", };
--------------------------------------------------------------------------------
add_surface_unit(GT)
