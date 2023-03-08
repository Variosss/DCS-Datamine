GT_t.WS_t.RIM_116 = {} -- RIM-116
GT_t.WS_t.RIM_116.angles = {
					{math.rad(180), math.rad(-180), math.rad(-15), math.rad(85)},
					};
GT_t.WS_t.RIM_116.omegaY = 1
GT_t.WS_t.RIM_116.omegaZ = 1
GT_t.WS_t.RIM_116.distanceMin = 2000
GT_t.WS_t.RIM_116.distanceMax = 10000
GT_t.WS_t.RIM_116.ECM_K = 0.8;
GT_t.WS_t.RIM_116.reference_angle_Z = 0
GT_t.WS_t.RIM_116.LN = {}
GT_t.WS_t.RIM_116.LN[1] = {}
GT_t.WS_t.RIM_116.LN[1].type = 4
GT_t.WS_t.RIM_116.LN[1].launch_delay = 3;
GT_t.WS_t.RIM_116.LN[1].reactionTime = 3;
GT_t.WS_t.RIM_116.LN[1].reflection_limit = 0.02;
GT_t.WS_t.RIM_116.LN[1].inclination_correction_upper_limit = math.rad(5.0);
GT_t.WS_t.RIM_116.LN[1].inclination_correction_bias = math.rad(5.0);
GT_t.WS_t.RIM_116.LN[1].min_launch_angle = math.rad(2.0)
GT_t.WS_t.RIM_116.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.RIM_116.LN[1].sensor, GT_t.WSN_t[0])
GT_t.WS_t.RIM_116.LN[1].beamWidth = math.rad(90);
GT_t.WS_t.RIM_116.LN[1].BR = { {pos = {0, 0, 0.9} }, {pos = {0, 0, -0.9} } }
GT_t.WS_t.RIM_116.LN[1].PL = {}
GT_t.WS_t.RIM_116.LN[1].PL[1] = {}
GT_t.WS_t.RIM_116.LN[1].PL[1].ammo_capacity = 21
GT_t.WS_t.RIM_116.LN[1].PL[1].type_ammunition = RIM_116A.wsTypeOfWeapon;
GT_t.WS_t.RIM_116.LN[1].PL[1].shot_delay = 0.1;
GT_t.WS_t.RIM_116.LN[1].PL[1].reload_time = 1000000; -- never during the mission

GT_t.LN_t.HOT2 = {} -- for VAB Mephisto
GT_t.LN_t.HOT2.type = 33
GT_t.LN_t.HOT2.distanceMin = 50
GT_t.LN_t.HOT2.distanceMax = 3800
GT_t.LN_t.HOT2.max_trg_alt = 3000
GT_t.LN_t.HOT2.reactionTime = 4;
GT_t.LN_t.HOT2.launch_delay = 2;
GT_t.LN_t.HOT2.beamWidth = math.rad(1);
GT_t.LN_t.HOT2.radialDisperse = 2.0;
GT_t.LN_t.HOT2.dispertionReductionFactor = 0.986;
GT_t.LN_t.HOT2.missileControlInterval = 0.1;
GT_t.LN_t.HOT2.maxShootingSpeed = 0; -- during HOT2 missile flight platform should stand still
GT_t.LN_t.HOT2.sensor = {}
set_recursive_metatable(GT_t.LN_t.HOT2.sensor, GT_t.WSN_t[0])
GT_t.LN_t.HOT2.PL = {}
GT_t.LN_t.HOT2.PL[1] = {}
GT_t.LN_t.HOT2.PL[1].type_ammunition=HOT2.wsTypeOfWeapon
GT_t.LN_t.HOT2.PL[1].name_ammunition=_("HOT2");
GT_t.LN_t.HOT2.PL[1].automaticLoader = true;
GT_t.LN_t.HOT2.PL[1].ammo_capacity = 12;
GT_t.LN_t.HOT2.PL[1].reload_time = 15*12;
GT_t.LN_t.HOT2.PL[1].shot_delay = 10;
GT_t.LN_t.HOT2.BR = {
                {pos = {0.0, 2.0, 0.0} },
            };
GT_t.LN_t.HOT2.inclination_correction_upper_limit = math.rad(45);
GT_t.LN_t.HOT2.inclination_correction_bias = math.rad(1.1);

