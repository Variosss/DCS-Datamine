dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_2
add_line(y_size -    y_pos_delta)
AddMode("ПЛАН")
AddButtons("","\\/","/\\","ЗАГР","ОТМЕНА")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()

current_list_block_1 			 = AddFrame(-x_size,x_size,-0.8*cursor_size_scaled/2,0.7*cursor_size_scaled/2)
current_list_block_1.init_pos  	 = {0,y_size -  2.5*y_pos_delta - 0.5*new_delta,0}
current_list_block_1.controllers = {{"current_list_controller",-new_delta*GetScale(),0,1000}}
use_mipfilter(current_list_block_1)



txt_load_header			   	   = CreateElement "ceStringPoly"
txt_load_header.name           = "txt_load_header"
txt_load_header.material       = "font_Ka-50_ABRIS_GREEN"
txt_load_header.init_pos	   =  {-0.99*x_size,y_size -  1.5*y_pos_delta,0}
txt_load_header.alignment      =  "LeftTop"
txt_load_header.stringdefs     =  abris_font[3]
txt_load_header.value   	   =  LOCALIZE("ЗАГРУЗКА МАРШРУТА")
Add(txt_load_header)
use_mipfilter(txt_load_header)


dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {-0*0.99*x_size,-y_pos_delta - 0.0*new_delta,0}
dummy.controllers      = {{"set_frame_size_for_current_menu",27}, {"specific_set_simple_menu"}} 
dummy.parent_element   = "txt_load_header"
Add(dummy)