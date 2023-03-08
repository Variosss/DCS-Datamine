dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

addPlaceholder("HARM_COMMON_ROOT",nil, nil,{{"WPN_isHarm"}})

add_PB_label(1, "", "HARM_COMMON_ROOT", {{"WPN_HARM_SubmodeLabelShow"}, {"WPN_HARM_ModeLabel"}}, nil, HarmModeLbl)
add_PB_label(2,"TBL1","HARM_COMMON_ROOT",{{"WPN_HARM_HAS_TblLabel"}}, nil, HarmThreatTablesLabel)
add_PB_label(5, "UFC", "HARM_COMMON_ROOT", {{"WPN_HARM_UFC"}}) 			--UFC Threat Table Access 

addPlaceholder("HARM_MODE_SELECT", nil, "HARM_COMMON_ROOT", {{"WPN_HARM_isModeSelect", 1}})
add_Selectable_PB_Label(20, "POS", "HARM_MODE_SELECT", {{"WPN_HARM_ModeSelected", 0, HarmMode.POS}}, {{"WPN_HARM_ModeSelected", 1, HarmMode.POS}})
add_Selectable_PB_Label(19, "HAS", "HARM_MODE_SELECT", {{"WPN_HARM_ModeSelected", 0, HarmMode.HAS}}, {{"WPN_HARM_ModeSelected", 1, HarmMode.HAS}})
add_Selectable_PB_Label(18, "DL", "HARM_MODE_SELECT", {{"WPN_HARM_ModeSelected", 0, HarmMode.DL}}, {{"WPN_HARM_ModeSelected", 1, HarmMode.DL}})

addPlaceholder("HARM_LOADED_STATIONS", nil, "HARM_COMMON_ROOT", {{"WPN_HARM_isLoadedStations_SHOW"}})
addWpnHarmLoadedWeapon("WPN_AG_Harm", "HARM_LOADED_STATIONS", 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addWpnHarmLoadedWeapon("WPN_AG_Harm", "HARM_LOADED_STATIONS", 4, {{"SMS_AG_LoadedWeapon", 4}}, {"SMS_AG_SelectedStation", 4})
addWpnHarmLoadedWeapon("WPN_AG_Harm", "HARM_LOADED_STATIONS", 6, {{"SMS_AG_LoadedWeapon", 6}}, {"SMS_AG_SelectedStation", 6})
addWpnHarmLoadedWeapon("WPN_AG_Harm", "HARM_LOADED_STATIONS", 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

local RDY_PH = addPlaceholder("Weapon_Status_Ready", nil, "HARM_COMMON_ROOT", {{"WPN_HARM_WeaponStatus"}})
addStrokeText("Weapon_Status_Ready_Bottom", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, RDY_PH.name)