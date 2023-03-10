-- PT-76
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_track_IFV)
set_recursive_metatable(GT.chassis, GT_t.CH_t.PT_76);
GT.armour_scheme.turret_azimuth = {{0.0, 150.0, 1.5}, {150.0, 180.0, 1.0}}

GT.visual.shape = "pt-76"
GT.visual.shape_dstr = "pt-76_p_1"

GT.IR_emission_coeff = 0.08

--chassis
GT.swing_on_run = false

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 1.97

--Burning after hit
GT.visual.fire_size = 0.55 --relative burning size
GT.visual.fire_pos[1] = -1.5 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.7 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 900 --burning time (seconds)
GT.visual.dust_pos = {1.8, 0.0, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-2.7, 0.5, -GT.chassis.Z_gear_2}

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_100mm, GT_t.IR_COEFFS_BODY, {0.23, 0.23/1250}}}


GT.CustomAimPoint = {0,1.3,0}
--GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, 0.0, 0.0}}
--GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = 5000;

local ws = 0;

ws = GT_t.inc_ws();
GT.WS[ws] = {}
--GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(25)
GT.WS[ws].omegaZ = math.rad(15)
GT.WS[ws].pidY = TANK_TOWER_PIDY
GT.WS[ws].pidZ = TANK_TOWER_PIDZ
GT.WS[ws].reference_angle_Z = math.rad(5)
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-4), math.rad(30)},
                    }
local __LN = add_launcher(GT.WS[ws], GT_t.LN_t.D56T);
set_recursive_metatable(GT.WS[ws].LN[1].sensor, GT_t.WSN_t[2]);
GT.WS[ws].LN[1].BR = {
						{connector_name = "POINT_GUN", recoilArgument = 23, recoilTime = 0.3 }
					}

__LN = add_launcher(GT.WS[ws], GT.WS[ws].LN[1]);
__LN.type = 6
__LN.PL[1].shell_name = {"OF_350"}
__LN.PL[1].ammo_capacity = 20

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_7_62);
__LN.PL[1].switch_on_delay = 15;
__LN.PL[1].ammo_capacity = 250;
__LN.PL[1].portionAmmoCapacity = 250;
__LN.PL[1].reload_time = 15;
for i = 2,4 do
	__LN.PL[i] = {};
	set_recursive_metatable(__LN.PL[i], __LN.PL[1]);
end
__LN.BR[1].connector_name = 'POINT_MGUN';
__LN.fireAnimationArgument = 45;

GT.Name = "PT_76";
GT.DisplayName = _("LT PT-76");
GT.DisplayNameShort = _("PT-76");
GT.Rate = 8;

GT.Sensors = { OPTIC = {"TKN-3B day", "TKN-3B night", -- командирский
                        },
            };

GT.DetectionRange  = 0;
GT.airWeaponDist = GT.WS[1].LN[3].distanceMax;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000002";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun, WSTYPE_PLACEHOLDER,
                "Tanks",
                "CustomAimPoint",
                };
GT.category = "Armor";
GT.Countries = {"USSR"}
GT.tags  =
{
    "Armor",
	"Tank",
}