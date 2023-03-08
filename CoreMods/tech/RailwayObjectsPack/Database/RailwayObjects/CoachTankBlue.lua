-- wagon with blue tank

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3;

GT.visual.shape = "wagon-cisterna_blue"
GT.visual.shape_dstr = "wagon-cisterna_p_1"

GT.IR_emission_coeff = 0

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 1.55 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 1000 --burning time (seconds)
GT.visual.min_time_agony = 15;
GT.visual.max_time_agony = 110;
GT.visual.agony_explosion_size = 15;

GT.Name = "Coach a tank blue"
GT.DisplayName = _("Tank Car blue") -- Coach a tank blue
GT.DisplayNameShort = _("TankCar")
GT.Rate = 4

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground, wsType_Moving, wsType_Civil, wsTypeWCisternaBLUE,
				"Trucks",
				};
GT.category = "Carriage";
GT.tags  =
{
    "Train",
	"Carriage",
}