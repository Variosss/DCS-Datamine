dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT({{"screen_ready", 3}})

AddTextLabel("INITIALIZING", "LeftTop", 13, max_pixels_count_y-25, predefined_fonts[1], "font_ARC210_small", {{"screen_ready", 3}})
--AddTextLabel("INITIALIZING", "LeftTop", 6, max_pixels_count_y-18, predefined_fonts[3], "font_MFCD", {{"screen_ready", 3}})
