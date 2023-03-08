-- Land Rover 109 S3

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
GT.chassis = {
	life = 3,
	mass = 1500,
	length = 4.41,
	width = 1.68,
	max_road_velocity = 34.7,
	fordingDepth = 0.6,
	max_slope = 0.47,
	engine_power = 50,
	max_vert_obstacle = 0.5,
	max_acceleration = 1.3,
	min_turn_radius = 7.15,
	X_gear_1 = 1.4,
	Y_gear_1 = 0,
	Z_gear_1 = 0.7,
	X_gear_2 = -1.44,
	Y_gear_2 = 0,
	Z_gear_2 = 0.7,
	gear_type = GT_t.GEAR_TYPES.WHEELS,
	r_max = 0.38,
	armour_thickness = 0.001,
}

GT.visual.shape = "land_rover_109_s3"
GT.visual.shape_dstr = "land_rover_109_s3_p_1"

GT.IR_emission_coeff = 0.075

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {-0.18, 1.56, 0.45};

GT.AddPropVehicle = {
			{ id = "TentedRoof" , control = 'checkbox', label = _('Tented Roof'), defValue = true, arg=60, boolean_inverted = true} -- boolean_inverted = true by default: element present - argVal=0, absent - argVal=1
		}


--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.31 --relative burning size
GT.visual.fire_pos[1] = 1.1 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.9 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 480 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 2;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0, 0}, IR_COEFFS_BODY, {0.18, 0.18/800}}}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.3, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

GT.Name = "Land_Rover_109_S3"
GT.DisplayName = _("LUV Land Rover 109 S3")
GT.DisplayNameShort = _("R109")
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
	"Scout/Recon",
}
GT.InternalCargo = {
			nominalCapacity = 700,
			maximalCapacity = 700, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}
		
GT.Countries = {"UK", "Iran", "Malaysia", "Oman", "Singapore", "Switzerland", "Turkey", "United Arab Emirates", "Zambia", "Australia", "Libya", "Netherlands", "Iraq"}