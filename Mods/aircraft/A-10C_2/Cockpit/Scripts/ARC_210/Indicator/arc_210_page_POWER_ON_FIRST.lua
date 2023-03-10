dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddTextLabel("POWER UP LOADER", "CenterTop", max_pixels_count_x/2, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small", {{"screen_ready", 3}})
AddTextLabel("VER: 984-1541-007", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small", {{"screen_ready", 3}})
AddTextLabel("CHECKING PAGE 1", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small", {{"screen_ready", 3}})
