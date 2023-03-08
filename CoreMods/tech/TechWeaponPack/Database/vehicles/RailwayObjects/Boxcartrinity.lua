-- wagon with container

GT = {};
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 4;

GT.visual.shape = "boxcartrinity"
GT.visual.shape_dstr = "boxcartrinity_p_1"

GT.IR_emission_coeff = 0

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0;


GT.Name = "Boxcartrinity"
GT.DisplayName = _("Flatcar") -- Boxcartrinity
GT.DisplayNameShort = _("Flatcar")
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