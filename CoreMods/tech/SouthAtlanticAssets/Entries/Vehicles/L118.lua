-- M105

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
--set_recursive_metatable(GT.chassis, GT_t.CH_t.BTR80);
GT.chassis.life 				= 3
GT.chassis.mass 				= 2260
GT.chassis.length 				= 3
GT.chassis.width 				= 1.78
GT.chassis.max_road_velocity 	= 3.4
GT.chassis.canSwim 				= false
GT.chassis.max_slope 			= 0.47
GT.chassis.max_vert_obstacle 	= 0.5
GT.chassis.max_acceleration 	= 0.925926
GT.chassis.min_turn_radius 		= 7
GT.chassis.X_gear_1 			= 2.147
GT.chassis.Y_gear_1 			= 0
GT.chassis.Z_gear_1 			= 1.092
GT.chassis.X_gear_2 			= -2.185
GT.chassis.Y_gear_2 			= 0
GT.chassis.Z_gear_2 			= 1.092
GT.chassis.r_max 				= 0.56
GT.chassis.armour_thickness 	= 0.011

GT.visual.shape = "M105"
--GT.visual.shape_dstr = ""

--Burning after hit
GT.visual.fire_size = 0.7 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 900 --burning time (seconds)
--GT.chassis = {}
--GT.driverCockpit = "DriverCockpit/DriverCockpitWithLLTV",
--GT.driverViewConnectorName = { "DRIVER_POINT",
--		offset = { -0.04, 0.02, 0 }
--	},
--GT.enablePlayerCanDrive = true
--GT.driverViewPoint = {2.05, 2.25, -0.55};

GT.Name = "M105"
GT.DisplayName = _("M105 Light Gun")
GT.Rate = 5
GT.DetectionRange  = 500
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000004";
GT.attribute = { 2, wsType_GenericAPC, 26, WSTYPE_PLACEHOLDER, 
		 "APC",
		 "Infantry carriers",
		 "Armored vehicles",
		 "All",
		 "Ground Units",
		 "Ground Units Non Airdefence",
		 "Armed ground units",
		 "Vehicles",
		 "Ground vehicles",
		 "Armed vehicles",
		 "AntiAir Armed Vehicles",
		 "NonAndLightArmoredUnits",
		 "LightArmoredUnits",	}
--GT.CanopyGeometry = {
--		azimuth = {},
--		elevation = {}
--	},
GT.category = "Unarmed";
GT.tags = { "Armor", "APC" },
add_surface_unit(GT)

