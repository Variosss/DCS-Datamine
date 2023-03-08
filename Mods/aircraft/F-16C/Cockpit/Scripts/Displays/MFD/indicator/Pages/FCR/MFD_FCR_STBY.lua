dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

--
local FCR_NotModeMenu = addPlaceholder("FCR_NotModeMenu_RootSTBY", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})

-- Menu labels
add_PB_label(1, "STBY", nil, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.STBY}}, {{"FCR_SelectedMode", 1, FCR_SELECT_MODES.STBY}})
add_Selected_PB_Label(4, "OVRD")

add_PB_label(9, "CZ")
