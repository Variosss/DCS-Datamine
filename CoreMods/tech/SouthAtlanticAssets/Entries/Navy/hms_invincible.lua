-- raz_invincible (based on HMS Invincible R05 c. 1982)

mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/hms_invincible/hms_invincible.zip");

GT = {};														-- Initialise the object properties/methods for the whole mod (as a "Weapon System"?) 
-- ===========================================================================================================================
local navy_path = '/Entries/Navy/'
dofile(current_mod_path .. navy_path ..'/hms_invincibleRunwaysAndRoutes.lua');		-- Include/insert additional definitions from this file here in the code.  This is the file with the runways and taxi routes specific to this variant of the module.
-- ===========================================================================================================================

GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship);

GT.visual = {};													
GT.visual.shape = "hms_invincible";						
GT.visual.shape_dstr = "";										


GT.life = 7200;											
GT.mass = 20000000;										
GT.max_velocity = 14.4;									
GT.race_velocity = 10.8;								
GT.economy_velocity = 9.26;								
GT.economy_distance = 13000;							
GT.race_distance = 2.778e+006;							
GT.shipLength = 209.431;  								
GT.Width = 37.371; 										
GT.Height = 53.41;										
GT.Length = 236;										
GT.DeckLevel = 14.709;									
GT.X_nose = 97.466;
--GT.X_nose = 107.0;									
GT.X_tail = -99.319;									
GT.Tail_Width = 14.8;
GT.draft = 11;		    					
GT.Gamma_max = 0.35;									
GT.Om = 0.05;											
GT.speedup = 0.16;										
GT.R_min = 665.8;										
GT.distFindObstacles = 250.0;							
GT.RCS = 700000;										
GT.TACAN = true;										
GT.TACAN_position = {7.006,  43.155,  -14.1};			

GT.numParking = 4;										
GT.Plane_Num_ = 7;										
GT.Helicopter_Num_ = 6;									

GT.airWeaponDist = 74000;								
GT.airFindDist = 100000;									

--GT.LSOView  = R1281_LSOView;

GT.exhaust = {
	  [1] = { size = 0.18 , pos = {12.985, 32.656, 8.003 } },		
      [2] = { size = 0.18 , pos = {-21.742, 30.148, 8.003 } },		
	  [3] = { size = 0.18 , pos = {9.985, 32.656, 8.003 } },		
      [4] = { size = 0.18 , pos = {-24.742, 30.148, 8.003 } },		
}





GT.carrierIlluminationStates = { 
	{{69, 0.0, 1.0}, {149, 0.0, 0.2}, {150, 0.0, 0.0}, {307, 0.0, 0.0}, {791, 0.0, 1.0}, {792, 0.0, 1.0}, {793, 0.0, 0.0},  {797, 0.0, 1.0}, {798,0.0,1.0},},	
	{{69, 0.0, 1.0}, {149, 0.0, 0.4}, {150, 0.0, 1.0}, {307, 0.0, 0.4}, {791, 0.0, 0.0}, {792, 0.0, 0.0}, {793, 0.0, 1.0}, {797, 0.0, 1.0}, {798,0.0,1.0},},	
	{{69, 0.0, 0.0}, {149, 0.0, 0.6}, {150, 0.0, 1.0}, {307, 0.0, 0.7}, {791, 0.0, 0.0}, {792, 0.0, 0.0}, {793, 0.0, 1.0}, {797, 0.0, 1.0}, {798,0.0,0.0},}	
}



GT.animation_arguments.radar1_rotation = 3; -- Radar 1 Rotation
GT.radar1_period = 5;

GT.animation_arguments.radar2_rotation = 2; -- Radar 2 Rotation
GT.radar2_period = 7;

GT.animation_arguments.radar3_rotation = 1; -- Anemometer Animation
GT.radar3_period = 1;

GT.animation_arguments.luna_lights = 150;

