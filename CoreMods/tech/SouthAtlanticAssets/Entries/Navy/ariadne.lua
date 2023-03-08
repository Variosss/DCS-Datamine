-- MOD for DCS WORLD 
-- Leander Class Frigate - Ariadne - Naval Gun Variant.

----- Shapes --------------------------------------------------
--mount_vfs_model_path	(current_mod_path.."/Shapes/")

----- Textures ---------------------------------------------------
--mount_vfs_texture_path  (current_mod_path.."/Textures/");
--mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Leander/leander.zip");
--mount_vfs_liveries_path (current_mod_path.."/Liveries");

GT = {};
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship);

GT.visual = {};
GT.visual.shape = "leander-gun-ariadne";
GT.visual.shape_dstr = "";
--####################################################################################
--###                           Animation Arguments                                ###
--####################################################################################

GT.animation_arguments = {
				radar1_rotation = 11, -- Flag Animation
				radar2_rotation = 2, -- Radar 2 Rotation
				radar3_rotation = 3, -- Radar 3 Rotation
				luna_lights = -1, -- Running Lights (Disabled)
				water_propeller = 8,
				flight_deck_fences = 88,
				nav_lights = 69,
}
GT.radar1_period = 1;
GT.radar2_period = 9;
GT.radar3_period = 6;

--####################################################################################
--###                         General Ship Parameters                              ###
--####################################################################################

GT.life = 1000;
GT.mass = 3200000;
GT.max_velocity = 14.4;
GT.race_velocity = 15;
GT.economy_velocity = 7.2;
GT.economy_distance = 4200000;
GT.race_distance = 3000000;
GT.shipLength = 110.15;
GT.Width = 13;      	-- set this - Total Ship max width
GT.Height = 29.5;    	-- set this - Total Ship Height above 0
GT.Length = 113.64;   	-- set this - Total Ship Length
GT.DeckLevel = 4.511;	-- set this - Height of the main deck (mainly for Aircraft Carriers)
GT.X_nose = 56.851;		-- set this - Position of the bow ref. ship datum 0
GT.X_tail = -56.857;	-- set this - Position of the stern ref. ship datum 0
GT.Tail_Width = 5.2;	-- set this - Width of the stern (used to caclulate wake width?  Usually the width of the propellors)
GT.draft = 7;
GT.Gamma_max = 0.35;
GT.Om = 0.05;
GT.speedup = 0.0814062;
GT.R_min = 208.4;
GT.distFindObstacles = 250.0;
GT.airWeaponDist = 140000;
GT.airFindDist = 180000;
GT.numParking = 1
GT.Helicopter_Num_ = 1
GT.Landing_Point = {-33.57, 4.511, 0.0}

GT.exhaust =
{
	[1] = { size = 0.20 , pos = {-3.435 , 15.04, 0.5 } },
	[2] = { size = 0.20 , pos = {-3.435 , 15.04, -0.5 } },
}


--####################################################################################
--###                               Damage Model                                   ###
--####################################################################################

