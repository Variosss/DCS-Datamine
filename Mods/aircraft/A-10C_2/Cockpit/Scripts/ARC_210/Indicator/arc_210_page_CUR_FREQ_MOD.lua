dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

freq_label_khz					= CreateElement "ceStringPoly"
freq_label_khz.name				= "freq_label_khz"
freq_label_khz.material			= "font_ARC210_big"
freq_label_khz.alignment		= "RightBottom"
freq_label_khz.formats			= {"%03d", "%d  "}
freq_label_khz.init_pos			= {max_pixels_count_x, 0}
freq_label_khz.stringdefs		= predefined_fonts[2]
freq_label_khz.controllers		= {{"indicated_freq_khz"}}
SetLowerLeftCornerOrigin(freq_label_khz)
Add(freq_label_khz)
use_mipfilter(freq_label_khz)

freq_label_mhz					= CreateElement "ceStringPoly"
freq_label_mhz.name				= "freq_label_mhz"
freq_label_mhz.material			= "font_ARC210_big"
freq_label_mhz.alignment		= "RightBottom"
freq_label_mhz.formats			= {"%d"}
freq_label_mhz.init_pos			= {max_pixels_count_x-53, 0}
freq_label_mhz.stringdefs		= predefined_fonts[2]
freq_label_mhz.controllers		= {{"indicated_freq_mhz"}}
SetLowerLeftCornerOrigin(freq_label_mhz)
Add(freq_label_mhz)
use_mipfilter(freq_label_mhz)

dot_mark						= CreateElement "ceStringPoly"
dot_mark.name					= "dot_mark"
dot_mark.material				= "font_ARC210_big"
dot_mark.alignment				= "RightBottom"
dot_mark.init_pos				= {max_pixels_count_x-105.5, -41.5}
dot_mark.stringdefs				= predefined_fonts[2]
dot_mark.value					= "."
SetLowerLeftCornerOrigin(freq_label_mhz)
Add(dot_mark)
use_mipfilter(dot_mark)

prev_manual_freq					= CreateElement "ceStringPoly"
prev_manual_freq.name				= "prev_manual_freq"
prev_manual_freq.material			= "font_ARC210_small"
prev_manual_freq.alignment			= "CenterTop"
prev_manual_freq.formats			= {"%d.", "%03d", "---.---"}
prev_manual_freq.init_pos			= {max_pixels_count_x-72, max_pixels_count_y}
prev_manual_freq.stringdefs			= predefined_fonts[1]
prev_manual_freq.controllers		= {{"prev_manual_freq"}}
SetLowerLeftCornerOrigin(prev_manual_freq)
Add(prev_manual_freq)
use_mipfilter(prev_manual_freq)



-- TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big")

modulation_label				= CreateElement "ceStringPoly"
modulation_label.name			= "modulation_label"
modulation_label.material		= "font_ARC210_small"
modulation_label.alignment		= "RightBottom"
modulation_label.formats		= {"AM", "FM"}
modulation_label.init_pos		= {max_pixels_count_x-23, 25}
modulation_label.stringdefs		= predefined_fonts[1]
modulation_label.controllers	= {{"indicated_modulation"}}
SetLowerLeftCornerOrigin(modulation_label)
Add(modulation_label)
use_mipfilter(modulation_label)
