dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local TGT_DATA_BaseName = "TGT_DATA_PAGE_COMMON_"

add_PB_label(16, {"GROUP",	nil, nil, {{"MPD_TGT_DATA_GROUP_Box"}}})
add_PB_label(19, {"GO",		nil, nil, {{"MPD_TGT_DATA_GO_Box"}}})
add_PB_label(20, {"NOGO",	nil, nil, {{"MPD_TGT_DATA_NOGO_Box"}}})

local box_half_width	= 400
local box_half_height	= 420
local box_pos_y			= -25
local box_width			= box_half_width * 2
local box_height		= box_half_height * 2

addStrokeBox(TGT_DATA_BaseName.."Box", box_width, box_height, "CenterCenter", {0, box_pos_y})
addStrokeLine(TGT_DATA_BaseName.."HorizontalDevider", box_width, {-box_half_width, box_pos_y}, -90)