-- ATZ-5 URAL-375
GT = {};

set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.URAL375);

GT.visual.shape = "atz5"
GT.visual.shape_dstr = "atz5_p_1"

GT.IR_emission_coeff = 0.08

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {1.4, 2.3, -0.6};

--chassis

GT.swing_on_run = false

--Burning after hit
GT.visual.fire_size = 1.5 --relative burning size
GT.visual.fire_pos[1] = -1.4 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.9 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 1500 --burning time (seconds)

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0, 0}, IR_COEFFS_BODY, {0.34, 0.34/2100}}}

GT.driverViewPoint = {1.67, 2.21, -0.460}; 

GT.Name = "ATZ-5"
GT.DisplayName = _("Refueler ATZ-5")
GT.DisplayNameShort = _("ATZ-5")
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