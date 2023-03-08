y_diplacement = (abris_font[5][1] + abris_font[5][4] )/GetScale()
x_diplacement = 0.67*(abris_font[5][2] + abris_font[5][3] )/GetScale()

txt_mrk             = CreateElement "ceStringPoly"
txt_mrk.name        = "txt_mrk"
txt_mrk.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk.alignment   = "LeftTop"
txt_mrk.stringdefs  = abris_font[5] 
txt_mrk.init_pos    = {-0.99*x_size,y_center_render - y_render_size,0}
txt_mrk.value       = "\n"..LOCALIZE("ШИР").."\n"..LOCALIZE("ДОЛ")
Add(txt_mrk)
use_mipfilter(txt_mrk)

txt_mrk2             = CreateElement "ceStringPoly"
txt_mrk2.name        = "txt_mrk2"
txt_mrk2.material    = "font_Ka-50_ABRIS_WHITE"
txt_mrk2.alignment   = "LeftTop"
txt_mrk2.stringdefs  = abris_font[5] 
txt_mrk2.formats     = {"\n\t\t\t %s\n","\t\t\t%s"}
txt_mrk2.controllers = {{"inserted_point_redactor_point_latitude" ,0},
						{"inserted_point_redactor_point_longitude",1}}
txt_mrk2.parent_element = "txt_mrk"
Add(txt_mrk2)
use_mipfilter(txt_mrk2)

frame = AddFrame(13*x_diplacement,26*x_diplacement,-3*y_diplacement,-1.1*y_diplacement)
frame.parent_element      = txt_mrk2.name
frame.controllers         = {{"inserted_point_redactor_position",1}}

txt_name             = Copy(txt_mrk)
txt_name.name        = "txt_name"
txt_name.value       = LOCALIZE("ИМЯ")
txt_name.parent_element = "txt_mrk"
txt_name.init_pos    = {0,0,0}
txt_name.controllers = {{"inserted_point_redactor_position_available",0}}
Add(txt_name)

txt_name_data             = Copy(txt_name)
txt_name_data.name        = "txt_name_data"
txt_name_data.formats 	  = {"\t\t\t%s"}
txt_name_data.controllers = {{"inserted_point_redactor_position_available",0}, {"inserted_point_redactor_value",0,0}}
Add(txt_name_data)


txt_cursor1   		   	     = Copy(txt_name_data)
txt_cursor1.controllers      = {{"inserted_point_redactor_position",0},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor1.parent_element   = txt_name_data.name
txt_cursor1.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor1)

frame1 = AddFrame(13*x_diplacement,30*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame1.parent_element      = txt_name_data.name
frame1.controllers         = {{"inserted_point_redactor_position",0}}

txt_callsign             = Copy(txt_name)
txt_callsign.name        = "txt_callsign"
txt_callsign.value       = LOCALIZE("ПОЗЫВНОЙ")
txt_callsign.init_pos    = {0,-3*y_diplacement,0}
txt_callsign.controllers = {{"inserted_point_redactor_position_available",2}}
Add(txt_callsign)


txt_callsign_data            	 = Copy(txt_callsign)
txt_callsign_data.name       	 = "txt_callsign_data"
txt_callsign_data.formats 	  = {"\t\t\t%s"}
txt_callsign_data.controllers	 = {{"inserted_point_redactor_position_available",2}, {"inserted_point_redactor_value",0,2}}
Add(txt_callsign_data)

txt_cursor2   		   	     = Copy(txt_callsign_data)
txt_cursor2.controllers      = {{"inserted_point_redactor_position",2},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor2.parent_element   = txt_callsign_data.name
txt_cursor2.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor2)

frame2 = AddFrame(13*x_diplacement,30*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame2.parent_element      = txt_callsign_data.name
frame2.controllers         = {{"inserted_point_redactor_position",2}}

txt_pointtype             = Copy(txt_name)
txt_pointtype.name        = "txt_pointtype"
txt_pointtype.formats     = {"%s"}
txt_pointtype.init_pos    = {0.99*x_size + 0.4*x_size,-3*y_diplacement,0}
txt_pointtype.controllers = {{"inserted_point_redactor_point_type",0}}
Add(txt_pointtype)


txt_band                 = Copy(txt_name)
txt_band.name            = "txt_band"
txt_band.value           = LOCALIZE("ЧАСТОТА")
txt_band.init_pos  		 = {0,-4*y_diplacement,0}
txt_band.controllers	 = {{"inserted_point_redactor_position_available",3}}
Add(txt_band)



txt_band_data            	 = Copy(txt_band)
txt_band_data.name       	 = "txt_band_data"
txt_band_data.formats 	     = {"\t\t\t%s"}
txt_band_data.controllers	 = {{"inserted_point_redactor_position_available",3}, {"inserted_point_redactor_value",0,3}}
Add(txt_band_data)

txt_cursor3   		   	     = Copy(txt_callsign_data)
txt_cursor3.controllers      = {{"inserted_point_redactor_position",3},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor3.parent_element   = txt_band_data.name
txt_cursor3.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor3)

frame3 = AddFrame(13*x_diplacement,20*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame3.parent_element      = txt_band_data.name
frame3.controllers         = {{"inserted_point_redactor_position",3}}


txt_height             = Copy(txt_name)
txt_height.name        = "txt_height"
txt_height.value       = LOCALIZE("ВЫСОТА")
txt_height.init_pos    = {0,-5*y_diplacement,0}
txt_height.controllers	 = {{"inserted_point_redactor_position_available",4}}
Add(txt_height)

txt_height_data             = Copy(txt_height)
txt_height_data.name       	 = "txt_height_data"
txt_height_data.formats 	     = {"\t\t\t%s"}
txt_height_data.controllers	 = {{"inserted_point_redactor_position_available",4}, {"inserted_point_redactor_value",0,4}}
Add(txt_height_data)

txt_cursor3   		   	     = Copy(txt_callsign_data)
txt_cursor3.controllers      = {{"inserted_point_redactor_position",4},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor3.parent_element   = txt_height_data.name
txt_cursor3.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor3)

frame4 = AddFrame(13*x_diplacement,20*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame4.parent_element      = txt_height_data.name
frame4.controllers         = {{"inserted_point_redactor_position",4}}

