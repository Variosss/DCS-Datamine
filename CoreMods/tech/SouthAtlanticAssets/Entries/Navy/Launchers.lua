
-- Weapon system definition template:
-- 4.5" Main Gun
GT_t.WS_t.ship_45cal_Mk6 = {name = "406 mm Mark 6"}
GT_t.WS_t.ship_45cal_Mk6.angles_mech = { {math.rad(150), math.rad(-150), math.rad(-2), math.rad(80)}, };
GT_t.WS_t.ship_45cal_Mk6.angles = { {math.rad(150), math.rad(-150), math.rad(-2), math.rad(80)}, };
GT_t.WS_t.ship_45cal_Mk6.omegaY = 0.6
GT_t.WS_t.ship_45cal_Mk6.omegaZ = 0.6
GT_t.WS_t.ship_45cal_Mk6.reference_angle_Z = math.rad(0)
GT_t.WS_t.ship_45cal_Mk6.LN = {}
GT_t.WS_t.ship_45cal_Mk6.LN[1] = {}
GT_t.WS_t.ship_45cal_Mk6.LN[1].type = 6
GT_t.WS_t.ship_45cal_Mk6.LN[1].distanceMin = 500
GT_t.WS_t.ship_45cal_Mk6.LN[1].distanceMax = 27500
GT_t.WS_t.ship_45cal_Mk6.LN[1].max_trg_alt = 2000
GT_t.WS_t.ship_45cal_Mk6.LN[1].reactionTime = 15
GT_t.WS_t.ship_45cal_Mk6.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_45cal_Mk6.LN[1].sensor, GT_t.WSN_t[10])   -- was 10 
GT_t.WS_t.ship_45cal_Mk6.LN[1].PL = {}
GT_t.WS_t.ship_45cal_Mk6.LN[1].PL[1] = {}
GT_t.WS_t.ship_45cal_Mk6.LN[1].PL[1].ammo_capacity = 150
GT_t.WS_t.ship_45cal_Mk6.LN[1].PL[1].shell_name = {"A222_130"}; 
GT_t.WS_t.ship_45cal_Mk6.LN[1].PL[1].shot_delay = 60/15 
GT_t.WS_t.ship_45cal_Mk6.LN[1].automaticLoader = false;
GT_t.WS_t.ship_45cal_Mk6.LN[1].reload_time = 240 * 20
GT_t.WS_t.ship_45cal_Mk6.LN[1].BR = { {pos = {8, 0, 0.1} }, {pos = {8, 0, 0.0} } }

-- --Oerlikon_20  Gun 
GT_t.WS_t.ship_Oerlikon_20 = {name = "20 mm Oerlikon"};
GT_t.WS_t.ship_Oerlikon_20.angles = { {math.rad(180), math.rad(-180), math.rad(-15), math.rad(90)}, };
GT_t.WS_t.ship_Oerlikon_20.omegaY = math.rad(115) 
GT_t.WS_t.ship_Oerlikon_20.omegaZ = math.rad(116) 
GT_t.WS_t.ship_Oerlikon_20.reference_angle_Z = math.rad(0)
GT_t.WS_t.ship_Oerlikon_20.LN = {}
GT_t.WS_t.ship_Oerlikon_20.LN[1] = {}
GT_t.WS_t.ship_Oerlikon_20.LN[1].type = 3
GT_t.WS_t.ship_Oerlikon_20.LN[1].distanceMin = 10
GT_t.WS_t.ship_Oerlikon_20.LN[1].distanceMax = 3600
GT_t.WS_t.ship_Oerlikon_20.LN[1].max_trg_alt = 1000
GT_t.WS_t.ship_Oerlikon_20.LN[1].reactionTime = 1.8
GT_t.WS_t.ship_Oerlikon_20.LN[1].beamWidth = math.rad(1);
GT_t.WS_t.ship_Oerlikon_20.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_Oerlikon_20.LN[1].sensor, GT_t.WSN_t[3])
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL = {}
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1] = {}
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1].ammo_capacity = 4000;
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1].shell_name = {"Rh202_20_AP", "Rh202_20_HE"};
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1].shell_display_name = "20mm AP+HE";
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1].shot_delay = 60/450 
GT_t.WS_t.ship_Oerlikon_20.LN[1].PL[1].reload_time = 1000000; 
GT_t.WS_t.ship_Oerlikon_20.LN[1].BR = { {pos = {0, 0, 0} } }

-- Sea Cat
GT_t.WS_t.ship_Sea_Cat = {};
GT_t.WS_t.ship_Sea_Cat_mech = { {math.rad(180), math.rad(-180), math.rad(0), math.rad(89) }, 
								  --{math.rad(-180), math.rad(180), math.rad(0), math.rad(89) },
							  }
