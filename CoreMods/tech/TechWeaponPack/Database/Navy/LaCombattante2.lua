-- FAC La Combattante IIa

GT = {};
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "La_Combattante_II"
GT.visual.shape_dstr = ""

GT.encyclopediaAnimation = { 
	args = {
		[14] = 0.15, -- fwd cannon elevation
		[15] = 1, -- aft cannon rotation
		[16] = 0.15, -- aft cannon elevation
	}		
}

GT.IR_emission_coeff = 0.35

GT.life = 750
GT.mass = 265.0e+003
GT.max_velocity = 18.61
GT.race_velocity = 16.0
GT.economy_velocity = 13.0
GT.propeller_omega_max = 5000.0
GT.economy_distance = 15700.0e+003
GT.race_distance = 1.5e+006
GT.shipLength = 46
GT.Width = 7
GT.Height = 13
GT.Length = 47
GT.DeckLevel = 2.2
GT.X_nose = 20.5
GT.X_tail = -23.0
GT.Tail_Width = 5.0
GT.draft = 2.5
GT.Gamma_max = 0.6
GT.Om = 0.03
GT.speedup = 0.8
GT.R_min = 120
GT.distFindObstacles = 250.0
GT.RCS = 18000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.

--GT.riverCraft = true

GT.airWeaponDist = 4000
GT.airFindDist = 19000
GT.sensor = {
	max_range_finding_target = 19000,
	min_range_finding_target = 0,
	max_alt_finding_target = 8000,
	min_alt_finding_target = 0,
	pos = {0.0, 12.8, 0.0},
}

GT.animation_arguments = {
	nav_lights = 69, -- навигационные огни
	radar1_rotation = 1,
	radar2_rotation = 2,
	radar3_rotation = -1,
	flag_animation = 314,
	water_propeller = 65,
	alarm_state = -1
}
GT.radar1_period = 6.0
GT.radar2_period = 3.0

GT.DM = {
    { area_name = "NOSE_R", 		area_arg = 70, area_life = 55},
	{ area_name = "BORT_R", 		area_arg = 71, area_life = 55, area_fire = { connector = 'FIRE_HULL_MIDDLE_R', 	size = 0.3}},
	{ area_name = "KORMA_R", 		area_arg = 72, area_life = 55, area_fire = { connector = 'FIRE_HULL_Stern', size = 0.3}},
	{ area_name = "NOSE_L", 		area_arg = 73, area_life = 55},
	{ area_name = "BORT_L", 		area_arg = 74, area_life = 55, area_fire = { connector = 'FIRE_HULL_MIDDLE_L', size = 0.3}},
	{ area_name = "KORMA_L", 		area_arg = 75, area_life = 55},
	{ area_name = "NOSE_TOP", 		area_arg = 76, area_life = 25},
	{ area_name = "BORT_TOP", 		area_arg = 77, area_life = 25},
	{ area_name = "KORMA_TOP",		area_arg = 78, area_life = 25},
	{ area_name = "KORMA_BACK",		area_arg = 79, area_life = 40},
	{ area_name = "RUBKA_R", 		area_arg = 80, area_life = 35},
	{ area_name = "RUBKA_L", 		area_arg = 83, area_life = 35},
	{ area_name = "RUBKA_TOP", 		area_arg = 86, area_life = 15},
	{ area_name = "TOWER_NOSE", 	area_arg = 97, area_life = 25},
	{ area_name = "ZA_01", 			area_arg = 98, area_life = 15},
	{ area_name = "TPK_01", 		area_arg = 109, area_life = 20, area_fire = { connector = 'FIRE_DECK_01', size = 0.5}},
	{ area_name = "TPK_02", 		area_arg = 110, area_life = 20, area_fire = { connector = 'FIRE_DECK_02', size = 0.5}},
}

-- weapon systems
GT.WS = {}
GT.WS.maxTargetDetectionRange = 45000;

