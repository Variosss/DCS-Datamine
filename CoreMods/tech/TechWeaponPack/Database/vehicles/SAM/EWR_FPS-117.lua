-- FPS-117 Radar without a radome

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "ewr_fps117";
GT.visual.shape_dstr = "ewr_fps117_p_1";	
GT.positioning = "ONLYHEIGTH"

GT.IR_emission_coeff = 0.07

-------------------------
GT.radar_rotation_period = 10;	-- frequency really
GT.animation_arguments.locator_rotation = 0;
GT.snd.radarRotation = "GndTech/RadarRotation";

GT.sensor = {};
GT.sensor.max_range_finding_target = 463000;
GT.sensor.min_range_finding_target = 0;
GT.sensor.max_alt_finding_target = 30000;
GT.sensor.height = 14.5;

GT.CustomAimPoint = {0,1.5,0}

GT.WS = {};
GT.WS.maxTargetDetectionRange = GT.sensor.max_range_finding_target;
GT.WS.requiredUnits = {{"FPS-117 ECS", 50, GT_t.REQUIRED_UNIT.NEED_AI_ON}}
GT.WS.radar_type = 105;
GT.WS.radar_rotation_type = 0;

local ws = 0;
for i = 1,10 do
    ws = GT_t.inc_ws();
	GT.WS[ws] = {}
    GT.WS[ws].pos = {0,10,0}
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(0), math.rad(30)},
					};
    GT.WS[ws].omegaY = 3
    GT.WS[ws].omegaZ = 3

    GT.WS[ws].LN = {}
    GT.WS[ws].LN[1] = {}
    GT.WS[ws].LN[1].type = 101
    GT.WS[ws].LN[1].reactionTime = 12;
    GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target;
    GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target;
	GT.WS[ws].LN[1].ECM_K = 0.65;
	GT.WS[ws].LN[1].reflection_limit = 0.18;
    GT.WS[ws].LN[1].min_trg_alt = 50
    GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target;
end --for

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Radar, {0.0, 0.0}, {0.0, 0.0}, {0.0, 0.00}, {0.2, 0.2/1050}}}

GT.Name          	=   "FPS-117";
GT.DisplayName 		= _("EWR AN/FPS-117 Radar");
GT.DisplayNameShort = _("117 R");
GT.Rate = 100;

GT.Sensors = { RADAR = "FPS-117"};

GT.EWR = true

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000036";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar, WSTYPE_PLACEHOLDER, -- EWR_FPS_117
				"EWR",
				"CustomAimPoint",
				};
GT.Countries = {"USA"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"EW Radar",
}