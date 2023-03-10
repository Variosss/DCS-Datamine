dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

active_channel					= CreateElement "ceStringPoly"
active_channel.name				= "active_channel"
active_channel.material			= "font_ARC210_big"
active_channel.alignment		= "RightTop"
active_channel.formats			= {"%d"}
active_channel.init_pos			= {max_pixels_count_x-2, max_pixels_count_y-channel_offset}
active_channel.stringdefs		= predefined_fonts[2]
active_channel.controllers		= {{"active_channel"}}
SetLowerLeftCornerOrigin(active_channel)
Add(active_channel)
use_mipfilter(active_channel)

AddTextLabel("LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Load Data")

xmit_recv_label					= CreateElement "ceStringPoly"
xmit_recv_label.name			= "xmit_recv_label"
xmit_recv_label.material		= "font_ARC210_small"
xmit_recv_label.alignment		= "RightBottom"
xmit_recv_label.formats			= {"XMIT", "RECV"}
xmit_recv_label.init_pos		= {max_pixels_count_x-53, 25}
xmit_recv_label.stringdefs		= predefined_fonts[1]
xmit_recv_label.controllers		= {{"active_channel_26_30"}, {"active_channel_26_30_xmit"}}
SetLowerLeftCornerOrigin(xmit_recv_label)
Add(xmit_recv_label)
use_mipfilter(xmit_recv_label)

