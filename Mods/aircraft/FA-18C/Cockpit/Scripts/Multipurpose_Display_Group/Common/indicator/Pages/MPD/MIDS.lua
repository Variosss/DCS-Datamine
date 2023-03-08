dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local function getTextWidth(symbol_num)
	return glyphNominalWidth120 * symbol_num + fontIntercharDflt120 * (symbol_num - 1)
end

local MIDS_BaseName = "MIDS_PAGE_"
--addStrokeText("Placeholder_FPAS", "FPAS PAGE\nPLACEHOLDER", STROKE_FNT_DFLT_200, "CenterCenter")

--addStrokeLine(name, length, pos, rot, parent, controllers, dashed, stroke, gap, material)
--addStrokeText(name, value, stringdef, align, pos, parent, controllers, formats)
--add_PB_label(PB number, string or table of strings or tables ({"Text", parent, controller, inBox (true or false) or box controller}))

local MenuPageSublevel = 
{
	MIDS_MAIN_MENU_PAGE					= 0,
	MIDS_SUBMENU_USER_TYPE_OPTIONS_PAGE	= 1,
	MIDS_SUBMENU_MODE_OPTIONS_PAGE		= 2,
	MIDS_SUBMENU_NTR_PAGE				= 3,
}

add_PB_label(1,  {"IPF"}, {"EXER", nil, {{"MPD_MIDS_IPF_Mode"}}})
add_PB_label(2,  {"IPF", nil, nil, {{"MPD_MIDS_IPF_Reset_Box"}}}, {"RSET"})
add_PB_label(3,  {"MSTR", nil, nil, {{"MPD_MIDS_Master_Reset_Box"}}}, {"RSET"})
add_PB_label(4,  "")
add_PB_label(5,  {"NAV", nil, nil, {{"MPD_MIDS_NAV_Reset_Box"}}}, {"RSET"})

local Main_Name_6_10 = "MIDS_Main_Root_PB_6_10"
addPlaceholder(Main_Name_6_10, {0, 0}, nil, {{"MPD_MIDS_PB_Label_Main_PB_6_10", MenuPageSublevel.MIDS_MAIN_MENU_PAGE}})
add_PB_label(6, 	{"NONE", Main_Name_6_10, {{"MPD_MIDS_UserTypeOption_Box", 1}}}, {"", Main_Name_6_10, {{"MPD_MIDS_UserTypeOption_Box", 2}}})
add_PB_label(7, 	{"", Main_Name_6_10})
add_PB_label(8, 	{"MODE", Main_Name_6_10}, {"NORM", Main_Name_6_10, {{"MPD_MIDS_ModeOption_Box", 1}}})
add_PB_label(9, 	{"", Main_Name_6_10})
add_PB_label(10, 	{"NTR", Main_Name_6_10, nil, {{"MPD_MIDS_Main_NTR_Box", 0}}})

add_PB_label(11,  {"ENTRY"}, {"NET"})
add_PB_label(12,  {"TIME"}, {"SET"})
add_PB_label(13,  "")
add_PB_label(14,  "")
add_PB_label(15,  "")

add_PB_label(16,  {"RELAY"})
add_PB_label(17,  {"XMIT"}, {"UPPER", nil, {{"MPD_MIDS_XMIT_Antenna"}}})
add_PB_label(19,  {"PWR"}, {"NORM", nil, {{"MPD_MIDS_PowerMode"}}})
add_PB_label(20,  {"O/H OVRD", nil, nil, {{"MPD_MIDS_OH_Ovrd_Box"}}}, {"MIDS"})

----------------------------- USER TYPE OPTIONS -----------------------------
local SelectUserTypeOptions_Name = "MIDS_SelectUserTypeOptions"
addPlaceholder(SelectUserTypeOptions_Name, {0, 0}, nil, {{"MPD_MIDS_PB_Label_Main_PB_6_10", MenuPageSublevel.MIDS_SUBMENU_USER_TYPE_OPTIONS_PAGE}})
add_PB_label(6, {"", SelectUserTypeOptions_Name})
add_PB_label(7, {"PRI", SelectUserTypeOptions_Name, nil, {{"MPD_MIDS_UserTypeOption_Box", 0, 1}}}, {"USER", SelectUserTypeOptions_Name})
add_PB_label(8, {"SEC", SelectUserTypeOptions_Name, nil, {{"MPD_MIDS_UserTypeOption_Box", 0, 2}}}, {"USER", SelectUserTypeOptions_Name})
add_PB_label(9, {"PRINAV", SelectUserTypeOptions_Name, nil, {{"MPD_MIDS_UserTypeOption_Box", 0, 3}}}, {"CNTLR", SelectUserTypeOptions_Name})
add_PB_label(10, {"SECNAV", SelectUserTypeOptions_Name, nil, {{"MPD_MIDS_UserTypeOption_Box", 0, 4}}}, {"CNTLR", SelectUserTypeOptions_Name})

----------------------------- MODE OPTIONS -----------------------------
local SelectModeOptions_Name = "MIDS_SelectModeOptions"
addPlaceholder(SelectModeOptions_Name, {0, 0}, nil, {{"MPD_MIDS_PB_Label_Main_PB_6_10", MenuPageSublevel.MIDS_SUBMENU_MODE_OPTIONS_PAGE}})
add_PB_label(6, {"", SelectModeOptions_Name})
add_PB_label(7, {"", SelectModeOptions_Name})
add_PB_label(8, {"NORM", SelectModeOptions_Name, nil, {{"MPD_MIDS_ModeOption_Box", 0, 0}}})
add_PB_label(9, {"POLL", SelectModeOptions_Name, nil, {{"MPD_MIDS_ModeOption_Box", 0, 1}}})
add_PB_label(10, {"SIL", SelectModeOptions_Name, nil, {{"MPD_MIDS_ModeOption_Box", 0, 2}}})

