dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

local y_diplacement = (abris_font[2][1] + abris_font[2][4] )/GetScale()

current_list_block_1 			 = AddFrame(-0.99*x_size,0.99*x_size,-1.1*y_diplacement,-0.2*y_diplacement)
current_list_block_1.init_pos  	 = {0,0.97*y_size - (y_size - up_line_pos[2]) - y_diplacement,0}
current_list_block_1.controllers = {{"current_list_controller",-y_diplacement*GetScale(),0,1000}}
use_mipfilter(current_list_block_1)

AddContextBlock(LOCALIZE("СООБЩЕН").."\n".."К-О41".."\n"..LOCALIZE("БЗД"))
AddButtons("УСТАН","","","КОПИР","МЕНЮ")
