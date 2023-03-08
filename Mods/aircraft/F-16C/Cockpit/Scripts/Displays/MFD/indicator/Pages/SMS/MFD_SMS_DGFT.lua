dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")

dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_AAM_Common.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

-- Pushbuttons
add_PB_label(1, "DGFT")
add_PB_label(2, "", nil, {{"SMS_SubModeLabel"}}, nil, AcftSubModeLbl)
add_PB_label(4, "INV")

local pb6 = add_Simple_PB_label(6, "", nil, {{"SMS_INV_Gun", 0}})
pb6.formats = {"%02dGUN"}
add_Simple_PB_label(7, "", nil, {{"SMS_AA_SelectedWeapon_label"}})

add_Simple_PB_label(20, "", nil, {{"SMS_AG_Gun_ScoreOn"}})