dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

active_channel					= CreateElement "ceStringPoly"
active_channel.name				= "active_channel"
active_channel.material			= "font_ARC210_big"
active_channel.alignment		= "RightTop"
active_channel.formats			= {"%d"}
active_channel.init_pos			= {max_pixels_count_x-2, max_pixels_count_y-18}
active_channel.stringdefs		= predefined_fonts[2]
active_channel.controllers		= {{"active_channel"}}
SetLowerLeftCornerOrigin(active_channel)
Add(active_channel)
use_mipfilter(active_channel)

--AddTextLabel("PREV", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
