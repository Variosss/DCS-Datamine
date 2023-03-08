-- NASAMS Command Post

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary)
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "NASAMS_Command_Post"
GT.visual.shape_dstr = "NASAMS_Command_Post_p_1"
GT.animation_arguments.alarm_state = -1

GT.IR_emission_coeff = 0.05

GT.swing_on_run = false

--Burning after hit
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.9 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)

GT.visual.fire_size = 0.65; --relative burning size
GT.visual.fire_time = 200; --burning time (seconds)
GT.visual.min_time_agony = 2;
GT.visual.max_time_agony = 30;
GT.visual.agony_explosion_size = 0.2;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0.0, 0.000}, IR_COEFFS_BODY, {0.15, 0.15/550}}}

GT.sensor = {};
GT.sensor.max_range_finding_target = 50000;
GT.sensor.min_range_finding_target = 3000;
GT.sensor.max_alt_finding_target = 17000;
GT.sensor.height = 2.7;

GT.WS = {};
GT.WS.maxTargetDetectionRange = 60000;

local ws = 0;
for i = 1,10 do
    ws = GT_t.inc_ws();
	GT.WS[ws] = {};
    GT.WS[ws].pos = {0.0, 2.0, 0.0}
	GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-90), math.rad(90)},
					};
    GT.WS[ws].omegaY = 3;
    GT.WS[ws].omegaZ = 3;

    GT.WS[ws].LN = {};
    GT.WS[ws].LN[1] = {};
    GT.WS[ws].LN[1].type = 100;
    GT.WS[ws].LN[1].reactionTime = 0.1;
    GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target;
    GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target;
	GT.WS[ws].LN[1].ECM_K = 0.4;
	GT.WS[ws].LN[1].reflection_limit = 0.05;
    GT.WS[ws].LN[1].min_trg_alt = 25;
    GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target;
	GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
    GT.WS[ws].LN[1].depends_on_unit = {{{"NASAMS_Radar_MPQ64F1"}}};
end

GT.Name = "NASAMS_Command_Post"
GT.DisplayName = _("SAM NASAMS C2")
GT.DisplayNameShort = _("NASAMS C2")
GT.Rate = 10

GT.EPLRS = true

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000046";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_NoWeapon,WSTYPE_PLACEHOLDER,
				"Trucks",
				"SAM CC",
				};
GT.Countries = {"USA"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Command & Control",
}