dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("ЕДИНИЦЫ")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local cursor_init_y           =  up_line_pos[2] - (y_size - up_line_pos[2])

AddCurrentListControl("current_list_block_1","current_list_block_2",cursor_init_y,0,6)

txt_data_header			   	 = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos		 = {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("ШИРОТА").."\n"..LOCALIZE("ДОЛГОТА").."\n"..LOCALIZE("СКОРОСТЬ").."\n"..LOCALIZE("РАССТОЯНИЕ").."\n"..LOCALIZE("ВЫСОТА").."\n"..LOCALIZE("ВЕС").."\n"..LOCALIZE("ЭЛЛИПСОИД").."\n"
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

--[[
txt_data			   	 = CreateElement "ceStringPoly"
txt_data.name            = "txt_data"
txt_data.material        = "font_Ka-50_ABRIS_WHITE"
txt_data.init_pos		 = {x_size,0,0}
txt_data.value           = " __°__\'__\"C/Ю\n___°__\'__\"В/З\nкм/ч\nкм\nм\nкг\nсоотношение"
txt_data.alignment       = "LeftTop"
txt_data.stringdefs      = abris_font[2]
txt_data.parent_element  = "txt_data_header"
Add(txt_data)
--]]

local fname = "current_menu_element_draw"
txt_data2			   	 = CreateElement "ceStringPoly"
txt_data2.name            = "txt_data2"
txt_data2.material        = "font_Ka-50_ABRIS_WHITE"
txt_data2.init_pos		 = {x_size,0,0}
txt_data2.formats         = {"%s\n"}
txt_data2.alignment       = "LeftTop"
txt_data2.stringdefs      = abris_font[2]
txt_data2.parent_element  = "txt_data_header"
txt_data2.controllers     = {{fname,0,0},
							 {fname,0,1},
							 {fname,0,2},
							 {fname,0,3},
							 {fname,0,4},
							 {fname,0,5},
							 {fname,0,6}
							 }
Add(txt_data2)
use_mipfilter(txt_data2)