----------------------------- NTR -----------------------------
local SelectNTR_Name = "MIDS_SelectNTR"
addPlaceholder(SelectNTR_Name, {0, 0}, nil, {{"MPD_MIDS_PB_Label_Main_PB_6_10", MenuPageSublevel.MIDS_SUBMENU_NTR_PAGE}})
add_PB_label(6, {"", SelectNTR_Name})
add_PB_label(7, {"", SelectNTR_Name})
add_PB_label(8, {"", SelectNTR_Name})
add_PB_label(9, {"ENABLE", SelectNTR_Name, {{"MPD_MIDS_Main_NTR_Box", 1}}}, {"NTR", SelectNTR_Name})
add_PB_label(10, {"RETURN", SelectNTR_Name}, {"CNTLR", SelectNTR_Name})

-----------------------------------------------------------------------------------------------------
--------- CHANNELS ----------------------------------------------------------------------------------
addStrokeText(MIDS_BaseName.."TEXT_AIC",		"AIC:",		STROKE_FNT_DFLT_120, "RightBottom",	{-142, 27})
addStrokeText(MIDS_BaseName.."TEXT_FF1",		"F/F 1:",	STROKE_FNT_DFLT_120, "RightBottom",	{-142, -27})
addStrokeText(MIDS_BaseName.."TEXT_VOICE_A",	"VOICE A:",	STROKE_FNT_DFLT_120, "RightBottom",	{-142, -81})
addStrokeText(MIDS_BaseName.."TEXT_FF2",		"F/F 2:",	STROKE_FNT_DFLT_120, "LeftBottom",	{16, -27})
addStrokeText(MIDS_BaseName.."TEXT_VOICE_B",	"VOICE B:",	STROKE_FNT_DFLT_120, "LeftBottom",	{16, -81})

addStrokeText(MIDS_BaseName.."CHAN_AIC",		"127", STROKE_FNT_DFLT_120, "RightBottom",	{-142 + getTextWidth(4), 27},		nil, {{"MPD_MIDS_Channel", 0}})
addStrokeText(MIDS_BaseName.."CHAN_FF1",		"127", STROKE_FNT_DFLT_120, "RightBottom",	{-142 + getTextWidth(4), -27},		nil, {{"MPD_MIDS_Channel", 1}})
addStrokeText(MIDS_BaseName.."CHAN_VOICE_A",	"127", STROKE_FNT_DFLT_120, "RightBottom",	{-142 + getTextWidth(4), -81},		nil, {{"MPD_MIDS_Channel", 3}})
addStrokeText(MIDS_BaseName.."CHAN_FF2",		"127", STROKE_FNT_DFLT_120, "RightBottom",	{16 + getTextWidth(6 + 4), -27},	nil, {{"MPD_MIDS_Channel", 2}})
addStrokeText(MIDS_BaseName.."CHAN_VOICE_B",	"127", STROKE_FNT_DFLT_120, "RightBottom",	{16 + getTextWidth(8 + 4), -81},	nil, {{"MPD_MIDS_Channel", 4}})

-----------------------------------------------------------------------------------------------------
--------- LINES -------------------------------------------------------------------------------------
local function addHorizontalSymmetricLine(name, length, y)
	addStrokeLine(MIDS_BaseName..name, length, {-length / 2, y}, -90)
end

addHorizontalSymmetricLine("TOP_DEVIDER_LINE", 725, -118)
addHorizontalSymmetricLine("BOTTOM_DEVIDER_LINE", 725, -292)

-----------------------------------------------------------------------------------------------------
--------- STATE / DATE / TIME -----------------------------------------------------------------------
addStrokeText(MIDS_BaseName.."TEXT_NET_ENTRY",	"NET ENTRY:",	STROKE_FNT_DFLT_120, "RightBottom",	{25, 341})
addStrokeText(MIDS_BaseName.."TEXT_DATE",		"DATE:",		STROKE_FNT_DFLT_120, "RightBottom",	{-55, 274})
addStrokeText(MIDS_BaseName.."TEXT_TIME",		"TIME:",		STROKE_FNT_DFLT_120, "RightBottom",	{-30, 207})
addStrokeText(MIDS_BaseName.."TEXT_NETWORK",	"NETWORK:",		STROKE_FNT_DFLT_120, "RightBottom",	{10, 140})

addStrokeText(MIDS_BaseName.."DATA_NET_ENTRY",	"",			STROKE_FNT_DFLT_120, "LeftBottom",	{25 + 25, 341}, nil, {{"MPD_MIDS_NetEntry"}}, {"", "NO ENTRY", "CHK TIME", "PENDING", "COARSE", "FINE"})
addStrokeText(MIDS_BaseName.."DATA_DATE",		"XX/XX/XX",	STROKE_FNT_DFLT_120, "LeftBottom",	{-55 + 25, 274}, nil, {{"MPD_MIDS_Date"}})
addStrokeText(MIDS_BaseName.."DATA_TIME",		"XX:XX:XX",	STROKE_FNT_DFLT_120, "LeftBottom",	{-30 + 25, 207}, nil, {{"MPD_MIDS_Time"}})
addStrokeText(MIDS_BaseName.."DATA_NETWORK",	"NET X",	STROKE_FNT_DFLT_120, "LeftBottom",	{10 + 25, 140}, nil, {{"MPD_MIDS_Network"}}, {"NET 1", "NET 2", "NET 3"})

-----------------------------------------------------------------------------------------------------
--------- CAUTIONS ----------------------------------------------------------------------------------
addStrokeText(MIDS_BaseName.."CAUTIONS",	"",	STROKE_FNT_DFLT_120, "LeftBottom",	{-330, -172})
