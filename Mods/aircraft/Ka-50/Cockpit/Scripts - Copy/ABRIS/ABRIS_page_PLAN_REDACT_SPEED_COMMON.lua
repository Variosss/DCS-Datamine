dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

new_delta = new_delta_4
cursor_delta = new_delta_3


local verts_cursor     =  {{-0.99*x_size, 1.2*new_delta},
						   {-0.5*x_size, 1.2*new_delta},
						   {-0.5*x_size,-0.2*new_delta},
						   {-0.99*x_size,-0.2*new_delta},
						   
						   {0.5*x_size, 1.2*new_delta},
						   {0.99*x_size, 1.2*new_delta},
						   {0.99*x_size,-0.2*new_delta},
						   {0.5*x_size,-0.2*new_delta},
	
						   {-0.5*x_size, 2.2*new_delta},
						   { 0.5*x_size, 2.2*new_delta},
						   { 0.5*x_size, 0.8*new_delta},
						   {-0.5*x_size, 0.8*new_delta}}
	

local inds_cursor      =   {0,1,2;
                            0,2,3;
							4,5,6;
							4,6,7;
							8,9,10;
							8,10,11}

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
txt_journal_segment_data_header[1].init_pos		    = {-0.3*x_size,3.7*new_delta,0}
txt_journal_segment_data_header[1].alignment        = "RightTop"
txt_journal_segment_data_header[1].stringdefs       = abris_font[8]
txt_journal_segment_data_header[1].value            = LOCALIZE("ИВС")
txt_journal_segment_data_header[1].parent_element   = "dummy"
Add(txt_journal_segment_data_header[1])
use_mipfilter(txt_journal_segment_data_header[1])

txt_journal_segment_data_header[4]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[4].name             = "jsd_4_"
txt_journal_segment_data_header[4].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[4].init_pos		    = {0.3*x_size,0,0}
txt_journal_segment_data_header[4].alignment        = "RightTop"
txt_journal_segment_data_header[4].stringdefs       = abris_font[8]
txt_journal_segment_data_header[4].value            = LOCALIZE("РСТ")
txt_journal_segment_data_header[4].parent_element   = txt_journal_segment_data_header[1].name
Add(txt_journal_segment_data_header[4])
use_mipfilter(txt_journal_segment_data_header[4])

txt_journal_segment_data_header[5]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[5].name             = "jsd_5_"
txt_journal_segment_data_header[5].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[5].init_pos		    = {0.6*x_size,0,0}
txt_journal_segment_data_header[5].alignment        = "RightTop"
txt_journal_segment_data_header[5].stringdefs       = abris_font[8]
txt_journal_segment_data_header[5].value            = LOCALIZE("Туч")
txt_journal_segment_data_header[5].parent_element   = txt_journal_segment_data_header[1].name
Add(txt_journal_segment_data_header[5])
use_mipfilter(txt_journal_segment_data_header[5])

txt_journal_segment_data_header[6]	  		   	    = CreateElement "ceStringPoly"
txt_journal_segment_data_header[6].name             = "jsd_6_"
txt_journal_segment_data_header[6].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data_header[6].init_pos		    = {1.05*x_size,0,0}
txt_journal_segment_data_header[6].alignment        = "RightTop"
txt_journal_segment_data_header[6].stringdefs       = abris_font[8]
txt_journal_segment_data_header[6].value            = LOCALIZE("Тппм")
txt_journal_segment_data_header[6].parent_element   = txt_journal_segment_data_header[1].name
Add(txt_journal_segment_data_header[6])
use_mipfilter(txt_journal_segment_data_header[6])

for i,o in pairs(txt_journal_segment_data_header) do
    SetDefaultClipWithLevel(o,2)
end








