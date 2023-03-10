dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

active_eccm_channel_index				= CreateElement "ceStringPoly"
active_eccm_channel_index.name			= "active_eccm_channel_index"
active_eccm_channel_index.material		= "font_ARC210_big"
active_eccm_channel_index.alignment		= "RightTop"
active_eccm_channel_index.formats		= {"%d"}
active_eccm_channel_index.init_pos		= {max_pixels_count_x-2, max_pixels_count_y-channel_offset}
active_eccm_channel_index.stringdefs	= predefined_fonts[2]
active_eccm_channel_index.controllers	= {{"active_eccm_channel_index"}}
SetLowerLeftCornerOrigin(active_eccm_channel_index)
Add(active_eccm_channel_index)
use_mipfilter(active_eccm_channel_index)

AddTextLabel("NO FILL", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small", {{"active_eccm_channel_type", 0}})

active_eccm_channel_type				= CreateElement "ceStringPoly"
active_eccm_channel_type.name			= "active_eccm_channel_type"
active_eccm_channel_type.material		= "font_ARC210_big"
active_eccm_channel_type.alignment		= "LeftTop"
active_eccm_channel_type.formats		= {"", "HQI", "HQII", " SG", " SG", " SG"}
active_eccm_channel_type.init_pos		= {40, max_pixels_count_y}
active_eccm_channel_type.stringdefs	= predefined_fonts[2]
active_eccm_channel_type.controllers	= {{"active_eccm_channel_type_text"}}
SetLowerLeftCornerOrigin(active_eccm_channel_type)
Add(active_eccm_channel_type)
use_mipfilter(active_eccm_channel_type)


--AddTextLabel("LOAD", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")

HQ_symb				= CreateElement "ceSimple"
HQ_symb.name		= "HQ_symb"
HQ_symb.controllers = {{"active_eccm_channel_type_HQ"}}
SetLowerLeftCornerOrigin(HQ_symb)
Add(HQ_symb)

comsec_mode					= CreateElement "ceStringPoly"
comsec_mode.name			= "comsec_mode"
comsec_mode.material		= "font_ARC210_small"
comsec_mode.alignment		= "LeftTop"
comsec_mode.formats			= {"ANDVT VOICE", "ANDVT DATA", "KY-58 VOICE", "KY-58 DATA", "KG-84 DATA"}
comsec_mode.init_pos		= {0, 50}
comsec_mode.stringdefs		= predefined_fonts[1]
comsec_mode.controllers		= {{"eccm_comsec_avail"}, {"comsec_mode"}}
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
comsec_submode.controllers	= {{"eccm_comsec_avail"}, {"comsec_submode"}}
SetLowerLeftCornerOrigin(comsec_submode)
Add(comsec_submode)
use_mipfilter(comsec_submode)

ky_submode_label					= CreateElement "ceStringPoly"
ky_submode_label.name				= "ky_submode_label"
ky_submode_label.material			= "font_ARC210_small"
ky_submode_label.alignment			= "LeftBottom"
ky_submode_label.formats			= {"%d"}
ky_submode_label.init_pos			= {0, 2}
ky_submode_label.stringdefs			= predefined_fonts[1]
ky_submode_label.controllers		= {{"eccm_comsec_avail"}, {"ky_submode_avail"}, {"ky_submode"}}
SetLowerLeftCornerOrigin(ky_submode_label)
Add(ky_submode_label)
use_mipfilter(ky_submode_label)

active_eccm_channel_HQ_status				= CreateElement "ceStringPoly"
active_eccm_channel_HQ_status.name			= "active_eccm_channel_HQI_status"
active_eccm_channel_HQ_status.material		= "font_ARC210_small"
active_eccm_channel_HQ_status.alignment		= "LeftCenter"
active_eccm_channel_HQ_status.formats		= {"", "NO OPER DAY", "NO TIME", "NO WOD", "NO MWOD", "NO FMT", "INVALID NET ID"}
active_eccm_channel_HQ_status.init_pos		= {0, max_pixels_count_y/2}
active_eccm_channel_HQ_status.stringdefs	= predefined_fonts[1]
active_eccm_channel_HQ_status.controllers	= {{"active_eccm_channel_HQ_status"}}
active_eccm_channel_HQ_status.parent_element	= "HQ_symb"
Add(active_eccm_channel_HQ_status)
use_mipfilter(active_eccm_channel_HQ_status)


net_ID_symbology					= CreateElement "ceSimple"
net_ID_symbology.name				= "net_ID_symbology"
net_ID_symbology.controllers 		= {{"eccm_net_ID_avail"}}
net_ID_symbology.parent_element		= "HQ_symb"
Add(net_ID_symbology)

Net_ID_right_part					= CreateElement "ceStringPoly"
Net_ID_right_part.name				= "Net_ID_right_part"
Net_ID_right_part.material			= "font_ARC210_big"
Net_ID_right_part.alignment			= "RightBottom"
Net_ID_right_part.formats			= {"%03d"}
Net_ID_right_part.init_pos			= {max_pixels_count_x, 0}
Net_ID_right_part.stringdefs		= predefined_fonts[2]
Net_ID_right_part.controllers		= {{"net_ID_right_part"}}
Net_ID_right_part.parent_element	= "net_ID_symbology"
Add(Net_ID_right_part)
use_mipfilter(Net_ID_right_part)

Net_ID_left_part					= CreateElement "ceStringPoly"
Net_ID_left_part.name				= "Net_ID_left_part"
Net_ID_left_part.material			= "font_ARC210_big"
Net_ID_left_part.alignment			= "RightBottom"
Net_ID_left_part.formats			= {"A%02d"}
Net_ID_left_part.init_pos			= {max_pixels_count_x-53, 0}
Net_ID_left_part.stringdefs			= predefined_fonts[2]
Net_ID_left_part.controllers		= {{"net_ID_left_part"}}
Net_ID_left_part.parent_element		= "net_ID_symbology"
Add(Net_ID_left_part)
use_mipfilter(Net_ID_left_part)

--TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big", nil, "net_ID_symbology")

AddTextLabel("AM", "RightBottom", max_pixels_count_x-23, 25, predefined_fonts[1], "font_ARC210_small", nil, "net_ID_symbology")

--------------------------------------------------------------------------
----- SG SYMBOLOGY
--------------------------------------------------------------------------

SG_symb				= CreateElement "ceSimple"
SG_symb.name		= "SG_symb"
SG_symb.controllers = {{"active_eccm_channel_type", 3}}
SetLowerLeftCornerOrigin(SG_symb)
Add(SG_symb)


SG_data						= CreateElement "ceStringPoly"
SG_data.name				= "SG_data"
SG_data.material			= "font_ARC210_big"
SG_data.alignment			= "RightBottom"
SG_data.formats				= {"F%03d"}
SG_data.init_pos			= {max_pixels_count_x-37.3, 0}
SG_data.stringdefs			= predefined_fonts[2]
SG_data.controllers			= {{"SG_symb"}}
SG_data.parent_element		= "SG_symb"
Add(SG_data)
use_mipfilter(SG_data)

top_line_label					= CreateElement "ceStringPoly"
top_line_label.name				= "top_line_label"
top_line_label.material			= "font_ARC210_small"
top_line_label.alignment		= "LeftTop"
top_line_label.formats			= {"LE", "LF%d"}
top_line_label.init_pos			= {0, max_pixels_count_y}
top_line_label.stringdefs		= predefined_fonts[1]
top_line_label.controllers		= {{"eccm_SG_LE_status"}}
top_line_label.parent_element	= "SG_symb"
Add(top_line_label)
use_mipfilter(top_line_label)

--------------------------------------------------------------------------
----- SG COLD START SYMBOLOGY
--------------------------------------------------------------------------

SG_CS_symb				= CreateElement "ceSimple"
SG_CS_symb.name			= "SG_CS_symb"
SG_CS_symb.controllers	= {{"active_eccm_channel_type", 4}}
SetLowerLeftCornerOrigin(SG_CS_symb)
Add(SG_CS_symb)

SG_CS_label_khz					= CreateElement "ceStringPoly"
SG_CS_label_khz.name			= "SG_CS_label_khz"
SG_CS_label_khz.material		= "font_ARC210_big"
SG_CS_label_khz.alignment		= "RightBottom"
SG_CS_label_khz.formats			= {"%03d", "%d  "}
SG_CS_label_khz.init_pos		= {max_pixels_count_x, 0}
SG_CS_label_khz.stringdefs		= predefined_fonts[2]
SG_CS_label_khz.controllers		= {{"SG_CS_freq_khz"}}
SG_CS_label_khz.parent_element	= "SG_CS_symb"
Add(SG_CS_label_khz)
use_mipfilter(SG_CS_label_khz)

SG_CS_label_mhz					= CreateElement "ceStringPoly"
SG_CS_label_mhz.name			= "SG_CS_label_mhz"
SG_CS_label_mhz.material		= "font_ARC210_big"
SG_CS_label_mhz.alignment		= "RightBottom"
SG_CS_label_mhz.formats			= {"%d"}
SG_CS_label_mhz.init_pos		= {max_pixels_count_x-53, 0}
SG_CS_label_mhz.stringdefs		= predefined_fonts[2]
SG_CS_label_mhz.controllers		= {{"SG_CS_freq_mhz"}}
SG_CS_label_mhz.parent_element	= "SG_CS_symb"
Add(SG_CS_label_mhz)
use_mipfilter(SG_CS_label_mhz)

-- TODO: fix this AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big", nil, "SG_CS_symb")

----AddTextLabel("FM", "RightBottom", max_pixels_count_x-23, 25, predefined_fonts[1], "font_ARC210_small", nil, "SG_CS_symb")

AddTextLabel("COLD ST", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small", nil, "SG_CS_symb")

--------------------------------------------------------------------------
----- SG CUE SYMBOLOGY
--------------------------------------------------------------------------
SG_CUE_symb				= CreateElement "ceSimple"
SG_CUE_symb.name		= "SG_CUE_symb"
SG_CUE_symb.controllers	= {{"active_eccm_channel_type", 5}}
SetLowerLeftCornerOrigin(SG_CUE_symb)
Add(SG_CUE_symb)

SG_CUE_label_khz				= CreateElement "ceStringPoly"
SG_CUE_label_khz.name			= "SG_CUE_label_khz"
SG_CUE_label_khz.material		= "font_ARC210_big"
SG_CUE_label_khz.alignment		= "RightBottom"
SG_CUE_label_khz.formats		= {"%03d", "%d  "}
SG_CUE_label_khz.init_pos		= {max_pixels_count_x, 0}
SG_CUE_label_khz.stringdefs		= predefined_fonts[2]
SG_CUE_label_khz.controllers	= {{"SG_CS_freq_khz"}}
SG_CUE_label_khz.parent_element	= "SG_CUE_symb"
Add(SG_CUE_label_khz)
use_mipfilter(SG_CUE_label_khz)
--[[
SG_CUE_label_khz				= CreateElement "ceStringPoly"
SG_CUE_label_khz.name			= "SG_CUE_label_khz"
SG_CUE_label_khz.material		= "font_ARC210_big"
SG_CUE_label_khz.alignment		= "RightBottom"
SG_CUE_label_khz.formats		= {"%d"}
SG_CUE_label_khz.init_pos		= {max_pixels_count_x-53, 0}
SG_CUE_label_khz.stringdefs		= predefined_fonts[2]
SG_CUE_label_khz.controllers	= {{"SG_CS_freq_mhz"}}
SG_CUE_label_khz.parent_element	= "SG_CUE_symb"
Add(SG_CUE_label_khz)
use_mipfilter(SG_CUE_label_khz)]]--

--TODO FIXME AddTextLabel(".", "RightBottom", max_pixels_count_x-42, 0, predefined_fonts[2], "font_ARC210_big", nil, "SG_CUE_symb")

AddTextLabel("FM", "RightBottom", max_pixels_count_x-23, 25, predefined_fonts[1], "font_ARC210_small", nil, "SG_CUE_symb")

SG_CUE_top_line_label					= CreateElement "ceStringPoly"
SG_CUE_top_line_label.name				= "SG_CUE_top_line_label"
SG_CUE_top_line_label.material			= "font_ARC210_small"
SG_CUE_top_line_label.alignment			= "LeftTop"
SG_CUE_top_line_label.formats			= {"CUE ON", "CUE"}
SG_CUE_top_line_label.init_pos			= {0, max_pixels_count_y}
SG_CUE_top_line_label.stringdefs		= predefined_fonts[1]
SG_CUE_top_line_label.controllers		= {{"SG_CUE_status"}}
SG_CUE_top_line_label.parent_element	= "SG_CUE_symb"
Add(SG_CUE_top_line_label)
use_mipfilter(SG_CUE_top_line_label)

add_osb_hint_controllers(1, "CUE ON/OFF", {{"active_eccm_channel_type", 5}})
