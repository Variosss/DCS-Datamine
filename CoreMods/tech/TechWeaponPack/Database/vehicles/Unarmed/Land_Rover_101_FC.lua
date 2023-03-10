-- Land Rover 101 fc

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
GT.chassis = {
	life = 3,
	mass = 1500,
	length = 4.29,
	width = 1.83,
	max_road_velocity = 34.7,
	fordingDepth = 0.6,
	max_slope = 0.47,
	engine_power = 90,
	max_vert_obstacle = 0.5,
	max_acceleration = 1.1,
	min_turn_radius = 7.15,
	X_gear_1 = 1.3,
	Y_gear_1 = 0,
	Z_gear_1 = 0.76,
	X_gear_2 = -1.27,
	Y_gear_2 = 0,
	Z_gear_2 = 0.76,
	gear_type = GT_t.GEAR_TYPES.WHEELS,
	r_max = 0.46,
	armour_thickness = 0.001,
}

GT.visual.shape = "land_rover_101_fc"
GT.visual.shape_dstr = "land_rover_101_fc_p_1"

GT.IR_emission_coeff = 0.075

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {1.06, 1.9, 0.59};

GT.AddPropVehicle = {
			{ id = "Variant" , control = 'comboList', wCtrl = 150, label = _('Variant'), defValue = 4, arg = 60,
				values = {
				{ id = 1, dispName = _("Covered/Empty"), value = 0.0},
				{ id = 2, dispName = _("Covered/Loaded"), value = 0.1},
				{ id = 3, dispName = _("Open/Loaded"), value = 0.2},
				{ id = 4, dispName = _("Open/Empty"), value = 0.3},
				}
			}
		}


--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.33 --relative burning size
GT.visual.fire_pos[1] = 0.7 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.1 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 480 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 2;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0, 0}, GT_t.IR_COEFFS_BODY, {0.15, 0.15/800}}}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.3, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

GT.Name = "Land_Rover_101_FC"
GT.DisplayName = _("Truck Land Rover 101 FC")
GT.DisplayNameShort = _("R101")
GT.Rate = 3

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_NoWeapon,wsType_GenericVehicle,
				"Trucks",
				};
GT.category = "Unarmed";
GT.tags  =
{
    "Unarmed",
	"Support & Logistics",
}
GT.Countries = {"UK", "Iran", "Malaysia", "Oman", "Singapore", "Switzerland", "Turkey", "United Arab Emirates", "Zambia", "Australia", "Libya", "Netherlands", "Iraq"}