dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

new_delta = new_delta_4

x_pos = {
-0.72,
-0.51,
-0.24,
0.08,
0.4,
0.75
}

-------------------------------------------------------------------------------------
txt_journal_segment_data = {}
txt_journal_segment_data[1]			   	   = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_1_"
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].init_pos		 = {0.1*x_size,0*2*new_delta + 0.2*new_delta,0}
txt_journal_segment_data[1].alignment        = "CenterCenter"
txt_journal_segment_data[1].stringdefs       = abris_font[8]
txt_journal_segment_data[1].formats			 = {"%02d"}
txt_journal_segment_data[1].controllers      ={{"current_menu_in_list_position_relative_current",-5.25*new_delta*GetScale(),1},
											   {"current_menu_item_number",0},
											   {"current_menu_item_change_color",0,0,0}}
											  -- {"current_waypoint_change_color",0,0,0}}
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])
-------------------------------------------------------------------------------------

txt_journal_segment_data[2]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[2].name             = "jsd_2_"
txt_journal_segment_data[2].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[2].alignment        = "LeftCenter"
txt_journal_segment_data[2].stringdefs       = abris_font[8]
txt_journal_segment_data[2].formats			 = {"  %s"}
txt_journal_segment_data[2].controllers      = {{"journal_segment_end_point_name",0},
												{"current_menu_item_change_color",1,1,0}}
												--{"current_waypoint_change_color",0,0,0}}
txt_journal_segment_data[2].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[2])
use_mipfilter(txt_journal_segment_data[2])

txt_journal_segment_data[3]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[3].name             = "jsd_3_"
txt_journal_segment_data[3].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[3].init_pos		 = {1.3*x_size,0.9*new_delta,0}
txt_journal_segment_data[3].alignment        = "LeftCenter"
txt_journal_segment_data[3].stringdefs       = abris_font[8]
txt_journal_segment_data[3].formats          = {" %s"}
txt_journal_segment_data[3].controllers      = {{"journal_segment_end_point_latitude" ,0},
										    	{"current_menu_item_change_color",0,0,0}}
												--{"current_waypoint_change_color",0,0,0}}
txt_journal_segment_data[3].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[3])
use_mipfilter(txt_journal_segment_data[3])

txt_journal_segment_data[4]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[4].name             = "jsd_4_"
txt_journal_segment_data[4].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[4].init_pos		 = {1.3*x_size,-0.9*new_delta,0}
txt_journal_segment_data[4].alignment        = "LeftCenter"
txt_journal_segment_data[4].stringdefs       = abris_font[8]
txt_journal_segment_data[4].formats          = {"%s"}
txt_journal_segment_data[4].controllers      = {{"journal_segment_end_point_longitude",0},
												{"current_menu_item_change_color",0,0,0}}
												--{"current_waypoint_change_color",0,0,0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])
----------------------------------------------------------------------------------------------

txt_journal_segment_data[6]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[6].name             = "jsd_6_"
txt_journal_segment_data[6].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[6].init_pos		 = {1.7*x_size,2.75*new_delta  - 0.1*new_delta,0}
txt_journal_segment_data[6].alignment        = "RightCenter"
txt_journal_segment_data[6].stringdefs       = abris_font[8]
txt_journal_segment_data[6].formats          = {LOCALIZE("РСТ").." %3.1f "}
--txt_journal_segment_data[6].value            =  "РСТ 0.0"

