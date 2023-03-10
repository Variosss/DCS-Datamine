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

satcom_channel_type_label					= CreateElement "ceStringPoly"
satcom_channel_type_label.name				= "satcom_channel_type_label"
satcom_channel_type_label.material			= "font_ARC210_small"
satcom_channel_type_label.alignment			= "RightBottom"
satcom_channel_type_label.formats			= {"IDLE", "5K", "25K", "DED"}
satcom_channel_type_label.init_pos			= {max_pixels_count_x-4, 25}
satcom_channel_type_label.stringdefs		= predefined_fonts[1]
satcom_channel_type_label.controllers		= {{"satcom_channel_type"}}
SetLowerLeftCornerOrigin(satcom_channel_type_label)
Add(satcom_channel_type_label)
use_mipfilter(satcom_channel_type_label)

satcom_top_channel_label					= CreateElement "ceStringPoly"
satcom_top_channel_label.name				= "satcom_top_channel_label"
satcom_top_channel_label.material			= "font_ARC210_small"
satcom_top_channel_label.alignment			= "LeftTop"
satcom_top_channel_label.formats			= {"CH %d", "%3d.%03d", "DAMA"}
satcom_top_channel_label.init_pos			= {50, max_pixels_count_y}
satcom_top_channel_label.stringdefs			= predefined_fonts[1]
satcom_top_channel_label.controllers		= {{"satcom_top_status"}}
SetLowerLeftCornerOrigin(satcom_top_channel_label)
Add(satcom_top_channel_label)
use_mipfilter(satcom_top_channel_label)

satcom_top_button_label					= CreateElement "ceStringPoly"
satcom_top_button_label.name			= "satcom_top_button_label"
satcom_top_button_label.material		= "font_ARC210_small"
satcom_top_button_label.alignment		= "LeftTop"
satcom_top_button_label.formats			= {"LOG IN", "LOGOUT", ""}
satcom_top_button_label.init_pos		= {0, max_pixels_count_y}
satcom_top_button_label.stringdefs		= predefined_fonts[1]
satcom_top_button_label.controllers		= {{"satcom_top_button"}}
SetLowerLeftCornerOrigin(satcom_top_button_label)
Add(satcom_top_button_label)
use_mipfilter(satcom_top_button_label)

add_osb_hint_format_controllers(1, {"Log In Channel", "Log Out Channel", ""}, {{"satcom_top_button_hint"}})


AddTextLabel("ATTEMPTING\nTO LOGIN", "CenterBottom", 90, 0, predefined_fonts[1], "font_ARC210_small", {{"satcom_channel_logging_in"}})
AddTextLabel("LOGGED IN-\nCONNECTING", "CenterBottom", 90, 0, predefined_fonts[1], "font_ARC210_small", {{"satcom_channel_connecting"}})

satcom_activated_status					= CreateElement "ceStringPoly"
satcom_activated_status.name			= "satcom_activated_status"
satcom_activated_status.material		= "font_ARC210_big"
satcom_activated_status.alignment		= "CenterBottom"
satcom_activated_status.formats			= {"ACTIVE", "CONNECT"}
satcom_activated_status.init_pos		= {70, 0}
satcom_activated_status.stringdefs		= predefined_fonts[2]
satcom_activated_status.controllers		= {{"satcom_channel_activated"}, {"satcom_activated_status"}}
SetLowerLeftCornerOrigin(satcom_activated_status)
Add(satcom_activated_status)
use_mipfilter(satcom_activated_status)

satcom_activated_time_remain				= CreateElement "ceStringPoly"
satcom_activated_time_remain.name			= "satcom_activated_time_remain"
satcom_activated_time_remain.material		= "font_ARC210_small"
satcom_activated_time_remain.alignment		= "RightBottom"
satcom_activated_time_remain.formats		= {"%02d:%02d:%02d", ""}
satcom_activated_time_remain.init_pos		= {56, 55}
satcom_activated_time_remain.stringdefs		= predefined_fonts[1]
satcom_activated_time_remain.controllers	= {{"satcom_channel_activated"}, {"satcom_activated_time_remain"}}
SetLowerLeftCornerOrigin(satcom_activated_time_remain)
Add(satcom_activated_time_remain)
use_mipfilter(satcom_activated_time_remain)

