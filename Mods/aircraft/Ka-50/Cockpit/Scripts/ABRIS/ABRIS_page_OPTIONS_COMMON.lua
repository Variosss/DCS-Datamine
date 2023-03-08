dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

up_line          = CreateElement "ceTexPoly"
up_line.name     = "up_line"
SetLine(up_line)
up_line.init_pos = up_line_pos
Add(up_line)

up_line2          = CreateElement "ceTexPoly"
up_line2.name     = "up_line2"
SetLine(up_line2)
up_line2.init_pos = {0,up_line_pos[2] - (y_size - up_line_pos[2]),0}
Add(up_line2)

--AddButtons("УСТАН","\\\/","\/\\","СМЕНА","МЕНЮ")
AddMode("ОПЦИИ")
AddContextBlock(LOCALIZE("ОСНОВН").."\n"..LOCALIZE("ЕДИНИЦЫ").."\n"..LOCALIZE("ТТХ").."\n"..LOCALIZE("СИГНАЛ").."\n"..LOCALIZE("КАРТЫ"))