GT_t.LN_t.NASAMS = {}
GT_t.LN_t.NASAMS.type = 4
GT_t.LN_t.NASAMS.distanceMin = 1000
GT_t.LN_t.NASAMS.distanceMax = 15000
GT_t.LN_t.NASAMS.reactionTime = 2
GT_t.LN_t.NASAMS.reflection_limit = 0.05;
GT_t.LN_t.NASAMS.ECM_K = 0.8
GT_t.LN_t.NASAMS.max_number_of_missiles_channels = 2;
GT_t.LN_t.NASAMS.launch_delay = 1;
GT_t.LN_t.NASAMS.maxShootingSpeed = 0.0;
GT_t.LN_t.NASAMS.show_external_missile = true
GT_t.LN_t.NASAMS.sensor = {}
set_recursive_metatable(GT_t.LN_t.NASAMS.sensor, GT_t.WSN_t[0])
GT_t.LN_t.NASAMS.barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;
GT_t.LN_t.NASAMS.PL = {}
GT_t.LN_t.NASAMS.PL[1] = {}
GT_t.LN_t.NASAMS.PL[1].ammo_capacity = 6;
GT_t.LN_t.NASAMS.PL[1].automaticLoader = false;
GT_t.LN_t.NASAMS.PL[1].type_ammunition={4,4,7,24};
GT_t.LN_t.NASAMS.PL[1].name_ammunition=_("AIM-120B")
GT_t.LN_t.NASAMS.PL[1].shot_delay = 0.1;
GT_t.LN_t.NASAMS.PL[1].reload_time = 6*420; --7 min per missile
GT_t.LN_t.NASAMS.BR = {
            };
				
			
			
GT_t.WS_t.MLRS_B8N1 = {};	-- mounted on a pickup truck
GT_t.WS_t.MLRS_B8N1.angles = {
                    {math.rad(0.6), math.rad(-0.6), math.rad(0), math.rad(28.8)},
                    };
GT_t.WS_t.MLRS_B8N1.reference_angle_Z = math.rad(10);
GT_t.WS_t.MLRS_B8N1.canSetTacticalDir = true
GT_t.WS_t.MLRS_B8N1.drawArgument2 = 1;
GT_t.WS_t.MLRS_B8N1.omegaY = math.rad(1);
GT_t.WS_t.MLRS_B8N1.omegaZ = math.rad(1);
GT_t.WS_t.MLRS_B8N1.pidY = {p = 10, i = 0.0, d = 7, inn = 1};
GT_t.WS_t.MLRS_B8N1.pidZ = {p = 10, i = 0.0, d = 7, inn = 1};
GT_t.WS_t.MLRS_B8N1.mount_before_move = true;

GT_t.WS_t.MLRS_B8N1.LN = {};
GT_t.WS_t.MLRS_B8N1.LN[1] = {};
GT_t.WS_t.MLRS_B8N1.LN[1].type = 34;
GT_t.WS_t.MLRS_B8N1.LN[1].maxShootingSpeed = 0;
GT_t.WS_t.MLRS_B8N1.LN[1].out_velocity = 450;
GT_t.WS_t.MLRS_B8N1.LN[1].distanceMin = 1000;
GT_t.WS_t.MLRS_B8N1.LN[1].distanceMax = 5000;
GT_t.WS_t.MLRS_B8N1.LN[1].reactionTimeLOFAC = 3;
GT_t.WS_t.MLRS_B8N1.LN[1].reactionTime = 15;
GT_t.WS_t.MLRS_B8N1.LN[1].launch_delay = 1.0;
GT_t.WS_t.MLRS_B8N1.LN[1].barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;
GT_t.WS_t.MLRS_B8N1.LN[1].connectorFire = false
GT_t.WS_t.MLRS_B8N1.LN[1].sensor = {};
set_recursive_metatable(GT_t.WS_t.MLRS_B8N1.LN[1].sensor, GT_t.WSN_t[3]);

GT_t.WS_t.MLRS_B8N1.LN[1].PL = {};
GT_t.WS_t.MLRS_B8N1.LN[1].PL[1] = {};
GT_t.WS_t.MLRS_B8N1.LN[1].PL[1].rocket_name = "weapons.nurs.C_8OFP2";
GT_t.WS_t.MLRS_B8N1.LN[1].PL[1].ammo_capacity = 20;
GT_t.WS_t.MLRS_B8N1.LN[1].PL[1].reload_time = 420;
GT_t.WS_t.MLRS_B8N1.LN[1].PL[1].shot_delay = 0.01;