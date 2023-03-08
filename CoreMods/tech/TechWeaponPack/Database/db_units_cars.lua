--db.Units.Cars = {};
local plugin_db_path = current_mod_path..'/Database/'

--------------------------------------------------------------------------
-- Cars
--------------------------------------------------------------------------

local function chassis_file(f)
    if dofile(plugin_db_path..f) then
		error("can't load file "..f)
		return
	end
end

local function vehicle_file(f)
	if dofile(plugin_db_path..f) then
		error("can't load file "..f)
		return
	end
	if(GT) then
		GT.shape_table_data = 
		{
			{
				file  	    = GT.visual.shape;
				username    = GT.Name;
				desrt       = GT.visual.shape_dstr;
			    classname 	= "lLandVehicle";
				
				positioning = GT.positioning or "BYNORMAL";
				--"BYNORMAL",	-- use normal from surface to form UP  ( y) axis 
				--"ONLYHEIGTH",	-- given position normalized ,  p.y  set to surface height value
				--"BY_XZ",	-- project x , z axis from given position projected to surface , 
				--"NO",			-- No transforms
				--"ADD_HEIGTH"	-- No transforms, only hight of surface are added to hight of object
				
				life		= GT.life or 6;
			},
			{
				name  = GT.visual.shape_dstr;
				file  = GT.visual.shape_dstr;
			},
		}
		GT.MaxSpeed = GT.chassis and GT.chassis.max_road_velocity and (GT.chassis.max_road_velocity * 3.6)
		add_surface_unit(GT)
		GT = nil;
	else
		error("GT empty in file "..f)
	end;
end

--- BEGIN Vehicles
GT = nil;

-- several countries
vehicle_file("vehicles/AirDefence/KS-19.lua")
vehicle_file("vehicles/AirDefence/SON-9.lua")

vehicle_file("vehicles/MissilesSS/ScudLauncher.lua")

chassis_file("chassis/tt_70_pickup.lua")
chassis_file("chassis/hilux_pickup.lua")

vehicle_file("vehicles/IFV/hilux_pickup-dshk.lua")
vehicle_file("vehicles/IFV/hilux_pickup-kord.lua")

vehicle_file("vehicles/IFV/tt70-dshk.lua")
vehicle_file("vehicles/IFV/tt70-kord.lua")

vehicle_file("vehicles/AirDefence/ZU-23 hilux_pickup.lua")
vehicle_file("vehicles/AirDefence/ZU-23 tt70_pickup.lua")

vehicle_file("vehicles/MLRS/hilux_pickup-B8M1.lua")
vehicle_file("vehicles/MLRS/tt70-B8M1.lua")
-- USA
chassis_file("chassis/Sherman.lua")
chassis_file("chassis/M2A1_halftrack.lua")

vehicle_file("vehicles/SAM/Radar/NASAMS_SR.lua")
vehicle_file("vehicles/SAM/NASAMS_CP.lua")
vehicle_file("vehicles/SAM/NASAMS_LN_B.lua")
vehicle_file("vehicles/SAM/NASAMS_LN_C.lua")

vehicle_file("vehicles/Tanks/M4_Sherman.lua")

vehicle_file("vehicles/IFV/M2A1_halftrack.lua")

vehicle_file("vehicles/SAM/EWR_FPS-117_Dome.lua")
vehicle_file("vehicles/SAM/EWR_FPS-117_ECS.lua")
vehicle_file("vehicles/SAM/EWR_FPS-117.lua")

--Russia
chassis_file("chassis/T-72B3.lua")
chassis_file("chassis/URAL4320.lua")
chassis_file("chassis/PT-76.lua")
chassis_file("chassis/KrAZ_258B1.lua")
chassis_file("chassis/ATZ-60_Maz.lua")
chassis_file("chassis/BTR80.lua")


vehicle_file("vehicles/IFV/BTR-80.lua")
vehicle_file("vehicles/SAM/S75_RF.lua")
vehicle_file("vehicles/SAM/S75_Launcher.lua")
vehicle_file("vehicles/SAM/Radar/S75_TR.lua")
vehicle_file("vehicles/SAM/Radar/19J6.lua")
vehicle_file("vehicles/SAM/Radar/S200_RPC_5N62V.lua")
vehicle_file("vehicles/SAM/S200_Launcher_P99.lua")

vehicle_file("vehicles/AirDefence/ZSU_57_2.lua")
vehicle_file("vehicles/AirDefence/S-60.lua")
vehicle_file("vehicles/AirDefence/Generator_5I57A.lua")

vehicle_file("vehicles/Tanks/T-72B3.lua")
vehicle_file("vehicles/Tanks/PT-76.lua")

vehicle_file("vehicles/IFV/BTR-82A.lua")

vehicle_file("vehicles/Unarmed/ATZ-5_URAL-375.lua")
vehicle_file("vehicles/Unarmed/AA-7_2_60.lua")
vehicle_file("vehicles/Unarmed/TZ-22_KrAZ.lua")
vehicle_file("vehicles/Unarmed/ATZ-60_Maz.lua")
vehicle_file("vehicles/Unarmed/ZIL-135.lua")
vehicle_file("vehicles/Unarmed/S-75_Zil.lua")

-- UK
chassis_file("chassis/Bedford.lua")
chassis_file("chassis/Chieftain_mk3.lua")

vehicle_file("vehicles/SAM/Rapier_FSA_Launcher.lua")
vehicle_file("vehicles/SAM/Rapier_FSA_OpticalTracker.lua")
vehicle_file("vehicles/SAM/Rapier_FSA_BlindfireTracker.lua")

vehicle_file("vehicles/AirDefence/Bofors40.lua")

vehicle_file("vehicles/Tanks/Chieftain_mk3.lua")
	
vehicle_file("vehicles/unarmed/Bedford_MWD.lua")
vehicle_file("vehicles/Unarmed/Land_Rover_101_FC.lua")
vehicle_file("vehicles/Unarmed/Land_Rover_109_S3.lua")

-- China
vehicle_file("vehicles/MissilesSS/HY-2_Launcher.lua")
vehicle_file("vehicles/MissilesSS/Mys-m1.lua")
--- END Vehicles

-- Railway Objects
vehicle_file("vehicles/RailwayObjects/ES44AH.lua")
vehicle_file("vehicles/RailwayObjects/boxcartrinity.lua")
vehicle_file("vehicles/RailwayObjects/tankcartrinity.lua")
vehicle_file("vehicles/RailwayObjects/wellcarnsc.lua")

-- Germany
chassis_file("chassis/Pz_IV_H.lua")
chassis_file("chassis/SdKfz_251.lua")
chassis_file("chassis/Blitz_36-6700A.lua")
chassis_file("chassis/Leopard-2A5.lua")

vehicle_file("vehicles/AirDefence/Flak18.lua")

vehicle_file("vehicles/Tanks/Pz_IV_H.lua")
vehicle_file("vehicles/Tanks/Leopard-2A5.lua")
vehicle_file("vehicles/Tanks/Leopard-2.lua")
vehicle_file("vehicles/Tanks/Leopard-2A4.lua")
vehicle_file("vehicles/Tanks/Leopard-2A4_trs.lua")

vehicle_file("vehicles/IFV/SdKfz251.lua")

vehicle_file("vehicles/unarmed/Blitz_36-6700A.lua")


--Turkey
chassis_file("chassis/T155.lua")
vehicle_file("vehicles/Artillery/T155_Firtina.lua")

-- France
chassis_file("chassis/VAB.lua")
vehicle_file("vehicles/IFV/VAB_Mephisto.lua")
