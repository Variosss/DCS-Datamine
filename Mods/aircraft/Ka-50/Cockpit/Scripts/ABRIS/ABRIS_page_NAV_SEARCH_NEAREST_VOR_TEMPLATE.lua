dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

txt_item_data			   	   = CreateElement "ceStringPoly"
txt_item_data.name             = "tid_"
txt_item_data.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_data.alignment        =  "LeftTop"
txt_item_data.init_pos		   =  {1.7*new_delta,0.015,0}
txt_item_data.stringdefs       =  abris_font[3]
txt_item_data.formats		   =  {"%s\n","D %3.2f ","%s ","(L) %s"}
txt_item_data.controllers      =  {{"current_menu_in_list_position",-3*new_delta*GetScale()},
								   {"current_menu_item_string_representation",0},
								   {"current_menu_item_band",1,2},
								   {"current_menu_item_callsign",2},
								   {"current_menu_item_description",0},
								   {"current_menu_item_morze_callsign",3}								   
								   }
Add(txt_item_data)
use_mipfilter(txt_item_data)

txt_item_coord_data			   	     = CreateElement "ceStringPoly"
txt_item_coord_data.name             = "tid_brg"
txt_item_coord_data.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_coord_data.alignment        =  "LeftTop"
txt_item_coord_data.init_pos		 =  {1.7*new_delta+1.5,0,0}
txt_item_coord_data.stringdefs       =  abris_font[3]
txt_item_coord_data.formats		   	 =  {"%03.f°", "%.1f", LOCALIZE("И").."\n", LOCALIZE("М").."\n"}
txt_item_coord_data.controllers      =  {{"current_menu_in_list_position",-3*new_delta*GetScale()},
								   {"current_menu_item_brg",0},
								   {"current_menu_item_brg_type",2,3},
								   {"current_menu_item_rng",1}
								   }								   
Add(txt_item_coord_data)
use_mipfilter(txt_item_coord_data)	

txt_item_number			   	     = CreateElement "ceStringPoly"
txt_item_number.name             = "tin_"
txt_item_number.material         = "font_Ka-50_ABRIS_WHITE"
txt_item_number.init_pos		 =  {-0.95*new_delta,0.0,0}
txt_item_number.alignment        =  "CenterTop"
txt_item_number.stringdefs       =  abris_font[3]
txt_item_number.formats		     = {"%d"}
txt_item_number.controllers      = {{"current_menu_item_number",0},{"current_menu_item_change_color",0,0,0}}
txt_item_number.parent_element   =  txt_item_data.name
Add(txt_item_number)
use_mipfilter(txt_item_number)

SetDefaultClipWithLevel(txt_item_data,2)
SetDefaultClipWithLevel(txt_item_coord_data,2)
SetDefaultClipWithLevel(txt_item_number,2)