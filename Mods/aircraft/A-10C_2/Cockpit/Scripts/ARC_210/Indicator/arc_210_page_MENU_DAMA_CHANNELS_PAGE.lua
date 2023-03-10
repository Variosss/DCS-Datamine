dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Load and Exit Menus")

AddTempSettingLabel({"DAMA CH. 41-50", "DAMA CH. 31-40"})
add_static_hint(2, "Select DAMA Channel Range")
