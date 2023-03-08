-- wagon passenger

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3;

GT.visual.shape = "wagon-pass"
GT.visual.shape_dstr = "wagon-pass_p_1"

GT.IR_emission_coeff = 0.05

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.9 --relative burning size
GT.visual.fire_pos[1] = -3.5 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.8 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 700 --burning time (seconds)
GT.visual.min_time_agony = 40;
GT.visual.max_time_agony = 150;
GT.visual.agony_explosion_size = 5;

GT.Name = "Coach a passenger"
GT.DisplayName = _("Passenger Car") -- Coach a passenger
GT.DisplayNameShort = _("Pass")
GT.Rate = 4

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground, wsType_Moving, wsType_Civil, wsTypeWagonPass,
				"Trucks",
				};
GT.category = "Carriage";
GT.tags  =
{
    "Train",
	"Carriage",
}