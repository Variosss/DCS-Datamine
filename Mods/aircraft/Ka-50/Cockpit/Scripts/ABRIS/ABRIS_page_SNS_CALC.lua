dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("МЕНЮ","СНС",">>","ВВОД","НАВ")
AddMode("РАСЧ")

txt_data_1				= CreateElement "ceStringPoly"
txt_data_1.name			= "txt_data_1"
txt_data_1.material		= "font_Ka-50_ABRIS_WHITE"
txt_data_1.init_pos		= {-0.95 * x_size, -0.3 * y_size, 0}
txt_data_1.value		= LOCALIZE("АЭРОДРОМ НАЗНАЧЕНИЯ").."\n"..LOCALIZE("ВРЕМЯ ПРИБЫТИЯ").."\n"..LOCALIZE("ПОЗ").."\n\n"..LOCALIZE("PRAIM ETA")
txt_data_1.alignment	= "LeftTop"
txt_data_1.stringdefs	= abris_font[5]
Add(txt_data_1)
use_mipfilter(txt_data_1)

--[[
txt_airdrome 				= Copy(txt_data_1)
txt_airdrome.name			= "txt_airdrome"
txt_airdrome.init_pos		= {0.2 * x_size, -0.3 * y_size, 0}
txt_airdrome.formats		=	{"%s"}
txt_airdrome.controllers	=	{{"string_editor_show_hide", 2,0},
									{"sns_calc_airport_callsign" , 0}}
Add(txt_airdrome)
use_mipfilter(txt_airdrome)
]]--


txt_airdrome				= CreateElement "ceStringPoly"
txt_airdrome.name			= "txt_airdrome"
txt_airdrome.material		= "font_Ka-50_ABRIS_WHITE"
txt_airdrome.init_pos		= {0.2 * x_size, -0.3 * y_size, 0}
txt_airdrome.alignment	= "LeftTop"
txt_airdrome.stringdefs	= abris_font[5]
txt_airdrome.controllers	=	{{"string_editor_show_hide", 2,0},
									{"sns_calc_airport_callsign"}}
Add(txt_airdrome)
use_mipfilter(txt_airdrome)


txt_arrival_time 			= Copy(txt_data_1)
txt_arrival_time.name			= "txt_arrival_time"
txt_arrival_time.init_pos		= {0.2 * x_size, -0.35 * y_size, 0}
txt_arrival_time.formats		= {"%02.f:%02.f"}
txt_arrival_time.controllers	=	{{"string_editor_show_hide", 1,0},
									 {"sns_calc_arrival_time",0}}
Add(txt_arrival_time)
use_mipfilter(txt_arrival_time)

txt_point_coordinates 			= Copy(txt_data_1)
txt_point_coordinates.name			= "txt_point_coordinates"
txt_point_coordinates.init_pos		= {-0.2 * x_size, -0.42 * y_size, 0}
txt_point_coordinates.formats 	= {"%s\n"}
	txt_point_coordinates.controllers = {{"wpt_not_found_blank", 0}, {"map_info_point_latitude", 0} , {"map_info_point_longitude", 0}}
Add(txt_point_coordinates)
use_mipfilter(txt_point_coordinates)

txt_calc_arival_time_yes				= CreateElement "ceStringPoly"
txt_calc_arival_time_yes.name			= "txt_calc_arival_time_yes"
txt_calc_arival_time_yes.material		= "font_Ka-50_ABRIS_GREEN"
txt_calc_arival_time_yes.alignment	= "LeftTop"
txt_calc_arival_time_yes.stringdefs	= abris_font[5]
txt_calc_arival_time_yes.init_pos		= {-0.2 * x_size, -0.54 * y_size, 0}
txt_calc_arival_time_yes.formats		= {"%02.f:%02.f".." "..LOCALIZE("ДА")}
txt_calc_arival_time_yes.controllers	=	{{"sns_calc_done", 1},
										 {"sns_calc_arrival_time",0},
										 {"sns_calc_raim", 0, 1}}
Add(txt_calc_arival_time_yes)
use_mipfilter(txt_calc_arival_time_yes)

txt_calc_arival_time_no				= CreateElement "ceStringPoly"
txt_calc_arival_time_no.name			= "txt_calc_arival_time_no"
txt_calc_arival_time_no.material		= "font_Ka-50_ABRIS_YELLOW"
txt_calc_arival_time_no.alignment	= "LeftTop"
txt_calc_arival_time_no.stringdefs	= abris_font[5]
txt_calc_arival_time_no.init_pos		= {-0.2 * x_size, -0.54 * y_size, 0}
txt_calc_arival_time_no.formats		= {"%02.f:%02.f".." "..LOCALIZE("НЕТ")}
txt_calc_arival_time_no.controllers	=	{{"sns_calc_done", 1},
										 {"sns_calc_arrival_time",0},
										 {"sns_calc_raim", 0, 0}}
