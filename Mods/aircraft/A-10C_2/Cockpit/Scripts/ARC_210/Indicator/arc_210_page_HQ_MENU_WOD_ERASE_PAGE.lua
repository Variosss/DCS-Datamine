dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/NO", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Do not Save, Exit Menus")

AddTextLabel("YES", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "Confirm Erase WOD")

AddTextLabel("ARE YOU SURE\nYOU WANT TO\nERASE WODS?", "LeftCenter", max_pixels_count_x/2-23, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
