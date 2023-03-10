dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("VERIFY WOD/MWOD", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Verify WOD/MWOD")

AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "Cycle HQ Options")
