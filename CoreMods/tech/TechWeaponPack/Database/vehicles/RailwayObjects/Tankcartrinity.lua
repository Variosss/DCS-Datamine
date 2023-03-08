-- wagon with tank

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 4;

GT.visual.shape = "tankcartrinity"
GT.visual.shape_dstr = "tankcartrinity_p_1"

GT.IR_emission_coeff = 0

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 1.3 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.65 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 1300 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 190;
GT.visual.agony_explosion_size = 15;

GT.Name = "Tankcartrinity"
GT.DisplayName = _("Tank Cartrinity") --Tankcartrinity
GT.DisplayNameShort = _("TankCar")
GT.Rate = 4

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground, wsType_Moving, wsType_Civil, wsTypeWGruz,
				"Trucks",
				};
GT.category = "Carriage";
GT.tags  =
{
    "Train",
	"Carriage",
}