txt_journal_segment_data[6].controllers      = {{"journal_segment_length",0}}--,{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[6].parent_element   = txt_journal_segment_data[1].name
SetDefaultClipWithLevel(txt_journal_segment_data[6],2)
Add(txt_journal_segment_data[6])
use_mipfilter(txt_journal_segment_data[6])

----------------------------------------------------------------------------------------------

txt_journal_segment_data[7]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[7].name             = "jsd_7_"
txt_journal_segment_data[7].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[7].init_pos		 = {0.7*x_size,2.75*new_delta - 0.1*new_delta,0}
txt_journal_segment_data[7].alignment        = "RightCenter"
txt_journal_segment_data[7].stringdefs       = abris_font[8]
txt_journal_segment_data[7].formats          = {LOCALIZE("ИПУ").." %03.f°"}
--txt_journal_segment_data[7].value            =  "ИПУ 0.0"
txt_journal_segment_data[7].controllers      = {{"journal_segment_track_angle",0}}--,{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[7].parent_element   = txt_journal_segment_data[1].name
SetDefaultClipWithLevel(txt_journal_segment_data[7],2)
Add(txt_journal_segment_data[7])
use_mipfilter(txt_journal_segment_data[7])


txt_journal_segment_data[8]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[8].name             = "jsd_8_"
txt_journal_segment_data[8].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[8].init_pos		 = {1.2*x_size,2.75*new_delta - 0.1*new_delta,0}
txt_journal_segment_data[8].alignment        = "RightCenter"
txt_journal_segment_data[8].stringdefs       = abris_font[8]
txt_journal_segment_data[8].formats          = {LOCALIZE("ИК").." %03.f°"}
--txt_journal_segment_data[8].value            =  "ИК 0.0"
txt_journal_segment_data[8].controllers      = {{"journal_segment_heading_angle",0}}--,{"current_waypoint_change_color",0,1,0}}
txt_journal_segment_data[8].parent_element   = txt_journal_segment_data[1].name
SetDefaultClipWithLevel(txt_journal_segment_data[8],2)
Add(txt_journal_segment_data[8])
use_mipfilter(txt_journal_segment_data[8])


txt_journal_segment_data[9]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[9].name             = "jsd_9_"
txt_journal_segment_data[9].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[9].init_pos		 = {0.6*x_size,0,0}
txt_journal_segment_data[9].alignment        = "CenterCenter"
txt_journal_segment_data[9].stringdefs       = abris_font[8]
txt_journal_segment_data[9].formats          = {"%s"}
txt_journal_segment_data[9].controllers      = {{"journal_segment_preset_flight_method",0},
												{"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[9].parent_element   = txt_journal_segment_data[2].name
Add(txt_journal_segment_data[9])
use_mipfilter(txt_journal_segment_data[9])

txt_journal_segment_data[10]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[10].name             = "jsd_10_"
txt_journal_segment_data[10].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[10].init_pos		  = {0.9*x_size,0,0}
txt_journal_segment_data[10].alignment        = "CenterCenter"
txt_journal_segment_data[10].stringdefs       = abris_font[8]
txt_journal_segment_data[10].value            = LOCALIZE("СКЛ")
txt_journal_segment_data[10].controllers      = {{"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[10].parent_element   = txt_journal_segment_data[2].name
Add(txt_journal_segment_data[10])
use_mipfilter(txt_journal_segment_data[10])

txt_journal_segment_data[11]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[11].name             = "jsd_11_"
txt_journal_segment_data[11].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[11].init_pos		  = {0.37*x_size,0,0}
txt_journal_segment_data[11].alignment        = "RightCenter"
txt_journal_segment_data[11].stringdefs       = abris_font[8]
txt_journal_segment_data[11].formats          = {"%06.2f"}
txt_journal_segment_data[11].controllers      = {{"journal_segment_preset_magnetic_variation",0},
											     {"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[11].parent_element   = txt_journal_segment_data[10].name
Add(txt_journal_segment_data[11])
use_mipfilter(txt_journal_segment_data[11])

txt_journal_segment_data[12]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[12].name             = "jsd_12_"
txt_journal_segment_data[12].material         = "font_Ka-50_ABRIS_WHITE_INVERSE"
txt_journal_segment_data[12].init_pos		  = {0.5*x_size,0,0}
txt_journal_segment_data[12].alignment        = "RightCenter"
txt_journal_segment_data[12].stringdefs       = abris_font[8]
txt_journal_segment_data[12].formats          = {"%s"}
txt_journal_segment_data[12].controllers      = {{"journal_segment_end_point_type",0},
											     {"current_menu_item_change_color",0,0,0}}
txt_journal_segment_data[12].parent_element   = txt_journal_segment_data[2].name
Add(txt_journal_segment_data[12])
use_mipfilter(txt_journal_segment_data[12])


for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,2)
end


--------------------------------------------------------------------------------------------------------------
