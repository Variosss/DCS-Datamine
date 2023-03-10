dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Load Setting and Exit Menus")

AddTempSettingLabel({"ANDVT VOICE", "ANDVT DATA", "KY-58 VOICE", "KY-58 DATA", "KG-84 DATA"})
add_static_hint(2, "Select Voice/Data Type")

AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small", {{"not_andvt_voice"}})
add_static_hint(3, "View more COMSEC Options")
