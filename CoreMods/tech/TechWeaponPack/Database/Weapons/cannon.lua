--Cannon Launchers
--
GT_t.LN_t.KS19 = {} 
GT_t.LN_t.KS19.type = 11  -- heavy AA gun
GT_t.LN_t.KS19.distanceMin = 20
GT_t.LN_t.KS19.distanceMax = 20000
GT_t.LN_t.KS19.max_trg_alt = 15400
GT_t.LN_t.KS19.reactionTime = 15
GT_t.LN_t.KS19.sensor = {}
set_recursive_metatable(GT_t.LN_t.KS19.sensor, GT_t.WSN_t[12])
GT_t.LN_t.KS19.PL = {}
GT_t.LN_t.KS19.PL[1] = {
							shell_name = {"KS19_100HE"},
							automaticLoader = false,
							shot_delay = 60/14,
							ammo_capacity = 200,
							portionAmmoCapacity = 200,
						}

GT_t.LN_t.KS19AP = {} 
GT_t.LN_t.KS19AP.type = 2  -- heavy gun
GT_t.LN_t.KS19AP.distanceMin = 20
GT_t.LN_t.KS19AP.distanceMax = 4000
GT_t.LN_t.KS19AP.max_trg_alt = 300
GT_t.LN_t.KS19AP.reactionTime = 10
GT_t.LN_t.KS19AP.sensor = {}
set_recursive_metatable(GT_t.LN_t.KS19AP.sensor, GT_t.WSN_t[6])
GT_t.LN_t.KS19AP.PL = {}
GT_t.LN_t.KS19AP.PL[1] = {
							shell_name = {"KS19_100AP"},
							automaticLoader = false,
							shot_delay = 60/14,
							ammo_capacity = 50,
							portionAmmoCapacity = 50,
						}

-- Pz.Kpfw IV Ausf.H KwK 40 L/48
GT_t.LN_t.KwK40 = {} 
GT_t.LN_t.KwK40.type = 2
GT_t.LN_t.KwK40.distanceMin = 10
GT_t.LN_t.KwK40.distanceMax = 3000
GT_t.LN_t.KwK40.distanceMaxForFCS = 4000
GT_t.LN_t.KwK40.max_trg_alt = 1500
GT_t.LN_t.KwK40.reactionTime = 2
GT_t.LN_t.KwK40.maxShootingSpeed = 2
GT_t.LN_t.KwK40.sensor = {}
set_recursive_metatable(GT_t.LN_t.KwK40.sensor, GT_t.WSN_t[6])
GT_t.LN_t.KwK40.PL = {}
GT_t.LN_t.KwK40.PL[1] = {}
GT_t.LN_t.KwK40.PL[1].shell_name = {"Pzgr_39/40"};
GT_t.LN_t.KwK40.PL[1].automaticLoader = false;
GT_t.LN_t.KwK40.PL[1].shot_delay = 10;
GT_t.LN_t.KwK40.BR = { {pos = {5.2, 0,0} } }

-- M4A4 Sherman gun
GT_t.LN_t.M3 = {} 
GT_t.LN_t.M3.type = 2
GT_t.LN_t.M3.distanceMin = 10
GT_t.LN_t.M3.distanceMax = 3000
GT_t.LN_t.M3.max_trg_alt = 1500
GT_t.LN_t.M3.reactionTime = 2
GT_t.LN_t.M3.maxShootingSpeed = 2
GT_t.LN_t.M3.sensor = {}
set_recursive_metatable(GT_t.LN_t.M3.sensor, GT_t.WSN_t[6])
GT_t.LN_t.M3.PL = {}
GT_t.LN_t.M3.PL[1] = {}
GT_t.LN_t.M3.PL[1].shell_name = {"M61"};
GT_t.LN_t.M3.PL[1].automaticLoader = false;
GT_t.LN_t.M3.PL[1].shot_delay = 6;
GT_t.LN_t.M3.BR = { {pos = {5.2, 0,0} } }

-- 8,8-cm-Flugabwehrkanone 18/36/37 (Acht-Acht, Flak 18) 
GT_t.LN_t.Flak18 = {} 
GT_t.LN_t.Flak18.type = 11  -- heavy AA gun
GT_t.LN_t.Flak18.distanceMin = 10
GT_t.LN_t.Flak18.distanceMax = 5000
GT_t.LN_t.Flak18.max_trg_alt = 10000
GT_t.LN_t.Flak18.reactionTime = 4
GT_t.LN_t.Flak18.sensor = {}
set_recursive_metatable(GT_t.LN_t.Flak18.sensor, GT_t.WSN_t[12])
GT_t.LN_t.Flak18.PL = {}
GT_t.LN_t.Flak18.PL[1] = {
							shell_name = {"Flak18_Sprgr_39"},
							automaticLoader = false,
							shot_delay = 60/15,
							ammo_capacity = 200,
							portionAmmoCapacity = 200
						}
--GT_t.LN_t.Flak18.BR = { {pos = {5.2, 0,0}, recoilArgument = 23, recoliTime = 0.4} }

