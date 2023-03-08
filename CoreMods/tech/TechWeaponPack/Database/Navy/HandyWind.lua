-- HandyWind

GT = {};

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "Ship_Handy_Wind"
GT.visual.shape_dstr = ""

GT.IR_emission_coeff = 0.35

GT.life = 1000
GT.mass = 23.456e+006
GT.max_velocity = 7.20222
GT.race_velocity = 6.17333
GT.economy_velocity = 6.17333
GT.economy_distance = 1.59272e+007
GT.race_distance = 1.59272e+007
GT.shipLength = 180
GT.Width = 24
GT.Height = 27
GT.Length = 180
GT.DeckLevel = 5.0
GT.X_nose = 85
GT.X_tail = -90
GT.Tail_Width = 20
GT.draft = 9.5
GT.Gamma_max = 1.0
GT.Om = 0.02
GT.speedup = 0.101986
GT.R_min = 400.0
GT.distFindObstacles = 500
GT.RCS = 100000  -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.trim = 0.5
GT.deltaWaterline = 4.0

GT.radar1_period = 3.0;
GT.radar2_period = 1.0;

GT.numParking = 1
GT.Helicopter_Num_ = 1
GT.Landing_Point = {9.2, 6.64, 0.0}
--GT.animation_arguments.flight_deck_fences = 312;
GT.exhaust =
{
	{ size = 0.5 , connector = "SMOKE_PIPE_Mailn", preset = "Bazar/ParticleEffects/effects/SmokeShip.lua"},
 }

GT.DM = {
    { area_name = "C_Hull_Front_Right", 	area_arg = 70, area_life = 200, area_fire = { pos = {72.36, 1.65, 9.8}, size = 0.5}},
    { area_name = "C_Hull_Center_Right", 	area_arg = 71, area_life = 200, area_fire = { pos = {9.0, 1.5, 12.2}, size = 0.5}, belongsToRunway = true},
    { area_name = "C_Hull_Back_Right", 		area_arg = 72, area_life = 200, area_fire = { pos = {-66.0, 0.5, 11.5}, size = 0.5}},
    { area_name = "C_Hull_Front_Left", 		area_arg = 73, area_life = 200, area_fire = { pos = {76.8, 4.05, -9.0}, size = 0.5}},
    { area_name = "C_Hull_Center_Left", 	area_arg = 74, area_life = 200, area_fire = { pos = {10.09, 0.76, -12.0}, size = 0.5}, belongsToRunway = true},
    { area_name = "C_Hull_Back_Left", 		area_arg = 75, area_life = 200, area_fire = { pos = {-56.0, 0.9, -12.0}, size = 0.5}},
    { area_name = "C_Superstructure_Right", area_arg = 76, area_life = 100},
    { area_name = "C_Superstructure_Left", 	area_arg = 77, area_life = 100},
    { area_name = "C_Pipe",					area_arg = 78, area_life = 55},
	{ area_name = "C_Deck_Front_Right", 	area_arg = 79, area_life = 100},
	{ area_name = "C_Deck_Central_Right", 	area_arg = 80, area_life = 100},
	{ area_name = "C_Deck_Back_Right", 		area_arg = 81, area_life = 70},
	
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

GT.Name = "HandyWind"
GT.DisplayName = _("Bulker Handy Wind")
GT.DisplayNameShort = _("HndWnd")
GT.Rate = 100

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="no";
GT.mapclasskey = "P0000000634";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_CivilShip,wsType_GenericCivShip,
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
	"Liberia",
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
	"Japan",
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