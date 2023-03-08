dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_2

txt_item_data			   	   = CreateElement "ceStringPoly"
txt_item_data.name             = "tid_"
txt_item_data.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_data.init_pos		   =  {0,0,0}
txt_item_data.alignment        =  "LeftTop"
txt_item_data.stringdefs       =  abris_font[3]
txt_item_data.formats		   =  {"%s"}
txt_item_data.controllers      =  {{"current_menu_in_list_position",-new_delta*GetScale()},
								   {"current_menu_item_string_representation",0}}                                 
SetDefaultClipWithLevel(txt_item_data,2)
Add(txt_item_data)
use_mipfilter(txt_item_data)
