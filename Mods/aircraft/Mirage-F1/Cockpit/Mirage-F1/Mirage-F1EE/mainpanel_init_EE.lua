dofile(LockOn_Options.script_path.."../../Common/mainpanel_init_common.lua")

shape_name   	   = "Cockpit-F1EE"
livery = find_custom_livery("Mirage-F1EE","default")

local RWR_type  = get_aircraft_property_or_nil("RWR_type")  or "ALR_300"

if RWR_type == "ALR_300" then
	args_initial_state[1243] = 0
else
	args_initial_state[1243] = 1
end
