-- EWR FPS-117 ECS 

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "ewr_fps117radar_shelter"
GT.visual.shape_dstr = "ewr_fps117radar_shelter_p_1"

GT.IR_emission_coeff = 0.05

--Burning after hit
GT.visual.fire_size = 0.3; --relative burning size
GT.visual.fire_time = 140 --burning time (seconds)
GT.visual.fire_pos[2] = 0.0; -- center of burn shift at vertical shift(meters)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 100;
GT.visual.agony_explosion_size = 0.2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Radar, {0.0, 0.0}, {0.0, 0.0}, {0.0, 0.00}, {0.2, 0.2/1050}}}

GT.sensor = {};
GT.sensor.max_range_finding_target = 160000;
GT.sensor.min_range_finding_target = 3000;
GT.sensor.max_alt_finding_target = 160000;
GT.sensor.height = 5.895;

GT.WS = {};
GT.WS.maxTargetDetectionRange = 200000;


GT.Name 			=   "FPS-117 ECS"
GT.DisplayName 		= _("EWR AN/FPS-117 ECS")
GT.DisplayNameShort = _("117 ECS")
GT.Rate = 20

GT.EPLRS = true

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000046";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar, WSTYPE_PLACEHOLDER,
				--"Trucks",
				"SAM CC",
				};
GT.Countries = {"USA"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"EW Radar",
}