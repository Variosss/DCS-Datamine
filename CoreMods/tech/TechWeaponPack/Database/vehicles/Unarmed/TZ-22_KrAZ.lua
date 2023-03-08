-- TZ-22 Truck KrAZ-258B1
GT = {};

set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.KrAZ_258B1);

GT.visual.shape = "tz_22_truck"
GT.visual.shape_dstr = "tz_22_truck_p_1"

GT.IR_emission_coeff = 0.09

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {1.1, 2.3, -0.45};

--chassis

GT.swing_on_run = false

--Burning after hit
GT.visual.fire_size = 1.9 --relative burning size
GT.visual.fire_pos[1] = 2.4 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.9 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 1500 --burning time (seconds)

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0, 0}, IR_COEFFS_BODY, {0.25, 0.25/800}}}

GT.driverViewPoint = {1.15, 2.285, -0.464};

GT.canTow = {"Saddle", "Saddle22"}

GT.Name = "TZ-22_KrAZ"
GT.DisplayName = _("Refueler TZ-22 Tractor (KrAZ-258B1)")
GT.DisplayNameShort = _("KrAZ")
GT.Rate = 3

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_NoWeapon,WSTYPE_PLACEHOLDER,
				"Trucks",
				};
GT.category = "Unarmed";
GT.Countries = {"Russia", "USSR"}
GT.tags  =
{
    "Unarmed",
	"Support & Logistics",
}