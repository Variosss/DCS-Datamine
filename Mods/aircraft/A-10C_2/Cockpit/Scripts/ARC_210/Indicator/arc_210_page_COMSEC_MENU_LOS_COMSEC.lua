dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTempSettingLabel({"LOS_COMSEC", "DAMA/SATCOM COMSEC"})
add_static_hint(2, "Select COMSEC")

AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "View more COMSEC Options")
