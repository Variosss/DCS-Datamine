-- NASAMS Search Radar MPQ64F1

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "NASAMS_Radar_MPQ64F1";
GT.visual.shape_dstr = "NASAMS_Radar_MPQ64F1_p_1";

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0.0, 0.000}, {0.0, 0.00}, {0.2, 0.2/750}}}

GT.IR_emission_coeff = 0.06

--chassis
GT.animation_arguments.alarm_state = -1
GT.animation_arguments.locator_rotation = 11;
GT.radar_rotation_period = 4.0;
GT.snd.radarRotation = "GndTech/RadarRotation";

GT.sensor = {};
GT.sensor.max_range_finding_target = 50000;
GT.sensor.min_range_finding_target = 3000;
GT.sensor.max_alt_finding_target = 17000;
GT.sensor.height = 2.7;

GT.WS = {};
GT.WS.maxTargetDetectionRange = 60000;
GT.WS.radar_type = 102;
GT.WS.radar_rotation_type = 0;

local ws = 0;
for i = 1,10 do
    ws = GT_t.inc_ws();
	GT.WS[ws] = {}
    GT.WS[ws].pos = {0,3,0}
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-10), math.rad(55)},
					};
    GT.WS[ws].omegaY = 3
    GT.WS[ws].omegaZ = 3
	GT.WS[ws].pidY = { p = 100, i = 0.0, d = 10};
	GT.WS[ws].pidZ = { p = 100, i = 0.0, d = 10};

    GT.WS[ws].LN = {}
    GT.WS[ws].LN[1] = {}
    GT.WS[ws].LN[1].type = 101
	GT.WS[ws].LN[1].reactionTime = 2;
	GT.WS[ws].LN[1].reflection_limit = 0.05;
    GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target
    GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target
	GT.WS[ws].LN[1].ECM_K = 0.8;
    GT.WS[ws].LN[1].min_trg_alt = 25
    GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target

end --for

GT.Name = "NASAMS_Radar_MPQ64F1";
GT.DisplayName = _("SAM NASAMS SR MPQ64F1");
GT.DisplayNameShort = _("NASAMS SR");
GT.Rate = 10;

GT.Sensors = { RADAR = GT.Name, };

GT.EPLRS = true

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000083";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar, WSTYPE_PLACEHOLDER,
				"MR SAM",
				"SAM SR",
				"RADAR_BAND1_FOR_ARM",
				"RADAR_BAND2_FOR_ARM",
				"Datalink"
				};
GT.Countries = {"USA"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Search Radar",
}