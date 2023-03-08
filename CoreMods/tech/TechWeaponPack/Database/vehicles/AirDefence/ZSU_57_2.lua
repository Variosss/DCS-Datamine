-- ZSU-57-2
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_track_IFV);
set_recursive_metatable(GT.chassis, GT_t.CH_t.T55);
GT.chassis.armour_thickness = 0.01
GT.chassis.r_track = 0.5

GT.visual.shape = "ZSU_57_2";
GT.visual.shape_dstr = "ZSU_57_2_p_1";

GT.encyclopediaAnimation = { 
	args = {
		[1] = 0.135, -- gun elevation
		[3] = 1, -- combat mode
	}		
}

GT.IR_emission_coeff = 0.1

GT.AddPropVehicle = {
			{ id = "Branches" , control = 'checkbox', label = _('Branches'), defValue = false, arg=60, boolean_inverted = false} -- boolean_inverted = true by default: element present - argVal=0, absent - argVal=1
		}
GT.animation_arguments.rollers_rotation = {
										   [12] = 1.0,
										   [14] = 1.0,
										   [61] = 1.64,
										   [62] = 1.64,
										   [63] = 1.51,
										   [64] = 1.51}

GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.826;

--Burning after hit
GT.visual.fire_size = 0.65; --relative burning size
GT.visual.fire_pos[1] = -1.0; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.1; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 650; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 70;
GT.visual.agony_explosion_size = 5;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_50mm, IR_COEFFS_BODY, {0.27, 0.27/1550}}}

GT.driverViewConnectorName = {"DRIVER_POINT_01", offset = {0.02, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 10000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].pointer = 'POINT_SIGHT_01';
GT.WS[ws].cockpit = {"genericAAA", {0.0, 0.0, 0.0}, open = true }
GT.WS[ws].omegaY = math.rad(20);
GT.WS[ws].omegaZ = math.rad(30);
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-10), math.rad(88)},
					};
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].pidY = GT_t.AAA_PIDY;
GT.WS[ws].pidZ = GT_t.AAA_PIDZ;

GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
local __LN = GT.WS[ws].LN[1];
__LN.name = "S_68"
__LN.display_name = _("S-68")
__LN.type = 3;
__LN.distanceMin = 0.0
__LN.distanceMax = 7000
__LN.max_trg_alt = 4000
__LN.maxTrackingSpeed = 5.56;
__LN.maxShootingSpeed = 0;
__LN.reactionTime = 3
__LN.reflection_limit = 0.22
__LN.connectorFire = true
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;
__LN.sensor = {}
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[3])
__LN.BR = {
            {connector_name = 'GUN_POINT_1', recoilArgument = 23, recoilTime = 0.2},
            {connector_name = 'GUN_POINT_2', recoilArgument = 24, recoilTime = 0.2},
        };

__LN.PL = {}
__LN.PL[1] = {}
__LN.PL[1].switch_on_delay = 0.7;
__LN.PL[1].ammo_capacity = 8; -- 1 clip per cannon side (barrel) = 2 clips each reloading
__LN.PL[1].portionAmmoCapacity = 8;
__LN.PL[1].reload_time = 4;
__LN.PL[1].shot_delay = 0.5;

-- HE (30 clips x 4 rounds)
__LN.PL[1].shell_name = {"53-UOR-281U"};
__LN.PL[1].shell_display_name = "53UOR281U (57mm HE-T)";
__LN.PL[1].feedSlot = 1;
for i = 2, 16 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1]);
end

-- AP (14 clips x 4 rounds)
__LN.PL[16].shell_name = {"53-UBR-281U"}
__LN.PL[16].shell_display_name = "53UBR281U (57mm APCBC-HE-T)"
__LN.PL[16].feedSlot = 2;
for i = 17, 22 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[16]);
end

GT.Name = "ZSU_57_2";
GT.DisplayName = _("SPAAA ZSU-57-2");
GT.DisplayNameShort = _("ZSU57");
GT.Rate = 6;

GT.Crew = 5;

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "SPAAA_NoRAD_Tank";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Gun, WSTYPE_PLACEHOLDER,
                "AA_flak",
                "Mobile AAA",
                };
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"SP AAA",
}
GT.Countries = {"Russia", "USSR", "Syria"}