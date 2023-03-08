--db.Units.Ships = {};
local plugin_db_path = current_mod_path..'/Database/'

--------------------------------------------------------------------------
-- Ships
--------------------------------------------------------------------------

local function ship_file(f)
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
				positioning = "BYNORMAL";
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

--- BEGIN Ships
GT = nil;

ship_file("Navy/HandyWind.lua")
ship_file("Navy/Seawise_Giant.lua")
ship_file("Navy/LaCombattante2.lua")
ship_file("Navy/BDK-775.lua")
