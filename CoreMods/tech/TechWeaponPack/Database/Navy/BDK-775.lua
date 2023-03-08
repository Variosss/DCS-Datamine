-- BDK-775
-- Animation Arguments:
-- 1-6 radar antennas
-- 13 - horizontal orientation fwd gun
-- 14 - vert orientation fwd gun
-- 15 - horizontal orientation back gun
-- 16 - vert orientation back gun
-- 53 - fwd cargo deck
-- 54 - back cargo deck
-- 56 - rudder
-- 65 - propeller
-- 70-81 damaged zone
-- 69 - front signal light
-- 149 - back signal light
-- 152 - lighning on the deck
-- 314 - flag waves
-- 315 - flag wind orientation

GT = {};
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "BDK_775"
GT.visual.shape_dstr = ""

GT.IR_emission_coeff = 0.35

GT.life = 2000
GT.mass = 4400.0e+003
GT.max_velocity = 17.5
GT.race_velocity = 16.0
GT.economy_velocity = 12.0
GT.propeller_omega_max = 5000.0
GT.economy_distance = 15700.0e+003
GT.race_distance = 1.5e+006
GT.shipLength = 112.5
GT.Width = 15
GT.Height = 26
GT.Length = 112.5
GT.DeckLevel = 4.7
GT.X_nose = 46.0
GT.X_tail = -53.0
GT.Tail_Width = 5.0
GT.draft = 3.7
GT.Gamma_max = 0.6
GT.Om = 0.03
GT.speedup = 0.8
GT.R_min = 120
GT.distFindObstacles = 500.0
GT.RCS = 51000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.exhaust =
{
	[1] = { size = 0.4, connector = "SMOKE_PIPE_01" },
	[2] = { size = 0.4, connector = "SMOKE_PIPE_02" },
 }

GT.airWeaponDist = 6000
GT.airFindDist = 25000
GT.sensor = {
	max_range_finding_target = 64000,
	min_range_finding_target = 0,
	max_alt_finding_target = 10000,
	min_alt_finding_target = 0,
	pos = {0.0, 12.8, 0.0},
}

GT.animation_arguments = {
	nav_lights = 69, -- навигационные огни
	radar1_rotation = 1,
	radar2_rotation = 2,
	radar3_rotation = 3,	-- 4,5,6
	flag_animation = 314,
	water_propeller = 65,
							-- rudders???
	alarm_state = -1
}
GT.radar1_period = 6.0
GT.radar2_period = 3.0

GT.DM = {	
	{	area_name = "HullFront_Right", 		area_arg = 70, area_life = 55,	area_fire = { connector = "FIRE_NOSE_R", size = 0.3}},
	{	area_name = "HullCentral_Right", 	area_arg = 71, area_life = 55,  area_fire = { connector = "FIRE_BORT_R", size = 0.3}},
	{	area_name = "HullBack_Right", 		area_arg = 72, area_life = 55,	area_fire = { connector = "FIRE_KORMA_R", size = 0.3}},	
	{ 	area_name = "HullFront_Left", 		area_arg = 73, area_life = 55,  area_fire = { connector = "FIRE_NOSE_L", size = 0.3}},	
	{	area_name = "HullCentral_Left", 	area_arg = 74, area_life = 55,	area_fire = { connector = "FIRE_BORT_L", size = 0.3}},
	{	area_name = "HullBack_Left", 		area_arg = 75, area_life = 55,	area_fire = { connector = "FIRE_KORMA_L", size = 0.3}},
	
	{	area_name = "BackTopside_Left", 	area_arg = 84, area_life = 55,  area_fire = { connector = "FIRE_BORT_L", size = 0.3}},		
	{	area_name = "BackTopside_Right", 	area_arg = 79, area_life = 55,	area_fire = { connector = "FIRE_BORT_R", size = 0.1}},
	{	area_name = "BackMast", 			area_arg = 87, area_life = 55,  area_fire = { pos = { -31.4, 7.57, 4.0}, size = 0.2}},			
	{	area_name = "CentralMast", 			area_arg = 78, area_life = 55,	area_fire = { connector = "FIRE_KORMA_TOP", size = 0.3}},
	{	area_name = "GunFront_Base", 		area_arg = 76, area_life = 55,  area_fire = { pos = { 15.5, 9.0, 0.0}, size = 0.2}}, 
	{	area_name = "GunBack_Base", 		area_arg = 77, area_life = 55,  area_fire = { pos = { -40.7, 8.7, 0.0}, size = 0.2}}, 
	
	{	area_name = "HullFront_Top", 		area_arg = 78, area_life = 55,  area_fire = { connector = "FIRE_NOSE_TOP", size = 0.3}},
	{	area_name = "HullBack_Top", 		area_arg = 78, area_life = 55,  area_fire = { connector = "FIRE_KORMA_TOP", size = 0.3}},
	
	{	area_name = "RUBKA_R", 				area_arg = 80, area_life = 55,  area_fire = { pos = { -8.4, 10.0, 4.5}, size = 0.2}},
	{	area_name = "RUBKA_L", 				area_arg = 83, area_life = 55,  area_fire = { pos = { -9.0, 10.5, -4.0}, size = 0.2}}, 
	{	area_name = "RUBKA_Top", 			area_arg = 86, area_life = 55,  area_fire = { connector = "CENTER_RADAR_02", size = 0.1}},
}

