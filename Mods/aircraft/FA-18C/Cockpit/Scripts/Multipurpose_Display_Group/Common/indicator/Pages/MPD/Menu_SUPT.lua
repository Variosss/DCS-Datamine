dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/display_formats_IDs.lua")

local rootName = "Menu_SUPT"
addPlaceholder(rootName, {0, 0})

add_PB_label(1,  {"ADI", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.ADI}}})
add_PB_label(2,  {"HSI", rootName})
add_PB_label(3,  {"HMD", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.HMD}}})
add_PB_label(6,  {"MIDS", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.MIDS}}})
add_PB_label(8,  {"BIT", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.BIT}}})
add_PB_label(10, {"MUMI", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.MUMI}}})
add_PB_label(11, {"CHKLST", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.CHECKLISTS}}})
add_PB_label(12, {"ENG", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.ENG}}})
add_PB_label(15, {"FCS", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.FCS}}})
add_PB_label(16, {"UFC BU", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.UFC_BU}}})
add_PB_label(19, {"FPAS", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.FPAS}}})
add_PB_label(20, {"FUEL", rootName, {{"MPD_MENU_FormatLabelShow", MDG_DISPL_FMT_LEV1.FUEL}}})

addMenuLabel("SUPT", rootName, nil, true)