local ws;
-- forward OTO Melara 76 mm
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_MK75)
GT.WS[ws].area = 'TOWER_NOSE'
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].reference_angle_Z = math.rad(9)
GT.WS[ws].angles = {
					{math.rad(136), math.rad(40), math.rad(-7.5), math.rad(65)},
					{math.rad(40), math.rad(-40), math.rad(0), math.rad(65)},
					{math.rad(-40), math.rad(-136), math.rad(-7.5), math.rad(65)},
					};
GT.WS[ws].LN[1].BR[1] = {connector_name = 'POINT_GUN_01',
				recoilArgument = 117,
				recoilTime = 0.120}
--GT.WS[ws].cockpit = { "IronSight/IronSight", {-1.2, 0.1, 0.0 }, open = true};
--GT.WS[ws].LN[1].sightMasterMode = 1;
				
-- Backward Bofors 40mm
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.Bofors_40mm)
GT.WS[ws].area = 'ZA_01'
GT.WS[ws].center = 'CENTER_TOWER_02'
GT.WS[ws].drawArgument1 = 15
GT.WS[ws].drawArgument2 = 16
GT.WS[ws].reference_angle_Y = math.rad(180)
GT.WS[ws].reference_angle_Z = math.rad(9)
GT.WS[ws].angles = {
					{math.rad(-40), math.rad(40), math.rad(-5), math.rad(85)},
					};
GT.WS[ws].LN[1].BR[1] = {connector_name = 'POINT_GUN_02',
				recoilArgument = 118,
				recoilTime = 0.120}
--GT.WS[ws].cockpit = { "IronSight/IronSight", {-1.2, 0.1, 0.0 }, open = true};
--GT.WS[ws].LN[1].sightMasterMode = 1;

-- Harpoons
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_HARPOON )
GT.WS[ws].area = 'TPK_01';
GT.WS[ws].center = 'POINT_ROCKET_02'
GT.WS[ws].angles = { {math.rad(0), math.rad(-90), math.rad(-90), math.rad(90)},}
GT.WS[ws].canSetTacticalDir = true
GT.WS[ws].reference_angle_Y = math.rad(-45)
GT.WS[ws].reference_angle_Z = math.rad(9)
GT.WS[ws].LN[1].PL[1].ammo_capacity = 2;
GT.WS[ws].LN[1].show_external_missile = true
GT.WS[ws].LN[1].BR = {
						{connector_name = 'POINT_ROCKET_01', recoilArgument = 177, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{connector_name = 'POINT_ROCKET_02', recoilArgument = 178, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
					}

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_HARPOON )
GT.WS[ws].area = 'TPK_02';
GT.WS[ws].center = 'POINT_ROCKET_03'
GT.WS[ws].angles = { {math.rad(90), math.rad(0), math.rad(-90), math.rad(90)},}
GT.WS[ws].canSetTacticalDir = true
GT.WS[ws].reference_angle_Y = math.rad(45)
GT.WS[ws].reference_angle_Z = math.rad(9)
GT.WS[ws].LN[1].PL[1].ammo_capacity = 2;
GT.WS[ws].LN[1].show_external_missile = true
GT.WS[ws].LN[1].BR = {
						{connector_name = 'POINT_ROCKET_03', recoilArgument = 179, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
						{connector_name = 'POINT_ROCKET_04', recoilArgument = 180, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
					}

GT.Name = "La_Combattante_II"
GT.DisplayName = _("FAC La Combattante IIa")
GT.DisplayNameShort = _("Comb")
GT.Rate = 1100

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV"},
				RADAR = {"molniya search radar"}
            };

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   = "no";
GT.mapclasskey = "P0091000070";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_ArmedShip, WSTYPE_PLACEHOLDER,
                    "Corvettes",
					"DetectionByAWACS",
					"NO_SAM"
				};
GT.Categories = {
					{name = "Armed Ship"},
				};
GT.tags  =
{
	"Fast Attack Craft",
}
GT.Countries = {"Iran", "Libya", "Germany", "Greece", "Malaysia"}

