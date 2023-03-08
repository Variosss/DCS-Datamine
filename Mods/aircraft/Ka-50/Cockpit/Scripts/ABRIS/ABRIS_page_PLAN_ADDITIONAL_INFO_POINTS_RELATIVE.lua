dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_page_PLAN_ADDITIONAL_INFO_POINTS_BLOCK.lua")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
down_line          = CreateElement "ceTexPoly"
down_line.name     = "down_line"
SetLine(down_line)
down_line.init_pos = {0,y_center_render - y_render_size - 6.5*y_diplacement,0}
Add(down_line)

txt_base_stp             = Copy(txt_name)
txt_base_stp.name        = "txt_base_stp"
txt_base_stp.value       = LOCALIZE("ППМ")
txt_base_stp.parent_element = "down_line"
txt_base_stp.init_pos    = {-0.99*x_size,-0.5*y_diplacement,0}
Add(txt_base_stp)

txt_base_stp_data             = Copy(txt_base_stp)
txt_base_stp_data.name        = "txt_base_stp_data"
txt_base_stp_data.formats 	  = {"\t\t\t%s"}
txt_base_stp_data.controllers = {{"inserted_point_redactor_value",0,5}}
Add(txt_base_stp_data)

txt_base_stp_coords             = Copy(txt_base_stp)
txt_base_stp_coords.name        = "txt_base_stp_coords"
txt_base_stp_coords.formats 	= {"\t\t\t\t  %s"," %s"}
--txt_base_stp_coords.parent_element = txt_base_stp_data.name
txt_base_stp_coords.controllers = {	{"inserted_point_redactor_point_latitude", 0, 1},
									{"inserted_point_redactor_point_longitude", 1, 1}}
Add(txt_base_stp_coords)

--frame_base_name = AddFrame(13*x_diplacement,30*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_name = AddFrame(13*x_diplacement,19*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_name.parent_element      = txt_base_stp_data.name
frame_base_name.controllers         = {{"inserted_point_redactor_position",5}}


txt_cursor4   		   	     = Copy(txt_callsign_data)
txt_cursor4.controllers      = {{"inserted_point_redactor_position",5},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor4.parent_element   = txt_base_stp_data.name
txt_cursor4.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor4)


txt_azimuth             = Copy(txt_base_stp)
txt_azimuth.name        = "txt_azimuth"
txt_azimuth.value       = LOCALIZE("АЗИМУТ")
txt_azimuth.init_pos    = {0,-y_diplacement,0}
txt_azimuth.parent_element = "txt_base_stp"
Add(txt_azimuth)

txt_azimuth_data             = Copy(txt_azimuth)
txt_azimuth_data.name        = "txt_azimuth_data"
txt_azimuth_data.formats 	  = {"\t\t\t%s"}
txt_azimuth_data.controllers = {{"inserted_point_redactor_value",0,6}}
Add(txt_azimuth_data)

txt_cursor5   		   	     = Copy(txt_callsign_data)
txt_cursor5.controllers      = {{"inserted_point_redactor_position",6},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor5.parent_element   = txt_azimuth_data.name
txt_cursor5.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor5)

--frame_base_az = AddFrame(13*x_diplacement,20*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_az = AddFrame(13*x_diplacement,19*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_az.parent_element      = txt_azimuth_data.name
frame_base_az.controllers         = {{"inserted_point_redactor_position",6}}

txt_distance             = Copy(txt_base_stp)
txt_distance.name        = "txt_distance"
txt_distance.value       = LOCALIZE("ДАЛЬНОСТЬ")
txt_distance.init_pos    = {0,-2*y_diplacement,0}
txt_distance.parent_element = "txt_base_stp"
Add(txt_distance)

txt_distance_data             = Copy(txt_distance)
txt_distance_data.name        = "txt_distance_data"
txt_distance_data.formats 	  = {"\t\t\t%s"}
txt_distance_data.controllers = {{"inserted_point_redactor_value",0,7}}
Add(txt_distance_data)

txt_cursor6   		   	     = Copy(txt_callsign_data)
txt_cursor6.controllers      = {{"inserted_point_redactor_position",7},{"blinking",32},{"txt_string_editor_current_position",0}}
txt_cursor6.parent_element   = txt_distance_data.name
txt_cursor6.init_pos         = {0,-0.1*y_diplacement,0}
Add(txt_cursor6)

--frame_base_ds = AddFrame(13*x_diplacement,20*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_ds = AddFrame(13*x_diplacement,19*x_diplacement,-y_diplacement,-0.1*y_diplacement)
frame_base_ds.parent_element      = txt_distance_data.name
frame_base_ds.controllers         = {{"inserted_point_redactor_position",7}}

AddButtons("ВВОД","ПОИСК",">>","ТИП","ОТМЕНА")