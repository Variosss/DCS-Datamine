dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons(">","\\/","/\\","ЗАПИСЬ","ОТМЕНА")

new_delta = new_delta_2

txt_save_header			   	   = CreateElement "ceStringPoly"
txt_save_header.name           = "txt_save_header"
txt_save_header.material       = "font_Ka-50_ABRIS_WHITE"
txt_save_header.init_pos	   =  {-0.99*x_size,y_center_render -  y_render_size - 2*new_delta ,0}
txt_save_header.alignment      =  "LeftTop"
txt_save_header.stringdefs     =  abris_font[3]
txt_save_header.value   	   =  LOCALIZE("ИМЯ МАРШРУТА")..":"
Add(txt_save_header)
use_mipfilter(txt_save_header)

txt_save_route_name			   	   = CreateElement "ceStringPoly"
txt_save_route_name.name           = "txt_save_route_name"
txt_save_route_name.material       = "font_Ka-50_ABRIS_WHITE"
txt_save_route_name.alignment      =  "LeftTop"
txt_save_route_name.stringdefs     =  abris_font[3]
txt_save_route_name.formats   	   =  {"%s"}
txt_save_route_name.init_pos	   =  {0.5*x_size,-4*new_delta ,0}
txt_save_route_name.controllers    = {{"string_editor_value",0}}
txt_save_route_name.parent_element =  "txt_save_header"
Add(txt_save_route_name)
use_mipfilter(txt_save_route_name)

txt_save_route_name_cursor			   	   = Copy(txt_save_route_name)
txt_save_route_name_cursor.init_pos	   =  {0,-0.2*new_delta ,0}
txt_save_route_name_cursor.controllers    = {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_save_route_name_cursor.parent_element =  "txt_save_route_name"
Add(txt_save_route_name_cursor)
use_mipfilter(txt_save_route_name_cursor)
