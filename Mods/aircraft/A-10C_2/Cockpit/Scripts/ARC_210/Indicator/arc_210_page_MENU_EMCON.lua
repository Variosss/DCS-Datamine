dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Load and Exit Menus")

AddTempSettingLabel({"EMCON: OFF", "EMCON: ON"})
add_static_hint(2, "EMCON: OFF/EMCON: ON")
