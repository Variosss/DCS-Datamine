dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_3

txt_journal_segment_data = {}
txt_journal_segment_data[1]			   	   = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_1_"
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].init_pos		 = {-0.9*x_size,1.35*new_delta,0}
txt_journal_segment_data[1].alignment        = "CenterTop"
txt_journal_segment_data[1].stringdefs       = abris_font[8]
txt_journal_segment_data[1].formats			 = {"%02d"}
txt_journal_segment_data[1].controllers      ={{"current_menu_in_list_position",-2*new_delta*GetScale()},
											   {"current_menu_item_number",0},
											   {"current_menu_item_change_color",0,0,0}}
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])


txt_journal_segment_data[2]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[2].name             = "jsd_2_"
txt_journal_segment_data[2].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[2].init_pos		 = {0,0,0}
txt_journal_segment_data[2].alignment        = "LeftTop"
txt_journal_segment_data[2].stringdefs       = abris_font[8]
txt_journal_segment_data[2].formats			 = {"  %s"}
txt_journal_segment_data[2].controllers      = {{"journal_segment_end_point_name",0},{"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[2].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[2])
use_mipfilter(txt_journal_segment_data[2])


txt_journal_segment_data[3]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[3].name             = "jsd_3_"
txt_journal_segment_data[3].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[3].init_pos		 = {0.65*x_size,0,0}
txt_journal_segment_data[3].alignment        = "CenterTop"
txt_journal_segment_data[3].stringdefs       = abris_font[8]
txt_journal_segment_data[3].formats          = {" %+03.f @ ","%05.f"," %s @ ","---","%s","-----"}
txt_journal_segment_data[3].controllers      = {{"journal_segment_preset_distance_to_take_flight_level",0},
												{"journal_segment_vnav_distance_not_setted",2,3},
												{"journal_segment_preset_flight_level",1},
												{"journal_segment_vnav_not_setted",4,5},
												{"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[3].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[3])
use_mipfilter(txt_journal_segment_data[3])


txt_journal_segment_data[4]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[4].name             = "jsd_5_"
txt_journal_segment_data[4].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[4].init_pos		 = {1.2*x_size,new_delta,0}
txt_journal_segment_data[4].alignment        = "RightTop"
txt_journal_segment_data[4].stringdefs       = abris_font[8]
txt_journal_segment_data[4].formats          =  {"00","%+03.f","%s","---"}
txt_journal_segment_data[4].controllers      = {{"journal_segment_preset_vertical_speed",1,0,1},{"journal_segment_vnav_not_setted",2,3},{"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])

txt_journal_segment_data[5]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[5].name             = "jsd_55_"
txt_journal_segment_data[5].material         = "font_Ka-50_ABRIS_YELLOW"
txt_journal_segment_data[5].init_pos		 = {1.2*x_size,new_delta,0}
txt_journal_segment_data[5].alignment        = "RightTop"
txt_journal_segment_data[5].stringdefs       = abris_font[8]
txt_journal_segment_data[5].formats          =  {"00","%+03.f","%s","---"}
txt_journal_segment_data[5].controllers      = {{"journal_segment_preset_vertical_speed",1,0,0},{"journal_segment_vnav_not_setted",2,3}}
txt_journal_segment_data[5].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[5])
use_mipfilter(txt_journal_segment_data[5])

for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,2)
end
