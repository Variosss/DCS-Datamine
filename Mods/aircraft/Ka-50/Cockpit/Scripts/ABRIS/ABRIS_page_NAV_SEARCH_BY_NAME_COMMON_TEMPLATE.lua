dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

txt_item_data			   	   = CreateElement "ceStringPoly"
txt_item_data.name             = "tid_"
txt_item_data.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_data.alignment        =  "LeftTop"
txt_item_data.init_pos		   =  {1.7*new_delta,0,0}
txt_item_data.stringdefs       =  abris_font[3]
txt_item_data.formats		   =  {"%s"}
txt_item_data.controllers      =  {{"current_menu_in_list_position",-2*new_delta*GetScale()},
								   {"current_menu_item_string_representation",0}}
Add(txt_item_data)
SetDefaultClipWithLevel(txt_item_data,2)
use_mipfilter(txt_item_data)

txt_item_number			   	     = CreateElement "ceStringPoly"
txt_item_number.name             = "tin_"
txt_item_number.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_number.init_pos		 =  {-0.95*new_delta,0,0}
txt_item_number.alignment        =  "CenterTop"
txt_item_number.stringdefs       =  abris_font[3]
txt_item_number.formats		     = {"%d"}
txt_item_number.controllers      = {{"current_menu_item_number",0},{"current_menu_item_change_color",0,0,0}}
txt_item_number.parent_element   =  txt_item_data.name
Add(txt_item_number)
SetDefaultClipWithLevel(txt_item_number,2)
use_mipfilter(txt_item_number)