dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ВВОД","",">>","","ОТМЕНА")

new_delta = new_delta_4
cursor_delta = new_delta_3


local verts_cursor     =  {{0.5*x_size, 1.2*new_delta},
						   {0.99*x_size, 1.2*new_delta},
						   {0.99*x_size,-0.2*new_delta},
						   {0.5*x_size,-0.2*new_delta},
	
						   {-0.5*x_size, 2.2*new_delta},
						   {-0.2*x_size, 2.2*new_delta},
						   {-0.2*x_size, 0.8*new_delta},
						   {-0.5*x_size, 0.8*new_delta}}
	

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

txt_journal_segment_data = {}

--[[

			INSERTED_SEGMENT_REDACTOR_NAME,0
			INSERTED_SEGMENT_REDACTOR_FLIGHT_METHOD,1
			INSERTED_SEGMENT_REDACTOR_DEVIATION,2
			INSERTED_SEGMENT_REDACTOR_COORDINATES,3
			//-----------SPEED-------------------------------
			INSERTED_SEGMENT_REDACTOR_TAS,4
			INSERTED_SEGMENT_REDACTOR_TIME_HOURS,5
			INSERTED_SEGMENT_REDACTOR_TIME_MINUTES,6
			//-----------METEO-------------------------------
			INSERTED_SEGMENT_REDACTOR_WIND_DIRECTION,7
			INSERTED_SEGMENT_REDACTOR_WIND_SPEED,8
			INSERTED_SEGMENT_REDACTOR_ATMOSPHERIC_TEMPERATURE,9
			//-----------VNAV -------------------------------
			INSERTED_SEGMENT_REDACTOR_DISTANCE_TO_TAKE_HEIGHT,10
			INSERTED_SEGMENT_REDACTOR_HEIGHT,11

--]]
txt_journal_segment_data[6]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[6].name             = "jsd_6_"
txt_journal_segment_data[6].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[6].init_pos		 = {-0.3*x_size,2.35*cursor_delta,0}
txt_journal_segment_data[6].alignment        = "RightTop"
txt_journal_segment_data[6].stringdefs       = abris_font[8]
txt_journal_segment_data[6].formats          = {"%s"}
txt_journal_segment_data[6].controllers      = {{"inserted_segment_redactor_value",0,4}}
txt_journal_segment_data[6].parent_element   = current_list.name
Add(txt_journal_segment_data[6])
use_mipfilter(txt_journal_segment_data[6])

txt_journal_segment_data[7]			   	      = Copy(txt_journal_segment_data[6])
txt_journal_segment_data[7].controllers      = {{"inserted_segment_redactor_position",4},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[7].parent_element   = txt_journal_segment_data[6].name
txt_journal_segment_data[7].init_pos         = {0,-0.2*cursor_delta,0}
Add(txt_journal_segment_data[7])
use_mipfilter(txt_journal_segment_data[7])

frame1 = AddFrame(-0.2,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame1.parent_element      = txt_journal_segment_data[6].name
frame1.controllers         = {{"inserted_segment_redactor_position",4}}


txt_journal_segment_data[4]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[4].name             = "jsd_4_"
txt_journal_segment_data[4].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[4].init_pos		 = {0.8*x_size,1.35*cursor_delta,0}
txt_journal_segment_data[4].alignment        = "RightTop"
txt_journal_segment_data[4].stringdefs       = abris_font[8]
txt_journal_segment_data[4].formats          = {"%s:  "}
txt_journal_segment_data[4].controllers      = {{"inserted_segment_redactor_value",0,5}}
txt_journal_segment_data[4].parent_element   = current_list.name
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])

txt_journal_segment_data[8]			   	      = Copy(txt_journal_segment_data[4])
txt_journal_segment_data[8].controllers      = {{"inserted_segment_redactor_position",5},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[8].parent_element   = txt_journal_segment_data[4].name
txt_journal_segment_data[8].init_pos         = {0,-0.2*cursor_delta,0}
txt_journal_segment_data[8].formats			 = {"%s   "}
Add(txt_journal_segment_data[8])
use_mipfilter(txt_journal_segment_data[8])


txt_journal_segment_data[5]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[5].name             = "jsd_5_"
txt_journal_segment_data[5].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[5].init_pos		 = {0.8*x_size,1.35*cursor_delta,0}
txt_journal_segment_data[5].alignment        = "RightTop"
txt_journal_segment_data[5].stringdefs       = abris_font[8]
txt_journal_segment_data[5].formats          = {"  :%s"}
txt_journal_segment_data[5].controllers      = {{"inserted_segment_redactor_value",0,6}}
txt_journal_segment_data[5].parent_element   = current_list.name
Add(txt_journal_segment_data[5])
use_mipfilter(txt_journal_segment_data[5])


txt_journal_segment_data[9]			   	     = Copy(txt_journal_segment_data[5])
txt_journal_segment_data[9].controllers      = {{"inserted_segment_redactor_position",6},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[9].parent_element   = txt_journal_segment_data[5].name
txt_journal_segment_data[9].init_pos         = {0,-0.2*cursor_delta,0}
txt_journal_segment_data[9].formats			 = {"   %s"}
Add(txt_journal_segment_data[9])
use_mipfilter(txt_journal_segment_data[9])

frame2 = AddFrame(-0.23,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame2.parent_element      = txt_journal_segment_data[4].name
frame2.controllers         = {{"inserted_segment_redactor_position",5}}

frame3 = AddFrame(-0.23,0.02,-1.6*cursor_delta,0.0*cursor_delta)
frame3.parent_element      = txt_journal_segment_data[5].name
frame3.controllers         = {{"inserted_segment_redactor_position",6}}


for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,3)
end





