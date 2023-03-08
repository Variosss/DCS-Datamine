-- CV-59 USS Forrestal

GT = {};
dofile(current_mod_path..'/Entry/CV-59-Forrestal_RunwaysAndRoutes.lua')
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "CV-59-Forrestal_LOD0"
GT.visual.shape_dstr = ""

GT.life = 7300;
GT.mass = 7.2916e+007;
GT.max_velocity = 18.4333;
GT.race_velocity = 18.4333;
GT.economy_velocity = 15.4333;
GT.economy_distance = 7.408e+007;
GT.race_distance = 7.408e+007;
GT.shipLength = 332.9;
GT.Width = 96;
GT.Height = 57.8;
GT.Length = 332.9;
GT.DeckLevel = 18.46;
GT.X_nose = 141.0;
GT.X_tail = -140.0;
GT.Tail_Width = 22;
GT.Gamma_max = 0.35;
GT.Om = 0.05;
GT.speedup = 0.119249;
GT.R_min = 665.8;
GT.distFindObstacles = 1048.7;
GT.TACAN = true;
GT.TACAN_position = {-55.0, 55.0, 29.0}
GT.ICLS = true;
GT.ICLS_Localizer_position = {-137.5, 12.0, 6.9, 189.4}	-- {x [m], y [m], z [m], yaw [deg]}
GT.ICLS_Glideslope_position = {-68.8, 26.5, 21.3, 3.5}	-- {x [m], y [m], z [m], glideslope = 3.5 [deg]}
GT.OLS = {Type = GT_t.OLS_TYPE.IFLOLS, CutLightsArg = 404, DatumAndWaveOffLightsArg = 405, MeatBallArg = 151, GlideslopeBasicAngle = 3.5, VerticalCoverageAngle = 1.7}

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
-- weapon systems
local LSO_Station = { HQ_model = "empty", dockConnector  = "LSO_VIEW" , hide_argument = 821 , cameraPos 			=  {-109,19.8,-18.7,180}} --this camera pos works

GT.Stations = 	{	LSO = LSO_Station, }

GT.LSOView = {cockpit = "empty", position = {--[[connector = "LSO_VIEW", ]]offset = {0.0, 0.0, 0.0, 0.0, 0.0}}} --this offset has no effect but the line needs to be here

GT.Landing_Point = {-104.0, 19.6, -33.0}
GT.animation_arguments.arresting_wires = {400, 401, 402, 403}
GT.animation_arguments.catapult_shuttles = {145, 146, 147, 148}
GT.animation_arguments.landing_strip_illumination = 150;

GT.animation_arguments.elevators = {57, 58, 59, 60};
GT.animation_arguments.elevators_doors = {47, 48, 53, 54};

--Radar/Sensor animations
GT.animation_arguments.radar1_rotation = 1; -- SPS-48
GT.animation_arguments.radar2_rotation = 2; -- secondary search radar
GT.animation_arguments.radar3_rotation = 3; -- navigation radar

--Lighting
	--150: Runway
	--790: Launch floods
	--791: 59 Illum
	--792: Underway/Navigation
	--793: Square Island 
	--794: Island interior Red

	--Navigation: Runway + Nav + Cockpit
	--Launch: Floods + Runway + Cockpit + Square + Nav
	--Recovery: Square + Runway + Cockpit + Nav

	--{int ArgumentNo, float OffValue, float OnValue, [float AnimationDuration],  [bool cycleAnimation]}

GT.carrierIlluminationStates = { 
	{{792, 0.0, 1.0}, {794, 0.0, 1.0}, {150, 0.0, 1.0}  }, --NAV_LIGHTS
	{{790, 0.0, 1.0}, {792, 0.0, 1.0}, {793, 0.0, 1.0}, {794, 0.0, 1.0}, {150, 0.0, 1.0}  }, -- AC_LAUNCH_STATE
	{{793, 0.0, 1.0}, {794, 0.0, 1.0}, {792, 0.0, 1.0}, {150, 0.0, 1.0}  }, -- AC_RECOVERY_STATE
   }

