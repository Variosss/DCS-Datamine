-- ZIL-131
GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.ZIL131);

GT.visual.shape = "S_75_Zil_Truck"
GT.visual.shape_dstr = "S_75_Zil_Truck_p_1"

GT.IR_emission_coeff = 0.1

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {1.5, 2.15, -0.5};

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.4; --relative burning size
GT.visual.fire_pos[1] = 0.75; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1;-- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 350; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 80;
GT.visual.agony_explosion_size = 1;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0, 0}, IR_COEFFS_BODY, {0.25, 0.25/800}}}

GT.driverViewPoint = {1.593, 2.151, -0.470};

GT.canTow = {"Saddle"}

GT.Name = "S_75_ZIL"
GT.DisplayName = _("S-75 Tractor (ZIL-131)")
GT.DisplayNameShort = _("ZIL")
GT.Rate = 3

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