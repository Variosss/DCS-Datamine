-- Rapier FSA Blindfire radar tracker

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3

GT.visual.shape = "rapier_fsa_blindfire_radar";
GT.visual.shape_dstr = "rapier_fsa_blindfire_radar_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.03

GT.sensor = {};
GT.sensor.max_range_finding_target = 30000;
GT.sensor.min_range_finding_target = 500;
GT.sensor.max_alt_finding_target = 4000;
GT.sensor.min_alt_finding_target = 50;
GT.sensor.height = 2.5;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0.0, 0.0}, {0.0, 0.00}, {0.15, 0.15/550}}}

-- weapon systems

-- zero tracker, dummy
GT.WS = {};
GT.WS.radar_type = 104;
GT.WS.maxTargetDetectionRange = 30000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {0, GT.sensor.height, 0};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), 0.0, math.rad(60)},
					};
GT.WS[ws].reference_angle_Y = math.pi					
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].omegaY = 1.2;
GT.WS[ws].omegaZ = 1.5;
GT.WS[ws].pidY = {p=10,i=0.1,d=3};
GT.WS[ws].pidZ = {p=20,i=0.1,d=5};

GT.WS[ws].LN = {{}}
local __LN = GT.WS[ws].LN[1]
__LN.type = 102;
__LN.distanceMin = 400;
__LN.distanceMax = GT.WS.maxTargetDetectionRange;
__LN.min_trg_alt = 20;
__LN.max_trg_alt = 8000;
__LN.reactionTime = 0.1;
__LN.reflection_limit = 0.1;
__LN.ECM_K = 0.65
__LN.maxShootingSpeed = 0;
__LN.beamWidth = math.rad(90)
__LN.sensor = {};
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[0]);
__LN.depends_on_unit = {{{"rapier_fsa_launcher", 1}}};

GT.Name = "rapier_fsa_blindfire_radar";
GT.DisplayName = _("SAM Rapier FSA Blindfire Tracker");
GT.DisplayNameShort = _("Rapier STR");
GT.Rate = 5;

GT.Sensors = { RADAR = {"Tor 9A331"}} -- Temporary

GT.DetectionRange  = GT.WS.maxTargetDetectionRange;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000083";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, WSTYPE_PLACEHOLDER,
				"SR SAM",
				"SAM TR",
				"RADAR_BAND1_FOR_ARM",
				"RADAR_BAND2_FOR_ARM",
				};
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Tracking Radar",
}
GT.Countries = {"UK", "Iran", "Malaysia", "Oman", "Singapore", "Switzerland", "Turkey", "United Arab Emirates", "Zambia", "Australia", "Libya", "Netherlands", "Iraq"}