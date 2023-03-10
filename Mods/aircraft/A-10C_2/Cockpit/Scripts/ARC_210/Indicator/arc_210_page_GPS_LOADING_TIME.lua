dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("ATTEMPTING TO", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
AddTextLabel("LOAD GPS TIME", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
