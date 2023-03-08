dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_formats_IDs.lua")


add_Selectable_PB_Label(1, "BLANK", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.BLANK}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.BLANK}})
add_Selectable_PB_Label(2, "HAD", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.HAD}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.HAD}})
add_Selectable_PB_Label(4, "RCCE", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.NONE}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.NONE}})
add_Selectable_PB_Label(5, "RESET", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.NONE}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.NONE}})
addStrokeText("MENU_PB_Selectable_Label_NotSelect_5", "MENU", STROKE_FNT_DFLT_10_14, "CenterCenter", {PB_positions[5][1], PB_positions[5][2] - 30})

add_Selectable_PB_Label(6, "SMS", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.SMS}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.SMS}})
add_Selectable_PB_Label(7, "HSD", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.HSD}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.HSD}})
add_Selectable_PB_Label(8, "DTE", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.DTE}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.DTE}})
add_Selectable_PB_Label(9, "TEST", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.TEST}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.TEST}})
add_Selectable_PB_Label(10, "FLCS", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.FLCS}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.FLCS}})

add_Selectable_PB_Label(16, "FLIR", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.NONE}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.NONE}})
add_Selectable_PB_Label(17, "TFR", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.NONE}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.NONE}})
add_Selectable_PB_Label(18, "WPN", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.WPN}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.WPN}})
add_Selectable_PB_Label(19, "TGP", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.TGP}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.TGP}})
add_Selectable_PB_Label(20, "FCR", nil, {{"MENU_SelectLabel", 0, MFD_DISPL_FMT_LEV1.FCR}}, {{"MENU_SelectLabel", 1, MFD_DISPL_FMT_LEV1.FCR}})