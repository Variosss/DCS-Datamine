dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("ОСНОВНЫЕ НАСТРОЙКИ")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local cursor_init_y           =  up_line_pos[2] - (y_size - up_line_pos[2])

AddCurrentListControl("current_list_block_1","current_list_block_2",cursor_init_y,0,11)
AddCurrentListControl("current_list_block_3","current_list_block_4",cursor_init_y - cursor_size_scaled,12,18)

txt_data_header			   	    = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos	    = {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("ДВИЖЕНИЕ КАРТЫ").."\n"..LOCALIZE("ОРИЕНТАЦИЯ КАРТЫ").."\n"..LOCALIZE("МАСШТАБ").."\n"..LOCALIZE("ПУ").."/"..LOCALIZE("КУРС").."\n"..LOCALIZE("ВЫСОТА").."\n"..LOCALIZE("ЧАСОВОЙ ПОЯС").."\n"..LOCALIZE("ВРЕМЯ").."\n"..LOCALIZE("ЧИСЛО").."\n"..LOCALIZE("ВРЕМЯ ПОЛЕТА").."\n"..LOCALIZE("САМОПИСЕЦ").."\n"..LOCALIZE("ВЫБОР ППМ").."\n"..LOCALIZE("ПРОЛЕТ ППМ").."\n"..LOCALIZE("ШКАЛА ЛБУ")..":".."\n".."\t"..LOCALIZE("  MIN").."\n".."\t"..LOCALIZE("  MAX").."\n"..LOCALIZE("РМИ1").."\n"..LOCALIZE("РМИ2").."\n"..LOCALIZE("ПОРОГ RAIM").."\n"..LOCALIZE("ВЫБОР ПОРОГА").."\n"..LOCALIZE("УЧЕТ ПСЕВДОДАЛЬНОСТИ")
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

--[[
txt_data			   	 = CreateElement "ceStringPoly"
txt_data.name            = "txt_data"
txt_data.material        = "font_Ka-50_ABRIS_WHITE"
txt_data.init_pos		 = {0.98*x_size + 0.4*x_size,0,0}
txt_data.value           = "string\nstring\nstring\nstring\nstring\nint\nhh:mm:ss\ndd:mm:year\nstring\nint\nint\nstring\n\nfloat\nfloat\nstring\nstring"
txt_data.alignment       = "LeftTop"
txt_data.stringdefs      = abris_font[2]
txt_data.parent_element  = "txt_data_header" 
Add(txt_data)
--]]

local fname = "current_menu_element_draw"
txt_data2			   	 = CreateElement "ceStringPoly"
txt_data2.name            = "txt_data2"
txt_data2.material        = "font_Ka-50_ABRIS_WHITE"
txt_data2.init_pos		 = {0.98*x_size + 0.4*x_size,0,0}
txt_data2.formats         = {"\n%s\n","%s\n"}
txt_data2.alignment       = "LeftTop"
txt_data2.stringdefs      = abris_font[2]
txt_data2.parent_element  = "txt_data_header"
txt_data2.controllers     = {{fname,1,0},
                             {fname,1,1},
                             {fname,1,2},
                             {fname,1,3},
                             {fname,1,4},
							 {fname,1,5},
                             {"current_menu_element_draw_or_not_draw",1,6}, --{fname,1,6},
                             {"current_menu_element_draw_or_not_draw",1,7}, --{fname,1,7},
                             {fname,1,8},
                             {fname,1,9},
                             {fname,1,10},
                             {fname,1,11},
                             {fname,0,12},
                             {fname,1,13},
                             {fname,1,14},
                             {fname,1,15},
							 --new
							 --{fname,1,16},
							 {"current_menu_element_draw_or_not_draw",1,16},
							 {fname,1,17},
							 {fname,1,18}
							 }
Add(txt_data2)
use_mipfilter(txt_data2)

txt_data_measurement			   	 = CreateElement "ceStringPoly"
txt_data_measurement.name            = "txt_data_measurement"
txt_data_measurement.material        = "font_Ka-50_ABRIS_GREEN"
txt_data_measurement.formats         = {"\n\n\n\n\n\n\n\n\n\n\n\t\t%s\n","\n\t\t%s\n","\t\t%s\n","\n\n\t\t%s"}
txt_data_measurement.alignment       = "LeftTop"
txt_data_measurement.stringdefs      = abris_font[2]
txt_data_measurement.parent_element  = "txt_data2"
txt_data_measurement.controllers     = {{"measurements_units_range",0},
										{"measurements_units_range",1},
										{"measurements_units_range",2},
										{"measurements_units_height",3}}
Add(txt_data_measurement)
use_mipfilter(txt_data_measurement)

txt_edited_value			   	   = CreateElement "ceStringPoly"
txt_edited_value.name           = "txt_edited_value"
txt_edited_value.material       = "font_Ka-50_ABRIS_WHITE"
txt_edited_value.init_pos		 = {0.4*x_size ,0.015 * y_size ,0}
txt_edited_value.alignment      =  "LeftTop"
txt_edited_value.stringdefs     =  abris_font[2]
txt_edited_value.formats   	   =  {"%s"}
txt_edited_value.controllers    = {{"string_editor_value",0}}
txt_edited_value.parent_element =  "current_list_block_3"
Add(txt_edited_value)
use_mipfilter(txt_edited_value)

txt_edited_value_cursor			   	   = Copy(txt_edited_value)
txt_edited_value_cursor.controllers    = {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_edited_value_cursor.parent_element =  "txt_edited_value"
txt_edited_value_cursor.init_pos		 = {0,-cursor_size_scaled * 0.2  ,0}
Add(txt_edited_value_cursor)
use_mipfilter(txt_edited_value_cursor)

txt_edited_value2			   	   = CreateElement "ceStringPoly"
txt_edited_value2.name           = "txt_edited_value2"
txt_edited_value2.material       = "font_Ka-50_ABRIS_WHITE"
txt_edited_value2.init_pos		 = {0.4*x_size ,0.015 * y_size ,0}
txt_edited_value2.alignment      =  "LeftTop"
txt_edited_value2.stringdefs     =  abris_font[2]
txt_edited_value2.formats   	   =  {"%s"}
txt_edited_value2.controllers    = {{"string_editor_value",0}}
txt_edited_value2.parent_element =  "current_list_block_1"
Add(txt_edited_value2)
use_mipfilter(txt_edited_value2)

txt_edited_value_cursor2			   	   = Copy(txt_edited_value2)
txt_edited_value_cursor2.controllers    = {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_edited_value_cursor2.parent_element =  "txt_edited_value2"
txt_edited_value_cursor2.init_pos		 = {0,-cursor_size_scaled * 0.2  ,0}
Add(txt_edited_value_cursor2)
use_mipfilter(txt_edited_value_cursor2)