-- HY-2 (Silkworm China)

-- missile
local HY_2_miss = {
        Name = HY_2, --P-15U
		display_name = _('HY-2 (SS-N-2 Styx)'),
		name = "HY-2",
		wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_SS_Missile,WSTYPE_PLACEHOLDER};
        Escort = 0,
        Head_Type = 5,
		sigma = {15, 15, 15},
        M = 2325.0,
        H_max = 12000.0,
        H_min = -1,
        Diam = 470.0,
        Cx_pil = 1,
        D_max = 100000.0,
        D_min = 3000.0,
        Head_Form = 1,
        Life_Time = 1800.0,
        Nr_max = 12,
        v_min = 170.0,
        v_mid = 374.0,
        Mach_max = 1.1,
        t_b = 0.0,
        t_acc = 6.0,
        t_marsh = 800.0,
        Range_max = 100000.0,
        H_min_t = 0.0,
        Fi_start = 3.14152,
        Fi_rak = 3.14152,
        Fi_excort = 3.14152,
        Fi_search = 99.9,
        OmViz_max = 99.9,
        warhead = antiship_penetrating_warhead(490.0),
        exhaust1 = {1,1,1,1},
		exhaust2 = {0.9, 0.9, 0.9, 0.05},
        X_back = -3.85,
        Y_back = 0.0,
        Z_back = 0.0,
		X_back_acc = -3.38,
        Y_back_acc = -0.58,
        Z_back_acc = 0.0,
        Reflection = 0.3967,
        KillDistance = 0.0,
		shape_table_data = 
		{
			{
				name	 = "HY_2";
				file  	 = "hy2_missile";
				life  	 = 1;
				fire  	 = { 0, 1};
				username = "HY_2";
				index = WSTYPE_PLACEHOLDER;
			},
		}
}
declare_weapon(HY_2_miss)

--launcher
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 4

GT.visual.shape = "hy_launcher";
GT.visual.shape_dstr = "hy_launcher_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.01

--chassis

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 3.0;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_LMG, {0.0, 0.00}, {0.15, 0.15/350}}}

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 120000;
local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {0, 1, 0};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-10), math.rad(80)}
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = -1;
GT.WS[ws].reference_angle_Z = math.rad(10)
GT.WS[ws].reference_angle_Y = math.pi
GT.WS[ws].reloadAngleY = math.pi;
GT.WS[ws].reloadAngleZ = 0.0;
GT.WS[ws].LN = {{}}
local __LN = GT.WS[ws].LN[1]
__LN.type = 1
__LN.distanceMin = 13000
__LN.distanceMax = 100000
__LN.reactionTime = 10
__LN.launch_delay = 5;
__LN.show_external_missile = true
__LN.sensor = {}
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[0])
__LN.depends_on_unit = {{{"Silkworm_SR"}}}
__LN.PL = {}
__LN.PL[1] = {}
__LN.PL[1].ammo_capacity = 1
__LN.PL[1].type_ammunition = HY_2_miss.wsTypeOfWeapon
__LN.PL[1].name_ammunition = HY_2_miss.shape_table_data.username
__LN.PL[1].reload_time = 2700
__LN.PL[1].shot_delay = 0.1
__LN.BR = {{connector_name = 'POINT_ROCKET'}};

GT.Name = "hy_launcher";
GT.DisplayName = _("AShM Silkworm (SS-N-2) ");
GT.DisplayNameShort = _("Silkworm");
GT.Rate = 10;

GT.DetectionRange  = 100000;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000079";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, WSTYPE_PLACEHOLDER,
				"SS_missile", "Artillery"
				};
GT.category = "MissilesSS";
GT.tags  =
{
    "MissilesSS",
	"SSM",
}
GT.Countries = {"China", "Iran", "Iraq"}