GT.DM = {
	{ area_name = "DMG-BOW-AW",						area_arg = 72,	area_life = 40, area_fire = { pos = {52.9, 0, 3.7}, size = 0.7}},
	{ area_name = "DMG-BOW-BW", 					area_arg = 73,	area_life = 40, area_fire = { pos = {51, 0,-1.7}, size = 0.7}},
	{ area_name = "PALUBA-FOCSLE", 					area_arg = 74,	area_life = 60, area_fire = { pos = {38.3, 0, 6.74}, size = 0.8}},
    { area_name = "DMG-HULL-AW-FWD-STBD",			area_arg = 75,	area_life = 60, area_fire = { pos = {42.2, 2.4, 1.73}, size = 1.5}},
    { area_name = "DMG-HULL-AW-FWD-PORT",			area_arg = 76,	area_life = 60, area_fire = { pos = {42.2, -2.4, 1.73}, size = 1.5}},
	{ area_name = "DMG-HULL-BW-FWD", 				area_arg = 77,	area_life = 60, area_fire = { pos = {38.3, 0, -2.9}, size = 1.5}},
 	{ area_name = "DMG-HULL-AW-AND-TURRET-A", 		area_arg = 78,	area_life = 60, area_fire = { pos = {22.8, 0, 4.5}, size = 1.5}},
 	{ area_name = "DMG-HULL-BW-FWD-MIDSHIPS", 		area_arg = 79,	area_life = 60, area_fire = { pos = {10.2, 0, -2.2}, size = 1.5}},

 	{ area_name = "DMG-BRIDGE", 					area_arg = 80,	area_life = 60, area_fire = { pos = {10.8, 0, 5.6}, size = 1.5}},

    { area_name = "DMG-HULL-AW-FWD-MIDSHIPS-STBD", 	area_arg = 81,	area_life = 60, area_fire = { pos = {5, 6.45, 1.3}, size = 1.5}},
 	{ area_name = "DMG-HULL-AW-FWD-MIDSHIPS-PORT", 	area_arg = 82,	area_life = 60, area_fire = { pos = {5, -6.45, 1.3}, size = 1.5}},

 	{ area_name = "DMG-SS-REAR-MIDSHIPS-FUNNEL", 	Area_arg = 83,	area_life = 60, area_fire = { pos = {-7.9, 0, 5}, size = 1.5}},

 	{ area_name = "DMG-HULL-AW-AFT-MIDSHIPS-STBD", 	area_arg = 84,	area_life = 60, area_fire = { pos = {-14.3, 6.45, 1.3}, size = 1.5}},
 	{ area_name = "DMG-HULL-AW-AFT-MIDSHIPS-PORT", 	area_arg = 85,	area_life = 60, area_fire = { pos = {-14.3, -6.45, 1.3}, size = 1.5}},

 	{ area_name = "DMG-SS-AFT-SEACAT-HANGAR", 		area_arg = 86,	area_life = 60, area_fire = { pos = {-19.7, 0, 6.15}, size = 1.5}},
 	{ area_name = "DMG-HULL-BW-AFT-ENGINE-PLANT", 	area_arg = 87,	area_life = 60, area_fire = { pos = {-21.9, 0, 1.3}, size = 1.5}},
 	{ area_name = "PALUBA-FLIGHT-DECK",			 	area_arg = 88,	area_life = 60, area_fire = { pos = {-30.5, 0, 3.6}, size = 1.5}},
 	{ area_name = "DMG-AFT-HULL-AND-LIMBO", 		area_arg = 89,	area_life = 60, area_fire = { pos = {-40, 0, 1.3}, size = 1.5}},
 	{ area_name = "DMG-HULL-STERN", 				area_arg = 90,	area_life = 60, area_fire = { pos = {-49.9, 0, 1.3}, size = 1.5}},

 	{ area_name = "DMG-REAR-MAST", 					area_arg = 91,	area_life = 60, area_fire = { pos = { -14.15, 0, 11.3 }, size = 0.5 } },
 	{ area_name = "DMG-MAST-FORE-UPPER", 			area_arg = 92,	area_life = 60, area_fire = { pos = { 5.75, 0, 14.9 }, size = 0.5 } },

	{ area_name = "Leander_Destroyed",				area_arg = 77,	area_life = 60, area_fire = { pos = {-2.1, 2, 0.0}, size = 3}},

}

--####################################################################################
--###                                 Armament                                     ###
--####################################################################################

GT.WS = {};
GT.WS.maxTargetDetectionRange = 450000;
GT.WS.radar_type = 102;
GT.WS.searchRadarMaxElevation = math.rad(60);
GT.WS.searchRadarFrequencies = {{50.0e6, 54.0e6}, {2.0e9, 2.2e9}};

--Test Optical 
GT.WS = {}
GT.WS.maxTargetDetectionRange = 25000;
GT.WS.radar_type = 109 --optical in wstypes
GT.WS.searchRadarMaxElevation = math.rad(70);

local ws;

--####################################################################################
--###                              Radar Trackers                                  ###
--####################################################################################

ws = GT_t.inc_ws();
local first_MK95_tracker_id = ws;
GT.WS[ws] = {
	omegaY = 1,
	omegaZ = 1,
	pidY = {p=100, i=0.05, d=12, inn = 50},
	pidZ = {p=100, i=0.05, d=12, inn = 50},
	area = "DMG-REAR-MAST",
	center = 'CENTER_RADAR_01',
	--drawArgument =
	--drawArgument =
	reference_angle_Y = math.rad(90),
	angles = {
				{math.rad(180), math.rad(90), math.rad(-10), math.rad(80) }
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
		beamWidth = math.rad(90)
		}
	}
};

local MK95_TRACKERS = {{{'self', ws}}};

ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT.WS[first_MK95_tracker_id]);
GT.WS[ws].area = "DMG-MAST-FORE-UPPER"
GT.WS[ws].center = 'CENTER_RADAR_02'
--GT.WS[ws].drawArgument1 =
--GT.WS[ws].drawArgument2 =
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].angles = {
				{math.rad(90), math.rad(-170)}
				}
table.insert(MK95_TRACKERS, {{'self', ws}});