GT.animation_arguments.water_propeller = 8;



 GT.DM = {
     { area_name = "COL-ISLAND-FWD", 		area_arg = 70, area_life = 50,  area_fire = { pos = { 19.5, 8.0, 19.6 }, 		size = 0.4}},  
     { area_name = "COL-ISLAND-AFT", 		area_arg = 71, area_life = 50,  area_fire = { pos = { -18.2, 8.0, 19.6 }, 		size = 0.4}},  
     { area_name = "COL-HULL-MID-PORT", 	area_arg = 72, area_life = 150, area_fire = { pos = { -4.0, -15.5, 6.2 }, 		size = 0.5}},  
     { area_name = "COL-HULL-MID-STBD", 	area_arg = 73, area_life = 150, area_fire = { pos = { -4.0, 14.5, 6.2 },		size = 0.5}},  
     { area_name = "COL-HULL-FWD-PORT", 	area_arg = 74, area_life = 150, area_fire = { pos = { 67.8, -9.2, 6.2 },		size = 0.5}},  
     { area_name = "COL-HULL-FWD-STBD", 	area_arg = 75, area_life = 150, area_fire = { pos = { 67.8, 9.2, 6.2 },			size = 0.5}},  
     { area_name = "COL-HULL-AFT-PORT", 	area_arg = 76, area_life = 150, area_fire = { pos = { -73.7, -12.6, 6.2 },		size = 0.5}},  
     { area_name = "COL-HULL-AFT-STBD", 	area_arg = 77, area_life = 150, area_fire = { pos = { -73.7, 12.6, 6.2 },		size = 0.5}},  
     { area_name = "COL-HULL-BELOW-WL-FWD", area_arg = 78, area_life = 150, area_fire = { pos = { 34.1, 0.0, -7.0 },		size = 0.5}},  
     { area_name = "COL-HULL-BELOW-WL-AFT", area_arg = 79, area_life = 150, area_fire = { pos = { -31.3, 0.0, -7.0 },		size = 0.5}},  
     { area_name = "COL-HULL-STERN",	 	area_arg = 80, area_life = 150, area_fire = { pos = { -101.0, 0.0, 6.2 }, 		size = 0.5}},  
     { area_name = "PALUBA_FWD", 			area_arg = 81, area_life = 150, area_fire = { pos = { 45.8, -4.5, 14.7 }, 		size = 0.5}},  
     { area_name = "PALUBA_MID", 			area_arg = 82, area_life = 150, area_fire = { pos = { -13.3, -4.5, 14.7 }, 		size = 0.5}},  
     { area_name = "PALUBA_AFT", 			area_arg = 83, area_life = 150, area_fire = { pos = { -73.7, 0, 14.7 }, 		size = 0.5}},  
     { area_name = "COL-FORECASTLE", 		area_arg = 84, area_life = 150, area_fire = { pos = { 90.2, 0, 11.8 }, 			size = 0.3}},  
     { area_name = "COL-LAUNCHER", 			area_arg = 85, area_life = 30,  area_fire = { pos = { 76.5, 1.5, 14.4 },		size = 0.3}},  
 }

GT.WS = {};
local ws;

GT.WS.maxTargetDetectionRange = 450000;
GT.WS.radar_type = 102;


ws = GT_t.inc_ws();
local first_MK95_tracker_id = ws;
GT.WS[ws] = {
	omegaY = 1,
	omegaZ = 1,
	pidY = {p=100, i=0.05, d=12, inn = 50},
	pidZ = {p=100, i=0.05, d=12, inn = 50},
	--area = "DMG-REAR-MAST",
	center = 'CENTER_RADAR_01',
	--drawArgument =
	--drawArgument =
	reference_angle_Y = math.rad(90),
	angles = {
				{math.rad(180), math.rad(-180), math.rad(-10), math.rad(80) }
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
--GT.WS[ws].area = "DMG-MAST-FORE-UPPER"
GT.WS[ws].center = 'CENTER_RADAR_02'
--GT.WS[ws].drawArgument1 =
--GT.WS[ws].drawArgument2 =
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].angles = {
				{math.rad(180), math.rad(-180)}
				}
table.insert(MK95_TRACKERS, {{'self', ws}});

-- ==============================================================================
-- ================             Weapon System Definitions              ==========
-- ================                                                    ==========
-- ================    Definition of the weapon parameters for use     ==========
-- ================          in the turret definitions                 ==========
-- ================                                                    ==========
-- ==============================================================================

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_Sea_Dart)
GT.WS[ws].area = 'COL-LAUNCHER'
GT.WS[ws].center = 'PIVOT-SEA-DART-BASE'
GT.WS[ws].drawArgument1 = 49
GT.WS[ws].drawArgument2 = 50
GT.WS[ws].reference_angle_Z = math.rad(90)
GT.WS[ws].LN[1].BR = {
						{connector_name = 'CON-SEA-DART-ATTACH-PORT', },  --drawArgument = 161
						{connector_name = 'CON-SEA-DART-ATTACH-STBD', },  --drawArgument = 162
					}
GT.WS[ws].LN[1].PL[1].ammo_capacity = 22;
GT.WS[ws].LN[1].depends_on_unit = MK95_TRACKERS

-- ===========================================================================================================================

GT.Name = "hms_invincible";										
GT.DisplayName = _("HMS Invincible (R05)");						
GT.Rate = 5500.000000;											

GT.Sensors = {  												
				OPTIC = {"long-range naval optics", 			
                         "long-range naval LLTV", 				
						 "long-range naval FLIR",},				
                RADAR = {
				    "Osa 9A33 ln",								
					"rezki search radar",
                    "carrier search radar",						
                },
            };

GT.DetectionRange	= GT.airFindDist;							
GT.ThreatRange		= GT.airWeaponDist;							
GT.Singleton		= "yes";									
GT.mapclasskey		= "P0091000065";							

GT.attribute		= {wsType_Navy, wsType_Ship, wsType_AirCarrier, WSTYPE_PLACEHOLDER, 
						"Aircraft Carriers",
						"Armed Air Defence",
--						"Arresting Gear",						
--						"catapult",								
						"ski_jump",								
						"RADAR_BAND1_FOR_ARM",					
						"RADAR_BAND2_FOR_ARM",					
						"DetectionByAWACS",						
					};											

GT.tags  =
{
    "Carrier",
}

GT.Categories		= {
						{name = "AircraftCarrier"},					
						{name = "AircraftCarrier With Tramplin"},	
--						{name = "AircraftCarrier With Catapult"},	
						{name = "Armed Ship"}						
					};

GT.Countries = {'UK'};

GT.tags  =
{
	"Carrier",
}

add_surface_unit(GT);											



