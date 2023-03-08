dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ВВОД","","","","ОТМЕНА")

new_delta = new_delta_4
cursor_delta = 	new_delta_3

local inds_cursor      =   {0,1,2;
							0,2,3}
local verts_cursor     =  {{0.15*x_size, 2.2*new_delta},
						   {0.32*x_size, 2.2*new_delta},
						   {0.32*x_size, 0.8*new_delta},
						   {0.15*x_size, 0.8*new_delta}}

current_list				= CreateElement "ceMeshPoly"
current_list.primitivetype  = "triangles"
current_list.vertices	 	= verts_cursor
current_list.indices     	= inds_cursor
current_list.material	 	= "RED"	   
current_list.init_pos  	 	= {0,y_center_render - y_render_size - 4*new_delta,0}
current_list.controllers 	= {{"current_list_controller",-2*cursor_delta*GetScale(),0,1000},{"set_menu_item_reference_to_current"}}
current_list.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
current_list.level			  = DEFAULT_LEVEL + 2
current_list.isvisible        = false
Add(current_list);
use_mipfilter(current_list)

txt_journal_segment_data = {}
txt_journal_segment_data[1]	  		   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_5_"
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].init_pos		 = {-0.9*x_size + 1.14*x_size,2.2*new_delta,0}
txt_journal_segment_data[1].alignment        = "CenterTop"
txt_journal_segment_data[1].stringdefs       = abris_font[8]
txt_journal_segment_data[1].formats          = {"%s"}
txt_journal_segment_data[1].controllers      = {{"inserted_segment_redactor_value",0,12,1}}
txt_journal_segment_data[1].parent_element   = current_list.name
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])

txt_journal_segment_data[2]			   	      = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[2].controllers      = {{"inserted_segment_redactor_position",10},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[2].parent_element   = txt_journal_segment_data[1].name
txt_journal_segment_data[2].init_pos         = {0 + (-0.9*x_size + 0.65*x_size) - (-0.9*x_size + 1.14*x_size),
												(-0.2*cursor_delta) + (1.35*new_delta) - (2.2*new_delta),
												0 + 0 - 0}
txt_journal_segment_data[2].formats          = {" %s        "}
Add(txt_journal_segment_data[2])
use_mipfilter(txt_journal_segment_data[2])

txt_journal_segment_data[3]			   	      = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[3].controllers      = {{"inserted_segment_redactor_position",11},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[3].parent_element   = txt_journal_segment_data[1].name
txt_journal_segment_data[3].init_pos         = {0 + (-0.9*x_size + 0.65*x_size) - (-0.9*x_size + 1.14*x_size),
												(-0.2*cursor_delta) + (1.35*new_delta) - (2.2*new_delta),
												0 + 0 - 0}
txt_journal_segment_data[3].formats          = {"       %s"}
Add(txt_journal_segment_data[3])
use_mipfilter(txt_journal_segment_data[3])

txt_journal_segment_data[4]			   	      = Copy(txt_journal_segment_data[1])
txt_journal_segment_data[4].controllers      = {{"inserted_segment_redactor_position",12},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
txt_journal_segment_data[4].init_pos         = {0 + (-0.9*x_size + 0.65*x_size) - (-0.9*x_size + 1.14*x_size),
												(0.65*cursor_delta) + (1.35*new_delta) - (2.2*new_delta),
												0 + 0 - 0}
txt_journal_segment_data[4].formats          = {"                      %s"}
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])

for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,3)
end

frame3 = AddFrame(	-0.08 * x_size,
					0.07 * x_size,
					-0.2 * cursor_delta,
					-1.6 * cursor_delta)
frame3.parent_element      = txt_journal_segment_data[1].name
frame3.controllers         = {{"inserted_segment_redactor_position",12}}