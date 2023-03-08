dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local function getTextWidth(symbol_num)
	return glyphNominalWidth120 * symbol_num + fontIntercharDflt120 * (symbol_num - 1)
end

local TGT_DATA_BaseName = "TGT_DATA_PAGE_GROUP_"

local box_half_width	= 400
local box_half_height	= 420
local box_pos_y			= -25
local box_width			= box_half_width * 2
local box_height		= box_half_height * 2

local line_space = 46
local column_fm_x	= -box_half_width + 60

-- status box
local line_s1_y = box_pos_y + box_half_height - 87
local line_s2_y = line_s1_y - 72

local column_vcs_x	= column_fm_x + 96
local column_1_x	= column_fm_x + 215
local column_2_x	= column_fm_x + 215 + 32 * 1
local column_3_x	= column_fm_x + 215 + 32 * 2
local column_H_x	= column_fm_x + 215 + 32 * 3
local column_fuel_x	= column_fm_x + 395
local column_rdr_x	= column_fm_x + 510
local column_stat_x	= column_fm_x + 615

addStrokeText(TGT_DATA_BaseName.."LABEL_FM_S",	"FM",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_fm_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_VCS",	"VCS",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_vcs_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_1",		"1",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_1_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_2",		"2",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_2_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_3",		"3",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_3_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_H",		"H",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_H_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_FUEL",	"FUEL",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_fuel_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_RDR",	"RDR",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_rdr_x,	line_s1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_STAT",	"STAT",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_stat_x,	line_s1_y})

local function addMemberStatus(num)
	local placeholder_name = TGT_DATA_BaseName.."STATUS_"..num
	addPlaceholder(placeholder_name, {0, line_s2_y - line_space * num}, nil, {{"MPD_TGT_DATA_GroupMemberShow", num}})

	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_FM_S",	"0",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_fm_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberName", num}}, {"0", "FA", "FB", "FC", "FD"})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_VCS",	"FM0"..num,	STROKE_FNT_DFLT_120, "LeftBottom",	{column_vcs_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberVCS", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_1",	"X",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_1_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberStores1", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_2",	"X",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_2_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberStores2", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_3",	"X",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_3_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberStores3", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_H",	"X",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_H_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberStoresH", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_FUEL",	"XX.X",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_fuel_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberFuel", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_RDR",	"XX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_rdr_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberRDR", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_STAT",	"NOGO",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_stat_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberState", num}}, {"NOGO", "GO"})

	add_X_Over(TGT_DATA_BaseName.."VALUE_RDR_INOPERABLE_"..num, getTextWidth(4), glyphNominalHeight120, {glyphNominalWidth120 + fontIntercharDflt120 / 2, glyphNominalHeight120 / 2}, TGT_DATA_BaseName.."VALUE"..num.."_RDR", {{"MPD_TGT_DATA_GroupMemberInoperableRDR", num}})
end

for i = 0,3 do
	addMemberStatus(i)
end

-- channels box
local line_c1_y = box_pos_y - 87
local line_c2_y = line_c1_y - 72

local column_tn_x	= column_fm_x + 96
local column_aic_x	= column_fm_x + 230
local column_ff1_x	= column_fm_x + 330
local column_ff2_x	= column_fm_x + 435
local column_va_x	= column_fm_x + 535
local column_vb_x	= column_fm_x + 630

addStrokeText(TGT_DATA_BaseName.."LABEL_FM_C",	"FM",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_fm_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_TN",	"TN",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_tn_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_AIC",	"AIC",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_aic_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_FF1",	"FF1",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_ff1_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_FF2",	"FF2",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_ff2_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_VA",	"VA",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_va_x,	line_c1_y})
addStrokeText(TGT_DATA_BaseName.."LABEL_VB",	"VB",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_vb_x,	line_c1_y})

local function addMemberChannels(num)
	local placeholder_name = TGT_DATA_BaseName.."CHANNELS_"..num
	addPlaceholder(placeholder_name, {0, line_c2_y - line_space * num}, nil, {{"MPD_TGT_DATA_GroupMemberShow", num}})

	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_FM_C",	"0",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_fm_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberName", num}}, {"0", "FA", "FB", "FC", "FD"})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_TN",	"XXXXX",	STROKE_FNT_DFLT_120, "LeftBottom",	{column_tn_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberTN", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_AIC",	"XXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_aic_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberAIC", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_FF1",	"XXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_ff1_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberFF1", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_FF2",	"XXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_ff2_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberFF2", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_VA",	"XXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_va_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberVA", num}})
	addStrokeText(TGT_DATA_BaseName.."VALUE"..num.."_VB",	"XXX",		STROKE_FNT_DFLT_120, "LeftBottom",	{column_vb_x,	0}, placeholder_name, {{"MPD_TGT_DATA_GroupMemberVB", num}})
end

for i = 0,3 do
	addMemberChannels(i)
end

