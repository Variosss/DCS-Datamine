dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menu")

AddTextLabel("LOAD\nTIME", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Load Time")

active_channel					= CreateElement "ceStringPoly"
active_channel.name				= "active_channel"
active_channel.material			= "font_ARC210_big"
active_channel.alignment		= "RightTop"
active_channel.formats			= {"%d"}
active_channel.init_pos			= {max_pixels_count_x-2, max_pixels_count_y-channel_offset}
active_channel.stringdefs		= predefined_fonts[2]
active_channel.controllers		= {{"temp_value"}}
SetLowerLeftCornerOrigin(active_channel)
Add(active_channel)
use_mipfilter(active_channel)

SG_time						= CreateElement "ceStringPoly"
SG_time.name				= "SG_time"
SG_time.material			= "font_ARC210_big"
SG_time.alignment			= "LeftBottom"
SG_time.formats				= {"%02d.%02d", "%02d.%1d"}
--SG_time.value				= "22.34"
SG_time.init_pos			= {28, 0}
SG_time.stringdefs			= predefined_fonts[2]
SG_time.controllers			= {{"SG_time"}}
SetLowerLeftCornerOrigin(SG_time)
Add(SG_time)
use_mipfilter(SG_time)
