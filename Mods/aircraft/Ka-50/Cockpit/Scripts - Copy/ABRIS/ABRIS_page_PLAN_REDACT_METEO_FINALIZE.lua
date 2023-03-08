dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ВВОД","",">>","","ОТМЕНА")

new_delta = new_delta_4
cursor_delta = new_delta_3


local verts_cursor     =  {{ 0*x_size, 2.2*new_delta},
						   {-0.5*x_size, 2.2*new_delta},
						   {-0.5*x_size,0.8*new_delta},
						   { 0*x_size,0.8*new_delta},
						   { 0.56*x_size, 2.2*new_delta},
						   { 0.84*x_size, 2.2*new_delta},
						   { 0.84*x_size, 0.8*new_delta},
						   { 0.56*x_size, 0.8*new_delta}}
	

local inds_cursor      =   {0,1,2;
                            0,2,3;
							4,5,6;
							4,6,7}

current_list				= CreateElement "ceMeshPoly"
current_list.primitivetype  = "triangles"
current_list.vertices	 	= verts_cursor
current_list.indices     	= inds_cursor
current_list.material	 	= "RED"	   
current_list.init_pos  	 	= {0,y_center_render - y_render_size - 4*new_delta,0}
current_list.controllers 	= {{"current_list_controller",-2*cursor_delta*GetScale(),0,1000},{"set_menu_item_reference_to_current"}}
current_list.isvisible	 	  = false
current_list.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
current_list.level			  = DEFAULT_LEVEL + 2
Add(current_list);
use_mipfilter(current_list)



--[[
	INSERTED_SEGMENT_REDACTOR_WIND_DIRECTION,7
	INSERTED_SEGMENT_REDACTOR_WIND_SPEED,8
	INSERTED_SEGMENT_REDACTOR_ATMOSPHERIC_TEMPERATURE,9
--]]
txt_journal_segment_data = {}
txt_journal_segment_data[1]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_1_"
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].init_pos		 = {-0.9*x_size + 0.85*x_size,1.35*cursor_delta + cursor_delta,0}
txt_journal_segment_data[1].alignment        = "RightTop"
txt_journal_segment_data[1].stringdefs       = abris_font[8]
txt_journal_segment_data[1].formats          = {"%s°/   "}
txt_journal_segment_data[1].controllers      = {{"inserted_segment_redactor_value",0,7}}
txt_journal_segment_data[1].parent_element   = current_list.name
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])

txt_journal_segment_data[2]	  		   	     = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[2].formats          = {"    %s"}
txt_journal_segment_data[2].controllers      = {{"inserted_segment_redactor_value",0,8}}
txt_journal_segment_data[2].init_pos         = {0,0,0}
txt_journal_segment_data[2].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[2])

txt_journal_segment_data[3]	  		   	     = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[3].init_pos		 = {0.85*x_size,0,0}
txt_journal_segment_data[3].formats          = {"%s°C"}
txt_journal_segment_data[3].controllers      = {{"inserted_segment_redactor_value",0,9}}
txt_journal_segment_data[3].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[3])

txt_journal_segment_data[4]			   	      = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[4].controllers      = {{"inserted_segment_redactor_position",7},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
txt_journal_segment_data[4].formats          = {"%s     "}
txt_journal_segment_data[4].init_pos         = {0,-0.2*cursor_delta,0}
Add(txt_journal_segment_data[4])

txt_journal_segment_data[5]			   	      = Copy(txt_journal_segment_data[2])
txt_journal_segment_data[5].controllers      = {{"inserted_segment_redactor_position",8},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[5].parent_element   = txt_journal_segment_data[2].name
txt_journal_segment_data[5].init_pos         = {0,-0.2*cursor_delta,0}
Add(txt_journal_segment_data[5])

txt_journal_segment_data[6]			   	     = Copy(txt_journal_segment_data[3])
txt_journal_segment_data[6].controllers      = {{"inserted_segment_redactor_position",9},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[6].parent_element   = txt_journal_segment_data[3].name
txt_journal_segment_data[6].init_pos         = {0,-0.2*cursor_delta,0}
txt_journal_segment_data[6].formats			 = {"%s  "}
Add(txt_journal_segment_data[6])

frame1 = AddFrame(-0.37,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame1.parent_element      = txt_journal_segment_data[1].name
frame1.controllers         = {{"inserted_segment_redactor_position",7}}

frame2 = AddFrame(-0.37,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame2.parent_element      = txt_journal_segment_data[2].name
frame2.controllers         = {{"inserted_segment_redactor_position",8}}

frame3 = AddFrame(-0.22,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame3.parent_element      = txt_journal_segment_data[3].name
frame3.controllers         = {{"inserted_segment_redactor_position",9}}



for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,3)
end



