-- NASAMS Missile Launcher AIM-120C

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "NASAMS_Missile_Launcher";
GT.visual.shape_dstr = "NASAMS_Missile_Launcher_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.05

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.707;

--Burning after hit
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.9 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)

GT.visual.fire_size = 0.5; --relative burning size
GT.visual.fire_time = 200; --burning time (seconds)
GT.visual.min_time_agony = 2;
GT.visual.max_time_agony = 30;
GT.visual.agony_explosion_size = 0.5;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_Med_SAM, {0.0, 0.00}, {0.15, 0.15/550}}}

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 50000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = "CENTER_TOWER"
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), 0.0, math.rad(60)},
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].omegaY = 0.523599;
GT.WS[ws].pidY = {p=10,i=0.2,d=4};

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.NASAMS);
__LN.PL[1].type_ammunition={4,4,7,106};
__LN.PL[1].name_ammunition=_("AIM-120C")
__LN.depends_on_unit = {{{"NASAMS_Command_Post"},},};
__LN.BR = {
				{connector_name = 'POINT_ROCKET_01', recoilArgument = 4, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
                {connector_name = 'POINT_ROCKET_02', recoilArgument = 5, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
                {connector_name = 'POINT_ROCKET_03', recoilArgument = 6, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
                {connector_name = 'POINT_ROCKET_04', recoilArgument = 7, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
				{connector_name = 'POINT_ROCKET_05', recoilArgument = 18, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
				{connector_name = 'POINT_ROCKET_06', recoilArgument = 19, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}
__LN = nil;

GT.Name = "NASAMS_LN_C";
GT.DisplayName = _("SAM NASAMS LN AIM-120C");
GT.DisplayNameShort = _("NASAMS LN-C");
GT.Rate = 5;

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000082";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, WSTYPE_PLACEHOLDER,
				"AA_missile",
				"SAM LL",
				"Datalink"
				};
GT.Countries = {"USA"}
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Launcher",
}