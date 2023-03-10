dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("VERIFY\nWOD/MWOD", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Verify WOD/MWOD")

active_channel					= CreateElement "ceStringPoly"
active_channel.name				= "active_channel"
active_channel.material			= "font_ARC210_big"
active_channel.alignment		= "RightCenter"
active_channel.formats			= {"%d"}
active_channel.init_pos			= {max_pixels_count_x-2, max_pixels_count_y/2}
active_channel.stringdefs		= predefined_fonts[2]
active_channel.controllers		= {{"oper_date"}}
SetLowerLeftCornerOrigin(active_channel)
Add(active_channel)
use_mipfilter(active_channel)
