-- HandyWind

GT = {};

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "seawise_giant"
GT.visual.shape_dstr = ""

GT.IR_emission_coeff = 0.4

GT.life = 1500
GT.mass = 646.642e+06
GT.max_velocity = 8.5
GT.race_velocity = 7.8
GT.economy_velocity = 6.0
GT.economy_distance = 1.59272e+007
GT.race_distance = 1.59272e+007
GT.shipLength = 457
GT.Width = 24.611
GT.Height = 27
GT.Length = 458.45
GT.DeckLevel = 10.0
GT.X_nose = 216.15
GT.X_tail = -225.73
GT.Tail_Width = 20
GT.draft = 29
GT.Gamma_max = 0.5
GT.Om = 0.02
GT.speedup = 0.101986
GT.R_min = 400.0
GT.distFindObstacles = 800
GT.RCS = 1400000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.trim = 0.5
GT.deltaWaterline = 10.0

GT.radar1_period = 3.0;
GT.radar2_period = 3.0;

GT.numParking = 1
GT.Helicopter_Num_ = 1
GT.Landing_Point = {-137.86, 8.525, -16.85}
GT.animation_arguments = {
	radar1_rotation = 1,
	radar2_rotation = 2,
	radar3_rotation = -1,
	nav_lights = 69, -- навигационные огни
	flight_deck_fences = 149, -- на посадочной площадке
	flag_animation = -1,
	water_propeller = 65,
	alarm_state = -1,
}
GT.exhaust =
{
	{ size = 0.5 , connector = "SMOKE_PIPE_1_L", preset = "Bazar/ParticleEffects/effects/SmokeShip.lua"},
	{ size = 0.5 , connector = "SMOKE_PIPE_1_R"},
 }

GT.DM = {
    { area_name = "Hull_Front_Right", 		area_arg = 70, area_life = 200, area_fire = { connector = 'FIRE_RIGHT_FRONT', size = 0.5}},
    { area_name = "Hull_Central_Right", 	area_arg = 71, area_life = 200, area_fire = { connector = 'FIRE_RIGHT_CENTER', size = 0.5}},
    { area_name = "Hull_Back_Right", 		area_arg = 72, area_life = 200, area_fire = { connector = 'FIRE_RIGHT_BACK', size = 0.5}},
    { area_name = "Hull_Front_Left", 		area_arg = 73, area_life = 200, area_fire = { connector = 'FIRE_LEFT_FRONT', size = 0.5}},
    { area_name = "Hull_Central_Left", 		area_arg = 74, area_life = 200, area_fire = { connector = 'FIRE_LEFT_CENTER', size = 0.5}},
    { area_name = "Hull_Back_Left", 		area_arg = 75, area_life = 200, area_fire = { connector = 'FIRE_LEFT_BACK', size = 0.5}},
    { area_name = "Topside_Right", 			area_arg = 76, area_life = 100},
	{ area_name = "Topside_Back_Right", 	area_arg = 77, area_life = 100},
	{ area_name = "Topside_Left", 			area_arg = 78, area_life = 100},
	{ area_name = "Topside_Back_Left", 		area_arg = 79, area_life = 100},
    { area_name = "Mast_Back", 				area_arg = 80, area_life = 55},
    { area_name = "Pipe",					area_arg = 81, area_life = 55},
	{ area_name = "Deck_Front",				area_arg = 82, area_life = 100, area_fire = { connector = 'FIRE_POS_01', size = 0.5}},
	{ area_name = "Deck_Central",			area_arg = 83, area_life = 100, area_fire = { connector = 'FIRE_POS_02', size = 0.5}},
	{ area_name = "Deck_Back",				area_arg = 84, area_life = 100, area_fire = { connector = 'FIRE_POS_03', size = 0.5}, belongsToRunway = true},
}

GT.airWeaponDist = 0
GT.airFindDist = 0
GT.sensor = {
	max_range_finding_target = 15000,
	min_range_finding_target = 0,
	max_alt_finding_target = 3000,
	min_alt_finding_target = 0,
	pos = {58.0, 17.5, 0.0},
}
-- weapon systems

GT.Name = "Seawise_Giant"
GT.DisplayName = _("Tanker Seawise Giant")
GT.DisplayNameShort = _("SwiseGnt")
GT.Rate = 150

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="no";
GT.mapclasskey = "P0000000634";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_CivilShip,WSTYPE_PLACEHOLDER,
				"Unarmed ships",
				"Side approach departure",	-- for aircraft style helicopter/stvol aircraft landing approch
				};
GT.Categories = {
                    {name = "HelicopterCarrier"},
                };
GT.tags  =
{
	"Civilian",
}
GT.Countries = {
"Japan",
"Australia",
"Brazil",
"Chile",
"China",
"Egypt",
"France",
"Germany",
"India",
"Indonesia",
"Iran",
"Israel",
"Italy",
"Lebanon",
"Malaysia",
"Mexico",
"Norway",
"Oman",
"Pakistan",
"Poland",
"Romania",
"Russia",
"Saudi Arabia",
"South Africa",
"South Korea",
"Spain",
"Thailand",
"The Netherlands",
"Turkey",
"UK",
"United Arab Emirates",
"USA"
}