GT_t.WS_t.ship_Sea_Cat.angles = { {math.rad(180), math.rad(-180), math.rad(-0), math.rad(90)}, }
GT_t.WS_t.ship_Sea_Cat.reference_angle_Z = math.rad(90)
GT_t.WS_t.ship_Sea_Cat.reference_angle_Y = math.rad(0)
GT_t.WS_t.ship_Sea_Cat.LN = {}
GT_t.WS_t.ship_Sea_Cat.LN[1] = {}
GT_t.WS_t.ship_Sea_Cat.LN[1].type = 4
GT_t.WS_t.ship_Sea_Cat.LN[1].distanceMin = 500
GT_t.WS_t.ship_Sea_Cat.LN[1].distanceMax = 5000
GT_t.WS_t.ship_Sea_Cat.LN[1].max_trg_alt = 5000
GT_t.WS_t.ship_Sea_Cat.LN[1].reactionTime = 3
GT_t.WS_t.ship_Sea_Cat.LN[1].launch_delay = 2;
GT_t.WS_t.ship_Sea_Cat.LN[1].max_number_of_missile_channels = 1;
GT_t.WS_t.ship_Sea_Cat.LN[1].beamWidth = math.rad (90)
GT_t.WS_t.ship_Sea_Cat.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_Sea_Cat.LN[1].sensor, GT_t.WSN_t[0])
GT_t.WS_t.ship_Sea_Cat.LN[1].PL = {}
GT_t.WS_t.ship_Sea_Cat.LN[1].PL[1] = {}
GT_t.WS_t.ship_Sea_Cat.LN[1].PL[1].ammo_capacity = 32;
GT_t.WS_t.ship_Sea_Cat.LN[1].PL[1].type_ammunition = {4,4,34,369}   
GT_t.WS_t.ship_Sea_Cat.LN[1].PL[1].reload_time = 1000000; 
GT_t.WS_t.ship_Sea_Cat.LN[1].BR = {}
GT_t.WS_t.ship_Sea_Cat.LN[1].BR = { {pos = {0, 0, 0} } }
GT_t.WS_t.ship_Sea_Cat.LN[1].show_external_missile = true;


-- -- Sea_Dart
GT_t.WS_t.ship_Sea_Dart = {};
--GT_t.WS_t.ship_Sea_Dart_mech = { {math.rad(180), math.rad(-180), math.rad(5), math.rad(89) }, }
GT_t.WS_t.ship_Sea_Dart.angles = { {math.rad(155), math.rad(-155), math.rad(0), math.rad(89) },}
GT_t.WS_t.ship_Sea_Dart.reference_angle_Z = math.rad(90)
GT_t.WS_t.ship_Sea_Dart.LN = {}
GT_t.WS_t.ship_Sea_Dart.LN[1] = {}
GT_t.WS_t.ship_Sea_Dart.LN[1].type = 4
GT_t.WS_t.ship_Sea_Dart.LN[1].distanceMin = 3000
GT_t.WS_t.ship_Sea_Dart.LN[1].distanceMax = 56000 
GT_t.WS_t.ship_Sea_Dart.LN[1].max_trg_alt = 18300
GT_t.WS_t.ship_Sea_Dart.LN[1].reactionTime = 3
GT_t.WS_t.ship_Sea_Dart.LN[1].launch_delay = 2;
GT_t.WS_t.ship_Sea_Dart.LN[1].max_number_of_missile_channels = 2;
GT_t.WS_t.ship_Sea_Dart.LN[1].beamWidth = math.rad (90)
GT_t.WS_t.ship_Sea_Dart.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_Sea_Dart.LN[1].sensor, GT_t.WSN_t[0])
GT_t.WS_t.ship_Sea_Dart.LN[1].PL = {}
GT_t.WS_t.ship_Sea_Dart.LN[1].PL[1] = {}
GT_t.WS_t.ship_Sea_Dart.LN[1].PL[1].ammo_capacity = 22;
GT_t.WS_t.ship_Sea_Dart.LN[1].PL[1].type_ammunition = {4,4,34,370}   
GT_t.WS_t.ship_Sea_Dart.LN[1].PL[1].reload_time = 100000; 
GT_t.WS_t.ship_Sea_Dart.LN[1].BR = { {pos = {0, 0, 0} } }
GT_t.WS_t.ship_Sea_Dart.LN[1].show_external_missile = true;



