dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddMode("ПЛАН")
AddButtons("ВВОД","СДВИГ",">>","","ОТМЕНА")

up_line             = CreateElement "ceTexPoly"
up_line.name		= "up_line"
SetLine(up_line)
up_line.init_pos	= {0,y_center_render + y_render_size,0}
Add(up_line)

new_delta = new_delta_4

x_pos = {
-0.72,
-0.51,
-0.24,
0.08,
0.4,
0.75
}

dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.primitivetype    = "triangles"
dummy.vertices         = {{0.15,1.5*new_delta},{2*0.95*x_size,1.5*new_delta},
						  {2*0.95*x_size,-1.5*new_delta},{0.15,-1.5*new_delta}}
dummy.indices 		   = box_ind  
dummy.material         = "RED"
dummy.init_pos		   = {-0.99*x_size,y_center_render - y_render_size - 7*new_delta,0}
dummy.controllers      = {{"set_menu_item_reference_to_current"}}
dummy.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
dummy.level			   = DEFAULT_LEVEL + 2
dummy.isvisble         = false
Add(dummy)
use_mipfilter(dummy)

-------------------------------------------------------------------------------------
txt_journal_segment_data = {}
txt_journal_segment_data[1]			   	   = CreateElement "ceStringPoly"
txt_journal_segment_data[1].name             = "jsd_1_"
txt_journal_segment_data[1].init_pos		 = {0.1*x_size,0*2*new_delta + 0.2*new_delta,0}
txt_journal_segment_data[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[1].alignment        = "LeftCenter"
txt_journal_segment_data[1].stringdefs       = abris_font[8]
txt_journal_segment_data[1].formats			 = {"  %s"}
txt_journal_segment_data[1].controllers      = {{"journal_segment_end_point_name",0}}
txt_journal_segment_data[1].parent_element   = dummy.name
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])

txt_journal_segment_data[2]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[2].name             = "jsd_2_"
txt_journal_segment_data[2].init_pos		 = {0.5*x_size,-0*0.15*new_delta,0}
txt_journal_segment_data[2].material         = "font_Ka-50_ABRIS_YELLOW"
txt_journal_segment_data[2].alignment        = "LeftCenter"
txt_journal_segment_data[2].stringdefs       = abris_font[8]
txt_journal_segment_data[2].value            = LOCALIZE("НЕТ В БАЗЕ")
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
txt_journal_segment_data[3].controllers      = {{"journal_segment_end_point_latitude" ,0}}
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
txt_journal_segment_data[4].controllers      = {{"journal_segment_end_point_longitude",0}}
txt_journal_segment_data[4].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[4])
use_mipfilter(txt_journal_segment_data[4])

for i,o in pairs(txt_journal_segment_data) do
    SetDefaultClipWithLevel(o,3)
end
