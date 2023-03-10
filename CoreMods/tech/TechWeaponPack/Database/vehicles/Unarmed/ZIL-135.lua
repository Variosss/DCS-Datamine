-- ZIL-135
GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.ZIL135);

GT.visual.shape = "Zil_135l"
GT.visual.shape_dstr = "Zil_135l_p1"

GT.IR_emission_coeff = 0.1

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {3.3, 2.3, -0.8};

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.5; --relative burning size
GT.visual.fire_pos[1] = 0.75; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1;-- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 350; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 80;
GT.visual.agony_explosion_size = 2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_WHEELS_Truck, {0.0, 0.0}, GT_t.IR_COEFFS_BODY, {0.29, 0.29/1600}}}

GT.driverViewPoint = {3.42, 2.3, -0.765};

GT.Name = "ZIL-135"
GT.DisplayName = _("Truck ZIL-135")
GT.DisplayNameShort = _("ZIL-135")
GT.Rate = 5

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000005";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_NoWeapon,WSTYPE_PLACEHOLDER,
				"Trucks",
				};
GT.category = "Unarmed";
GT.tags  =
{
    "Unarmed",
	"Support & Logistics",
}
GT.warehouse = true
GT.Countries = {"USSR", "Russia"}