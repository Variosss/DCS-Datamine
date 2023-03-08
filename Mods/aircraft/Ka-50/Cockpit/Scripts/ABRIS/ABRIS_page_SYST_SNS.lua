dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddSubMode("УСТ ВСТРОЕН ДАТЧИКОВ")

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local cursor_init_y           =  up_line_pos[2] - (y_size - up_line_pos[2])

AddCurrentListControl("current_list_block_1","current_list_block_2",cursor_init_y,0,12)

txt_data_header			   	 = CreateElement "ceStringPoly"
txt_data_header.name            = "txt_data_header"
txt_data_header.material        = "font_Ka-50_ABRIS_WHITE"
txt_data_header.init_pos		 = {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]),0}
txt_data_header.value           = LOCALIZE("ДАТЧИК").."\n"..LOCALIZE("ПОРТ").."\n"..LOCALIZE("СКОРОСТЬ БОД").."\n"..LOCALIZE("БИТЫ ДАННЫХ").."\n"..LOCALIZE("ЧЕТНОСТЬ").."\n"..LOCALIZE("СТОП БИТ").."\n"..LOCALIZE("КОНТРОЛЬ").."\n"..LOCALIZE("ИСП GPS").."\n"..LOCALIZE("МАСКА PDOP").."\n"..LOCALIZE("МАСКА ВОЗВ").."\n"..LOCALIZE("ИСКЛЮЧИТЬ КА")--.."\n".."".."\n"..LOCALIZE("СОХР И ТЕСТ")
txt_data_header.alignment       = "LeftTop"
txt_data_header.stringdefs      = abris_font[2]
Add(txt_data_header)
use_mipfilter(txt_data_header)

save_test_label				= CreateElement "ceStringPoly"
save_test_label.name        = "save_test_label"
save_test_label.material    = "font_Ka-50_ABRIS_WHITE"
save_test_label.init_pos	= {-0.98*x_size,up_line_pos[2] - (y_size - up_line_pos[2]) - 0.785 * y_size,0}
save_test_label.alignment   = "LeftTop"
save_test_label.stringdefs  = abris_font[2]
save_test_label.formats   	=  {LOCALIZE("СОХР И ТЕСТ"), LOCALIZE("ОСТ ТЕСТ")}
save_test_label.controllers = {{"save_test_label",0,1}}
Add(save_test_label)
use_mipfilter(save_test_label)

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
							 {fname,0,6},
							 {fname,0,7},
							 --{fname,0,8},
								{"current_menu_element_draw_or_not_draw",0,8},
							 --{fname,0,9},
								{"current_menu_element_draw_or_not_draw",0,9},
							 --{fname,0,10},
								{"current_menu_element_draw_or_not_draw",0,10},
							 {fname,0,11},
							 {fname,0,12}
							 }
Add(txt_data2)
use_mipfilter(txt_data2)
--
txt_edited_value			   	   = CreateElement "ceStringPoly"
txt_edited_value.name           = "txt_edited_value"
txt_edited_value.material       = "font_Ka-50_ABRIS_WHITE"
txt_edited_value.init_pos		 = {0.015 * x_size ,0.015 * y_size ,0}
txt_edited_value.alignment      =  "LeftTop"
txt_edited_value.stringdefs     =  abris_font[2]
txt_edited_value.formats   	   =  {"%s"}
txt_edited_value.controllers    = {{"string_editor_value",0}}
txt_edited_value.parent_element =  "current_list_block_1"
Add(txt_edited_value)
use_mipfilter(txt_edited_value)

txt_edited_value_cursor			   	   = Copy(txt_edited_value)
txt_edited_value_cursor.controllers    = {{"blinking",32},{"txt_string_editor_current_position",0}}
txt_edited_value_cursor.parent_element =  "txt_edited_value"
txt_edited_value_cursor.init_pos		 = {0,-cursor_size_scaled * 0.2  ,0}
Add(txt_edited_value_cursor)
use_mipfilter(txt_edited_value_cursor)

txt_edited_value_border					   = AddFrameMaterial(-0.02 * x_size, 0.2 * x_size, -0.08 * y_size, -0.02 * y_size , "INDICATION_ABRIS_WHITE")
txt_edited_value_border.parent_element = "txt_edited_value"

sns_data_window	= AddFrameMaterial(-0.85 * x_size, 0.9 * x_size, -0.2 * y_size, -0.8 * y_size, "INDICATION_ABRIS_WHITE")

sns_message_window 		 = CreateElement "ceSimple"
sns_message_window.name  = "sns_message_window"
sns_message_window.init_pos   = {-0.85 * x_size, -0.2 * y_size, 0}
sns_message_window.controllers = {{"sns_testing"}}
Add(sns_message_window)

add_console(sns_message_window,12,"font_Ka-50_ABRIS_WHITE",abris_font[7],0.05 * y_size)

--AddButtons("УСТ","ГНСС","","ТЕСТ","НАВ")