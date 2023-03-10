-- 19J6 search radar

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 4;

GT.visual.shape = "rls_19j6";
GT.visual.shape_dstr = "rls_19j6_p_1";
GT.visual.fire_pos[2] = 1;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0.0, 0.000}, GT_t.IR_COEFFS_BODY, {0.2, 0.2/750}}}

GT.IR_emission_coeff = 0.08

--chassis
GT.animation_arguments.locator_rotation = 0
GT.radar_rotation_period = 10.0;
GT.snd.radarRotation = "GndTech/RadarRotation";

GT.sensor = {};
GT.sensor.max_range_finding_target = 150000;
GT.sensor.min_range_finding_target = 2000;
GT.sensor.max_alt_finding_target = 25000;
GT.sensor.height = 8.0;

GT.CustomAimPoint = {0,7.0,0}

GT.WS = {};
GT.WS.maxTargetDetectionRange = GT.sensor.max_range_finding_target;
GT.WS.searchRadarMaxElevation = math.rad(45);
GT.WS.radar_type = 102;
GT.WS.radar_rotation_type = 0;

--Burning after hit
GT.visual.fire_size = 0.4; --relative burning size
GT.visual.fire_pos[1] = -3.2; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.1; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 800; --burning time (seconds)

local ws = 0;
for i = 1,32 do 
    ws = GT_t.inc_ws();
	GT.WS[ws] = {}
    GT.WS[ws].center = "CENTER_TOWER"
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-15), math.rad(45)},
					};
    GT.WS[ws].omegaY = 3
    GT.WS[ws].omegaZ = 3
    GT.WS[ws].LN = 
    {
        {
        type = 101,
		reflection_limit = 0.049,
        distanceMin = GT.sensor.min_range_finding_target,
        distanceMax = GT.sensor.max_range_finding_target,
		ECM_K = 0.4,
        min_trg_alt = 100,
        max_trg_alt = GT.sensor.max_alt_finding_target,
        reactionTime = 4;
        },
    }
end --for

GT.Name = "RLS_19J6";
GT.DisplayName = _("SR 19J6");
GT.DisplayNameShort = _("19J6 SR");
GT.Rate = 20;

GT.Sensors = { RADAR = GT.Name };

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000083";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar,WSTYPE_PLACEHOLDER,
				"LR SAM",
				"SAM SR",
				"RADAR_BAND1_FOR_ARM",
				"RADAR_BAND2_FOR_ARM",
				"CustomAimPoint",
				};
GT.Countries = {"USSR", "Russia"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Search Radar",
}