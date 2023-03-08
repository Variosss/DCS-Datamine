-- BTR-80
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_IFV)
set_recursive_metatable(GT.chassis, GT_t.CH_t.BTR80);

GT.visual.shape = "BTR-80"
GT.visual.shape_dstr = "BTR-80_p_1"

GT.IR_emission_coeff = 0.08

--chassis
GT.swing_on_run = false

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 2.32

--Burning after hit
GT.visual.fire_size = 0.85 --relative burning size
GT.visual.fire_pos[1] = -0.8 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.11 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 580 --burning time (seconds)
GT.visual.min_time_agony = 5;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 5;

-- see description in GT_t.lua
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, GT_t.IR_COEFFS_HMG, IR_COEFFS_BODY, {0.3, 0.3/1400}}}

GT.driverViewConnectorName = {"POINT_DRIVER", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = 5000;
GT.WS.smoke = {"SMOKE_01", "SMOKE_02", "SMOKE_03", "SMOKE_04", "SMOKE_05", "SMOKE_06"};

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.KPVT_BTR)
GT.WS[ws].angles = {
					{math.rad(160), math.rad(-160), math.rad(-6), math.rad(60)},
					{math.rad(-160), math.rad(160), math.rad(-2), math.rad(60)},
}
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].pointer = 'POINT_SIGHT_02'
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_MGUN_01'
GT.WS[ws].LN[2].BR[1].connector_name = 'POINT_MGUN_02'
GT.WS[ws].LN[2].fireAnimationArgument = -1

GT.Name = "BTR-80"
GT.DisplayName = _("APC BTR-80")
GT.DisplayNameShort = _("BTR80")
GT.Rate = 10

GT.Sensors = { OPTIC = {"TKN-3B day", "TKN-3B night"} };

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000004";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun,wsType_GenericAPC,
                "APC",
                };
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"APC",
}
GT.InternalCargo = {
			nominalCapacity = 700,
			maximalCapacity = 700, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}
GT.Countries = {"USSR"}