dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")

dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_AAM_Common.lua")

-- OSBs
add_PB_label(1, "MSL")
add_PB_label(4, "INV")

add_Simple_PB_label(7, "", nil, {{"SMS_AA_SelectedWeapon_label"}})
