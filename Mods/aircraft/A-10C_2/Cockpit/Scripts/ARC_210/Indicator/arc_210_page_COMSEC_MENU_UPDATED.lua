dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

--AddTextLabel("LOS\nCOMSEC\nPARAMETRS\nUPDATED", "CenterCenter", max_pixels_count_x/2, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")

ky_label					= CreateElement "ceStringPoly"
ky_label.name				= "ky_label"
ky_label.material			= "font_ARC210_small"
ky_label.alignment			= "CenterCenter"
ky_label.formats			= {"LOS\nCOMSEC\nPARAMETRS\nUPDATED", "DAMA\nCOMSEC\nPARAMETRS\nUPDATED"}
ky_label.init_pos			= {max_pixels_count_x/2, max_pixels_count_y/2}
ky_label.stringdefs			= predefined_fonts[1]
ky_label.controllers		= {{"comsec_menu_mode"}}
SetLowerLeftCornerOrigin(ky_label)
Add(ky_label)
use_mipfilter(ky_label)

