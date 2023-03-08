dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ВВОД","СДВИГ",">>","ПОИСК","ОТМЕНА")

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
txt_journal_segment_data[1].controllers      = {{"inserted_segment_redactor_value",0,0}}
txt_journal_segment_data[1].parent_element   = dummy.name
Add(txt_journal_segment_data[1])
use_mipfilter(txt_journal_segment_data[1])

frame1 = AddFrame(0.07,0.4,-0.05,0.025)
frame1.parent_element      = txt_journal_segment_data[1].name
frame1.controllers         = {{"inserted_segment_redactor_position",0}}


txt_journal_segment_data[2]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[2].name             = "jsd_2_"
txt_journal_segment_data[2].init_pos		 = {0,-0.15*new_delta,0}
txt_journal_segment_data[2].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[2].alignment        = "LeftCenter"
txt_journal_segment_data[2].stringdefs       = abris_font[8]
txt_journal_segment_data[2].formats			 = {"  %s"}
txt_journal_segment_data[2].controllers      = {{"inserted_segment_redactor_position",0},{"blinking",32},{"txt_string_editor_current_position",0}}
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


frame4 = AddFrame(-0.02,0.48,-0.125,0.1)
frame4.parent_element      = txt_journal_segment_data[1].name
frame4.init_pos            = {1.3*x_size,0,0}
frame4.controllers         = {{"inserted_segment_redactor_position",3}}

txt_journal_segment_data[5]			   	     = CreateElement "ceStringPoly"
txt_journal_segment_data[5].name             = "jsd_5_"
txt_journal_segment_data[5].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[5].init_pos		 = {0.6*x_size,0,0}
txt_journal_segment_data[5].alignment        = "CenterCenter"
txt_journal_segment_data[5].stringdefs       = abris_font[8]
txt_journal_segment_data[5].formats          = {"%s"}
txt_journal_segment_data[5].controllers      = {{"inserted_segment_redactor_value",0,1}} --flight method
txt_journal_segment_data[5].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[5])
use_mipfilter(txt_journal_segment_data[5])

frame2 = AddFrame(-0.1,0.1,-0.05,0.025)
frame2.parent_element      = txt_journal_segment_data[5].name
frame2.controllers         = {{"inserted_segment_redactor_position",1}}

txt_journal_segment_data[6]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[6].name             = "jsd_6_"
txt_journal_segment_data[6].init_pos		  = {0.45*x_size,0,0}
txt_journal_segment_data[6].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[6].alignment        = "CenterCenter"
txt_journal_segment_data[6].stringdefs       = abris_font[8]
txt_journal_segment_data[6].formats		  = {"%s"}
txt_journal_segment_data[6].controllers      = {{"inserted_segment_redactor_value",0,15}}
txt_journal_segment_data[6].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[6])
use_mipfilter(txt_journal_segment_data[6])

txt_journal_segment_data[10]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[10].name             = "jsd_10_"
txt_journal_segment_data[10].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[10].init_pos		  = {0.9*x_size,0,0}
txt_journal_segment_data[10].alignment        = "CenterCenter"
txt_journal_segment_data[10].stringdefs       = abris_font[8]
txt_journal_segment_data[10].value            = LOCALIZE("СКЛ")
txt_journal_segment_data[10].parent_element   = txt_journal_segment_data[1].name
Add(txt_journal_segment_data[10])
use_mipfilter(txt_journal_segment_data[10])

txt_journal_segment_data[11]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[11].name             = "jsd_11_"
txt_journal_segment_data[11].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[11].init_pos		  = {0.37*x_size,0,0}
txt_journal_segment_data[11].alignment        = "RightCenter"
txt_journal_segment_data[11].stringdefs       = abris_font[8]
txt_journal_segment_data[11].formats          = {"%s","%06.2f"}
txt_journal_segment_data[11].controllers      = {{"inserted_segment_redactor_value",0,2}}
txt_journal_segment_data[11].parent_element   = txt_journal_segment_data[10].name
Add(txt_journal_segment_data[11])
use_mipfilter(txt_journal_segment_data[11])

frame3 = AddFrame(-0.27,0.02,-0.05,0.025)
frame3.parent_element      = txt_journal_segment_data[11].name
frame3.controllers         = {{"inserted_segment_redactor_position",2}}


txt_journal_segment_data[12]			   	  = CreateElement "ceStringPoly"
txt_journal_segment_data[12].name             = "jsd_12_"
txt_journal_segment_data[12].init_pos		  = {0,-0.15*new_delta,0}
txt_journal_segment_data[12].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_segment_data[12].alignment        = "RightCenter"
txt_journal_segment_data[12].stringdefs       = abris_font[8]
txt_journal_segment_data[12].formats		  = {"%s"}
txt_journal_segment_data[12].controllers      = {{"inserted_segment_redactor_position",2},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_journal_segment_data[12].parent_element   = txt_journal_segment_data[11].name
Add(txt_journal_segment_data[12])
use_mipfilter(txt_journal_segment_data[12])



