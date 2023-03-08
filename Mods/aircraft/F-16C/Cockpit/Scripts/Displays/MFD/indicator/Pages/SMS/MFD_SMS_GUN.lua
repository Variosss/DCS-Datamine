dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

-- Pushbuttons
add_PB_label(1, "GUN")
add_PB_label(2, "", nil, {{"SMS_SubModeLabel"}}, nil, AcftSubModeLbl)
add_PB_label(4, "INV")

local pb6 = add_Simple_PB_label(6, "", nil, {{"SMS_INV_Gun", 0}})
pb6.formats = {"%02dGUN"}

local RDY_PH = addPlaceholder("Weapon_Status_Ready", nil, nil, {{"SMS_WeaponStatus"}})
addStrokeText("Weapon_Status_Ready_Top", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[6][1] - 165, PB_positions[6][2]}, RDY_PH.name)
addStrokeText("Weapon_Status_Ready_Bottom", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, RDY_PH.name)


local Gun_In_AG_Mode = addPlaceholder("Gun_In_AG_Mode", nil, nil, {{"SMS_AG_Gun_In_AG_MasterMode"}})
add_Simple_PB_label(9, "", Gun_In_AG_Mode.name, {{"SMS_AG_Gun_BulletInRangeData"}})

local Gun_In_AA_Mode = addPlaceholder("Gun_In_AA_Mode", nil, nil, {{"SMS_AG_Gun_In_AA_MasterMode"}})
add_Simple_PB_label(20, "", Gun_In_AA_Mode.name, {{"SMS_AG_Gun_ScoreOn"}})