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

AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big")

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