--Flak 18/36/37
GT_t.WS_t.Flak18 = {}
GT_t.WS_t.Flak18.pos = {0.0, 1.0, 0.0}
GT_t.WS_t.Flak18.omegaY = math.rad(10.6);
GT_t.WS_t.Flak18.omegaZ = math.rad(6);
GT_t.WS_t.Flak18.angles = {
                    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(85)},
                    };
GT_t.WS_t.Flak18.drawArgument1 = 0
GT_t.WS_t.Flak18.drawArgument2 = 1
GT_t.WS_t.Flak18.reference_angle_Z = math.rad(5)
GT_t.WS_t.Flak18.pidY = GT_t.AAA_PIDY
GT_t.WS_t.Flak18.pidZ = GT_t.AAA_PIDZ
GT_t.WS_t.Flak18.LN = {{}}
set_recursive_metatable(GT_t.WS_t.Flak18.LN[1], GT_t.LN_t.Flak18)

-- PT-76 gun
GT_t.LN_t.D56T = {
	type = 2,
	distanceMin = 0,
	distanceMax = 2000,
	max_trg_alt = 300,
	reactionTime = 2,
	maxShootingSpeed = 9,
	sensor = GT_t.WSN_t[2],
	PL = {
		{
			shot_delay = 5,
			ammo_capacity = 20,
			reload_time = 20 * 10,
			shell_name = {"BR_354N"}
		},
	}
}

-- Hyundai WIA CN98 155 mm 52 caliber from Korean K9 Thunder for Turkish Firtina
GT_t.LN_t.howitzer_CN98 = {} 
GT_t.LN_t.howitzer_CN98.type = 6
GT_t.LN_t.howitzer_CN98.distanceMin = 30
GT_t.LN_t.howitzer_CN98.max_trg_alt = 5000
GT_t.LN_t.howitzer_CN98.reactionTimeLOFAC = 3; -- убираем задержку на прицеливание
GT_t.LN_t.howitzer_CN98.reactionTime = 30;
GT_t.LN_t.howitzer_CN98.maxShootingSpeed = 0;
GT_t.LN_t.howitzer_CN98.sensor = {}
set_recursive_metatable(GT_t.LN_t.howitzer_CN98.sensor, GT_t.WSN_t[8])
GT_t.LN_t.howitzer_CN98.PL = {}
GT_t.LN_t.howitzer_CN98.PL[1] = {}
GT_t.LN_t.howitzer_CN98.PL[1].ammo_capacity = 48
GT_t.LN_t.howitzer_CN98.PL[1].automaticLoader = false;
GT_t.LN_t.howitzer_CN98.PL[1].shell_name = {"K307_155HE"};
GT_t.LN_t.howitzer_CN98.PL[1].shot_delay = 15
GT_t.LN_t.howitzer_CN98.PL[1].reload_time = 1200;
GT_t.LN_t.howitzer_CN98.BR = { {pos = {6.7, 0 ,0} } }
----
GT_t.LN_t.S_60_gun = {}
GT_t.LN_t.S_60_gun.type = 3;
GT_t.LN_t.S_60_gun.distanceMin = 0.0
GT_t.LN_t.S_60_gun.distanceMax = 6000
GT_t.LN_t.S_60_gun.max_trg_alt = 4000
GT_t.LN_t.S_60_gun.reactionTime = 3
GT_t.LN_t.S_60_gun.sensor = {}
set_recursive_metatable(GT_t.LN_t.S_60_gun.sensor, GT_t.WSN_t[3])

GT_t.LN_t.S_60_gun.PL = {}
GT_t.LN_t.S_60_gun.PL[1] = {}
GT_t.LN_t.S_60_gun.PL[1].switch_on_delay = 0.7;
GT_t.LN_t.S_60_gun.PL[1].ammo_capacity = 4; -- 1 clip per cannon side (barrel) = 2 clips each reloading
GT_t.LN_t.S_60_gun.PL[1].portionAmmoCapacity = 4;
GT_t.LN_t.S_60_gun.PL[1].reload_time = 4;
GT_t.LN_t.S_60_gun.PL[1].shot_delay = 0.5;

 --HE (30 clips x 4 rounds)
GT_t.LN_t.S_60_gun.PL[1].shell_name = {"53-UOR-281U"};  --53-UOR-281U with this doesn't find
GT_t.LN_t.S_60_gun.PL[1].shell_display_name = "57mm HE-T";
GT_t.LN_t.S_60_gun.PL[1].feedSlot = 1;
for i = 2, 31 do
	GT_t.LN_t.S_60_gun.PL[i] = {}
	set_recursive_metatable(GT_t.LN_t.S_60_gun.PL[i], GT_t.LN_t.S_60_gun.PL[1]);
end
-- AP (14 clips x 4 rounds)
GT_t.LN_t.S_60_gun.PL[31].shell_name = {"53-UOR-281U"}
GT_t.LN_t.S_60_gun.PL[31].shell_display_name = "57mm APCBC-HE-T"
GT_t.LN_t.S_60_gun.PL[31].feedSlot = 2;
for i = 32, 44 do
	GT_t.LN_t.S_60_gun.PL[i] = {}
	set_recursive_metatable(GT_t.LN_t.S_60_gun.PL[i], GT_t.LN_t.S_60_gun.PL[31]);
end
