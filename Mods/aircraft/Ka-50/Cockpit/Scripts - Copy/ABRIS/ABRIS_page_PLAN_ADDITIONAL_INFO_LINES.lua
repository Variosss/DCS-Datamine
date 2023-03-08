dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")


txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.99*x_size,y_center_render - y_render_size,0}
txt_mrk.value       = LOCALIZE("ШИР").."\n"..
					  LOCALIZE("ДОЛ")
Add(txt_mrk)
use_mipfilter(txt_mrk)

txt_mrk1                 = Copy(txt_mrk)
txt_mrk1.name            = "txt_mrk1"
txt_mrk1.value           = "\n\n"..LOCALIZE("ВЫСОТА").."\n"..
								   LOCALIZE("СКЛ").."\n"..
								   LOCALIZE("РАССТОЯНИЕ").."\n"..
								   LOCALIZE("АЗИМУТ").."\n"..
								   LOCALIZE("ОБРАТНЫЙ")
txt_mrk1.parent_element  = "txt_mrk"
txt_mrk1.init_pos        = {0,0,0}
txt_mrk1.controllers     = {{"cursor_marker_available"}}
Add(txt_mrk1)
use_mipfilter(txt_mrk1)


txt_mrk2             = CreateElement "ceStringPoly"
txt_mrk2.name        = "txt_mrk2"
txt_mrk2.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk2.alignment   = "LeftTop"
txt_mrk2.stringdefs  = abris_font[5] 
txt_mrk2.init_pos    = {0.4*x_size,0,0}
txt_mrk2.formats     = { "\t%s\n",
						 "\t%s\n",
						 "\t%.f\n",
						 "\t%.1f°"}
txt_mrk2.controllers = {{"txt_cursor_latitude"        ,0},
						{"txt_cursor_longitude"       ,1},
						{"txt_cursor_surface_height"  ,2},
						{"txt_cursor_magnetic_variation",3}}
					   
txt_mrk2.parent_element = "txt_mrk"
Add(txt_mrk2)
use_mipfilter(txt_mrk2)


txt_mrk3             = CreateElement "ceStringPoly"
txt_mrk3.name        = "txt_mrk3"
txt_mrk3.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk3.alignment   = "LeftTop"
txt_mrk3.stringdefs  = abris_font[5] 
txt_mrk3.init_pos    = {0.4*x_size,0,0}
txt_mrk3.formats     = {"\n\n\n\n\t%.2f\n",
						"\t%03.f°\n",
						"\t%03.f°"}
txt_mrk3.controllers = {{"txt_cursor_segment_length"  ,0},
						{"txt_cursor_marker_bearing"  ,1},
						{"txt_cursor_marker_bearing"  ,2,1}}
txt_mrk3.parent_element = "txt_mrk1"						
Add(txt_mrk3)
use_mipfilter(txt_mrk3)

---------------------------------------------------------------------------------------
cursor_segment				   = CreateElement "ceSimpleLineObject"
cursor_segment.primitivetype   = "triangles"
cursor_segment.name            = "cursor_segment"
cursor_segment.material	       = "RED"
cursor_segment.width           = 0.004 
cursor_segment.init_pos        = {0,y_center_render,0}
SetDefaultClipWithLevel(cursor_segment,3)
cursor_segment.controllers     = {{"cursor_segment",x_size,x_size}}
Add(cursor_segment)
use_mipfilter(cursor_segment)
---------------------------------------------------------------------------------------

new_delta = new_delta_2
border = 0.09 * new_delta
x = 0.25*x_size
y = 0.4*new_delta



dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {0.7*x_size,y_center_render - 1.1*y_render_size,0}
dummy.controllers      = {{"specific_set_simple_menu"}} 
Add(dummy)



current_list_block_1 			 = AddFrame(-1.05*x,1.05*x,-1.1*y,1.1*y)
current_list_block_1.controllers = {{"current_list_controller",-new_delta*GetScale(),0,1000}}
current_list_block_1.parent_element = "dummy"
use_mipfilter(current_list_block_1)

AddButtons("ВВОД","ЦВЕТ","МСШТБ+","МСШТБ-","ОТМЕНА")
AddContextBlock(LOCALIZE("ВВОД").."\n"..LOCALIZE("СОХРАН").."\n"..LOCALIZE("УДАЛ"))