--Smokestack
GT.exhaust =
{
	[1] = { size = 0.35 , pos = {5, 37, 28} },
 }

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
	{ area_name = "CENTER_L_03", 			area_arg = 98, area_life = 150},
    { area_name = "BACK_L", 				area_arg = 75, area_life = 300, area_fire = { connector = "FIRE_BACK_L", size = 0.5}},
	
	{ area_name = "PALUBA_NOSE",			area_arg = 76, area_life = 100, area_fire = { connector = "FIRE_PALUBA_NOSE", size = 0.8}, belongsToRunway = true},
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
	{ area_name = "LIFT_03",				area_arg = 111, area_life = 50},
	{ area_name = "LIFT_04",				area_arg = 112, area_life = 50},
}

GT.WS = {}
GT.WS.maxTargetDetectionRange = 50000;
GT.WS.radar_type = 104
GT.WS.searchRadarMaxElevation = math.rad(50);

-- CWIS Rear Left
local ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].angles = {
					 {math.rad(-165), math.rad(25), math.rad(-5), math.rad(85)},	--main angle
					 {math.rad(25), math.rad(0), math.rad(35), math.rad(85)},		--far deck
					 {math.rad(0), math.rad(-165), math.rad(75), math.rad(85)},		--close deck
				   }
GT.WS[ws].center = 'CIWS_RL_CENTER'
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR[1].connector_name = 'CIWS_RL_BARREL';
GT.WS[ws].LN[1].fireAnimationArgument = 120; --todo arg
GT.WS[ws].LN[1].createMuzzleFlashEffect = true;

-- CWIS Forward Left
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].angles = {
					 {math.rad(-179), math.rad(145), math.rad(15), math.rad(85)}, -- over deck backwards
					 {math.rad(145), math.rad(30), math.rad(-5), math.rad(85)}, --main angle
					 {math.rad(30), math.rad(0), math.rad(15), math.rad(85)}, -- over reilings
					 {math.rad(0), math.rad(-179), math.rad(75), math.rad(85)}, -- over deck
				   }
GT.WS[ws].center = 'CIWS_FL_CENTER'
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR[1].connector_name = 'CIWS_FL_BARREL';
GT.WS[ws].LN[1].fireAnimationArgument = 121; --todo arg

-- CWIS Island (right)
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
GT.WS[ws].angles = {

					 {math.rad(0), math.rad(-25), math.rad(-5), math.rad(18)}, -- front
					 {math.rad(-25), math.rad(-55), math.rad(-5), math.rad(60)}, -- under the balcony
					 {math.rad(-55), math.rad(-140), math.rad(-5), math.rad(85)}, -- main angle
					 {math.rad(-140), math.rad(175), math.rad(-5), math.rad(12)}, -- backwards

				   }
GT.WS[ws].center = 'CIWS_ISLAND_CENTER'
GT.WS[ws].drawArgument1 = 21
GT.WS[ws].drawArgument2 = 22
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR[1].connector_name = 'CIWS_ISLAND_BARREL';
GT.WS[ws].LN[1].fireAnimationArgument = 119;


-- Mk 95 radars
--Rear Left Lower
ws = GT_t.inc_ws();
local first_MK95_tracker_id = ws;
GT.WS[ws] = {
	omegaY = 1,
	omegaZ = 1,
	pidY = {p=100, i=0.05, d=12, inn = 50},
	pidZ = {p=100, i=0.05, d=12, inn = 50},
--	area = 'RUBKA',
	center = 'CENTER_RADAR_10',
	drawArgument1 = 6,
	drawArgument2 = 7,
	reference_angle_Y = math.rad(90),
	angles = { 
				{math.rad(-150), math.rad(30), math.rad(-10), math.rad(80)}
			},
	LN = {
		[1] = {
			type = 102,
			frequencyRange = {0.5e9, 0.58e9},
			distanceMin = 400,
			distanceMax = 50000,
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

--Rear Left Upper
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
GT.WS[ws].center = 'CENTER_RADAR_11'
GT.WS[ws].drawArgument1 = 8
GT.WS[ws].drawArgument2 = 9
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].angles = {{ math.rad(180), math.rad(10), math.rad(-10), math.rad(80)} }
table.insert(MK95_TRACKERS, {{'self', ws}})

--Island Lower
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
--GT.WS[ws].area = 'TOWER'
GT.WS[ws].center = 'CENTER_RADAR_12'
GT.WS[ws].drawArgument1 = 10
GT.WS[ws].drawArgument2 = 11
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].angles = { {math.rad(45), math.rad(-180), math.rad(-10), math.rad(80)} }
table.insert(MK95_TRACKERS, {{'self', ws}})

--Island Upper
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
--GT.WS[ws].area = 'TOWER'
GT.WS[ws].center = 'CENTER_RADAR_13'
GT.WS[ws].drawArgument1 = 12
GT.WS[ws].drawArgument2 = 13
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].angles = { {math.rad(45), math.rad(-180), math.rad(-10), math.rad(80)} }
table.insert(MK95_TRACKERS, {{'self', ws}})


