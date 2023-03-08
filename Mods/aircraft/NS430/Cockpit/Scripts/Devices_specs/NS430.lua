--- NS430 specifications
local gettext = require("i_18n")
_ = gettext.translate

dofile(LockOn_Options.common_script_path.."tools.lua")

common_path          = LockOn_Options.script_path.."NS430/"

package.path = package.path..";./Scripts/?.lua"

local S        = require("Serializer")

routes = {}

function save_file(name, table_to_save, file_to_save)
    local str = S:serialize_to_string(name, table_to_save)
    save_to_mission(file_to_save, str)
end

function LoadRoutes()
	local res, env, data = safe_do_mission_file("NS430/ROUTES.lua",common_path.."ROUTES.lua")
	routes = env.routes or {}
end    

function SaveRoutes()
	save_file("routes", routes, "NS430/ROUTES.lua")
end
