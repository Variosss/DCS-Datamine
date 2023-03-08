dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("PERFOMANCE SETUP")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local cursor_init_y           =  up_line_pos[2] - (y_size - up_line_pos[2])

AddCurrentListControl("current_list_block_1","current_list_block_2",cursor_init_y -  cursor_size_scaled,0,12)
AddCurrentListControl("current_list_block_3","current_list_block_4",cursor_init_y -2*cursor_size_scaled,13,16)

txt_data_header			   	 = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos		 = {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("СКОРОСТИ И КРЕНЫ").."\n\tV1\n\tV2\n\tV4\n\t"..LOCALIZE("V набора нормальная").."\n\t"..LOCALIZE("V набора МД").."\n\t"..LOCALIZE("V крейс нормальная").."\n\t"..LOCALIZE("V крейс МД").."\n\t"..LOCALIZE("V снижения нормальная").."\n\t"..LOCALIZE("V снижения МД").."\n\t"..LOCALIZE("Vy набор").."\n\t"..LOCALIZE("Vy снижение").."\n\t"..LOCALIZE("крен на маршруте").."\n\t"..LOCALIZE("крен в РА").."\n"..LOCALIZE("ТОПЛИВО").."\n\t"..LOCALIZE("руление").."\n\t"..LOCALIZE("взлет").."\n\t"..LOCALIZE("эшелон расход норм").."\n\t"..LOCALIZE("эшелон расход МД")
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

--[[
txt_data			   	 = CreateElement "ceStringPoly"
txt_data.name            = "txt_data"
txt_data.material        = "font_Ka-50_ABRIS_WHITE"
txt_data.init_pos		 = {0.98*x_size + 0.5*x_size,0,0}
txt_data.value           = "\nfloat км\nfloat км\nfloat км\nfloat км\nfloat км\nfloat км\nfloat км\nfloat км\nfloat км\nfloat мс\nfloat мс\nfloat°\nfloat°\n\nfloat кг\nfloat кг\nfloat кг\nfloat кг"
txt_data.alignment       = "LeftTop"
txt_data.stringdefs      = abris_font[2]
txt_data.parent_element  = "txt_data_header"
Add(txt_data)
--]]

local fname = "current_menu_element_draw"
txt_data2			   	 = CreateElement "ceStringPoly"
txt_data2.name            = "txt_data2"
txt_data2.material        = "font_Ka-50_ABRIS_WHITE"
txt_data2.init_pos		 = {0.98*x_size + 0.5*x_size,0,0}
txt_data2.formats         = {"\n%s\n","%s\n","%s°\n"}
txt_data2.alignment       = "LeftTop"
txt_data2.stringdefs      = abris_font[2]
txt_data2.parent_element  = "txt_data_header"
txt_data2.controllers     = {{fname,0,0},
                             {fname,1,1},
                             {fname,1,2},
                             {fname,1,3},
                             {fname,1,4},
                             {fname,1,5},
                             {fname,1,6},
                             {fname,1,7},
                             {fname,1,8},
                             {fname,1,9},
                             {fname,1,10},
                             {fname,2,11},
                             {fname,2,12},
                             {fname,0,13},
                             {fname,1,14},
                             {fname,1,15},
                             {fname,1,16}}
Add(txt_data2)
use_mipfilter(txt_data2)


txt_data_measurement			   	 = CreateElement "ceStringPoly"
txt_data_measurement.name            = "txt_data_measurement"
txt_data_measurement.material        = "font_Ka-50_ABRIS_GREEN"
txt_data_measurement.formats         = {"\n\t%s\n","\t%s\n","\n\n\n\t%s\n"}
txt_data_measurement.alignment       = "LeftTop"
txt_data_measurement.stringdefs      = abris_font[2]
txt_data_measurement.parent_element  = "txt_data2"
txt_data_measurement.controllers     =  {{"measurements_units_speed",0},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_speed",1},
			                             {"measurements_units_vertical_speed",1},
			                             {"measurements_units_vertical_speed",1},
			                             {"measurements_units_weight",2},
			                             {"measurements_units_weight",1},
			                             {"measurements_units_weight",1},
			                             {"measurements_units_weight",1}}
Add(txt_data_measurement)
use_mipfilter(txt_data_measurement)
