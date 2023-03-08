local AA_Misssile =
{
	AIM_9LM	= 1,
	AIM_9X	= 3,
	AIM_120	= 4,
}

-- Common
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 1, {{"SMS_AA_LoadedWeapon", 1}}, {"SMS_AA_SelectedStation", 1})
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 2, {{"SMS_AA_LoadedWeapon", 2}}, {"SMS_AA_SelectedStation", 2})
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 3, {{"SMS_AA_LoadedWeapon", 3}}, {"SMS_AA_SelectedStation", 3})
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 7, {{"SMS_AA_LoadedWeapon", 7}}, {"SMS_AA_SelectedStation", 7})
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 8, {{"SMS_AA_LoadedWeapon", 8}}, {"SMS_AA_SelectedStation", 8})
addSmsAaLoadedWeapon("SMS_AA_Weap", nil, 9, {{"SMS_AA_LoadedWeapon", 9}}, {"SMS_AA_SelectedStation", 9})

-- AIM-9L/M
local AIM9LM_root = addPlaceholder("AIM9LM_Selected", nil, nil, {{"SMS_AA_SelectedWeapon", AA_Misssile.AIM_9LM}})

-- OSBs
add_PB_label(3, "SPOT", AIM9LM_root.name, {{"SMS_AA_Aim9FovOption", 0}}) 
add_PB_label(3, "SCAN", AIM9LM_root.name, {{"SMS_AA_Aim9FovOption", 1}}) 

add_Simple_PB_label(8, "WARM", AIM9LM_root.name, {{"SMS_AA_Aim9LM_CoolingOption", 0}}) 
add_Simple_PB_label(8, "COOL", AIM9LM_root.name, {{"SMS_AA_Aim9LM_CoolingOption", 1}}) 
addFillBox("COOLAim9X_FillBox", 100, 20, 							"Center", {PB_positions[8][1], PB_positions[8][2]}, AIM9LM_root.name, {{"SMS_AA_Aim9X_CoolingOption", 0}})
addBlackBoldText("COOLAim9X_Text", 	"COOL", STROKE_FNT_DFLT_10_14,	"Center", {PB_positions[8][1] - 45, PB_positions[8][2]-7},	AIM9LM_root.name, {{"SMS_AA_Aim9X_CoolingOption", 1}})

add_Simple_PB_label(19, "SLAVE", AIM9LM_root.name, {{"SMS_AA_Aim9LosOption", 0}}) 
add_Simple_PB_label(19, "BORE",  AIM9LM_root.name, {{"SMS_AA_Aim9LosOption", 1}}) 

-- AIM-120B/C
local AIM120_root = addPlaceholder("AIM120_Selected", nil, nil, {{"SMS_AA_SelectedWeapon", AA_Misssile.AIM_120}})

-- OSBs
add_Simple_PB_label(19, "SLAVE", AIM120_root.name, {{"SMS_AA_Aim120LosOption", 0}}) 
add_Simple_PB_label(19, "BORE",  AIM120_root.name, {{"SMS_AA_Aim120LosOption", 1}}) 
