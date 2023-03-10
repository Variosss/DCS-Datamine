dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

comsec_mode					= CreateElement "ceStringPoly"
comsec_mode.name			= "comsec_mode"
comsec_mode.material		= "font_ARC210_small"
comsec_mode.alignment		= "LeftTop"
comsec_mode.formats			= {"ANDVT VOICE", "ANDVT DATA", "KY-58 VOICE", "KY-58 DATA", "KG-84 DATA"}
comsec_mode.init_pos		= {0, 50}
comsec_mode.stringdefs		= predefined_fonts[1]
comsec_mode.controllers		= {{"comsec_mode"}}
SetLowerLeftCornerOrigin(comsec_mode)
Add(comsec_mode)
use_mipfilter(comsec_mode)

comsec_submode				= CreateElement "ceStringPoly"
comsec_submode.name			= "comsec_submode"
comsec_submode.material		= "font_ARC210_small"
comsec_submode.alignment	= "LeftTop"
comsec_submode.formats		= {"PT", "CT", "CT-TD"}
comsec_submode.init_pos		= {0, 35}
comsec_submode.stringdefs	= predefined_fonts[1]
comsec_submode.controllers	= {{"comsec_submode"}}
SetLowerLeftCornerOrigin(comsec_submode)
Add(comsec_submode)
use_mipfilter(comsec_submode)

add_static_hint(2, "Cycle COMSEC setting")


ky_submode_label					= CreateElement "ceStringPoly"
ky_submode_label.name				= "ky_submode_label"
ky_submode_label.material			= "font_ARC210_small"
ky_submode_label.alignment			= "LeftBottom"
ky_submode_label.formats			= {"%d"}
ky_submode_label.init_pos			= {0, 2}
ky_submode_label.stringdefs			= predefined_fonts[1]
ky_submode_label.controllers		= {{"ky_submode_avail"}, {"ky_submode"}}
SetLowerLeftCornerOrigin(ky_submode_label)
Add(ky_submode_label)
use_mipfilter(ky_submode_label)

add_osb_hint_controllers(3, "Cycle COMSEC Delay", {{"ky_submode_avail"}})
