dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("СИГНАЛИЗАЦИЯ")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local cursor_init_y           =  up_line_pos[2] - (y_size - up_line_pos[2])

AddCurrentListControl("current_list_block_1","current_list_block_2",cursor_init_y -  cursor_size_scaled,0,6)
AddCurrentListControl("current_list_block_3","current_list_block_4",cursor_init_y -2*cursor_size_scaled,7,8)
AddCurrentListControl("current_list_block_5","current_list_block_6",cursor_init_y -3*cursor_size_scaled,9,11)

txt_data_header			   	    = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos		= {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("ПОДХОД К").."\n\t"..LOCALIZE("ППМ").."\n\t"..LOCALIZE("точка набора").."\n\t"..LOCALIZE("точка снижения").."\n\t"..LOCALIZE("точка начала разв").."\n\t"..LOCALIZE("граница РПИ").."\n\t"..LOCALIZE("граница ЗОРП").."\n\t"..LOCALIZE("граница зоны УВД").."\n"..LOCALIZE("ЛИМИТ").."\n\t"..LOCALIZE("по ЛБУ").."\n\t"..LOCALIZE("по ПУ").."\n" --..LOCALIZE("ПРЕПЯТСТВИЯ").."\n\t"..LOCALIZE("в радиусе").."\n\t"..LOCALIZE("по вертикали").."\n"..LOCALIZE("СПС с землей")
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

--[[
txt_data			   	 = CreateElement "ceStringPoly"
txt_data.name            = "txt_data"
txt_data.material        = "font_Ka-50_ABRIS_WHITE"
txt_data.init_pos		 = {0.98*x_size + 0.5*x_size,0,0}
txt_data.value           = "\nfloat мин\nfloat мин\nfloat мин\nfloat мин\nfloat км\nfloat км\nfloat км\n\nfloat км\nfloat°\n\nfloat км\nfloat м\nВЫКЛ"
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
txt_data2.formats         = {"\n%s "..LOCALIZE("МИН").."\n",
							   "%s "..LOCALIZE("МИН").."\n",
							   "\n%s\n",
							   "%s\n"}
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
                             {fname,2,7},
                             {fname,3,8},
                             {fname,2,9},
                             {fname,3,10},
                             {fname,3,11}}
Add(txt_data2)
use_mipfilter(txt_data2)
