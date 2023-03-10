-- HL pickup with B8M1

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle);
set_recursive_metatable(GT.chassis, GT_t.CH_t.hilux_pickup);
GT.chassis.mass = GT.chassis.mass + 470; 	--2130=1660+470kg B8M1 S-8OF

GT.visual.shape = "ttHL-B8M1";
GT.visual.shape_dstr = "ttHL_p_1";

GT.encyclopediaAnimation = { 
	args = {
		[1] = 0.125, -- B8M1 angle
		[121] = 1.0, -- rocket back
		[122] = 1.0, -- rocket back
		[123] = 1.0, -- rocket back
		[124] = 1.0, -- rocket back
		[125] = 1.0, -- rocket back
		[126] = 1.0, -- rocket back
		[127] = 1.0, -- rocket back
		[128] = 1.0, -- rocket back
		[129] = 1.0, -- rocket back
		[130] = 1.0, -- rocket back
		[131] = 1.0, -- rocket back
		[132] = 1.0, -- rocket back
		[133] = 1.0, -- rocket back
		[134] = 1.0, -- rocket back
		[135] = 1.0, -- rocket back
		[136] = 1.0, -- rocket back
		[137] = 1.0, -- rocket back
		[138] = 1.0, -- rocket back
		[139] = 1.0, -- rocket back
		[140] = 1.0, -- rocket back
	}
}

GT.IR_emission_coeff = 0.08

GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.826;

--destruction  
GT.agony_fire_pos_y = 0.982;
GT.agony_fire_pos_y = 1.725;
GT.agony_fire_pos_z = 0.315;

--Burning after hit
GT.visual.fire_size = 0.65; --relative burning size
GT.visual.fire_pos[1] = 0.2; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.8; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 300; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_MLRS_80, GT_t.IR_COEFFS_BODY, {0.25, 0.25/1050}}}

GT.driverCockpit = "DriverCockpit/DriverCockpit"
GT.driverViewConnectorName = "POINT_DRIVER"

-- weapon systems

GT.WS = {};
GT.WS.fire_on_march = false;
GT.WS.maxTargetDetectionRange = 7500;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.MLRS_B8N1);
GT.WS[ws].pos = {-0.21, 1.67, 0.0}
GT.WS[ws].reference_angle_Z = math.rad(10);

GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_ROCKET_01', drawArgument = 121},
	{connector_name = 'POINT_ROCKET_02', drawArgument = 122},
	{connector_name = 'POINT_ROCKET_03', drawArgument = 123},
	{connector_name = 'POINT_ROCKET_04', drawArgument = 124},
	{connector_name = 'POINT_ROCKET_05', drawArgument = 125},
	{connector_name = 'POINT_ROCKET_06', drawArgument = 126},
	{connector_name = 'POINT_ROCKET_07', drawArgument = 127},
	{connector_name = 'POINT_ROCKET_08', drawArgument = 128},
	{connector_name = 'POINT_ROCKET_09', drawArgument = 129},
	{connector_name = 'POINT_ROCKET_10', drawArgument = 130},
	{connector_name = 'POINT_ROCKET_11', drawArgument = 131},
	{connector_name = 'POINT_ROCKET_12', drawArgument = 132},
	{connector_name = 'POINT_ROCKET_13', drawArgument = 133},
	{connector_name = 'POINT_ROCKET_14', drawArgument = 134},
	{connector_name = 'POINT_ROCKET_15', drawArgument = 135},
	{connector_name = 'POINT_ROCKET_16', drawArgument = 136},
	{connector_name = 'POINT_ROCKET_17', drawArgument = 137},
	{connector_name = 'POINT_ROCKET_18', drawArgument = 138},
	{connector_name = 'POINT_ROCKET_19', drawArgument = 139},
	{connector_name = 'POINT_ROCKET_20', drawArgument = 140},
}

GT.WS[ws].LN[1].customViewPoint = { "genericMLRS", {-3.0, 0.3, -0.8 }, open = true};

GT.Name = "HL_B8M1";
GT.DisplayName = _("MLRS HL with B8M1 80mm");
GT.DisplayNameShort = _("HL B8M1");
GT.Rate = 6;

GT.Crew = 2;

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000208";
GT.mapclasskey 		= "P0091000208";
GT.attribute = {wsType_Ground, wsType_Tank,wsType_Miss,wsType_GenericMLRS, WSTYPE_PLACEHOLDER,
                 "MLRS",
                };
GT.category = "Artillery"
GT.tags  =
{
    "Artillery",
    "MRL",
}
GT.Countries = {"Japan"}