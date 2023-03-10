-- VAB ("Véhicule de l'avant blindé" in French) Mephisto
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_IFV);
set_recursive_metatable(GT.chassis, GT_t.CH_t.VAB);

GT.visual.shape = "VAB_Mephisto";
GT.visual.shape_dstr = "VAB_Mephisto_p_1";

GT.encyclopediaAnimation = {
	args = {
		[4] = 1, -- launcher cover
		[5] = 1, -- launcher cover
		[6] = 1, -- launcher cover
		[7] = 1, -- launcher cover
		[25] = 1, -- scope extension
		[95] = 1, -- launcher battle state
		[96] = 1, -- launcher battle state
	}
}

GT.IR_emission_coeff = 0.085

--chassis
GT.swing_on_run = false;

-- times
local windowsFinishTime = 1;
local sightMountStartTime = windowsFinishTime+1;
local sightMountFinishTime = sightMountStartTime + 3;
local totalDuration = sightMountFinishTime;

GT.animation_arguments.alarm_state_sequence =
{
	totalDuration = totalDuration,
	-- support legs
	{3, {{startTime=0.0, endTime = windowsFinishTime},
		{startTime=windowsFinishTime, endTime = totalDuration, startVal = 1.0, endVal = 1.0}}},
	-- sight mount
	{25, {
		{startTime=0.0, endTime = sightMountStartTime, startVal = 0.0, endVal = 0.0},
		{startTime=sightMountStartTime, endTime = sightMountFinishTime, startVal = 0.0, endVal = 1.0},
	}},
}

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 3.0;

--Burning after hit
GT.visual.fire_size = 0.4; --relative burning size
GT.visual.fire_pos[1] = 2.2; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.8; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0.4; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 500; --burning time (seconds)

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, GT_t.IR_COEFFS_ATGM, GT_t.IR_COEFFS_BODY, {0.2, 0.2/1300}}}

GT.driverViewConnectorName = {"POINT_DRIVER", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 5000;
--GT.WS.smoke = {"SMOKE_02", "SMOKE_05", "SMOKE_04", "SMOKE_07", "SMOKE_01", "SMOKE_06", "SMOKE_03", "SMOKE_08",};

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(10)},
                    };
GT.WS[ws].reloadAngleY = math.rad(0);
GT.WS[ws].reloadAngleZ = math.rad(0);
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].pidY = {p=100, i=0.1, d=10, inn=10};
GT.WS[ws].pidZ = {p=100, i=0.1, d=10, inn=10};
GT.WS[ws].omegaY = math.rad(40);
GT.WS[ws].omegaZ = math.rad(10);
GT.WS[ws].laser = true;
GT.WS[ws].animation_alarm_state = {arg = 95, time = 3}

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.HOT2);
__LN.barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;

__LN.BR = { {connector_name = 'POINT_MISSILE_01', drawArgument = 4, recoilArgument = 96, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
            {connector_name = 'POINT_MISSILE_02', drawArgument = 5, recoilArgument = 96, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
			{connector_name = 'POINT_MISSILE_03', drawArgument = 6, recoilArgument = 96, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
			{connector_name = 'POINT_MISSILE_04', drawArgument = 7, recoilArgument = 96, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
        };
__LN.customViewPoint = {"VAB_sight/VAB_sight", {0.0, 0.0, 0.0}};
__LN = nil;

GT.Name = "VAB_Mephisto";
GT.DisplayName = _("ATGM VAB Mephisto");
GT.DisplayNameShort = _("Meph");
GT.Rate = 15;

GT.Sensors = { OPTIC = {"TAS4 TOW day", "TAS4 TOW night",
                        },
            };

GT.EPLRS = true

GT.DetectionRange  = 0;
GT.airWeaponDist = GT.WS[1].LN[1].distanceMax;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000204";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_MissGun,wsType_Stryker,
                "IFV",
                "ATGM",
                "Datalink"
                };
GT.Countries = {"France", "Lebanon"}
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"SP ATGM",
}