GT.WS = {};
GT.WS.maxTargetDetectionRange = 64000; 
GT.WS.radar_type = 102
GT.WS.searchRadarMaxElevation = math.rad(40);

-- radars firstly
--	 ws = GT_t.inc_ws();
--	 GT.WS[ws] = {}
--	 set_recursive_metatable(GT.WS[ws], GT_t.SS_t.VYMPEL_TRACKER[1]);
--	 GT.WS[ws].center = 'CENTER_RADAR_01'
--	 GT.WS[ws].angles[1][1] = math.rad(180);
--	 GT.WS[ws].angles[1][2] = math.rad(-180);
--	 GT.WS[ws].drawArgument1 = 5
--	 GT.WS[ws].drawArgument2 = 6	
--	 GT.WS[ws].area = 'BackMast'
--	 local trackers_for_AK725 = {{{"self", ws}}};
		
    ws = GT_t.inc_ws();
	GT.WS[ws] = {}
	
    GT.WS[ws].center = 'CENTER_RADAR_01'
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(0), math.rad(90)},
					};
    GT.WS[ws].omegaY = 1
    GT.WS[ws].omegaZ = 1

    GT.WS[ws].LN = {}	-- searching radar for RWR
    GT.WS[ws].LN[1] = {}
    GT.WS[ws].LN[1].type = 103
    GT.WS[ws].LN[1].reactionTime = 12;
    GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target;
    GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target;
	GT.WS[ws].LN[1].ECM_K = 0.65;
	GT.WS[ws].LN[1].reflection_limit = 0.18;
    GT.WS[ws].LN[1].min_trg_alt = 50
    GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target;
	GT.WS[ws].LN[1].beamWidth = math.rad(90)		
		
-- weapon systems  	2 × АК-725 
	ws = GT_t.inc_ws();
	GT.WS[ws] = {}
	set_recursive_metatable(GT.WS[ws], GT_t.WS_t.BDK_775_AK725)
	GT.WS[ws].angles_mech = { {math.rad(120), math.rad(-120), math.rad(-12), math.rad(85)}};
	GT.WS[ws].angles = { {math.rad(120), math.rad(-120), math.rad(-12), math.rad(85)}};
	
	GT.WS[ws].center = 'CENTER_TOWER_01'
	GT.WS[ws].drawArgument1 = 13
	GT.WS[ws].drawArgument2 = 14
	--GT.WS[ws].LN[1].depends_on_unit = trackers_for_AK725
	GT.WS[ws].reference_angle_Y = math.rad(0)
	GT.WS[ws].area = 'GunFront_Base'
	
	GT.WS[ws].LN[1].BR = 
	{
		{connector_name = 'POINT_GUN_01',},
		{connector_name = 'POINT_GUN_02',}
	}		
	
	ws = GT_t.inc_ws();	-- back gun
	GT.WS[ws] = {}
	set_recursive_metatable(GT.WS[ws], GT_t.WS_t.BDK_775_AK725)
	GT.WS[ws].angles_mech = { {math.rad(-50), math.rad(50), math.rad(-10), math.rad(88)}};	-- strange angles because of safe boat on left deck
	GT.WS[ws].angles = { {math.rad(-50), math.rad(50), math.rad(-10), math.rad(88)}};	
	GT.WS[ws].center = 'CENTER_TOWER_02'
	GT.WS[ws].drawArgument1 = 15
	GT.WS[ws].drawArgument2 = 16
	--GT.WS[ws].LN[1].depends_on_unit = trackers_for_AK725
	GT.WS[ws].reference_angle_Y = math.rad(-180)

	GT.WS[ws].area = 'GunBack_Base'	
	GT.WS[ws].LN[1].BR =
	{
		{connector_name = 'POINT_GUN_03',},
		{connector_name = 'POINT_GUN_04',}
	}

GT.Name = "BDK-775"
GT.DisplayName = _("LS Ropucha")	
GT.DisplayNameShort = _("Ropucha")	
GT.Rate = 300

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV"},
				RADAR = {"rezki search radar"}
            };

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   = "no";
GT.mapclasskey = "P0091000070";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_ArmedShip, WSTYPE_PLACEHOLDER,
                    "Landing Ships",
					"Heavy armed ships",
					"NO_SAM"
				};
GT.Categories = {
					{name = "Armed Ship"},
				};
GT.tags  =
{
	"Amphibious Assault",
}
GT.Countries = {"Russia"}

