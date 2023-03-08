-- Mys-M1 mobile shore radar
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 4

GT.visual.shape = "mys-m1";
GT.visual.shape_dstr = "mys-m1_p_1";

GT.IR_emission_coeff = 0.05

--chassis
GT.animation_arguments.locator_rotation = 0;
GT.animation_arguments.alarm_state = -1;
GT.radar_rotation_period = 10.0;
GT.snd.radarRotation = "GndTech/RadarRotation";

GT.sensor = {};
GT.sensor.max_range_finding_target = 200000;
GT.sensor.min_range_finding_target = 1500;
GT.sensor.max_alt_finding_target = 500;
GT.sensor.height = 4.0;

GT.WS = {};
GT.WS.maxTargetDetectionRange = 200000;
GT.WS.radar_type = 103;
GT.WS.radar_rotation_type = 0;

--Burning after hit
GT.visual.fire_size = 0.4; --relative burning size
GT.visual.fire_pos[1] = -1; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.8; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 60 --burning time (seconds)
GT.visual.min_time_agony = 8;
GT.visual.max_time_agony = 35;
GT.visual.agony_explosion_size = 5;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_LMG, {0.0, 0.00}, {0.15, 0.15/350}}}

local ws = 0;
for i = 1,10 do
    ws = GT_t.inc_ws();
	GT.WS[ws] = {}
    GT.WS[ws].pos = {2.5,3.5,0}
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-10), math.rad(10)},
					};
    GT.WS[ws].omegaY = 3
    GT.WS[ws].omegaZ = 3

    GT.WS[ws].LN = {}
    GT.WS[ws].LN[1] = {}
	__LN = GT.WS[ws].LN[1];
    __LN.type = 103
    __LN.reactionTime = 10;
    __LN.reflection_limit = 0.18;
    __LN.distanceMin = 500
    __LN.distanceMax = GT.sensor.max_range_finding_target
	__LN.ECM_K = 0.5;
    __LN.min_trg_alt = -1
    __LN.max_trg_alt = GT.sensor.max_alt_finding_target
	__LN.external_tracking_awacs = true;

end --for

GT.Name = "Silkworm_SR";
GT.DisplayName = _("AShM Silkworm Radar");
GT.DisplayNameShort = _("SilkWrm SR");
GT.Rate = 10;

GT.Sensors = { RADAR = "Mys-M1_SR" };

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000083";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar,WSTYPE_PLACEHOLDER,
				"DetectionByAWACS",
				"Artillery",
				};
GT.category = "MissilesSS";
GT.tags  =
{
    "MissilesSS",
	"RadarSSM",
}
GT.Countries = {"China", "Iran", "Iraq"}