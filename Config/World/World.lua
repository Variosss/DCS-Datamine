RandomMissionEvents = true
MissionDate = { Year = 2016, Month = 6, Day = 21 }
ChangeDateBySeason = false	-- if true then changes the month only to fit on the season

FragmentLanding = 
{
	TrashWaterOn = false,
  	TrashGroundOnLifeTime = 60,  -- seconds
  	PartsGroundOnLifeTime = 600, -- seconds
}

-- The burn time of unit after hit. If the specific unit's name doesn't present in this list it will burning at default time 60 seconds.
ConflagrationTime = {}
ConflagrationTime["SHAPE_NAME"] 	= 60
ConflagrationTime["MT-LB"] 			= 120
-- Tanks
ConflagrationTime["LEOPARD-2"] 		= 600
ConflagrationTime["M-1"] 			= 600
ConflagrationTime["M-60"] 			= 600
ConflagrationTime["M-48"] 			= 600
ConflagrationTime["T-80UD"] 		= 600
--IFVs
ConflagrationTime["BMD-1"] 			= 500
ConflagrationTime["BMP-1"] 			= 500
ConflagrationTime["BMP-2"] 			= 500
ConflagrationTime["BMP-3"] 			= 500
ConflagrationTime["BRDM-2"] 		= 500
ConflagrationTime["BTR-70"] 		= 500
ConflagrationTime["LAV-25"] 		= 500
ConflagrationTime["AAV-7"] 			= 500
ConflagrationTime["M-113"] 			= 500
ConflagrationTime["M-113g"] 		= 500
ConflagrationTime["MARDER"] 		= 500
ConflagrationTime["TPZ"] 			= 500
ConflagrationTime["M-2"] 			= 500
ConflagrationTime["MCV-80"] 		= 500
ConflagrationTime["BTR-D"] 			= 500
--Self-propelled Guns and MLRSs
ConflagrationTime["2-C19"] 			= 500
ConflagrationTime["2-C3"] 			= 500
ConflagrationTime["2-C9"] 			= 500
ConflagrationTime["BM-21-40"] 		= 600
ConflagrationTime["M-109"] 			= 500
ConflagrationTime["A-222"] 			= 700
ConflagrationTime["SMERCH"] 		= 700
ConflagrationTime["2C1"] 			= 500
ConflagrationTime["MLRS"] 			= 500
--Vehicles
ConflagrationTime["URAL-APA"] 		= 500
ConflagrationTime["HUMMER"] 		= 500
ConflagrationTime["UAZ-469"] 		= 500
ConflagrationTime["URAL-375"] 		= 500
ConflagrationTime["URAL-375-F"] 	= 500
ConflagrationTime["ZIL-135"] 		= 500
ConflagrationTime["ICARUS"] 		= 800
ConflagrationTime["VAZ"] 			= 300
ConflagrationTime["TROLEBUS"] 		= 800
ConflagrationTime["KAMAZ-FIRE"] 	= 10
ConflagrationTime["KAMAZ-TENT"] 	= 800
ConflagrationTime["LAZ-695"] 		= 500
ConflagrationTime["GAZ-66"] 		= 500
ConflagrationTime["GAZ-3307"] 		= 800
ConflagrationTime["GAZ-3308"] 		= 800
ConflagrationTime["MAZ-6303"] 		= 800
ConflagrationTime["ZIL-4331"] 		= 800
--Reilroad Units
ConflagrationTime["WAGON-CISTERNA"]	= 2000
ConflagrationTime["WAGON-GRUZ"]		= 1000
ConflagrationTime["WAGON-GRUZ-OTKR"]= 500
ConflagrationTime["WAGON-PLATFORMA"]= 500
ConflagrationTime["WAGON-PASS"]		= 1000
--Fuel Servicing Trucks
ConflagrationTime["ATMZ-5"]			= 1000
ConflagrationTime["ATZ-10"]			= 2000
ConflagrationTime["ATZ-60"]			= 3000


function GetConflagrationTime(shape_name)
	if ConflagrationTime[shape_name] ~= nil then
		return ConflagrationTime[shape_name]
	else
		return 60;
	end
end

--Maintenance

COMMAND_VOID 					= 0
COMMAND_REARM 					= 1
COMMAND_RELOAD_CANNON 			= 2
COMMAND_REFUEL 					= 3
COMMAND_CHANGE_PILOT_EQUIPMENT 	= 4
COMMAND_CHANGE_POWER_SOURCE 	= 5
COMMAND_GROUND_POWER_ON_OFF 	= 6

MaintenanceDuration = {}
MaintenanceDuration[COMMAND_VOID] 					= 10
MaintenanceDuration[COMMAND_REARM] 					= 30
MaintenanceDuration[COMMAND_RELOAD_CANNON] 			= 10
MaintenanceDuration[COMMAND_REFUEL] 				= 10
MaintenanceDuration[COMMAND_CHANGE_PILOT_EQUIPMENT] = 5
MaintenanceDuration[COMMAND_CHANGE_POWER_SOURCE] 	= 10
MaintenanceDuration[COMMAND_GROUND_POWER_ON_OFF] 	= 5