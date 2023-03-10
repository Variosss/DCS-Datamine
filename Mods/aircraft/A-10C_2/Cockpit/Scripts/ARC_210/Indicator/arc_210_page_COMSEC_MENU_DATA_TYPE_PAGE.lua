dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
AddTempSettingLabel({"DIGITAL DATA", "ANALOG DATA"})
AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
