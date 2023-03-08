-- DRG Class 86

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
--set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis = {
	life = 20,
	mass = 30000,
	length = 8.5,
	width = 2.5,
	max_road_velocity = 20.8333,
	max_slope = 0.47,
	fordingDepth = 0.0,
	engine_power = 18000,
	max_vert_obstacle = 0.6,
	max_acceleration = 0.925926,
	min_turn_radius = 10.5,
	X_gear_1 = 7.0,
	Y_gear_1 = 0,
	Z_gear_1 = 1.4,
	X_gear_2 = -7.0,
	Y_gear_2 = 0,
	Z_gear_2 = 1.4,
	gear_type = GT_t.GEAR_TYPES.WHEELS,
	r_max = 0.5,
	armour_thickness = 0.001,
}
GT.visual.shape = "es44ah"
GT.visual.shape_dstr = "es44ah_p_1"

GT.IR_emission_coeff = 0.15

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 3.0;

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 1.5 --relative burning size
GT.visual.fire_pos[1] = -6.3 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.8 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 1000 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 90;
GT.visual.agony_explosion_size = 10;

GT.Name = "ES44AH"
GT.DisplayName = _("Loco ES44AH")
GT.DisplayNameShort = _("Loco44H")
GT.Rate = 10

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P91000108";
GT.attribute = {wsType_Ground, wsType_Moving, wsType_Civil, wsTypeTeplowoz,
				"Trucks",
				};
GT.category = "Locomotive"
GT.tags  =
{
    "Train",
	"Locomotive",
}