dofile(LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/definitions.lua")

local screen_origin = create_origin()
screen_origin.init_pos = {cx, cy}
screen_origin.isdraw = true

local grid_origin = create_origin()
grid_origin.parent_element = screen_origin.name
grid_origin.isdraw = true
grid_origin.controllers = {{"RWR_display_RIO"}}