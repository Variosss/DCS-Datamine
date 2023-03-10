dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

--AddTextLabel("HQ MENUS", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
top_line_label					= CreateElement "ceStringPoly"
top_line_label.name				= "top_line_label"
top_line_label.material			= "font_ARC210_small"
top_line_label.alignment		= "LeftTop"
top_line_label.formats			= {"EMCON", "HQ MENUS", "EXIT"}
top_line_label.init_pos			= {0, max_pixels_count_y}
top_line_label.stringdefs		= predefined_fonts[1]
top_line_label.controllers		= {{"root_menu_top_line_label"}}
SetLowerLeftCornerOrigin(top_line_label)
Add(top_line_label)
use_mipfilter(top_line_label)

add_osb_hint_format_controllers(1, {"Go to EMCON Menu", "Go to HQ Menu", "Exit Menus"}, {{"root_menu_top_line_hint"}})

AddTextLabel("COMSEC", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Go to COMSEC Menu")

AddTextLabel("RADIO SETTINGS", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "Go to Radio Settings Menu")
