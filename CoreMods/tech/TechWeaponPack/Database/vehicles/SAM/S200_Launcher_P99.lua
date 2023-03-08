-- SA-5 Gammon(Vega-M) launcher P99

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "S-200_Launcher";
GT.visual.shape_dstr = "S-200_Launcher_Destroyed";

GT.toggle_alarm_state_interval = 0.01;
GT.animation_arguments.alarm_state = -1;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.617;

--Burning after hit
GT.visual.fire_size = 0.4; --relative burning size
GT.visual.fire_pos[1] = 0; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.6; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 500; --burning time (seconds)

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, {0.0, 0.0}, GT_t.IR_COEFFS_Hot_SAM, {0.0, 0.00}, {0.15, 0.15/550}}}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 400000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
--GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pos = {0.0, 1.7, 0.0}
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(0), math.rad(50.0)},
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].omegaY = math.rad(5.11);
GT.WS[ws].omegaZ = math.rad(1.37);
GT.WS[ws].pidY = { p = 5, i = 0.0, d = 4, inn = 0.2};
GT.WS[ws].pidZ = { p = 50, i = 0.0, d = 40, inn = 0.2};
GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
GT.WS[ws].LN[1].type = 4
GT.WS[ws].LN[1].distanceMin = 7000
GT.WS[ws].LN[1].distanceMax = 255000
GT.WS[ws].LN[1].ECM_K = -1
GT.WS[ws].LN[1].reactionTime = 3
GT.WS[ws].LN[1].min_launch_angle = math.rad(48);
GT.WS[ws].LN[1].show_external_missile = true
GT.WS[ws].LN[1].barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;
GT.WS[ws].LN[1].depends_on_unit = {{{"RPC_5N62V", 1},},};
GT.WS[ws].LN[1].sensor = {}
set_recursive_metatable(GT.WS[ws].LN[1].sensor, GT_t.WSN_t[0])
GT.WS[ws].LN[1].PL = {}
GT.WS[ws].LN[1].PL[1] = {}
GT.WS[ws].LN[1].PL[1].ammo_capacity = 1
GT.WS[ws].LN[1].PL[1].type_ammunition = SA5V28.wsTypeOfWeapon;
GT.WS[ws].LN[1].PL[1].name_ammunition = SA5V28.shape_table_data.username
GT.WS[ws].LN[1].PL[1].reload_time = 900;
GT.WS[ws].LN[1].PL[1].shot_delay = 0.1
GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
GT.WS[ws].LN[1].BR = {
	{connector_name = 'S200_Point_Missile', drawArgument = 4},
	}
	
GT.Name = "S-200_Launcher";
GT.DisplayName = _("SAM SA-5 LN SM-99");
GT.DisplayNameShort = _("SA-5");
GT.Rate = 10;

GT.DetectionRange  = 0;
GT.ThreatRangeMin = GT.WS[1].LN[1].distanceMin;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000082";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, SA3_LN,
				"AA_missile",
				"LR SAM",
				"SAM LL",
				};
GT.category = "Air Defence";
GT.tags  =
{
	"Air Defence",
	"Launcher",
}
GT.Countries = {"Belarus", "Bulgaria", "Czech Republic", "Georgia", "Germany", "Hungary", "Iran", "Kazakhstan", "Libya", "North Korea", "Russia", "Syria", "Poland", "Ukraine", "USSR"}