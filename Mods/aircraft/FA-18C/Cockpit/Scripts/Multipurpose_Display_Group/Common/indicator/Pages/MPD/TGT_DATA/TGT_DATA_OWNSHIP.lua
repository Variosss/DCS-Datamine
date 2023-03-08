dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local function getTextWidth(symbol_num)
	return glyphNominalWidth120 * symbol_num + fontIntercharDflt120 * (symbol_num - 1)
end

local TGT_DATA_BaseName = "TGT_DATA_PAGE_OWNSHIP_"

add_PB_label(1,		{"CURSOR"}, {"VCS"})
add_PB_symbol(2,	"124-arrow-down")
add_PB_symbol(3,	"124-arrow-up")
add_PB_label(4,		{"ENTER"})
add_PB_label(5,		{"UFC"})
add_PB_label(6,		{"MSNCDR", nil, nil, {{"MPD_TGT_DATA_MSNCDR_Box"}}})
add_PB_label(7,		{"FLTLDR", nil, nil, {{"MPD_TGT_DATA_FLTLDR_Box"}}})
add_PB_label(12,	{"ACTVTY"}, {"RSET"})

local box_half_width	= 400
local box_half_height	= 420
local box_pos_y			= -25
local box_width			= box_half_width * 2
local box_height		= box_half_height * 2

addStrokeLine(TGT_DATA_BaseName.."VerticalDevider", box_height, {0, box_pos_y - box_half_height}, 0)

addStrokeText(TGT_DATA_BaseName.."EMERG_INDICATOR",	"EMERG",	STROKE_FNT_DFLT_120, "LeftBottom",	{-box_half_width + 15, box_pos_y + box_half_height + 15})
addStrokeText(TGT_DATA_BaseName.."EXER_INDICATOR",	"EXER",		STROKE_FNT_DFLT_120, "RightBottom",	{ box_half_width - 15, box_pos_y + box_half_height + 15})

-- status box
local status_label_column_pos_x = -box_half_width / 2 - 10
local status_value_column_pos_x = status_label_column_pos_x + 25
local status_line_space = 41
local statuc_line1_pos_y = box_pos_y + box_half_height - 60
local statuc_line2_pos_y = statuc_line1_pos_y - status_line_space * 1
local statuc_line3_pos_y = statuc_line1_pos_y - status_line_space * 2
local statuc_line4_pos_y = statuc_line1_pos_y - status_line_space * 3
local statuc_line5_pos_y = statuc_line1_pos_y - status_line_space * 4

addStrokeText(TGT_DATA_BaseName.."LABEL_VOICE_CALL_SIGN",	"VC:",		STROKE_FNT_DFLT_120, "RightBottom",	{status_label_column_pos_x, statuc_line1_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_TYPE_AND_MODEL",	"TYPE:",	STROKE_FNT_DFLT_120, "RightBottom",	{status_label_column_pos_x, statuc_line2_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_STRENGTH",			"STRGTH:",	STROKE_FNT_DFLT_120, "RightBottom",	{status_label_column_pos_x, statuc_line3_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_ACTIVITY",			"ACTVTY:",	STROKE_FNT_DFLT_120, "RightBottom",	{status_label_column_pos_x, statuc_line4_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_PRINCIPLE_TN",		"PRI TN:",	STROKE_FNT_DFLT_120, "RightBottom",	{status_label_column_pos_x, statuc_line5_pos_y})

addStrokeText(TGT_DATA_BaseName.."VALUE_VOICE_CALL_SIGN",	"XXXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{status_value_column_pos_x, statuc_line1_pos_y})
addStrokeText(TGT_DATA_BaseName.."VALUE_TYPE_AND_MODEL",	"FA-18C",	STROKE_FNT_DFLT_120, "LeftBottom",	{status_value_column_pos_x, statuc_line2_pos_y})
addStrokeText(TGT_DATA_BaseName.."VALUE_STRENGTH",			"1",		STROKE_FNT_DFLT_120, "LeftBottom",	{status_value_column_pos_x, statuc_line3_pos_y})
addStrokeText(TGT_DATA_BaseName.."VALUE_ACTIVITY",			"XXXXXX",	STROKE_FNT_DFLT_120, "LeftBottom",	{status_value_column_pos_x, statuc_line4_pos_y})
addStrokeText(TGT_DATA_BaseName.."VALUE_PRINCIPLE_TN",		"XXXXX",	STROKE_FNT_DFLT_120, "LeftBottom",	{status_value_column_pos_x, statuc_line5_pos_y})

addStrokeText(TGT_DATA_BaseName.."VALUE_FUEL",		"XX.X",	STROKE_FNT_DFLT_120, "LeftBottom",	{-box_half_width + 15, box_pos_y + 15})
addStrokeText(TGT_DATA_BaseName.."LABEL_FUEL",		"FUEL",	STROKE_FNT_DFLT_120, "LeftBottom",	{-box_half_width + 30 + getTextWidth(4), box_pos_y + 15})
addStrokeText(TGT_DATA_BaseName.."LABEL_GUN",		"GUN",	STROKE_FNT_DFLT_120, "LeftBottom",	{-box_half_width + 45 + getTextWidth(8), box_pos_y + 15})

-- stores box
local stores_column_pos_x = 43
local stores_line_space = 41
local stores_line1_pos_y = box_pos_y + box_half_height - 60
local stores_line2_pos_y = stores_line1_pos_y - stores_line_space * 1
local stores_line3_pos_y = stores_line1_pos_y - stores_line_space * 2
local stores_line4_pos_y = stores_line1_pos_y - stores_line_space * 3
local stores_line5_pos_y = stores_line1_pos_y - stores_line_space * 4

addStrokeText(TGT_DATA_BaseName.."STORE_1",		"X - XXXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{stores_column_pos_x, stores_line1_pos_y})
addStrokeText(TGT_DATA_BaseName.."STORE_2",		"X - XXXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{stores_column_pos_x, stores_line2_pos_y})
addStrokeText(TGT_DATA_BaseName.."STORE_3",		"X - XXXXXX",	STROKE_FNT_DFLT_120, "LeftBottom",	{stores_column_pos_x, stores_line3_pos_y})
addStrokeText(TGT_DATA_BaseName.."STORE_4",		"X - XXXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{stores_column_pos_x, stores_line4_pos_y})
addStrokeText(TGT_DATA_BaseName.."STORE_5",		"X - XXXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{stores_column_pos_x, stores_line5_pos_y})

-- IFF box
local IFF_column_pos_x = 35
local iff_line_space = 45
local IFF_line1_pos_y = box_pos_y - 60
local IFF_line2_pos_y = IFF_line1_pos_y - iff_line_space * 1
local IFF_line3_pos_y = IFF_line1_pos_y - iff_line_space * 2

addStrokeText(TGT_DATA_BaseName.."LABEL_IFF1",	"IFF 1:",	STROKE_FNT_DFLT_120, "LeftBottom",	{IFF_column_pos_x, IFF_line1_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_IFF2",	"IFF 2:",	STROKE_FNT_DFLT_120, "LeftBottom",	{IFF_column_pos_x, IFF_line2_pos_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_IFF3",	"IFF 3:",	STROKE_FNT_DFLT_120, "LeftBottom",	{IFF_column_pos_x, IFF_line3_pos_y})

