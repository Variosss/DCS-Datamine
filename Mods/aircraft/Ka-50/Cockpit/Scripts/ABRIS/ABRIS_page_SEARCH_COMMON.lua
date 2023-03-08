dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddMode("ПОИСК")

txt_searched			   	   = CreateElement "ceStringPoly"
txt_searched.name           = "txt_searched"
txt_searched.material       = "font_Ka-50_ABRIS_WHITE"
txt_searched.alignment      = "LeftCenter"
txt_searched.stringdefs     = abris_font[3]
txt_searched.formats   	   = {"%s"}
txt_searched.init_pos	   = {-0.9*x_size,y_center_render -  y_render_size - 1.35*new_delta ,0}
txt_searched.controllers    = {{"string_editor_value",0}}
Add(txt_searched)
use_mipfilter(txt_searched)


txt_searched_cursor			   	   = Copy(txt_searched)
txt_searched_cursor.init_pos	   =  {0,-0.2*new_delta ,0}
txt_searched_cursor.controllers    = {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_searched_cursor.parent_element =  "txt_searched"
Add(txt_searched_cursor)
use_mipfilter(txt_searched_cursor)

frame1 					   = AddFrame(-0.02,1.2,-0.06,0.025)
frame1.parent_element      = txt_searched.name

