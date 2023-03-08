dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

new_delta = new_delta_4
cursor_delta = new_delta_3


local verts_cursor     =  {{-0.99*x_size, 1.2*new_delta},
						   {0.15*x_size, 1.2*new_delta},
						   {0.15*x_size,-0.2*new_delta},
						   {-0.99*x_size,-0.2*new_delta},
						   
						   {0.15*x_size, 2.2*new_delta},
						   {0.99*x_size, 2.2*new_delta},
						   {0.99*x_size,0.8*new_delta},
						   {0.15*x_size,0.8*new_delta}}
	

local inds_cursor      =   {0,1,2;
                            0,2,3;
							4,5,6;
							4,6,7}

current_list				= CreateElement "ceMeshPoly"
current_list.primitivetype  = "triangles"
current_list.vertices	 	= verts_cursor
current_list.indices     	= inds_cursor
current_list.material	 	= "SIMPLE_WHITE"	   
current_list.init_pos  	 	= {0,y_center_render - y_render_size - 4*new_delta,0}
current_list.controllers 	= {{"current_list_controller",-2*cursor_delta*GetScale(),0,1000}}
SetDefaultClipWithLevel(current_list,2)
Add(current_list);
use_mipfilter(current_list)

dummy				   = CreateElement "ceSimple"
dummy.name             = "dummy"
dummy.init_pos		   = {0,y_center_render - y_render_size - 4*new_delta,0}
dummy.controllers      = {{"set_frame_size_for_current_menu",6},{"specific_draw_journal"}} 
Add(dummy)

txt_journal_segment_data_header = {}

txt_journal_segment_data_header[1]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[1].name             = "jsd_1_"
txt_journal_segment_data_header[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[1].init_pos		    = {-0.4*x_size,3.7*new_delta,0}
txt_journal_segment_data_header[1].alignment        = "RightTop"
txt_journal_segment_data_header[1].stringdefs       = abris_font[8]
txt_journal_segment_data_header[1].value            = LOCALIZE("S")
txt_journal_segment_data_header[1].parent_element   = "dummy"
Add(txt_journal_segment_data_header[1])
use_mipfilter(txt_journal_segment_data_header[1])

txt_journal_segment_data_header[2]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[2].name             = "jsd_2_"
txt_journal_segment_data_header[2].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[2].init_pos		    = {0.3*x_size,0,0}
txt_journal_segment_data_header[2].alignment        = "RightTop"
txt_journal_segment_data_header[2].stringdefs       = abris_font[8]
txt_journal_segment_data_header[2].value            = LOCALIZE("H")
txt_journal_segment_data_header[2].parent_element   = txt_journal_segment_data_header[1].name
Add(txt_journal_segment_data_header[2])
use_mipfilter(txt_journal_segment_data_header[2])

txt_journal_segment_data_header[3]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[3].name             = "jsd_3_"
txt_journal_segment_data_header[3].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[3].init_pos		    = {0.7*x_size,0,0}
txt_journal_segment_data_header[3].alignment        = "RightTop"
txt_journal_segment_data_header[3].stringdefs       = abris_font[8]
txt_journal_segment_data_header[3].value            = LOCALIZE("Vy")
txt_journal_segment_data_header[3].parent_element   = txt_journal_segment_data_header[1].name
Add(txt_journal_segment_data_header[3])
use_mipfilter(txt_journal_segment_data_header[3])

for i,o in pairs(txt_journal_segment_data_header) do
    SetDefaultClipWithLevel(o,2)
end










