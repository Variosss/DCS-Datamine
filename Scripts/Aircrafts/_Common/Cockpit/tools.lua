
function copyTable(target, src)
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = { }
            end
            copyTable(target[i], v)
        else
            target[i] = v
        end
    end
end


function do_chunk_in_env(chunk,env)
	if not chunk then
		return false
	end
	setfenv(chunk,env)
	res, data = pcall(chunk)
	if not res then
		print("ERROR:",data)
	end
	return res,data
end

function  make_safe_environment()
	local env = 
	{ _ 	= _ ,
	 math   = math , 
	 string = string ,
	 table  = table, 
	 pairs 	= pairs,
	 ipairs = ipairs,
	}
	env['_G']    = env
	env.dofile = function(file) 
						local res,data = do_chunk_in_env(loadfile(file),env)
						return data
					 end
	return env
end

function safe_do_mission_file(file,file_default,env)
	local env = env or make_safe_environment()
	local res  = false
	local data = nil
	if  file then
		res,data   = do_chunk_in_env(load_mission_file(file),env)
	end
	if  not res and file_default then
		res,data   = do_chunk_in_env(loadfile(file_default),env)
	end
	return res,env,data
end


function   safe_do_mission_file_2(file,env)
	return safe_do_mission_file(file,file,env)
end

function get_lat_lon_scaling()

	local   geo_center   		  = lo_to_geo_coords(0,0)
	local   lo_1   				  = geo_to_lo_coords(geo_center.lat + 0.1,geo_center.lon)
	local   lo    				  = geo_to_lo_coords(geo_center.lat      ,geo_center.lon + 0.1)
	local   dist_1       		  = math.sqrt(lo_1.z * lo_1.z + lo_1.x * lo_1.x) * 10
	local   meters_per_lon_degree = math.sqrt(lo.x * lo.x     + lo.z * lo.z) * 10
	local   lat_lon_aspect 		  = meters_per_lon_degree/dist_1
	return  lat_lon_aspect,meters_per_lon_degree
end

function get_livery_setting_from_plugin(options_plugin_name,option_name,def) --multi aircraft per module 
	local   option_name = option_name or "CPLocalList"
	local   livery      = def or "default"
	local  CNCPText = get_plugin_option_value(options_plugin_name,option_name,"local")
	return CNCPText or livery
end

function find_custom_livery(options_plugin_name,def)
	return get_livery_setting_from_plugin(options_plugin_name,"CPLocalList",def)
end
