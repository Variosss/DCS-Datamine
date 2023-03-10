-- TT Pickup with ZU-23

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle);
set_recursive_metatable(GT.chassis, GT_t.CH_t.tt_70_pickup);
GT.chassis.mass = GT.chassis.mass + 950;  --3025=2075+950kg Zu-23

GT.visual.shape = "tt70-zu23";
GT.visual.shape_dstr = "tt70_p_1";

GT.encyclopediaAnimation = { 
	args = {
		[1] = 0.36666, -- cannon elevation 33 degrees
	}		
}

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

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_30mm, GT_t.IR_COEFFS_BODY, {0.25, 0.25/1050}}}

GT.driverCockpit = "DriverCockpit/DriverCockpit"
GT.driverViewConnectorName = "POINT_DRIVER"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 7500;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ZU_23);
GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].cockpit = { "IronSight/IronSight", open = true};
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].angles = {
					{math.rad(37), math.rad(-37), math.rad(33), math.rad(88)}, -- over hood
					{math.rad(-37), math.rad(37), math.rad(-14), math.rad(88)}, -- main sector
					};
GT.WS[ws].reference_angle_Z = math.rad(33);
GT.WS[ws].LN[1].fireAnimationArgument = -1;
GT.WS[ws].LN[1].sightMasterMode = 1
GT.WS[ws].LN[1].sightIndicationMode = 1

GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_GUN_01'
GT.WS[ws].LN[1].BR[2].connector_name = 'POINT_GUN_02'


GT.Name 			= "tt_ZU-23";
GT.DisplayName		= _("SPAAA LC with ZU-23");
GT.DisplayNameShort = _("LC ZU-23");
GT.Rate = 6;
GT.Crew = 2;

GT.DetectionRange  = 0
GT.airWeaponDist   = 0
GT.ThreatRange     = GT.WS[1].LN[1].distanceMax

GT.mapclasskey 	   = "P0091000205"
GT.attribute 	   = {wsType_Ground,wsType_SAM,wsType_Gun, WSTYPE_PLACEHOLDER,
						"AA_flak",
						"Mobile AAA",
					};
GT.category = "Air Defence"
GT.tags  =
{
   "Air Defence",
   "SP AAA",
}
GT.Countries = {"Japan"}