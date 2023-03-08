-- Interface to the current navigational computer
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "command_defs.lua")
-- TODO: to check

need_to_be_closed = true;
function post_initialize()
    local self  = GetSelf()
    local pvi   = GetDevice(devices.PVI)	
    local birth = LockOn_Options.init_conditions.birth_place  
	if    birth == "GROUND_HOT" or 
		  birth == "AIR_HOT" or
		  LockOn_Options.flight.easy_radar then
	   	
   		self:performClickableAction(device_commands.Button_1, 1.0);--power
		self:performClickableAction(device_commands.Button_2, 1.0);--power
        
		pvi:performClickableAction(device_commands.Button_26, 0.3);-- set master mode to Work
		pvi:performClickableAction(device_commands.Button_11, 1);-- push PPM
		pvi:performClickableAction(device_commands.Button_11, 0);-- release PPM
		
		if birth == "GROUND_HOT" then --set Waypoint 1
			pvi:performClickableAction(device_commands.Button_2, 1);--push
			pvi:performClickableAction(device_commands.Button_2, 0);--release
		else --set Waypoint 2
			pvi:performClickableAction(device_commands.Button_3, 1);--push
			pvi:performClickableAction(device_commands.Button_3, 0);--release
		end
	end
end