Add(txt_calc_arival_time_no)
use_mipfilter(txt_calc_arival_time_no)

label_15min 			= Copy(txt_data_1)
label_15min.name			= "label_15min"
label_15min.init_pos		= {0.3 * x_size, -0.54 * y_size, 0}
label_15min.formats 	= {"%s\n"}
label_15min.value		= "+/- 15 "..LOCALIZE("мин")
Add(label_15min)
use_mipfilter(label_15min)

txt_wpt_not_found				= CreateElement "ceStringPoly"
txt_wpt_not_found.name			= "txt_wpt_not_found"
txt_wpt_not_found.material		= "font_Ka-50_ABRIS_YELLOW"	
txt_wpt_not_found.alignment    	= "LeftTop"
txt_wpt_not_found.stringdefs   	= abris_font[5]
txt_wpt_not_found.init_pos		= {-0.2 * x_size, -0.42 * y_size, 0}
txt_wpt_not_found.value			= LOCALIZE("НЕТ В БАЗЕ")	
txt_wpt_not_found.controllers	= {{"wpt_not_found_blank", 1}}
Add(txt_wpt_not_found)
use_mipfilter(txt_wpt_not_found)

txt_raim_ready 				= Copy(txt_wpt_not_found)
txt_raim_ready.name			= "txt_raim_ready"
txt_raim_ready.init_pos		= {-0.8 * x_size, -0.84 * y_size, 0}
txt_raim_ready.material		= "font_Ka-50_ABRIS_YELLOW"
txt_raim_ready.value		= LOCALIZE("РАСЧЕТ ПРОИЗВЕДЕН")
txt_raim_ready.controllers	= {{"sns_calc_done", 1}}
Add(txt_raim_ready)
use_mipfilter(txt_raim_ready)

time_table_rect					   = AddFrameMaterial(-0.8 * x_size, 0.8 * x_size, -0.07 * y_size, 0.07 * y_size,"INDICATION_ABRIS_WHITE")
time_table_rect.init_pos = {0.0, (-0.65 - 0.8) * y_size * 0.5, 0.0}

local centers_line  = (385  + (388 - 385)/2)/512

time_table_hor_line					= CreateElement "ceSimpleLineObject"
time_table_hor_line.name          = "time_table_hor_line"
time_table_hor_line.material	  = "INDICATION_ABRIS_WHITE"
time_table_hor_line.width         = 0.004 
time_table_hor_line.tex_params    = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
time_table_hor_line.vertices      = {	{-0.8 * x_size, 0.0},
										{0.8 * x_size, 0.0}}
time_table_hor_line.parent_element = time_table_rect.name
Add(time_table_hor_line)
use_mipfilter(time_table_hor_line)

local cell_width = 1.6 / 7 * x_size
time_table_ver_line = {}
time_table_label = {}
time_table_raim_plus = {}
time_table_raim_minus = {}

