dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("СООБЩЕНИЯ")
up_line2          = CreateElement "ceTexPoly"
up_line2.name     = "up_line2"
SetLine(up_line2)
up_line2.init_pos = {0,up_line_pos[2] - (y_size - up_line_pos[2]),0}
Add(up_line2)

new_delta = new_delta_2
local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()

current_list_block_1 			    = AddFrame(-x_size,x_size,-0.9*cursor_size_scaled/2,0.7*cursor_size_scaled/2)
current_list_block_1.init_pos  	    = {0,-0.5*new_delta,0}
current_list_block_1.controllers    = {{"current_list_controller",-new_delta*GetScale(),0,1000}}
current_list_block_1.parent_element = up_line2.name
use_mipfilter(current_list_block_1)

dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {-0.99*x_size,0,0}
dummy.controllers      = {{"specific_set_simple_menu"}} 
dummy.parent_element   = "up_line2"
Add(dummy)

AddContextBlock(LOCALIZE("СООБЩЕН").."\n".."К-О41".."\n"..LOCALIZE("БЗД"))
AddButtons("УСТАН","\\/","/\\","ПОСЛ","МЕНЮ")