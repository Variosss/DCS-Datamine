-- Diesel power station 5i57A

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3;
GT.chassis.mass = 4000

GT.visual.shape = "generator_5i57"
GT.visual.shape_dstr = "generator_5i57_p_1"
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.07

--Burning after hit
GT.visual.fire_size = 0.8 --relative burning size
GT.visual.fire_pos[1] = 1 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.8 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 120 --burning time (seconds)

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0.0, 0.0}, IR_COEFFS_BODY, {0.27, 0.27/1550}}}

GT.Name = "generator_5i57"
GT.DisplayName = _("Diesel Power Station 5I57A")
GT.DisplayNameShort = _("DPS")
GT.Rate = 4

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000004";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_NoWeapon,WSTYPE_PLACEHOLDER,
				"AD Auxillary Equipment",
				};
GT.category = "Air Defence";
GT.Countries = {"Russia", "USSR"}
GT.tags  =
{
    "Air Defence",
	"Generator",
}