--SON-9 radar
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.mass = 5000	-- maybe false
GT.chassis.life = 2

GT.visual.shape = "son-9.EDM"
GT.visual.shape_dstr = "son-9_p_1.EDM"
GT.animation_arguments.alarm_state = -1;										
GT.animation_arguments.locator_rotation = 0;
GT.animation_arguments.locator_elevation = 1;
GT.radar_rotation_period = 2.5;									

GT.IR_emission_coeff = 0.05

GT.snd.radarRotation = "GndTech/RadarRotation" -- не поворот, но звук работы

GT.sensor = {};
GT.sensor.max_range_finding_target = 55000
GT.sensor.min_range_finding_target = 50
GT.sensor.max_alt_finding_target   = 14000
GT.sensor.height = 4.5;

--Burning after hit
GT.visual.fire_size = 0.6; 		--relative burning size
GT.visual.fire_pos[1] = 0; 		-- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.5;    -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; 		-- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 100; 		--burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 60;
GT.visual.agony_explosion_size = 5;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, {0.0, 0.0}, {0.0, 0.000}, {0.0, 0.00}, {0.2, 0.2/750}}}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 55000
GT.WS.radar_type = 103;
GT.WS.radar_rotation_type = 2;

local ws = GT_t.inc_ws();
local base = ws;
GT.WS[ws] = {};

GT.WS[ws].pos = {0.59, 2.9, 0.28}	-- Target_Turret" 0.584497 2.916016 0.286241
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-5), math.rad(90)},
					};
GT.WS[ws].pointer = 'POINT_RADAR_01'
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].reference_angle_Z = math.rad(0);
GT.WS[ws].omegaY = 2.5;
GT.WS[ws].omegaZ = 2.5;
GT.WS[ws].pidY = { p = 10, i = 1, d = 3, inn = 1};
GT.WS[ws].pidZ = { p = 10, i = 1, d = 3, inn = 1};

GT.WS[ws].LN = {};
GT.WS[ws].LN[1] = {};
GT.WS[ws].LN[1].type = 103;
GT.WS[ws].LN[1].distanceMin = 100;
GT.WS[ws].LN[1].distanceMax = 55000;
GT.WS[ws].LN[1].ECM_K = 0.5;
GT.WS[ws].LN[1].min_trg_alt = 25;
GT.WS[ws].LN[1].max_trg_alt = 14000;
GT.WS[ws].LN[1].reactionTime = 1;
GT.WS[ws].LN[1].reflection_limit = 0.01;
GT.WS[ws].LN[1].beamWidth = math.rad(90)		

--for KS-19
ws = GT_t.inc_ws();
GT.WS[ws] = {
	pos = {0.59, 2.9, 0.28},
	angles = {
		{math.rad(180), math.rad(-180), math.rad(-5), math.rad(80)},
		},
    omegaY = 1,
    omegaZ = 1,
	}
GT.WS[ws].LN = {[1] = {}}
set_recursive_metatable(GT.WS[ws].LN[1], GT_t.LN_t.KS19);
GT.WS[ws].LN[1].sensor = GT_t.WSN_t[13]
GT.WS[ws].LN[1].distanceMax = 20000
GT.WS[ws].LN[1].sightMaxTanVel = 220
GT.WS[ws].LN[1].reactionTime = 4;
GT.WS[ws].LN[1].depends_on_unit = {{{"self", 1}}}
GT.WS[ws].LN[1].BR = nil
GT.WS[ws].LN[1].aiming_director = true;

 --for S-60 
 ws = GT_t.inc_ws();
GT.WS[ws] = {
	pos = {0.59, 2.9, 0.28},
	angles = {
		{math.rad(180), math.rad(-180), math.rad(-5), math.rad(80)},
		},
    omegaY = 1,
    omegaZ = 1,
	}
GT.WS[ws].LN = {[1] = {}}
set_recursive_metatable(GT.WS[ws].LN[1], GT_t.LN_t.S_60_gun);
GT.WS[ws].LN[1].sensor = GT_t.WSN_t[5]
GT.WS[ws].LN[1].distanceMax = 5000
--GT.WS[ws].LN[1].sightMaxTanVel = 200
GT.WS[ws].LN[1].reactionTime = 4;
GT.WS[ws].LN[1].depends_on_unit = {{{"self", 1}}}
GT.WS[ws].LN[1].BR = nil
GT.WS[ws].LN[1].aiming_director = true;
---------------------------------------

GT.Name = "SON_9"
GT.DisplayName = _("AAA Fire Can SON-9")
GT.DisplayNameShort = _("SON-9")
GT.Rate = 10;

GT.Sensors = { RADAR = "son-9 tr" }

GT.DetectionRange  = GT.sensor.max_range_finding_target
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000083";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Radar,WSTYPE_PLACEHOLDER,
				"SAM TR",
				"AAA",
				};
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Tracking Radar",
	"AAA",
}
GT.Countries = {"Russia", "USSR", "Syria"}