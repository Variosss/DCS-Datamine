-- Scud B Launcher

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle);
set_recursive_metatable(GT.chassis, GT_t.CH_t.MAZ543M);

GT.visual.shape = "Scud_B";
GT.visual.shape_dstr = "Scud_B_Crashed";

GT.IR_emission_coeff = 0.09

GT.toggle_alarm_state_interval = 20.0;
GT.animation_arguments.alarm_state = 4;

local missileLaunched = {30, 1.0}; -- when the missile is present the 30th argument value is 0.0

-- times
local legsFinishTime = 60;
local mainArmStartTime = legsFinishTime+3;
local mainArmFinishTime = mainArmStartTime + 180;
local rocketLockInterval = 20;
local rocketUnlockStartTime = mainArmFinishTime+3;
local rocketUnlockFinishTime = rocketUnlockStartTime + rocketLockInterval;
local mainArmDownStartTime = rocketUnlockFinishTime + 1;
local mainArmDownFinishTime = mainArmDownStartTime + 180;
local totalDuration = mainArmDownFinishTime;

GT.animation_arguments.alarm_state_sequence =
{
	totalDuration = mainArmDownFinishTime,
	-- support legs
	{2, {{startTime=0.0, endTime = legsFinishTime},
		{startTime=legsFinishTime, endTime = totalDuration, startVal = 1.0, endVal = 1.0}}},
	{3, {{startTime=0.0, endTime = legsFinishTime-10}, -- virtual argument, no animation, only for leveling
		{startTime=legsFinishTime-10.0, endTime = legsFinishTime, leveling = true},
		{startTime=legsFinishTime, endTime = totalDuration, startVal = 1.0, endVal = 1.0}}},
	-- rocket pad
	{4, {
		{startTime=0.0, endTime = mainArmStartTime, startVal = 0.0, endVal = 0.0},
		{startTime=mainArmStartTime, endTime = mainArmFinishTime, startVal = 0.0, endVal = 1.0},
		{startTime=mainArmFinishTime, endTime = totalDuration, startVal = 1.0, endVal = 1.0}
	}},
	-- main arm
	{5, {
		{startTime=0.0, endTime = mainArmStartTime, startVal = 0.0, endVal=0.0},
		{startTime=mainArmStartTime, endTime = mainArmFinishTime, conditions={missileLaunched}},
		{startTime=mainArmFinishTime, endTime = rocketUnlockFinishTime, startVal = 1.0, endVal=1.0, conditions={missileLaunched}},
		{startTime=mainArmDownStartTime, endTime = mainArmDownFinishTime, startVal = 1.0, endVal=0.0, conditions={missileLaunched}}
	}},
	-- rocket locking arms
	{6, {
		{startTime=0.0, endTime = rocketUnlockStartTime, startVal = 0.0, endVal=0.0},
		{startTime=rocketUnlockStartTime, endTime = rocketUnlockFinishTime, conditions={missileLaunched}},
		{startTime=rocketUnlockFinishTime, endTime = mainArmDownFinishTime-rocketLockInterval, startVal = 1.0, endVal=1.0, conditions={missileLaunched}},
		{startTime=mainArmDownFinishTime-rocketLockInterval, endTime = mainArmDownFinishTime, startVal = 1.0, endVal=0.0, conditions={missileLaunched}}
	}},
}
GT.verticalDeviationCompensationPeriod = 10.0
GT.maxVerticalDeviationAngle = math.rad(5)

-- Sound
GT.sound = {};

-- Engine params
GT.sound.engine = {};
GT.sound.engine.idle = "GndTech/BradleyEngineIdle";
GT.sound.engine.max = "GndTech/BradleyEngineMax";

GT.sound.engine.acc_start = "GndTech/BradleyEngineAccStart";
GT.sound.engine.acc_end = "GndTech/BradleyEngineAccEnd";

GT.sound.engine.idle_formula_gain = "0.625 x * 0.875 +";
GT.sound.engine.idle_formula_pitch = "0.55 x * 0.89 +";

GT.sound.engine.max_formula_gain = "0.75 x * 0.25 +";
GT.sound.engine.max_formula_pitch = "0.7025 x * 0.4195 +";
-- Engine params

-- Move params
GT.sound.move = {};
GT.sound.move.sound = "GndTech/TankMove";
GT.sound.move.pitch = {{0.0, 0.6}, {10.0, 1.2}};
GT.sound.move.gain = {{0.0, 0.01}, {0.5, 0.5}, {12.0, 1.0}};
GT.sound.move.start_move = "GndTech/TStartMove";
GT.sound.move.end_move = "GndTech/TEndMove";
-- Move params

GT.sound.noise = {};
GT.sound.noise.sound = "Damage/VehHit";

-- Sound

--chassis
GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.617;

--Burning after hit
GT.visual.fire_size = 0.8; --relative burning size
GT.visual.fire_pos[1] = 2.6; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.5; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 900 --burning time (seconds)
GT.visual.min_time_agony = 30;
GT.visual.max_time_agony = 135;
GT.visual.agony_explosion_size = 15;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, GT_t.IR_COEFFS_ATGM, IR_COEFFS_BODY, {0.3, 0.3/1500}}}

-- weapon systems
GT.WS = {};
GT.WS.fire_on_march = false;
GT.WS.maxTargetDetectionRange = 10000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {-6.0, 1.0, 0.0}
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-90), math.rad(90)},
					};
GT.WS[ws].reference_angle_Z = math.rad(90)
GT.WS[ws].moveable = false
GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
GT.WS[ws].LN[1].type = 8
GT.WS[ws].LN[1].distanceMin = 50000
GT.WS[ws].LN[1].distanceMax = 320000
GT.WS[ws].LN[1].reactionTime = 8
GT.WS[ws].LN[1].show_external_missile = true
GT.WS[ws].LN[1].external_tracking_awacs = true
GT.WS[ws].LN[1].sensor = {}
set_recursive_metatable(GT.WS[ws].LN[1].sensor, GT_t.WSN_t[0])
GT.WS[ws].LN[1].PL = {}
GT.WS[ws].LN[1].PL[1] = {}
GT.WS[ws].LN[1].PL[1].ammo_capacity = 1
GT.WS[ws].LN[1].PL[1].type_ammunition = {wsType_Weapon,wsType_Missile,wsType_SS_Missile,96}
GT.WS[ws].LN[1].PL[1].name_ammunition = _('Scud')
GT.WS[ws].LN[1].PL[1].reload_time = 2400;
GT.WS[ws].LN[1].PL[1].shot_delay = 10
GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_ROCKET', drawArgument = 30},
	}

GT.Name = "Scud_B";
GT.DisplayName = _("SSM 9P117 Scud B");
GT.DisplayNameShort = _("Scud");
GT.Rate = 20;

GT.DetectionRange  = 0;
GT.ThreatRangeMin = GT.WS[1].LN[1].distanceMin;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000208";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Miss,wsType_GenericMLRS,
                "SS_missile", "Artillery", "Datalink",
                };
GT.category = "MissilesSS";
GT.tags  =
{
    "MissilesSS",
	"SSM",
}
GT.Countries = {"Egypt", "Iran", "Kazakhstan", "North Korea", "Libya", "Oman", "Syria", "Vietnam", "Yemen", "Belarus", "Bulgaria", "Czech Republic", "Hungary", "Iraq", "Poland", "Romania", "Yemen", "Ukraine", "United Arab Emirates", "Yugoslavia", "USSR"}