-- Torpedos
--GT_t.WS_t.ship_mk46 ={};
GT_t.WS_t.ship_mk46 = { name = "mk46-torp", display_name = ("Mk46"),};
GT_t.WS_t.ship_mk46.angles = { {math.rad(180), math.rad(-180), math.rad(0), math.rad(90)}, };
GT_t.WS_t.ship_mk46.reference_angle_X = 0
GT_t.WS_t.ship_mk46.reference_angle_Y = 0
GT_t.WS_t.ship_mk46.reference_angle_Z = 0
GT_t.WS_t.ship_mk46.LN = {};
GT_t.WS_t.ship_mk46.LN[1] = {};
GT_t.WS_t.ship_mk46.LN[1].type = 32
GT_t.WS_t.ship_mk46.LN[1].distanceMin = 3000;
GT_t.WS_t.ship_mk46.LN[1].distanceMax = 56000;
GT_t.WS_t.ship_mk46.LN[1].max_trg_alt = 18300;
GT_t.WS_t.ship_mk46.LN[1].reactionTime = 3
GT_t.WS_t.ship_mk46.LN[1].launch_delay = 2;
GT_t.WS_t.ship_mk46.LN[1].max_number_of_missile_channels = 3;
GT_t.WS_t.ship_mk46.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_mk46.LN[1].sensor, GT_t.WSN_t[0])
GT_t.WS_t.ship_mk46.LN[1].PL = {}
GT_t.WS_t.ship_mk46.LN[1].PL[1] = {}
GT_t.WS_t.ship_mk46.LN[1].PL[1].ammo_capacity = 18;
GT_t.WS_t.ship_mk46.LN[1].PL[1].type_ammunition = {4,8,11,398};
GT_t.WS_t.ship_mk46.LN[1].PL[1].reload_time = 1000000; 
GT_t.WS_t.ship_mk46.LN[1].BR = { {pos = {0, 0, 0} }, {pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} } }
GT_t.WS_t.ship_mk46.LN[1].show_external_missile = true;
--add_launcher(GT_t.WS_t.ship_mk46, GT_t.LN_t.ship_mk46);

GT_t.WS_t.ship_Torpedo84 = {};
GT_t.WS_t.ship_Torpedo84.angles = { {math.rad(180), math.rad(-180), math.rad(0), math.rad(90)}, };
GT_t.WS_t.ship_Torpedo84.reference_angle_X = 0
GT_t.WS_t.ship_Torpedo84.reference_angle_Y = 0
GT_t.WS_t.ship_Torpedo84.reference_angle_Z = 0
GT_t.WS_t.ship_Torpedo84.LN = {}
GT_t.WS_t.ship_Torpedo84.LN[1] = {}
GT_t.WS_t.ship_Torpedo84.LN[1].type = 32 
GT_t.WS_t.ship_Torpedo84.LN[1].distanceMin = 3000
GT_t.WS_t.ship_Torpedo84.LN[1].distanceMax = 56000 
GT_t.WS_t.ship_Torpedo84.LN[1].max_trg_alt = 18300
GT_t.WS_t.ship_Torpedo84.LN[1].reactionTime = 3
GT_t.WS_t.ship_Torpedo84.LN[1].launch_delay = 2;
GT_t.WS_t.ship_Torpedo84.LN[1].max_number_of_missile_channels = 3;
GT_t.WS_t.ship_Torpedo84.LN[1].sensor = {}
set_recursive_metatable(GT_t.WS_t.ship_Torpedo84.LN[1].sensor, GT_t.WSN_t[0])
GT_t.WS_t.ship_Torpedo84.LN[1].PL = {}
GT_t.WS_t.ship_Torpedo84.LN[1].PL[1] = {}
GT_t.WS_t.ship_Torpedo84.LN[1].PL[1].ammo_capacity = 18;
GT_t.WS_t.ship_Torpedo84.LN[1].PL[1].type_ammunition = {4,8,11,319}   
GT_t.WS_t.ship_Torpedo84.LN[1].PL[1].reload_time = 1000000; 
GT_t.WS_t.ship_Torpedo84.LN[1].BR = { {pos = {0, 0, 0} }, {pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} },{pos = {0, 0, 0} } }
GT_t.WS_t.ship_Torpedo84.LN[1].show_external_missile = true;



-- Harpoon

GT_t.LN_t.HARPOON = {}
GT_t.LN_t.HARPOON.type = 1
GT_t.LN_t.HARPOON.distanceMin = 3000
GT_t.LN_t.HARPOON.distanceMax = 95000
GT_t.LN_t.HARPOON.max_trg_alt = 18300
GT_t.LN_t.HARPOON.reactionTime = 3
GT_t.LN_t.HARPOON.launch_delay = 2;
GT_t.LN_t.HARPOON.max_number_of_missile_channels = 8;
GT_t.LN_t.HARPOON.sensor = {}
set_recursive_metatable(GT_t.LN_t.HARPOON.sensor, GT_t.WSN_t[0])
GT_t.LN_t.HARPOON.PL = {}
GT_t.LN_t.HARPOON.PL[1] = {}
GT_t.LN_t.HARPOON.PL[1].ammo_capacity = 4;
GT_t.LN_t.HARPOON.PL[1].type_ammunition = {4,4,11,126}  
GT_t.LN_t.HARPOON.PL[1].reload_time = 1000000; 
GT_t.LN_t.HARPOON.BR = { {pos = {0, 0, 0} },{pos = {0, 0, 0} }, }
GT_t.LN_t.HARPOON.show_external_missile = true;

GT_t.WS_t.ship_HARPOON = {}
GT_t.WS_t.ship_HARPOON.angles = {
					{math.rad(180), math.rad(-180), math.rad(-90), math.rad(90)},
					};
GT_t.WS_t.ship_HARPOON.reference_angle_Z = 0.785398
GT_t.WS_t.ship_HARPOON.moveable = false
GT_t.WS_t.ship_HARPOON.LN = {}
add_launcher(GT_t.WS_t.ship_HARPOON, GT_t.LN_t.HARPOON);




















