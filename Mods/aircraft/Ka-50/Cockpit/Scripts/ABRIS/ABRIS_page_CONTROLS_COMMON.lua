dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

up_line          = CreateElement "ceTexPoly"
up_line.name     = "up_line"
SetLine(up_line)
up_line.init_pos = up_line_pos
Add(up_line)

AddMode("УПРАВЛЕНИЕ")

