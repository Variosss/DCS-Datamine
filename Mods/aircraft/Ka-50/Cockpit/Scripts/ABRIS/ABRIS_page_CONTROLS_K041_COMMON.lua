dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("K-O41")

up_line2          = CreateElement "ceTexPoly"
up_line2.name     = "up_line2"
SetLine(up_line2)
up_line2.init_pos = {0,up_line_pos[2] - (y_size - up_line_pos[2]),0}
Add(up_line2)

txt_data_header			   	    = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos	    = {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("Режим").."\n"..LOCALIZE("TIME OUT").."\n"..LOCALIZE("Широта").."\n"..LOCALIZE("Долгота").."\n"..LOCALIZE("Курс").."\n"..LOCALIZE("ФПУ").."\n"..LOCALIZE("Скорость")
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

new_delta					  = (3.0*y_size -  3*y_pos_delta)/29
local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()

current_list_block_1 			    = AddFrame(-x_size,x_size,-0.9*cursor_size_scaled/2,0.9*cursor_size_scaled/2)
current_list_block_1.init_pos  	    = {0,-0.5*new_delta,0}
current_list_block_1.parent_element = up_line2.name
use_mipfilter(current_list_block_1)

txt_data			   	 = CreateElement "ceStringPoly"
txt_data.name            = "txt_data"
txt_data.material        = "font_Ka-50_ABRIS_WHITE"
txt_data.init_pos	     = {0.98*x_size,0,0}
--txt_data.value           = LOCALIZE("Контроль").."\n".."345\n00°00\'00\"C\n00°00\'00\"B\n____\n____\n____"
txt_data.formats           = {" %s", "\n %d", "\n %s ", "\n %s ", "\n %.1f", "\n %.1f", "\n %.1f"}
txt_data.controllers 	 = {{"K041_controller_mode", 0},
							{"K041_controller_time", 1},
							{"K041_controller_lat", 2},
							{"K041_controller_long", 3},
							{"K041_controller_head", 4},
							{"K041_controller_fpu", 5},
							{"K041_controller_speed", 6}}
txt_data.alignment       = "LeftTop"
txt_data.stringdefs      = abris_font[2]
txt_data.parent_element  =  "txt_data_header"
Add(txt_data)
use_mipfilter(txt_data)


AddContextBlock(LOCALIZE("СООБЩЕН").."\n".."К-О41".."\n"..LOCALIZE("БЗД"))