satcom_DED_freq_label_khz					= CreateElement "ceStringPoly"
satcom_DED_freq_label_khz.name				= "freq_label_khz"
satcom_DED_freq_label_khz.material			= "font_ARC210_big"
satcom_DED_freq_label_khz.alignment			= "RightBottom"
satcom_DED_freq_label_khz.formats			= {"%03d"}
satcom_DED_freq_label_khz.init_pos			= {max_pixels_count_x, 0}
satcom_DED_freq_label_khz.stringdefs		= predefined_fonts[2]
satcom_DED_freq_label_khz.parent_element	= "satcom_DED_freq_avail"
satcom_DED_freq_label_khz.controllers		= {{"satcom_DED_freq_avail"}, {"satcom_DED_freq_khz"}}
SetLowerLeftCornerOrigin(satcom_DED_freq_label_khz)
Add(satcom_DED_freq_label_khz)
use_mipfilter(satcom_DED_freq_label_khz)

satcom_DED_freq_label_mhz					= CreateElement "ceStringPoly"
satcom_DED_freq_label_mhz.name				= "satcom_DED_freq_label_mhz"
satcom_DED_freq_label_mhz.material			= "font_ARC210_big"
satcom_DED_freq_label_mhz.alignment			= "RightBottom"
satcom_DED_freq_label_mhz.formats			= {"%d"}
satcom_DED_freq_label_mhz.init_pos			= {max_pixels_count_x-53, 0}
satcom_DED_freq_label_mhz.stringdefs		= predefined_fonts[2]
satcom_DED_freq_label_mhz.parent_element	= "satcom_DED_freq_avail"
satcom_DED_freq_label_mhz.controllers		= {{"satcom_DED_freq_avail"}, {"satcom_DED_freq_mhz"}}
SetLowerLeftCornerOrigin(satcom_DED_freq_label_mhz)
Add(satcom_DED_freq_label_mhz)
use_mipfilter(satcom_DED_freq_label_mhz)

--TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big", {{"satcom_DED_freq_avail"}})

comsec_satcom_mode					= CreateElement "ceStringPoly"
comsec_satcom_mode.name				= "comsec_satcom_mode"
comsec_satcom_mode.material			= "font_ARC210_small"
comsec_satcom_mode.alignment		= "LeftTop"
comsec_satcom_mode.formats			= {"ANDVT VOICE", "ANDVT DATA", "KY-58 VOICE", "KY-58 DATA", "KG-84 DATA"}
comsec_satcom_mode.init_pos			= {0, 50}
comsec_satcom_mode.stringdefs		= predefined_fonts[1]
comsec_satcom_mode.controllers		= {{"comsec_satcom_mode"}}
SetLowerLeftCornerOrigin(comsec_satcom_mode)
Add(comsec_satcom_mode)
use_mipfilter(comsec_satcom_mode)

AddTextLabel("CT", "LeftTop", 0, 35, predefined_fonts[1], "font_ARC210_small")

comsec_satcom_delay					= CreateElement "ceStringPoly"
comsec_satcom_delay.name			= "comsec_satcom_delay"
comsec_satcom_delay.material		= "font_ARC210_small"
comsec_satcom_delay.alignment		= "LeftBottom"
comsec_satcom_delay.formats			= {"%d"}
comsec_satcom_delay.init_pos		= {0, 2}
comsec_satcom_delay.stringdefs		= predefined_fonts[1]
comsec_satcom_delay.controllers		= {{"comsec_satcom_delay"}}
SetLowerLeftCornerOrigin(comsec_satcom_delay)
Add(comsec_satcom_delay)
use_mipfilter(comsec_satcom_delay)

add_static_hint(3, "Set Comsec Delay")
