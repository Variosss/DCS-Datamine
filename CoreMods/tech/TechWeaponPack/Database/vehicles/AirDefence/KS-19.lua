--Air Defence Heavy Gun KS-19 100mm
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.mass = 9350
GT.chassis.life = 4

GT.visual.shape = "KS-19"
GT.visual.shape_dstr = "KS-19_p_1"

GT.IR_emission_coeff = 0.01

--chassis
GT.swing_on_run = false
GT.toggle_alarm_state_interval = 2;
GT.animation_arguments.alarm_state = -1;

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 1.8

--Burning after hit
GT.visual.fire_size = 0.2 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.5 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 0 --burning time (seconds)
GT.visual.max_time_agony = 0;
GT.visual.agony_explosion_size = 1;
GT.visual.dust_pos = {0.0, 0.0, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {0.0, 0.0, -GT.chassis.Z_gear_2}

GT.visual.IR = { coeffs = {{0.0, 0.0}, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_100mm, {0.0, 0.0}, {0.27, 0.27/550}}}

-- weapon systems
GT.WS = {}
GT.WS.maxTargetDetectionRange = 20000;
GT.WS.fire_on_march = false;

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].omegaY = math.rad(10);
GT.WS[ws].omegaZ = math.rad(10);
GT.WS[ws].angles = {
         {math.rad(180), math.rad(-180), math.rad(-10), math.rad(85)},
         };
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].reference_angle_Z = math.rad(5)
GT.WS[ws].pidY = GT_t.AAA_PIDY
GT.WS[ws].pidZ = GT_t.AAA_PIDZ
--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.KS19);
__LN.depends_on_unit = {{{"SON_9", 2}}, {{"none"}}}
__LN.BR = {
			{connector_name = 'POINT_GUN_01',
			recoilArgument = 23,
			recoilTime = 0.55, alternativeRecoil = true,
			muzzleBrakeType = 2,
			reloadArgument = 70, reloadAnimDelay = 1.8, reloadDuration = 1.8,}	
		  }
__LN.reloadSound = {
	firstSoundTime = 1.7,
	secondSoundTime = 2.2
}

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.KS19AP);
__LN.BR = {}
set_recursive_metatable(__LN.BR, GT.WS[ws].LN[1].BR);


GT.Name = "KS-19"
GT.DisplayName = _("AAA KS-19 100mm")
GT.DisplayNameShort = _("KS-19")
GT.Rate = 5

--GT.Sensors = { OPTIC = {"long-range air defence optics"}, };

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.airWeaponDist = GT.WS[1].LN[1].distanceMax
GT.mapclasskey = "P0091000015";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Gun,WSTYPE_PLACEHOLDER,
                "AA_flak",
                "Static AAA",
                };
GT.Countries = {"USSR"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"AAA",
}
