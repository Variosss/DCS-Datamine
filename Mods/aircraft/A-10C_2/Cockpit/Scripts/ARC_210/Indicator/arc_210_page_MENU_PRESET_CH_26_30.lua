dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("PRESET CH. 26-30", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "CH. 26-30 Type")

AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "View More Options")
