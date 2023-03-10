-- BTR-82
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_IFV)
set_recursive_metatable(GT.chassis, GT_t.CH_t.BTR80);

GT.visual.shape = "BTR-82A"
GT.visual.shape_dstr = "BTR-82A_p_1"

GT.encyclopediaAnimation = { 
	args = {
		[1] = 0.1, -- gun elevation
	}		
}

GT.IR_emission_coeff = 0.08

--chassis
GT.swing_on_run = false

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 2.32

--Burning after hit
GT.visual.fire_size = 0.65 --relative burning size
GT.visual.fire_pos[1] = -1.2 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.13 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 680 --burning time (seconds)
GT.visual.min_time_agony = 15;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 5;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, GT_t.IR_COEFFS_30mm, GT_t.IR_COEFFS_BODY, {0.3, 0.3/1800}}}

GT.driverViewConnectorName = {"POINT_DRIVER", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = 5000;
GT.WS.smoke = {"SMOKE_03", "SMOKE_04", "SMOKE_02", "SMOKE_05", "SMOKE_01", "SMOKE_06"};

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].angles = {
					{math.rad(160), math.rad(-160), math.rad(-6), math.rad(60)},
					{math.rad(-160), math.rad(160), math.rad(-2), math.rad(60)},
}
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].pointer = 'POINT_SIGHT_02'
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(30)
GT.WS[ws].omegaZ = math.rad(40)
GT.WS[ws].stabilizer = true;
GT.WS[ws].cockpit = {"BPK-2-42/BPK-2-42", 	{0.0, 0.0, 0.0}}

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.PKT); --coaxial machinegun
__LN.distanceMaxForFCS = 2000;
__LN.PL[1].ammo_capacity = 2000;
__LN.PL[1].portionAmmoCapacity = 2000;
__LN.PL[1].reload_time = 600;
__LN.PL[1].switch_on_delay = 0.1;
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[11]);
__LN.beamWidth = math.rad(1);
__LN.BR[1].connector_name = 'POINT_GUN_02';
__LN.secondary = true;

--GT.WS[1].LN[2]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.automatic_gun_2A72); --30mm autocannon
__LN.distanceMaxForFCS = 4000;
__LN.PL[1].feedSlot = 1;
__LN.PL[1].ammo_capacity = 180;
__LN.PL[2].feedSlot = 2;
__LN.PL[2].ammo_capacity = 120;
__LN.beamWidth = math.rad(1);
__LN.BR = {{
			connector_name = 'POINT_GUN_01',
			recoilArgument = 23,
			recoilTime = 0.1}
		  };
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;


GT.Name = "BTR-82A"
GT.DisplayName = _("APC BTR-82A")
GT.DisplayNameShort = _("BTR82A")
GT.Rate = 11

GT.Sensors = { OPTIC = {"TKN-3B day", "TKN-3B night"} };

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[2].distanceMax;
GT.mapclasskey = "P0091000004";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun, WSTYPE_PLACEHOLDER,
                "APC",
                };
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"IFV",
}
GT.InternalCargo = {
			nominalCapacity = 700,
			maximalCapacity = 700, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}
GT.Countries = {"Kazakhstan", "Russia", "Syria"}