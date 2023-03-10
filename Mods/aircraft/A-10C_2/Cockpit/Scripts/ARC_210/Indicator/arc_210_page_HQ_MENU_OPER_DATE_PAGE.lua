dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("LOAD", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Load Data")

AddTextLabel("OPER. DATE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")

active_oper_date					= CreateElement "ceStringPoly"
active_oper_date.name				= "active_oper_date"
active_oper_date.material			= "font_ARC210_big"
active_oper_date.alignment			= "RightTop"
active_oper_date.formats			= {"%d"}
active_oper_date.init_pos			= {max_pixels_count_x-2, max_pixels_count_y-channel_offset}
active_oper_date.stringdefs			= predefined_fonts[2]
active_oper_date.controllers		= {{"oper_date"}}
SetLowerLeftCornerOrigin(active_oper_date)
Add(active_oper_date)
use_mipfilter(active_oper_date)