for i = -3,3 do
	time_table_ver_line[i]		= CreateElement "ceSimpleLineObject"
	time_table_ver_line[i].name          = "time_table_hor_line"..string.format("%d",i)
	time_table_ver_line[i].material	     = "INDICATION_ABRIS_WHITE"
	time_table_ver_line[i].width         = 0.004 
	time_table_ver_line[i].tex_params    = {{0.1,centers_line},{0.9,centers_line},{scale_2,scale_2}}	
	time_table_ver_line[i].vertices      = {{-0.8 * x_size + cell_width * (i+3), 0.07 * y_size},
											{-0.8 * x_size + cell_width * (i+3), -0.07 * y_size}}
	time_table_ver_line[i].parent_element = time_table_rect.name
	Add(time_table_ver_line[i])
	use_mipfilter(time_table_ver_line[i])

	time_table_label[i]			   = CreateElement "ceStringPoly"
	time_table_label[i].name         = "time_table_label"..string.format("%d",i)
	time_table_label[i].material     = "font_Ka-50_ABRIS_WHITE"
	time_table_label[i].init_pos	   = {-0.8 * x_size + cell_width * (i+3) + cell_width * 0.5, 0.035 * y_size,0.0} 
	time_table_label[i].value        = string.format("%d",  i * 5)
	time_table_label[i].alignment    = "CenterCenter"
	time_table_label[i].stringdefs   = abris_font[5]
	time_table_label[i].parent_element = time_table_rect.name
	Add(time_table_label[i])
	use_mipfilter(time_table_label[i])	
	
	time_table_raim_plus[i]			   		= CreateElement "ceStringPoly"
	time_table_raim_plus[i].name         	= "time_table_raim_plus"..string.format("%d",i)
	time_table_raim_plus[i].material     	= "font_Ka-50_ABRIS_GREEN"
	time_table_raim_plus[i].init_pos	   		= {-0.8 * x_size + cell_width * (i+3) + cell_width * 0.5, -0.035 * y_size,0.0} 
	time_table_raim_plus[i].alignment    	= "CenterCenter"
	time_table_raim_plus[i].stringdefs   	= abris_font[1]
	time_table_raim_plus[i].parent_element 	= time_table_rect.name
	time_table_raim_plus[i].value			= "+"
	time_table_raim_plus[i].controllers		=	{--{"sns_calc_done", 1},
											 {"sns_calc_raim", i , 1}}
	Add(time_table_raim_plus[i])
	use_mipfilter(time_table_raim_plus[i])
	
	time_table_raim_minus[i]			   		= CreateElement "ceStringPoly"
	time_table_raim_minus[i].name         	= "time_table_raim_minus"..string.format("%d",i)
	time_table_raim_minus[i].material     	= "font_Ka-50_ABRIS_YELLOW"
	time_table_raim_minus[i].init_pos	   		= {-0.8 * x_size + cell_width * (i+3) + cell_width * 0.5, -0.035 * y_size,0.0} 
	time_table_raim_minus[i].alignment    	= "CenterCenter"
	time_table_raim_minus[i].stringdefs   	= abris_font[1]
	time_table_raim_minus[i].parent_element 	= time_table_rect.name
	time_table_raim_minus[i].value			= "-"
	time_table_raim_minus[i].controllers		=	{--{"sns_calc_done", 1},
											 {"sns_calc_raim", i , 0}}
	Add(time_table_raim_minus[i])
	use_mipfilter(time_table_raim_minus[i])		
	
end

local cursor_size_scaled      =  cursor_size/GetScale()

txt_edited_value 			= CreateElement "ceStringPoly"
txt_edited_value.name			= "txt_edited_value"
txt_edited_value.material		= "font_Ka-50_ABRIS_WHITE"
txt_edited_value.init_pos		= {0.2 * x_size, -0.3 * y_size, 0}
txt_edited_value.alignment	= "LeftTop"
txt_edited_value.stringdefs     =  abris_font[5]
txt_edited_value.formats   	   =  {"%s"}
txt_edited_value.controllers    = {	{"string_editor_show_hide", 1},
									{"string_editor_value", 0}
									 }
Add(txt_edited_value)
use_mipfilter(txt_edited_value)

txt_edited_value_cursor					= Copy(txt_edited_value)
txt_edited_value_cursor.controllers    	= {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_edited_value_cursor.parent_element 	=  "txt_edited_value"
txt_edited_value_cursor.init_pos		 = {0,-cursor_size_scaled * 0.0  ,0}
Add(txt_edited_value_cursor)
use_mipfilter(txt_edited_value_cursor)

txt_edited_value_border					   = AddFrameMaterial(-0.02 * x_size, 0.2 * x_size, -0.06 * y_size, 0.0, "INDICATION_ABRIS_WHITE")
txt_edited_value_border.parent_element = "txt_edited_value"

txt_edited_value2 				= CreateElement "ceStringPoly"
txt_edited_value2.name			= "txt_edited_value2"
txt_edited_value2.material		= "font_Ka-50_ABRIS_WHITE"
txt_edited_value2.init_pos		= {0.2 * x_size, -0.35 * y_size, 0}
txt_edited_value2.alignment		= "LeftTop"
txt_edited_value2.stringdefs    =  abris_font[5]
txt_edited_value2.formats   	=  {"%s"}
txt_edited_value2.controllers   = {	{"string_editor_show_hide", 2},
									{"string_editor_value",0}
									}
Add(txt_edited_value2)
use_mipfilter(txt_edited_value2)

txt_edited_value_cursor2			   	  	= Copy(txt_edited_value2)
txt_edited_value_cursor2.controllers    	= {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_edited_value_cursor2.parent_element 	=  "txt_edited_value2"
txt_edited_value_cursor2.init_pos		 	= {0,-cursor_size_scaled * 0.0  ,0}
Add(txt_edited_value_cursor2)
use_mipfilter(txt_edited_value_cursor2)

txt_edited_value_border2					   = AddFrameMaterial(-0.02 * x_size, 0.25 * x_size, -0.06 * y_size, 0.0, "INDICATION_ABRIS_WHITE")
txt_edited_value_border2.parent_element = "txt_edited_value2"