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
				life		= GT.life or 5;
			},
			{
				name  = GT.visual.shape_dstr;
				file  = GT.visual.shape_dstr;
			},
		}
		add_surface_unit(GT)
		GT = nil;
	else
		error("GT empty in file "..f)
	end;
end

--- BEGIN Vehicles
GT = nil;

-- Railway Objects
vehicle_file("RailwayObjects/VL80T.lua")
vehicle_file("RailwayObjects/CHME3T.lua")
vehicle_file("RailwayObjects/CoachCargo.lua")
vehicle_file("RailwayObjects/CoachCargoOpen.lua")
vehicle_file("RailwayObjects/CoachTankBlue.lua")
vehicle_file("RailwayObjects/CoachTankYellow.lua")
vehicle_file("RailwayObjects/CoachPassenger.lua")
vehicle_file("RailwayObjects/CoachPlatform.lua")