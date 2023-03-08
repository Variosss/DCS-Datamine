-- Rapier FSA Launcher

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3

GT.visual.shape = "rapier_fsa_optical_tracker_unit";
GT.visual.shape_dstr = "rapier_fsa_optical_tracker_unit_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.03

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 1.44;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0.0, 0.00}, {0.0, 0.00}, {0.15, 0.15/550}}}

-- weapon systems

-- zero tracker, dummy
GT.WS = {};
GT.WS.maxTargetDetectionRange = 20000;
GT.WS.isDetector = true; -- depends on another unit but has to detect targets by it's own sensors

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {0, GT.sensor.height, 0};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), 0.0, math.rad(60)},
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].omegaY = 1.0;
GT.WS[ws].omegaZ = 1.0;
GT.WS[ws].pidY = {p=10,i=0.1,d=3};
GT.WS[ws].pidZ = {p=10,i=0.1,d=3};

GT.WS[ws].LN = {{}}
local __LN = GT.WS[ws].LN[1]
__LN.type = 100;
__LN.distanceMin = 400;
__LN.distanceMax = GT.WS.maxTargetDetectionRange;
__LN.min_trg_alt = 20;
__LN.max_trg_alt = 8000;
__LN.reactionTime = 6.0;
__LN.reflection_limit = 0.0;
__LN.ECM_K = -1
__LN.maxShootingSpeed = 0;
__LN.sensor = {};
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[0]);
__LN.depends_on_unit = {{{"rapier_fsa_launcher", 1}}};

GT.Name = "rapier_fsa_optical_tracker_unit";
GT.DisplayName = _("Rapier FSA Optical Tracker");
GT.DisplayNameShort = _("Rapier OTR");
GT.Rate = 5;

GT.Sensors = { OPTIC = {"generic SAM search visir"}} --, "generic SAM IR search visir"

GT.DetectionRange  = GT.WS.maxTargetDetectionRange;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000082";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, WSTYPE_PLACEHOLDER,
				"SR SAM",
				"SAM SR",
				};
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Optical Tracker",
}
GT.Countries = {"UK", "Iran", "Malaysia", "Oman", "Singapore", "Switzerland", "Turkey", "United Arab Emirates", "Zambia", "Australia", "Libya", "Netherlands", "Iraq"}