dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_2

AddSimpleCurrentListControl(y_size -  y_pos_delta - 5.5*new_delta  - 2*y_render_size ,-4*new_delta*GetScale())
add_line(y_size -  y_pos_delta - 2*new_delta  - 2*y_render_size)
add_line(y_size -  y_pos_delta - 5*new_delta  - 2*y_render_size)
add_line(y_size -  y_pos_delta - 6*new_delta  - 2*y_render_size)
add_line(y_size -  y_pos_delta - 9*new_delta  - 2*y_render_size)

x_pos = {
-0.72,
-0.51,
-0.24,
0.08,
0.4,
0.75
}

for i =1,2 do
	for j = 1,6 do
	if i == 1 then
	add_line_vertical(x_pos[j],y_size -  y_pos_delta - 2*new_delta - (4*i - 1)*new_delta - 2*y_render_size,0,5*new_delta)
	else
	add_line_vertical(x_pos[j],y_size -  y_pos_delta - 2*new_delta - (4*i - 1)*new_delta - 2*y_render_size,0,3*new_delta)
	end
	end
end

txt_journal_header = {}
txt_journal_header[1]			   	   = CreateElement "ceStringPoly"
txt_journal_header[1].name             = "txt_journal_header_1"
txt_journal_header[1].material         = "font_Ka-50_ABRIS_WHITE"
txt_journal_header[1].init_pos		   = {-0.99*x_size,y_size -  y_pos_delta - 2*y_render_size,0}
txt_journal_header[1].alignment        = "LeftTop"
txt_journal_header[1].stringdefs       = abris_font[3]
Add(txt_journal_header[1])
use_mipfilter(txt_journal_header[1])

for i = 2,7 do
	txt_journal_header[i]			   	   = CreateElement "ceStringPoly"
	txt_journal_header[i].name             = string.format("txt_journal_header_%d",i)
	txt_journal_header[i].material         = "font_Ka-50_ABRIS_WHITE"
	txt_journal_header[i].init_pos		   = {x_size + x_pos[i-1],0,0}
	txt_journal_header[i].alignment        = "LeftTop"
	txt_journal_header[i].stringdefs       = abris_font[3]
	txt_journal_header[i].parent_element   = "txt_journal_header_1"
	Add(txt_journal_header[i])
	use_mipfilter(txt_journal_header[i])
end
txt_journal_header[1].value			= LOCALIZE("ЗИПУ").."\n"..LOCALIZE("ИК")
--txt_journal_header[2].value			= LOCALIZE("A°").."\n" --..LOCALIZE("кч")
txt_journal_header[2].formats		= {LOCALIZE("A°").."\n".."%s"}
txt_journal_header[2].controllers 	= {{"measurements_units_speed",0}}

txt_journal_header[3].formats		= {LOCALIZE("V").."\n"..LOCALIZE("W").."%s"}
txt_journal_header[3].controllers 	= {{"measurements_units_speed",0}}
--txt_journal_header[3].value			= LOCALIZE("V").."\n"..LOCALIZE("W") --..LOCALIZE("кч")

txt_journal_header[4].formats		= {LOCALIZE("Sппм").."\n"..LOCALIZE("Sост").."%s"}
txt_journal_header[4].controllers 	= {{"measurements_units_range",0}}
--txt_journal_header[4].value			= LOCALIZE("Sппм").."\n"..LOCALIZE("Sост")
txt_journal_header[5].value			= LOCALIZE("Тппм").."\n"..LOCALIZE("Тпрол")
txt_journal_header[6].value			= LOCALIZE("Qчас").."\n"..LOCALIZE("Gост")
txt_journal_header[7].value			= LOCALIZE("H").."\nT°C"

AddButtons("ВЫБРАТЬ","РЕДАКТ","","АКТ","МЕНЮ")

local cut_window_min_y = -y_size
local cut_window_max_y =  y_size -  y_pos_delta - 2*new_delta - 2*y_render_size

stencil_mask				   = CreateElement "ceMeshPoly"
stencil_mask.primitivetype     = "triangles"
stencil_mask.name              = "stencil_mask"
stencil_mask.material          = "GREEN"
stencil_mask.vertices          = {{-x_size,cut_window_max_y},
								  { x_size,cut_window_max_y},
								  { x_size,cut_window_min_y},
								  {-x_size,cut_window_min_y}}
stencil_mask.indices           =  box_ind
stencil_mask.isvisible         =  false
stencil_mask.h_clip_relation   =  h_clip_relations.INCREASE_LEVEL
Add(stencil_mask)

dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {-0.99*x_size,cut_window_max_y - 3*new_delta,0}
dummy.controllers      = {{"set_frame_size_for_current_menu",2},{"specific_draw_journal"}} 
Add(dummy)


--dummy				   = CreateElement "ceMeshPoly"
--dummy.name             = "dummy"
--dummy.material         = "GREEN"
--dummy.isvisible        = false
--dummy.init_pos		   = {-0.99*x_size,y_size -  2*y_pos_delta - 5*new_delta,0}
--dummy.controllers      = {{"set_frame_size_for_current_menu",4},{"specific_draw_journal"}} 
--Add(dummy)


RewriteDefaultLevel()
AddContextBlock(LOCALIZE("ЗАГР").."\n"..LOCALIZE("ЗАПИСЬ").."\n"..LOCALIZE("ОЧИСТ").."\n"..LOCALIZE("ВОЗВРАТ").."\n"..LOCALIZE("УДАЛИТЬ").."\n"..LOCALIZE("ИНВЕРТ").."\n"..LOCALIZE("СЛМ").."\n"..LOCALIZE("ДОП.ИНФ"))
AddContextBlock(LOCALIZE("РИСОВ").."\n"..LOCALIZE("СКОР").."\n"..LOCALIZE("ВНАВ").."\n"..LOCALIZE("МЕТЕО").."\n"..LOCALIZE("ТОПЛИВО"),1)




