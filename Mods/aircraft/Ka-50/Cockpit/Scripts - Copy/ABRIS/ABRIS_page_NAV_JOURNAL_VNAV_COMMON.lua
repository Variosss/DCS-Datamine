dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
---------------------------------------------------------------------------------------
up_line             = CreateElement "ceTexPoly"
up_line.name		= "up_line"
SetLine(up_line)
up_line.init_pos	= {0,y_center_render + y_render_size,0}
Add(up_line)
AddMode("ВНАВ")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddMap()
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
middle_line             = CreateElement "ceTexPoly"
middle_line.name		= "middle_line"
SetLine(middle_line)
middle_line.init_pos	= {0,y_center_render - y_render_size,0}
Add(middle_line)