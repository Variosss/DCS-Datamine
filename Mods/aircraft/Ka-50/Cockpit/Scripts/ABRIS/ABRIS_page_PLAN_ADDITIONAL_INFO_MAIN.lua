dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
--AddButtons("ДОБ.ТЧК","ДОБ.ЛИН","МСШТБ+","МСШТБ-","ПЛАН")

---------------------------------------------------------------------------------------
txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.99*x_size,y_center_render - y_render_size,0}
txt_mrk.value      =   LOCALIZE("ШИР").."\n"..
						LOCALIZE("ДОЛ").."\n"..
						LOCALIZE("ВЫСОТА").."\n"..
						LOCALIZE("СКЛ")
Add(txt_mrk)
use_mipfilter(txt_mrk)

txt_mrk2             = CreateElement "ceStringPoly"
txt_mrk2.name        = "txt_mrk2"
txt_mrk2.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk2.alignment   = "LeftTop"
txt_mrk2.stringdefs  = abris_font[5] 
txt_mrk2.init_pos    = {0.5*x_size,0,0}
txt_mrk2.formats     = {"%s\n",
						"%s\n",
						"%.f\n",
						"%.1f°"}
txt_mrk2.controllers = {{"txt_cursor_latitude"        ,0},
						{"txt_cursor_longitude"       ,1},
						{"txt_cursor_surface_height"  ,2},
						{"txt_cursor_magnetic_variation",3}}
txt_mrk2.parent_element = "txt_mrk"
Add(txt_mrk2)
use_mipfilter(txt_mrk2)

edited_point_info_dummy 			= CreateElement "ceSimple"
edited_point_info_dummy.name  		= "edited_point_info_dummy"
edited_point_info_dummy.init_pos    = {-0.99*x_size,y_center_render - y_render_size - 0.31 * x_size,0}
edited_point_info_dummy.controllers = {{"edited_point_present",1}}
Add(edited_point_info_dummy)
--
txt_mrk_callsign             = CreateElement "ceStringPoly"
txt_mrk_callsign.name        = "txt_mrk_callsign"
txt_mrk_callsign.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk_callsign.alignment   = "LeftTop"
txt_mrk_callsign.stringdefs  = abris_font[5]
txt_mrk_callsign.parent_element = "edited_point_info_dummy"
txt_mrk_callsign.init_pos    = {0.0, 0.0, 0.0}
txt_mrk_callsign.value       = LOCALIZE("ПОЗЫВНОЙ")
txt_mrk_callsign.controllers = {{"inserted_point_redactor_position_available",2}}
Add(txt_mrk_callsign)
use_mipfilter(txt_mrk_callsign)

txt_mrk_callsign_data             	= CreateElement "ceStringPoly"
txt_mrk_callsign_data.name        	= "txt_mrk_callsign_data"
txt_mrk_callsign_data.material    	= "font_Ka-50_ABRIS_WHITE"
txt_mrk_callsign_data.alignment   	= "LeftTop"
txt_mrk_callsign_data.stringdefs  	= abris_font[5] 
txt_mrk_callsign_data.parent_element = "txt_mrk_callsign"
txt_mrk_callsign_data.init_pos    	= {0.5 * x_size,0,0}
txt_mrk_callsign_data.formats     	= {"%s"}
txt_mrk_callsign_data.controllers 	= {{"inserted_point_redactor_value",0,2}}
Add(txt_mrk_callsign_data)
use_mipfilter(txt_mrk_callsign_data)
--
txt_mrk_name             = CreateElement "ceStringPoly"
txt_mrk_name.name        = "txt_mrk_name"
txt_mrk_name.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk_name.alignment   = "LeftTop"
txt_mrk_name.stringdefs  = abris_font[5] 
txt_mrk_name.parent_element = "edited_point_info_dummy"
txt_mrk_name.init_pos    = {0.0, 0.0, 0.0}
txt_mrk_name.value       = LOCALIZE("ИМЯ")
txt_mrk_name.controllers = {{"inserted_point_redactor_position_available",0}, {"inserted_point_redactor_position_available",2,0}}
Add(txt_mrk_name)
use_mipfilter(txt_mrk_name)

txt_mrk_name_data             	= CreateElement "ceStringPoly"
txt_mrk_name_data.name        	= "txt_mrk_name_data"
txt_mrk_name_data.material    	= "font_Ka-50_ABRIS_WHITE"
txt_mrk_name_data.alignment   	= "LeftTop"
txt_mrk_name_data.stringdefs  	= abris_font[5] 
txt_mrk_name_data.parent_element = "txt_mrk_name"
txt_mrk_name_data.init_pos    	= {0.5 * x_size,0,0}
txt_mrk_name_data.formats     	= {"%s"}
txt_mrk_name_data.controllers 	= {{"inserted_point_redactor_value",0,0}}
Add(txt_mrk_name_data)
use_mipfilter(txt_mrk_name_data)
--
txt_pointtype             = Copy(txt_mrk)
txt_pointtype.name        = "txt_pointtype"
txt_pointtype.formats     = {"%s"}
txt_pointtype.parent_element = "edited_point_info_dummy"
txt_pointtype.init_pos    = {1.5*x_size,0,0}
txt_pointtype.controllers = {{"inserted_point_redactor_point_description",0}}
Add(txt_pointtype)
use_mipfilter(txt_pointtype)
---------------------------------------------------------------------------------------

AddContextBlock(LOCALIZE("НАПРЯМУЮ").."\n"..LOCALIZE("ОТНОСИТ"))
