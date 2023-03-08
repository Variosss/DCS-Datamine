-- HL pickup with DShK

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle);
set_recursive_metatable(GT.chassis, GT_t.CH_t.hilux_pickup);
GT.chassis.mass = GT.chassis.mass + 80;   --1740=1660+80kg DShK

GT.visual.shape = "ttHL-dshk";	
GT.visual.shape_dstr = "ttHL_p_1";

GT.IR_emission_coeff = 0.08

GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.826;

--destruction  
GT.agony_fire_pos_y = 0.982;
GT.agony_fire_pos_y = 1.725;
GT.agony_fire_pos_z = 0.315;

--Burning after hit
GT.visual.fire_size = 0.65; --relative burning size
GT.visual.fire_pos[1] = 0.2; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0.8; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 300; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_HMG, IR_COEFFS_BODY, {0.21, 0.21/1050}}}

GT.driverCockpit = "DriverCockpit/DriverCockpit"
GT.driverViewConnectorName = "POINT_DRIVER"

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 7500;

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].cockpit = { "IronSight/IronSight", open = true};
GT.WS[ws].pointer = "POINT_SIGHT_01"
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].angles = {
					 {math.rad(45), math.rad(-45), math.rad(-8), math.rad(80)},		-- main
                    {math.rad(-45), math.rad(45), math.rad(0), math.rad(80)},		-- roof sector
					};
--GT.WS[ws].reference_angle_Y = math.rad(180);
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_utes);
__LN.type = 10; 
__LN.reactionTime = 0.5
__LN.fireAnimationArgument = -1;
__LN.sightMasterMode = 1
__LN.sightIndicationMode = 1

__LN.BR[1].connector_name = 'POINT_GUN_01';

GT.Name = "HL_DSHK";
GT.DisplayName = _("Scout HL with DSHK 12.7mm");
GT.DisplayNameShort = _("HL DSHK");
GT.Rate = 6;
GT.Crew = 2;

GT.DetectionRange  = GT.sensor.max_range_finding_target;
--GT.airWeaponDist = 0
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000004";
GT.attribute = {wsType_Ground, wsType_Tank, wsType_Gun, WSTYPE_PLACEHOLDER,
                "APC",
                };
GT.category = "Armor"
GT.tags  =
{
   "Armor",
   "Scout/Recon",
}
GT.Countries = {"Japan"}