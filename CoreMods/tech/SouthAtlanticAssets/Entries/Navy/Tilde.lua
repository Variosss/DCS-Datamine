-- Ship_Tilde_Supply

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "Ship_Tilde_Supply"
GT.visual.shape_dstr = ""

GT.IR_emission_coeff = 0.35

GT.life = 1000
GT.mass = 17.456e+006
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
GT.Gamma_max = 1.0
GT.Om = 0.02
GT.speedup = 0.101986
GT.R_min = 400.0
GT.distFindObstacles = 500
GT.RCS = 100000  -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.animation_arguments.radar1_rotation = 2; -- Radar 1 Rotation
GT.radar1_period = 5;

GT.numParking = 1
GT.Helicopter_Num_ = 1
GT.Landing_Point = {-74.276, 12.831, 0.0}		-- ( x= 74.276, y= 0, z= 12.831 )
--GT.animation_arguments.flight_deck_fences = 312;

GT.exhaust = {
	  [1] = { size = 0.4 , pos = {-55.5, 34, 0 }}			-- Smoke Origin from Funnel (Y, Z, X : where +Y=port, -Y=stbd)
}

GT.DM = {
    { area_name = "COL-BOW", 		area_arg = 70, area_life = 200, area_fire = { pos = {60.8, 0, 4.0}, size = 0.5}},
    { area_name = "COL-MIDSHIPS", 	area_arg = 71, area_life = 200, area_fire = { pos = {10, 0, 4}, size = 0.5}},
    { area_name = "COL-SS", 		area_arg = 72, area_life = 200, area_fire = { pos = {-45.0, 0, 11.5}, size = 0.5}},
    { area_name = "PALUBA-COL", 	area_arg = 73, area_life = 200, area_fire = { pos = {-74.3, 0 , 12.5}, size = 0.5}, belongsToRunway = true},
	{ area_name = "Supply_Destroyed",	area_arg = 77,	area_life = 400, area_fire = { pos = {-2.1, 0, 0.0}, size = 3}},
}

GT.airWeaponDist = 0
GT.airFindDist = 0
-- weapon systems

GT.Name = "Ship_Tilde_Supply"
GT.DisplayName = _("Supply Ship MV Tilde")
GT.DisplayNameShort = _("Tilde")
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
};				
    --GT.Countries = {
	-- "Liberia",
	-- "Australia",
	-- "Brazil",
	-- "Chile",
	-- "China",
	-- "Egypt",
	-- "France",
	-- "Germany",
	-- "India",
	-- "Indonesia",
	-- "Iran",
	-- "Israel",
	-- "Italy",
	-- "Japan",
	-- "Lebanon",
	-- "Malaysia",
	-- "Mexico",
	-- "Norway",
	-- "Oman",
	-- "Pakistan",
	-- "Poland",
	-- "Romania",
	-- "Russia",
	-- "Saudi Arabia",
	-- "South Africa",
	-- "South Korea",
	-- "Spain",
	-- "Thailand",
	-- "The Netherlands",
	-- "Turkey",
	-- "UK",
	-- "United Arab Emirates",
	-- "USA"
-- }

add_surface_unit(GT)