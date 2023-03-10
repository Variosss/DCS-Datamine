dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

AddRT()

guard_label					= CreateElement "ceStringPoly"
guard_label.name			= "prev_freq_label"
guard_label.material		= "font_ARC210_small"
guard_label.alignment		= "LeftTop"
guard_label.value			= "UHF  GUARD"
guard_label.init_pos		= {0, max_pixels_count_y}
guard_label.stringdefs		= predefined_fonts[1]
SetLowerLeftCornerOrigin(guard_label)
Add(guard_label)
use_mipfilter(guard_label)

freq_label_khz					= CreateElement "ceStringPoly"
freq_label_khz.name				= "freq_label_khz"
freq_label_khz.material			= "font_ARC210_big"
freq_label_khz.alignment		= "RightBottom"
freq_label_khz.value			= "000"
freq_label_khz.init_pos			= {max_pixels_count_x, 0}
freq_label_khz.stringdefs		= predefined_fonts[2]
SetLowerLeftCornerOrigin(freq_label_khz)
Add(freq_label_khz)
use_mipfilter(freq_label_khz)

freq_label_mhz					= CreateElement "ceStringPoly"
freq_label_mhz.name				= "freq_label_mhz"
freq_label_mhz.material			= "font_ARC210_big"
freq_label_mhz.alignment		= "RightBottom"
freq_label_mhz.value			= "243"
freq_label_mhz.init_pos			= {max_pixels_count_x-53, 0}
freq_label_mhz.stringdefs		= predefined_fonts[2]
SetLowerLeftCornerOrigin(freq_label_mhz)
Add(freq_label_mhz)
use_mipfilter(freq_label_mhz)


dot_mark						= CreateElement "ceStringPoly"
dot_mark.name					= "dot_mark_243"
dot_mark.material				= "font_ARC210_big"
dot_mark.alignment				= "RightBottom"
dot_mark.init_pos				= {max_pixels_count_x-105.5, -41.5}
dot_mark.stringdefs				= predefined_fonts[2]
dot_mark.value					= "."
SetLowerLeftCornerOrigin(freq_label_mhz)
Add(dot_mark)
use_mipfilter(dot_mark)

-- TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big")
