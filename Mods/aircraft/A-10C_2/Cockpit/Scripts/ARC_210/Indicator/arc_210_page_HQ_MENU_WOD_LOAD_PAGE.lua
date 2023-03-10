dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("LOAD\nWOD", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Load WOD")

WOD_segment					= CreateElement "ceStringPoly"
WOD_segment.name			= "WOD_segment"
WOD_segment.material		= "font_ARC210_big"
WOD_segment.alignment		= "LeftTop"
WOD_segment.formats			= {"%d"}
WOD_segment.init_pos		= {max_pixels_count_x/2-20, max_pixels_count_y-25}
WOD_segment.stringdefs		= predefined_fonts[2]
WOD_segment.controllers		= {{"WOD_segment"}}
SetLowerLeftCornerOrigin(WOD_segment)
Add(WOD_segment)
use_mipfilter(WOD_segment)

WOD_segment_data_khz				= CreateElement "ceStringPoly"
WOD_segment_data_khz.name			= "WOD_segment_data_khz"
WOD_segment_data_khz.material		= "font_ARC210_big"
WOD_segment_data_khz.alignment		= "RightBottom"
WOD_segment_data_khz.formats		= {"%03d", "%d  "}
WOD_segment_data_khz.init_pos		= {max_pixels_count_x, 0}
WOD_segment_data_khz.stringdefs		= predefined_fonts[2]
WOD_segment_data_khz.controllers	= {{"WOD_segment_displayed"}, {"WOD_segment_data_khz"}}
SetLowerLeftCornerOrigin(WOD_segment_data_khz)
Add(WOD_segment_data_khz)
use_mipfilter(WOD_segment_data_khz)

WOD_segment_data_mhz				= CreateElement "ceStringPoly"
WOD_segment_data_mhz.name			= "WOD_segment_data_mhz"
WOD_segment_data_mhz.material		= "font_ARC210_big"
WOD_segment_data_mhz.alignment		= "RightBottom"
WOD_segment_data_mhz.formats		= {"%d"}
WOD_segment_data_mhz.init_pos		= {max_pixels_count_x-53, 0}
WOD_segment_data_mhz.stringdefs		= predefined_fonts[2]
WOD_segment_data_mhz.controllers	= {{"WOD_segment_displayed"}, {"WOD_segment_data_mhz"}}
SetLowerLeftCornerOrigin(WOD_segment_data_mhz)
Add(WOD_segment_data_mhz)
use_mipfilter(WOD_segment_data_mhz)

--TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big", {{"WOD_segment_displayed"}})

WOD_segment_date					= CreateElement "ceStringPoly"
WOD_segment_date.name				= "WOD_segment_date"
WOD_segment_date.material			= "font_ARC210_big"
WOD_segment_date.alignment			= "RightTop"
WOD_segment_date.formats			= {"%02d"}
WOD_segment_date.init_pos			= {max_pixels_count_x-2, max_pixels_count_y-channel_offset}
WOD_segment_date.stringdefs			= predefined_fonts[2]
WOD_segment_date.controllers		= {{"WOD_date_displayed"}, {"WOD_date"}}
SetLowerLeftCornerOrigin(WOD_segment_date)
Add(WOD_segment_date)
use_mipfilter(WOD_segment_date)
