-- Electric locomotive VL80T
-- Электровоз ВЛ80Т

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
GT.chassis = {
	life = 20,
	mass = 30000,
	length = 33,
	width = 3.0,
	max_road_velocity = 30.55,
	max_slope = 0.47,
	fordingDepth = 0.0,
	engine_power = 18000,
	max_vert_obstacle = 0.6,
	max_acceleration = 0.925926,
	min_turn_radius = 10.5,
	X_gear_1 = 10.0,
	Y_gear_1 = 0,
	Z_gear_1 = 1.4,
	X_gear_2 = -10.0,
	Y_gear_2 = 0,
	Z_gear_2 = 1.4,
	gear_type = GT_t.GEAR_TYPES.WHEELS,
	r_max = 0.5,
	armour_thickness = 0.001,
}
GT.visual.shape = "elektrowoz"
GT.visual.shape_dstr = "elektrowoz_p_1"

GT.IR_emission_coeff = 0.1

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 1.0 --relative burning size
GT.visual.fire_pos[1] = 4.3 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 2.5 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 800 --burning time (seconds)
GT.visual.min_time_agony = 15;
GT.visual.max_time_agony = 190;
GT.visual.agony_explosion_size = 5;

GT.Name = "Electric locomotive"
GT.DisplayName = _("Loco VL80 Electric") -- Electric locomotive VL80
GT.DisplayNameShort = _("Loco80")
GT.Rate = 10

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P91000108";
GT.attribute = {wsType_Ground, wsType_Moving, wsType_Civil, wsTypeElectrovoz,
				"Trucks",
				};
GT.category = "Locomotive"
GT.tags  =
{
    "Train",
	"Locomotive",
}