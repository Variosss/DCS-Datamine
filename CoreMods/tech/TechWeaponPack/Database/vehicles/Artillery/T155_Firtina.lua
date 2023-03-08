-- SPG T155 Firtina
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_track_vehicle);
set_recursive_metatable(GT.chassis, GT_t.CH_t.T155);

GT.armour_scheme = {
						hull_elevation = { {-90,11,0.8}, {11,40,1}, {40,90,0.5}, },
						hull_azimuth = { {0, 160,1.0}, {160,180,0.5}},
						turret_elevation = { {-90,40,1}, {40,90,0.5}}, 
						turret_azimuth = { {0,180,1.0}}
					};

GT.DM = {
	{ area_name = "FRONT_01", 			armour = {width=0.040}},
	{ area_name = "FRONT_02", 			armour = {width=0.040}},
	{ area_name = "HULL",	 			armour = {width=0.032}},
	{ area_name = "BODY_BACK", 			armour = {width=0.024}},
	{ area_name = "BODY_BOTTOM",		armour = {width=0.016}},
	{ area_name = "BODY_TOP",			armour = {width=0.016}},
	
	{ area_name = "TURRET_FRONT",		armour = {width=0.032}},
	{ area_name = "TURRET_LEFT",		armour = {width=0.032}},
	{ area_name = "TURRET_RIGHT",		armour = {width=0.032}},
	{ area_name = "TURRET_BACK",		armour = {width=0.032}},
	{ area_name = "TURRET_TOP",			armour = {width=0.016}},
	{ area_name = "TURRET_COM",			armour = {width=0.016}},
	{ area_name = "TURRET_COM_TOP",		armour = {width=0.016}},
	
	{ area_name = "TRACK_LEFT", 		armour = {width=0.050}},
	{ area_name = "TRACK_RIGHT", 		armour = {width=0.050}},
	{ area_name = "GUN",		 		armour = {width=0.5}},
}

GT.visual.shape = "Firtina_T155_trs"
GT.visual.shape_dstr = "Firtina_T155_trs_p_1"

GT.IR_emission_coeff = 0.11

--chassis
GT.swing_on_run = false
GT.toggle_alarm_state_interval = 5;


GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 2.8

GT.visual.fire_pos[1] = 1.863

--Burning after hit
GT.visual.fire_size = 1.05 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 430 --burning time (seconds)
GT.visual.min_time_agony = 5;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {3.7, 0.35, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-3.5, 0.6, -GT.chassis.Z_gear_2}

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_152mm, IR_COEFFS_BODY, {0.3, 0.3/1650}}}

GT.driverViewConnectorName = {"DRIVER_POINT"}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = 5000;
GT.WS.fire_on_march = false;

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].cockpit = {"genericHowitzer", {0.0, 0.0, 0.0}}
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-2), math.rad(75)},
                    };
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].mount_before_move = true;
GT.WS[ws].omegaY = math.rad(15);
GT.WS[ws].omegaZ = math.rad(20);
GT.WS[ws].pidY = {p=20, i=0.0, d=8, inn=1.5};
GT.WS[ws].pidZ = {p=20, i=0.0, d=8, inn=1.5};
GT.WS[ws].reference_angle_Y = 0;
GT.WS[ws].reference_angle_Z = 0;

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.howitzer_CN98); -- Hyundai WIA CN98 155 mm 52 caliber
__LN.connectorFire = true;
__LN.BR[1] = {connector_name = 'POINT_GUN_01',
			  recoilArgument = 23,
			  recoilTime = 0.5}
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

--GT.WS[2]
ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].base = 1;
GT.WS[ws].center = 'CENTER_M2';
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-8), math.rad(50)},
                    };
GT.WS[ws].drawArgument1 = 24;
GT.WS[ws].drawArgument2 = 25;
GT.WS[ws].omegaY = math.rad(50);
GT.WS[ws].omegaZ = math.rad(50);
GT.WS[ws].pidY = MG_TOWER_PIDY
GT.WS[ws].pidZ = MG_TOWER_PIDZ
GT.WS[ws].pointer = 'POINT_SIGHT_02'
GT.WS[ws].cockpit = {'IronSight/IronSight', {0.1, 0.0, 0.0 },}

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_M2);
__LN.type = 10; -- AA Machinegun
__LN.BR[1].connector_name = 'POINT_M2_01';
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

GT.Name = "T155_Firtina"
GT.DisplayName = _("SPH T155 Firtina 155mm")
GT.DisplayNameShort = _("Firtina")
GT.Rate = 15

GT.Sensors = { OPTIC = {"MP7"}};

--GT.EPLRS = true

GT.DetectionRange  = 0;
--GT.ThreatRangeMin = GT.WS[1].LN[1].distanceMin;
GT.ThreatRange = 41000;
GT.mapclasskey = "P0091000006";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun, WSTYPE_PLACEHOLDER,
                "Artillery", "Datalink",
                };
GT.Countries = {"Turkey"}
GT.category = "Artillery";
GT.tags  =
{
    "Artillery",
    "SPA",
}
