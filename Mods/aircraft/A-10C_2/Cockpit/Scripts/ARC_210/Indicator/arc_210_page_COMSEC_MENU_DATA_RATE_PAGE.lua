dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT/LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Load Setting and Exit Menus")

AddTempSettingLabel({"DATA RATE: 75", 
					"DATA RATE: 300", 
					"DATA RATE: 600", 
					"DATA RATE: 1.2K", 
					"DATA RATE: 2.4K", 
					"DATA RATE: 4.8", 
					"DATA RATE: 6K",
					"DATA RATE: 8K",
					"DATA RATE: 9.6K",
					"DATA RATE: 12K",
					"DATA RATE: 16K",
					"DATA RATE: 19.2K",
					"DATA RATE: 32K",
					"DATA RATE: 38.4K"
					})
add_static_hint(2, "Select Data Rate")

AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")
add_static_hint(3, "View more COMSEC Options")