--####################################################################################
--###      Turret A - Twin 4.5in (115mm) Mk 6 Mount Naval Cannon AA/AS             ###
--####################################################################################

ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_45cal_Mk6 );
GT.WS[ws].area = 'DMG-HULL-AW-AND-TURRET-A';
GT.WS[ws].center = 'CENTER_TOWER_01';
GT.WS[ws].drawArgument1 = 41;
GT.WS[ws].drawArgument2 = 51;
GT.WS[ws].angles = { 
					{math.rad(150),math.rad(40),math.rad(-2),math.rad(80)},
					{math.rad(40),math.rad(-40),math.rad(5),math.rad(80)},
					{math.rad(-40),math.rad(-150),math.rad(-2),math.rad(80)}
					}
GT.WS[ws].reference_angle_Z = math.rad(5);
GT.WS[ws].LN[1].BR = {
	{
		connector_name = 'POINT_NC_1_1',
		recoilArgument = 33,
	},
	{
		connector_name = 'POINT_NC_1_2',
		recoilArgument = 32,
	}
}
GT.WS[ws].LN[1].BR[1].recoilTime = 0.6;
GT.WS[ws].LN[1].BR[2].recoilTime = 0.6;

-- --####################################################################################
-- --###              Single 20mm Oerlikon mm gun - Superstructure Port               ###
-- --####################################################################################

ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_Oerlikon_20 );
GT.WS[ws].area = 'DMG-BRIDGE';
GT.WS[ws].center = 'CENTER_TOWER_02';
GT.WS[ws].drawArgument1 = 42;
GT.WS[ws].drawArgument2 = 52;
GT.WS[ws].angles = {{math.rad(-165), math.rad(5), math.rad(-5), math.rad(70)},};
GT.WS[ws].reference_angle_Y = math.rad(90);  
GT.WS[ws].reference_angle_Z = math.rad(5);  
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_Oerlikon_2_1'

-- --####################################################################################
-- --###              Single 20mm Oerlikon mm gun - Superstructure Stbd               ###
-- --####################################################################################

ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws],GT_t.WS_t.ship_Oerlikon_20  );
GT.WS[ws].area = 'DMG-BRIDGE';
GT.WS[ws].center = 'CENTER_TOWER_03';
GT.WS[ws].drawArgument1 = 43;
GT.WS[ws].drawArgument2 = 53;
GT.WS[ws].angles = 	{{math.rad(-5), math.rad(165), math.rad(-5), math.rad(70)},};
GT.WS[ws].reference_angle_Y = math.rad(-90);  
GT.WS[ws].reference_angle_Z = math.rad(5);
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_Oerlikon_3_1'


--####################################################################################
--###               Sea Cat Missile System - Rear Superstructure                   ###
--####################################################################################
ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_Sea_Cat);
GT.WS[ws].area = 'DMG-SS-AFT-SEACAT-HANGAR'
GT.WS[ws].center = 'CENTER_TOWER_04'
GT.WS[ws].drawArgument1 = 44
GT.WS[ws].drawArgument2 = 54
GT.WS[ws].angles = {
					 {math.rad(180), math.rad(20), math.rad(0), math.rad(90)},
					 {math.rad(20), math.rad(-20), math.rad(70), math.rad(90)},
					 {math.rad(-20), math.rad(-180), math.rad(0), math.rad(90)},
				   }
GT.WS[ws].reference_angle_Z = math.rad(90)
GT.WS[ws].LN[1].BR = {
						{connector_name = 'CON-SEACAT-ATTACH-001'},
						{connector_name = 'CON-SEACAT-ATTACH-002'},
						{connector_name = 'CON-SEACAT-ATTACH-003'},
						{connector_name = 'CON-SEACAT-ATTACH-004'},
					}

--GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS



--####################################################################################
--###            Set the ship classification for the filter in the ME              ###
--####################################################################################

GT.tags  =
{
	"Frigate",
}

--####################################################################################
--###                             The Final Code                                   ###
--###           Is in the ship definition file that calls this one.                ###
--####################################################################################

GT.airWeaponDist = 100000;
GT.airFindDist = 150000;
GT.Name = "leander-gun-ariadne";
GT.DisplayName = _("HMS Ariadne (F72)");
GT.Rate = 4000;

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV", "long-range naval FLIR",},
                RADAR = {
--                   "ticonderoga search radar",
                   "Patriot str",
                }
            };

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="yes";
GT.mapclasskey = "P0091000070";

GT.attribute = {wsType_Navy,wsType_Ship,wsType_ArmedShip,REZKY,
                    "Frigates",
                    "RADAR_BAND1_FOR_ARM",
                    "DetectionByAWACS",
				};
			

GT.Categories = {
					{name = "Armed Ship"},
					{name = "HelicopterCarrier"}
				};
				
GT.Countries		= {"UK"};

add_surface_unit(GT);