--Mk 57 Mod3 Sea Sparrow
--forward right
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.seasparrow)
--GT.WS[ws].area = 'RIM7_FR_CENTER'	--todo add damage area (see collison.edm)
GT.WS[ws].center = 'RIM7_RL_CENTER'
GT.WS[ws].angles_mech = {
							{math.rad(180), math.rad(-180), math.rad(-5), math.rad(85)}
						}
GT.WS[ws].angles = {
					 {math.rad(170), math.rad(0), math.rad(55), math.rad(80)},	-- over the deck
					 {math.rad(0), math.rad(-25), math.rad(15), math.rad(80)},	--forward dir, parallel to deck
					 {math.rad(-25), math.rad(-135), math.rad(-5), math.rad(80)}, --main angle
					 {math.rad(-135), math.rad(170), math.rad(65), math.rad(80)}, --over the tower
				   }
GT.WS[ws].drawArgument1 = 49
GT.WS[ws].drawArgument2 = 50
GT.WS[ws].reference_angle_Y = math.rad(-90)
--GT.WS[ws].LN[1].min_launch_angle = math.rad(15);
GT.WS[ws].LN[1].BR = {
						{connector_name = 'ROCKET_POINT_09', drawArgument = 153},
						{connector_name = 'ROCKET_POINT_10', drawArgument = 154},
						{connector_name = 'ROCKET_POINT_11', drawArgument = 155},
						{connector_name = 'ROCKET_POINT_12', drawArgument = 156},
						{connector_name = 'ROCKET_POINT_13', drawArgument = 157},
						{connector_name = 'ROCKET_POINT_14', drawArgument = 158},
						{connector_name = 'ROCKET_POINT_15', drawArgument = 159},
						{connector_name = 'ROCKET_POINT_16', drawArgument = 160}
					}
GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS

--rear left
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.seasparrow)
--GT.WS[ws].area = 'RIM7_RL_CENTER' --todo add damage area (see collison.edm)
GT.WS[ws].center = 'RIM7_RL_CENTER'
GT.WS[ws].angles_mech = {
							{math.rad(180), math.rad(-180), math.rad(-5), math.rad(85)}
						}
GT.WS[ws].angles = {
					 {math.rad(-165), math.rad(30), math.rad(-5), math.rad(80)}, --main angle
					 {math.rad(30), math.rad(178), math.rad(76), math.rad(80)}, -- over the deck
					 {math.rad(178), math.rad(-165), math.rad(25), math.rad(80)}, -- parallel to deck, backwards
				   }
GT.WS[ws].drawArgument1 = 51
GT.WS[ws].drawArgument2 = 52
GT.WS[ws].reference_angle_Y = math.rad(90)
--GT.WS[ws].LN[1].min_launch_angle = math.rad(15);
GT.WS[ws].LN[1].BR = {
						{connector_name = 'ROCKET_POINT_01', drawArgument = 161},
						{connector_name = 'ROCKET_POINT_02', drawArgument = 162},
						{connector_name = 'ROCKET_POINT_03', drawArgument = 163},
						{connector_name = 'ROCKET_POINT_04', drawArgument = 164},
						{connector_name = 'ROCKET_POINT_05', drawArgument = 165},
						{connector_name = 'ROCKET_POINT_06', drawArgument = 166},
						{connector_name = 'ROCKET_POINT_07', drawArgument = 167},
						{connector_name = 'ROCKET_POINT_08', drawArgument = 168}
					}
GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS

-- RIM-116 Rolling Airframe Missile
--GT.WS[ws].reference_angle_Z = math.rad(30)
--GT.WS[ws].reference_angle_Y = math.rad(90)
					
GT.Name = "Forrestal"
GT.DisplayName = _("CV-59 Forrestal")
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
					
GT.tags  =
{
	"Carrier",
}

GT.Categories		= {
						{name = "AircraftCarrier"},
						{name = "AircraftCarrier With Catapult"},
						{name = "Armed Ship"},
						{name = "AircraftCarrier With Arresting Gear"}
					};
GT.Countries		= {"USA"}