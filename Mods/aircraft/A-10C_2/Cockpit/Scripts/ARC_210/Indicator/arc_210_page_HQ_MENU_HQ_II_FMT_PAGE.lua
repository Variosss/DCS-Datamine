dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("LOAD\nHQII FMT", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
add_static_hint(2, "Next Fmt")

HQII_segment					= CreateElement "ceStringPoly"
HQII_segment.name				= "HQII_segment"
HQII_segment.material			= "font_ARC210_big"
HQII_segment.alignment			= "LeftTop"
HQII_segment.formats			= {"%d"}
HQII_segment.init_pos			= {max_pixels_count_x/2, max_pixels_count_y-25}
HQII_segment.stringdefs			= predefined_fonts[2]
HQII_segment.controllers		= {{"HQII_segment"}}
SetLowerLeftCornerOrigin(HQII_segment)
Add(HQII_segment)
use_mipfilter(HQII_segment)

HQII_segment_data_khz				= CreateElement "ceStringPoly"
HQII_segment_data_khz.name			= "HQII_segment_data_khz"
HQII_segment_data_khz.material		= "font_ARC210_big"
HQII_segment_data_khz.alignment		= "RightBottom"
HQII_segment_data_khz.formats		= {"%03d", "%d  "}
HQII_segment_data_khz.init_pos		= {max_pixels_count_x, 0}
HQII_segment_data_khz.stringdefs	= predefined_fonts[2]
HQII_segment_data_khz.controllers	= {{"HQII_segment_data_khz"}}
SetLowerLeftCornerOrigin(HQII_segment_data_khz)
Add(HQII_segment_data_khz)
use_mipfilter(HQII_segment_data_khz)

HQII_segment_data_mhz				= CreateElement "ceStringPoly"
HQII_segment_data_mhz.name			= "HQII_segment_data_mhz"
HQII_segment_data_mhz.material		= "font_ARC210_big"
HQII_segment_data_mhz.alignment		= "RightBottom"
HQII_segment_data_mhz.formats		= {"%d"}
HQII_segment_data_mhz.init_pos		= {max_pixels_count_x-53, 0}
HQII_segment_data_mhz.stringdefs	= predefined_fonts[2]
HQII_segment_data_mhz.controllers	= {{"HQII_segment_data_mhz"}}
SetLowerLeftCornerOrigin(HQII_segment_data_mhz)
Add(HQII_segment_data_mhz)
use_mipfilter(HQII_segment_data_mhz)

-- TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big")
