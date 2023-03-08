dofile(LockOn_Options.common_script_path.."tools.lua")

local file_path  		    = SETTINGS_PATH or "SETTINGS.lua"
local default_path          = LockOn_Options.script_path..file_path

package.path = package.path..";./Scripts/?.lua"
local S        = require("Serializer")

settings = {}

function LoadSettings(custom_path)  
	local f_mission = file_path
	local f_default = default_path
	if  custom_path then
		f_mission = custom_path.."SETTINGS.lua"
		f_default = LockOn_Options.script_path.."SETTINGS.lua"
	end
	local res,env,data = safe_do_mission_file(f_mission,f_default)
	settings = env.settings or {}
	if res then 
		return 1
	else
		return 0
	end
end    

function SaveSettings(custom_path)
	local file = file_path
	if  custom_path then
		file = custom_path.."SETTINGS.lua"
	end
	local str  = S:serialize_to_string("settings",settings)
	save_to_mission(file,str)
end

