dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

------------------------------------------------------------------ BOMB ------------------------------------------------------------------
local bomb_root = addPlaceholder("BOMB_ROOT", nil, nil, {{"SMS_AG_isBomb"}})
add_Selectable_PB_Label(5, "CNTL", bomb_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})

------------------------------------------------------------- BOMB MODE SELECT------------------------------------------------------------
local bombModeSelect_root = addPlaceholder("BOMB_MODE_SELECT", nil, bomb_root.name, {{"SMS_AG_Bomb_isModeSelect", 1}, {"SMS_AG_CNTL_Page", 0}})
add_Selectable_PB_Label(16, "MAN",  bombModeSelect_root.name, {{"SMS_AG_BombModeSelected", 0, AcftSubMode.MAN}}, {{"SMS_AG_BombModeSelected", 1, AcftSubMode.MAN}})
add_Selectable_PB_Label(17, "LADD", bombModeSelect_root.name, {{"SMS_AG_BombModeSelected", 0, AcftSubMode.LADD}}, {{"SMS_AG_BombModeSelected", 1, AcftSubMode.LADD}})
add_Selectable_PB_Label(18, "DTOS", bombModeSelect_root.name, {{"SMS_AG_BombModeSelected", 0, AcftSubMode.DTOS}}, {{"SMS_AG_BombModeSelected", 1, AcftSubMode.DTOS}})
add_Selectable_PB_Label(19, "CCRP", bombModeSelect_root.name, {{"SMS_AG_BombModeSelected", 0, AcftSubMode.CCRP}}, {{"SMS_AG_BombModeSelected", 1, AcftSubMode.CCRP}})
add_Selectable_PB_Label(20, "CCIP", bombModeSelect_root.name, {{"SMS_AG_BombModeSelected", 0, AcftSubMode.CCIP}}, {{"SMS_AG_BombModeSelected", 1, AcftSubMode.CCIP}})

---------------------------------------------------------------- BOMB PAGE ---------------------------------------------------------------
local bombPage_root = addPlaceholder("BOMB_PAGE", nil, bomb_root.name, {{"SMS_AG_Bomb_isModeSelect", 0}, {"SMS_AG_CNTL_Page", 0}})

add_Simple_PB_label(7,  nil, bombPage_root.name, {{"SMS_AG_Bomb_Profile"}})
add_Simple_PB_label(8,  nil, bombPage_root.name, {{"SMS_AG_Bomb_ReleaseOption"}})
add_Simple_PB_label(9,  nil, bombPage_root.name, {{"SMS_AG_Bomb_ImpactSeparationDistance"}})
add_Simple_PB_label(10, nil, bombPage_root.name, {{"SMS_AG_Bomb_ReleasePulses"}})
add_Simple_PB_label(18, nil, bombPage_root.name, {{"SMS_AG_Bomb_FuseArming"}})

local stringOffset = 25
addStrokeText("Arming_Delay", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, stringOffset}, bombPage_root.name, {{"SMS_AG_Bomb_ArmingDelay"}})
addStrokeText("Burst_Altitude", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 0}, bombPage_root.name, {{"SMS_AG_Bomb_BurstAltitude"}})
addStrokeText("Release_Angle", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -stringOffset}, bombPage_root.name, {{"SMS_AG_Bomb_ReleaseAngle"}})

local LADDSymbology_Root = addPlaceholder("LADDSymbology_Root", nil, bombPage_root.name, {{"SMS_AG_Bomb_LADDSymbology_Show"}})
	addStrokeText("PR", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -2*stringOffset}, LADDSymbology_Root.name, {{"SMS_AG_Bomb_LADD_PR"}}, {"PR  %2d00FT"})
	addStrokeText("TOF", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -3*stringOffset}, LADDSymbology_Root.name, {{"SMS_AG_Bomb_LADD_TOF"}}, {"TOF %.02fSEC"})
	addStrokeText("MRA", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -4*stringOffset}, LADDSymbology_Root.name, {{"SMS_AG_Bomb_LADD_MRA"}}, {"MRA %3dFT"})

------------------------------------------------------------ BOMB CONTROL PAGE -----------------------------------------------------------
local BombCntlPage_root = addPlaceholder("BOMB_CNTL_PAGE", nil, bomb_root.name, {{"SMS_AG_CNTL_Page", 1}})
add_Selectable_PB_Label(20, "C1", BombCntlPage_root.name, {{"SMS_AG_Bomb_CntlC1", 0}}, {{"SMS_AG_Bomb_CntlC1", 1}}, nil, true)
add_Selectable_PB_Label(19, "C2", BombCntlPage_root.name, {{"SMS_AG_Bomb_CntlC2", 0}}, {{"SMS_AG_Bomb_CntlC2", 1}}, nil, true)
add_Selectable_PB_Label(18, "C3", BombCntlPage_root.name, {{"SMS_AG_Bomb_CntlC3", 0}}, {{"SMS_AG_Bomb_CntlC3", 1}}, nil, true)
add_Selectable_PB_Label(17, "C4", BombCntlPage_root.name, {{"SMS_AG_Bomb_CntlC4", 0}}, {{"SMS_AG_Bomb_CntlC4", 1}}, nil, true)
add_Selectable_PB_Label(6, "LADD", BombCntlPage_root.name, {{"SMS_AG_Bomb_CntlLADD", 0}}, {{"SMS_AG_Bomb_CntlLADD", 1}}, nil, true)

addStrokeSelectableText("C1 AD", "AD", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[20][1] + 40, PB_positions[20][2] + 10}, BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C1_AD_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C1_AD_SEL", 1}})
addStrokeText("C1 AD Data",  nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[20][1] + 40, PB_positions[20][2] + 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C1_AD"}}, 	{"    %.02fSEC"})
addStrokeSelectableText("C1 AD2", "AD2", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[20][1] + 40, PB_positions[20][2] - 10}, BombCntlPage_root.name,  {{"SMS_AG_Bomb_Cntl_C1_AD2_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C1_AD2_SEL", 1}})
addStrokeText("C1 AD2 Data", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[20][1] + 40, PB_positions[20][2] - 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C1_AD2"}}, 	{"    %.02fSEC"})


addStrokeSelectableText("C2 AD", "AD", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[19][1] + 40, PB_positions[19][2] + 10}, BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C2_AD_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C2_AD_SEL", 1}})
addStrokeText("C2 AD Data", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[19][1] + 40, PB_positions[19][2] + 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C2_AD"}}, 	{"    %.02fSEC"})
addStrokeText("C2 BA",  nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[19][1] + 40, PB_positions[19][2] - 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C2_BA"}}, 	{"BA  %3dFT"})

addStrokeSelectableText("C3 AD", "AD", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[18][1] + 40, PB_positions[18][2] + 10}, BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C3_AD_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C3_AD_SEL", 1}})
addStrokeText("C3 AD Data", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[18][1] + 40, PB_positions[18][2] + 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C3_AD"}}, 	{"    %.02fSEC"})
addStrokeText("C3 BA",  nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[18][1] + 40, PB_positions[18][2] - 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C3_BA"}}, 	{"BA  %3dFT"})

addStrokeSelectableText("C4 AD1", "AD1", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[17][1] + 40, PB_positions[17][2] + 10}, BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C4_AD1_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C4_AD1_SEL", 1}})
addStrokeText("C4 AD1 Data", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[17][1] + 40, PB_positions[17][2] + 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C4_AD1"}}, 	{"AD1 %.02fSEC"})
addStrokeSelectableText("C4 AD2", "AD2", STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[17][1] + 40, PB_positions[17][2] - 10}, BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C4_AD2_SEL", 0}}, {{"SMS_AG_Bomb_Cntl_C4_AD2_SEL", 1}})
addStrokeText("C4 AD2 Data", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[17][1] + 40, PB_positions[17][2] - 10},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C4_AD2"}}, 	{"AD2 %.02fSEC"})
addStrokeText("C4 BA",  nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[17][1] + 40, PB_positions[17][2] - 30},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_C4_BA"}}, 	{"BA  %3dFT"})

addStrokeText("LADD PR", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[6][1] - 200, PB_positions[6][2] + 20},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_LADD_PR"}},  {"PR  %2d00FT"})
addStrokeText("LADD TOF", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[6][1] - 200, PB_positions[6][2]},		BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_LADD_TOF"}}, {"TOF %.02fSEC"})
addStrokeText("LADD MRA", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[6][1] - 200, PB_positions[6][2] - 20},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_LADD_MRA"}}, {"MRA %3dFT"})

addStrokeText("REL ANG", 	nil, STROKE_FNT_DFLT_10_14, "RightCenter", {PB_positions[10][1], PB_positions[10][2]},	BombCntlPage_root.name, {{"SMS_AG_Bomb_Cntl_REL_ANG"}})
----------------------------------------------------------------- ROCKET -----------------------------------------------------------------
local rocket_root = addPlaceholder("ROCKET_ROOT", nil, nil, {{"SMS_AG_isRocket"}})
----------------------------------------------------------------- ROCKET MODE SELECT------------------------------------------------------
local rocketModeSelect_root = addPlaceholder("ROCKET_MODE_SELECT", nil, rocket_root.name, {{"SMS_AG_Rocket_isModeSelect", 1}, {"SMS_AG_CNTL_Page", 0}})
add_Selectable_PB_Label(19, "MAN",  rocketModeSelect_root.name, {{"SMS_AG_RocketModeSelected", 0, AcftSubMode.MAN}}, {{"SMS_AG_RocketModeSelected", 1, AcftSubMode.MAN}})
add_Selectable_PB_Label(20, "CCIP", rocketModeSelect_root.name, {{"SMS_AG_RocketModeSelected", 0, AcftSubMode.CCIP}}, {{"SMS_AG_RocketModeSelected", 1, AcftSubMode.CCIP}})
----------------------------------------------------------------- ROCKET PAGE-------------------------------------------------------------
local rocketPage_root = addPlaceholder("ROCKET_PAGE", nil, rocket_root.name, {{"SMS_AG_Rocket_isModeSelect", 0}, {"SMS_AG_CNTL_Page", 0}})
add_Simple_PB_label(8, nil, rocketPage_root.name, {{"SMS_AG_Rocket_ReleaseOption"}})
----------------------------------------------------------------- MAVERICK ---------------------------------------------------------------
local maverick_root = addPlaceholder("MAVERICK_ROOT", nil, nil, {{"SMS_AG_isMaverick"}})
add_Selectable_PB_Label(5, "CNTL", maverick_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})

-------------------------------------------------------------- MAVERICK PAGE -------------------------------------------------------------
local maverickPage_root = addPlaceholder("MAVERICK_PAGE", nil, maverick_root.name, {{"SMS_AG_CNTL_Page", 0}})

add_Simple_PB_label(7,  "", maverickPage_root.name, {{"SMS_AG_Maverick_Power"}})
add_Simple_PB_label(8,  "", maverickPage_root.name, {{"SMS_AG_Maverick_ReleasePulses"}})
add_Simple_PB_label(19, "STEP", maverickPage_root.name, {{"SMS_AG_Maverick_MissileStep"}})

addSmsAgLoadedWeapon("SMS_AG_Mav", maverickPage_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addSmsAgLoadedWeapon("SMS_AG_Mav", maverickPage_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

------------------------------------------------------------ MAVERICK CNTL PAGE ----------------------------------------------------------
local maverickCntlPage_root = addPlaceholder("MAVERICK_CNTL_PAGE", nil, maverick_root.name, {{"SMS_AG_CNTL_Page", 1}})

add_Simple_PB_label(7,  "", maverickCntlPage_root.name, {{"SMS_AG_MAV_CNTL_AutoPwr"}})
add_Simple_PB_label(19, "", maverickCntlPage_root.name, {{"SMS_AG_MAV_CNTL_AutoStptNum"}}, nil, {"STPT %d"})
add_Simple_PB_label(20, "", maverickCntlPage_root.name, {{"SMS_AG_MAV_CNTL_AutoRelPos"}}, nil, {"NORTH OF", "EAST OF", "SOUTH OF", "WEST OF"})

------------------------------------------------------------------ HARM ------------------------------------------------------------------
local harm_root = addPlaceholder("HARM_ROOT", nil, nil, {{"SMS_AG_isHarm"}})
add_Simple_PB_label(7, nil, harm_root.name, {{"SMS_AG_Harm_Power"}})
add_Simple_PB_label(8, nil, harm_root.name, {{"SMS_AG_Harm_BIT"}})

addSmsAgLoadedWeapon("SMS_AG_Harm", harm_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addSmsAgLoadedWeapon("SMS_AG_Harm", harm_root.name, 4, {{"SMS_AG_LoadedWeapon", 4}}, {"SMS_AG_SelectedStation", 4})
addSmsAgLoadedWeapon("SMS_AG_Harm", harm_root.name, 6, {{"SMS_AG_LoadedWeapon", 6}}, {"SMS_AG_SelectedStation", 6})
addSmsAgLoadedWeapon("SMS_AG_Harm", harm_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

------------------------------------------------------------------ JDAM ------------------------------------------------------------------
local jdam_root = addPlaceholder("JDAM_ROOT", nil, nil, {{"SMS_AG_isJDAM"}})
add_Selectable_PB_Label(5, "CNTL", jdam_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})

--local RDY_PH = addPlaceholder("JDAM_Status", nil, jdam_root.name, {{"SMS_JDAMStatus"}})
	addStrokeText("Weapon_Status_Top", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[6][1] - 165, PB_positions[6][2]},jdam_root.name, {{"SMS_JDAMStatus", 0}})
	addStrokeText("Weapon_Status_Bottom", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, jdam_root.name, {{"SMS_JDAMStatus", 1}})

------------------------------------------------------------------ JDAM PAGE -------------------------------------------------------------
local JDAMPage_root = addPlaceholder("JDAM_PAGE", nil, jdam_root.name, {{"SMS_AG_CNTL_Page", 0}})
add_Simple_PB_label(2,"PRE",JDAMPage_root.name,{{"SMS_AG_JDAM_MODE"}}, nil, JDAMSubModesLabel)
add_Simple_PB_label(7, nil, JDAMPage_root.name, {{"SMS_AG_JDAM_Power"}})
add_Simple_PB_label(8, nil, JDAMPage_root.name, {{"SMS_AG_JDAM_BIT"}})
add_Simple_PB_label(20, nil, JDAMPage_root.name, {{"SMS_AG_JDAM_PROG"}})
addSmsAgLoadedWeapon("SMS_AG_JDAM", JDAMPage_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addSmsAgLoadedWeapon("SMS_AG_JDAM", JDAMPage_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

addStrokeText("JDAM_Arming_Delay", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 100}, JDAMPage_root.name, 		{{"SMS_AG_JDAM_ImpactInformation", 0}}, {"AD %.02fSEC"})
addStrokeText("JDAM_Function_Delay", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 50}, JDAMPage_root.name,  		{{"SMS_AG_JDAM_ImpactInformation", 1}}, {"FD %.02f%s"})
addStrokeText("JDAM_Impact_Angle", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 0}, JDAMPage_root.name, 		{{"SMS_AG_JDAM_ImpactInformation", 2}}, {"IMP ANG %d°"})
addStrokeText("JDAM_Impact_Azimuth", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -50}, JDAMPage_root.name, 		{{"SMS_AG_JDAM_ImpactInformation", 3}}, {"IMP AZ %d°"})
addStrokeText("JDAM_Impact_Velocity",nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -100}, JDAMPage_root.name, 	{{"SMS_AG_JDAM_ImpactInformation", 4}}, {"IMP VEL %d"})

------------------------------------------------------------ JDAM CNTL PAGE --------------------------------------------------------------
local JDAMCntlPage_root = addPlaceholder("JDAM_CNTL_PAGE", nil, jdam_root.name, {{"SMS_AG_CNTL_Page", 1}})

add_Simple_PB_label(20, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 20}})
add_Simple_PB_label(19, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 19}})
add_Simple_PB_label(18, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 18}})
add_Simple_PB_label(17, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 17}})
add_Simple_PB_label(8, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 8}})
add_Simple_PB_label(7, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 7}})
add_Simple_PB_label(6, nil, JDAMCntlPage_root.name, {{"SMS_AG_JDAM_CntlPageLabels", 6}})

------------------------------------------------------------------ JSOW -------------------------------------------------------------
local jsow_root = addPlaceholder("JSOW_ROOT", nil, nil, {{"SMS_AG_isJSOW"}})
	add_Selectable_PB_Label(5, "CNTL", jsow_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})
	addStrokeText("Weapon_Status_JSOW_Top", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[6][1] - 165, PB_positions[6][2]},jsow_root.name, {{"SMS_JDAMStatus", 0}})
	addStrokeText("Weapon_Status_JSOW_Bottom", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, jsow_root.name, {{"SMS_JDAMStatus", 1}})

------------------------------------------------------------------ JSOW PAGE -------------------------------------------------------------
local JSOWPage_root = addPlaceholder("JSOW_PAGE", nil, jsow_root.name, {{"SMS_AG_CNTL_Page", 0}})
	add_Simple_PB_label(2,"PRE",JSOWPage_root.name,{{"SMS_AG_JSOW_MODE"}}, nil, JSOWSubModesLabel)
	add_Simple_PB_label(7, nil, JSOWPage_root.name, {{"SMS_AG_JSOW_Power"}})
	add_Simple_PB_label(8, nil, JSOWPage_root.name, {{"SMS_AG_JSOW_BIT"}})
	add_Simple_PB_label(18, nil, JSOWPage_root.name, {{"SMS_AG_JSOW_ImpactSpacing"}})
	add_Simple_PB_label(20, nil, JSOWPage_root.name, {{"SMS_AG_JSOW_TargetType"}})
	addSmsAgLoadedWeapon("SMS_AG_JSOW", JSOWPage_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
	addSmsAgLoadedWeapon("SMS_AG_JSOW", JSOWPage_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})
	
addStrokeText("JSOW_Attack_Azimuth", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 0}, JSOWPage_root.name, 		{{"SMS_AG_JSOW_ImpactInformation", 0}}, {"ATK AZ %d°"})
addStrokeText("JDAM_EGEA", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -50}, JSOWPage_root.name, 				{{"SMS_AG_JSOW_ImpactInformation", 1}}, {"EGEA %d FT"})
addStrokeText("JDAM_ROB", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, -100}, JSOWPage_root.name, 				{{"SMS_AG_JSOW_ImpactInformation", 2}}, {"ROB %.01f NM"})

local Impact_option = addPlaceholder("Impact_option_PH", {PB_positions[19][1] + 8 , (PB_positions[19][2] - PB_positions[18][2]) / 2 + PB_positions[18][2]}, JSOWPage_root.name)
local JSOW_IO_Offset = 35
local JSOW_IO_SymbolScale = 3.5
	local Single_PH = addPlaceholder("Single_PH", {0,0}, Impact_option.name, {{"SMS_AG_JSOW_ImpactOption", 0}})
		local Single = addStrokeSymbol("Single_triangle", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, JSOW_IO_Offset}, Single_PH.name, nil, JSOW_IO_SymbolScale)
		Single.init_rot = {180}
	local Tandem_PH = addPlaceholder("Tandem_PH", {0,0}, Impact_option.name, {{"SMS_AG_JSOW_ImpactOption", 1}})
		local Tandem_1 = addStrokeSymbol("Tandem_triangle_1", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, JSOW_IO_Offset}, Tandem_PH.name, nil, JSOW_IO_SymbolScale)
		local Tandem_2 = addStrokeSymbol("Tandem_triangle_2", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, JSOW_IO_Offset/2}, Tandem_PH.name, nil, JSOW_IO_SymbolScale)
		Tandem_1.init_rot = {180}
		Tandem_2.init_rot = {180}
	local SBS_PH = addPlaceholder("SBS_PH", {0,0}, Impact_option.name, {{"SMS_AG_JSOW_ImpactOption", 2}})
		local SBS_1 = addStrokeSymbol("SBS_triangle_1", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, JSOW_IO_Offset}, SBS_PH.name, nil, JSOW_IO_SymbolScale)
		local SBS_2 = addStrokeSymbol("SBS_triangle_2", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {JSOW_IO_Offset, JSOW_IO_Offset}, SBS_PH.name, nil, JSOW_IO_SymbolScale)
		SBS_1.init_rot = {180}
		SBS_2.init_rot = {180}
------------------------------------------------------------ JSOW CNTL PAGE --------------------------------------------------------------
local JSOWCntlPage_root = addPlaceholder("JSOW_CNTL_PAGE", nil, jsow_root.name, {{"SMS_AG_CNTL_Page", 1}})
	add_Simple_PB_label(18, nil, JSOWCntlPage_root.name, {{"SMS_AG_JSOW_CntlPageLabels", 18}},nil, {"ROB \n%.01f NM"})
	add_Simple_PB_label(19, nil, JSOWCntlPage_root.name, {{"SMS_AG_JSOW_CntlPageLabels", 19}},nil, {"EGEA \n%d FT"})
	add_Simple_PB_label(20, nil, JSOWCntlPage_root.name, {{"SMS_AG_JSOW_CntlPageLabels", 20}},nil, {"ATK AZ \n%d°"})

------------------------------------------------------------------ WCMD ------------------------------------------------------------------
local wcmd_root = addPlaceholder("WCMD_ROOT", nil, nil, {{"SMS_AG_isWCMD"}})
	add_Selectable_PB_Label(5, "CNTL", wcmd_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})
	addStrokeText("Weapon_Status_WCMD_Top", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[6][1] - 165, PB_positions[6][2]},wcmd_root.name, {{"SMS_JDAMStatus", 0}})
	addStrokeText("Weapon_Status_WCMD_Bottom", "", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, wcmd_root.name, {{"SMS_JDAMStatus", 1}})

------------------------------------------------------------------ WCMD PAGE -------------------------------------------------------------
local WCMDPage_root = addPlaceholder("WCMD_PAGE", nil, wcmd_root.name, {{"SMS_AG_CNTL_Page", 0}})
	add_Simple_PB_label(2,"PRE",WCMDPage_root.name,{{"SMS_AG_WCMD_MODE"}}, nil, WCMDSubModesLabel)
	add_Simple_PB_label(7, nil, WCMDPage_root.name, {{"SMS_AG_WCMD_Power"}})
	add_Simple_PB_label(8, nil, WCMDPage_root.name, {{"SMS_AG_WCMD_BIT"}})
	add_Simple_PB_label(18, nil, WCMDPage_root.name, {{"SMS_AG_WCMD_ImpactSpacing"}})
	
	addSmsAgLoadedWeapon("SMS_AG_WCMD", WCMDPage_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
	addSmsAgLoadedWeapon("SMS_AG_WCMD", WCMDPage_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})
	
	addStrokeText("WCMD_Attack_Azimuth", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 0}, WCMDPage_root.name, 		{{"SMS_AG_WCMD_ImpactInformation", 0}}, {"ATK AZ %d°"})
	addStrokeText("WCMD_Burst_Altitude", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 25}, WCMDPage_root.name, 		{{"SMS_AG_WCMD_ImpactInformation", 1}}, {"BA %dFT"})
	addStrokeText("WCMD_Arming_Delay", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 50}, WCMDPage_root.name, 		{{"SMS_AG_WCMD_ImpactInformation", 2}}, {"AD %.02fSEC"})
	addStrokeText("WCMD_Spin_Speed", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 75}, WCMDPage_root.name, 			{{"SMS_AG_WCMD_ImpactInformation", 3}}, {"SPIN %dRPM"})
	addStrokeText("WCMD_Target_Wind", nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 100}, WCMDPage_root.name, 		{{"SMS_AG_WCMD_ImpactInformation", 4}}, {"TGT WD %d/%d%s"})
	
local Impact_option_WCMD = addPlaceholder("Impact_option_WCMD_PH", {PB_positions[19][1] + 8 , (PB_positions[19][2] - PB_positions[18][2]) / 2 + PB_positions[18][2]}, WCMDPage_root.name)
local WCMD_IO_Offset = 35
local WCMD_IO_SymbolScale = 3.5
	local Single_WCMD_PH = addPlaceholder("Single_WCMD_PH", {0,0}, Impact_option_WCMD.name, {{"SMS_AG_WCMD_ImpactOption", 0}})
		local Single_WCMD = addStrokeSymbol("Single_WCMD_triangle", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, WCMD_IO_Offset}, Single_WCMD_PH.name, nil, WCMD_IO_SymbolScale)
		Single_WCMD.init_rot = {180}
	local Tandem_WCMD_PH = addPlaceholder("Tandem_WCMD_PH", {0,0}, Impact_option_WCMD.name, {{"SMS_AG_WCMD_ImpactOption", 1}})
		local Tandem_WCMD_1 = addStrokeSymbol("Tandem_WCMD_triangle_1", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, WCMD_IO_Offset}, Tandem_WCMD_PH.name, nil, WCMD_IO_SymbolScale)
		local Tandem_WCMD_2 = addStrokeSymbol("Tandem_WCMD_triangle_2", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, WCMD_IO_Offset/2}, Tandem_WCMD_PH.name, nil, WCMD_IO_SymbolScale)
		Tandem_WCMD_1.init_rot = {180}
		Tandem_WCMD_2.init_rot = {180}
	local SBS_WCMD_PH = addPlaceholder("SBS_WCMD_PH", {0,0}, Impact_option_WCMD.name, {{"SMS_AG_WCMD_ImpactOption", 2}})
		local SBS_WCMD_1 = addStrokeSymbol("SBS_WCMD_triangle_1", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, WCMD_IO_Offset}, SBS_WCMD_PH.name, nil, WCMD_IO_SymbolScale)
		local SBS_WCMD_2 = addStrokeSymbol("SBS_WCMD_triangle_2", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {WCMD_IO_Offset, WCMD_IO_Offset}, SBS_WCMD_PH.name, nil, WCMD_IO_SymbolScale)
		SBS_WCMD_1.init_rot = {180}
		SBS_WCMD_2.init_rot = {180}

------------------------------------------------------------ WCMD CNTL PAGE --------------------------------------------------------------
local WCMDCntlPage_root = addPlaceholder("WCMD_CNTL_PAGE", nil, wcmd_root.name, {{"SMS_AG_CNTL_Page", 1}})
	add_Simple_PB_label(6, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 6}},nil, {"TGT WD\n%d  %dKTS"})
	add_Simple_PB_label(7, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 7}},nil, {"WD SOURCE\n%s"})
	add_Simple_PB_label(17, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 17}},nil, {"SPIN\n%dRPM"})
	add_Simple_PB_label(18, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 18}},nil, {"BA %dFT"})
	add_Simple_PB_label(19, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 19}},nil, {"AD %.02fSEC"})
	add_Simple_PB_label(20, nil, WCMDCntlPage_root.name, {{"SMS_AG_WCMD_CntlPageLabels", 20}},nil, {"ATK AZ \n%d°"})
	
	------------------------------------------------------------------ GBU24 ------------------------------------------------------------------
local GBU24_root = addPlaceholder("GBU24_ROOT", nil, nil, {{"SMS_AG_isGBU24"}})
add_Selectable_PB_Label(5, "CNTL", GBU24_root.name, {{"SMS_AG_CNTL_Page", 0}}, {{"SMS_AG_CNTL_Page", 1}})
	
------------------------------------------------------------------ GBU24 PAGE -------------------------------------------------------------
local GBU24Page_root = addPlaceholder("GBU24_PAGE", nil, GBU24_root.name, {{"SMS_AG_CNTL_Page", 0}})
add_Simple_PB_label(2,"PRE", GBU24Page_root.name,{{"SMS_AG_GBU24_MODE"}}, nil, GBU24SubModesLabel)
add_Simple_PB_label(7,  nil, GBU24Page_root.name, {{"SMS_AG_GBU24_PROG"}})
add_Simple_PB_label(8,  nil, GBU24Page_root.name, {{"SMS_AG_GBU24_ReleaseOption"}})
add_Simple_PB_label(9, 	nil, GBU24Page_root.name, {{"SMS_AG_GBU24_Ripple_Release_Interval"}})
add_Simple_PB_label(10, nil, GBU24Page_root.name, {{"SMS_AG_Bomb_ReleasePulses"}})
add_Simple_PB_label(17, "AD/BA", GBU24Page_root.name)
add_Simple_PB_label(18, nil, GBU24Page_root.name, {{"SMS_AG_GBU24_FuseArming"}})
add_Simple_PB_label(19, "MODE\n2", GBU24Page_root.name)
add_Simple_PB_label(20, "RBS", GBU24Page_root.name)

addStrokeText("GBU24_CUE_RNG", 			nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 100}, GBU24Page_root.name,  {{"SMS_AG_GBU24_ImpactInformation", 0}}, {"CUE RNG %.02f%sNM"})
addStrokeText("GBU24_Arming_Delay", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 50}, GBU24Page_root.name, 	{{"SMS_AG_GBU24_ImpactInformation", 1}}, {"AD %.02fSEC"})
addStrokeText("GBU24_Release_Angle", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {-75, 0}, GBU24Page_root.name, 	{{"SMS_AG_GBU24_ImpactInformation", 2}}, {"REL ANG %d°"})
------------------------------------------------------------ GBU24 CNTL PAGE --------------------------------------------------------------
local GBU24CntlPage_root = addPlaceholder("GBU24_CNTL_PAGE", nil, GBU24_root.name, {{"SMS_AG_CNTL_Page", 1}})

add_PB_label(3, "SIM\nFLT", GBU24CntlPage_root.name)
addStrokeText("GBU24_TOF", 	nil, STROKE_FNT_DFLT_10_14, "LeftCenter", {PB_positions[6][1] - 220, PB_positions[6][2]}, GBU24CntlPage_root.name,  {{"SMS_AG_GBU24_CntlPageLabels", 0}})
add_Simple_PB_label(9, nil, GBU24CntlPage_root.name, {{"SMS_AG_GBU24_CntlPageLabels", 9}})
add_Simple_PB_label(10, nil, GBU24CntlPage_root.name, {{"SMS_AG_GBU24_CntlPageLabels", 10}})

----------------------------------------------------------------- COMMON -----------------------------------------------------------------
add_PB_label(1, "A-G")
add_PB_label(2, "", nil, {{"SMS_AG_SubmodeLabelShow"}, {"SMS_SubModeLabel"}}, nil, AcftSubModeLbl)
add_PB_label(4, "INV")

add_Simple_PB_label(6, "      ", nil, {{"SMS_AG_SelectedWeapon"}, {"SMS_AG_CNTL_Page", 0}})

local RDY_PH = addPlaceholder("Weapon_Status_Ready", nil, nil, {{"SMS_WeaponStatus"}, {"SMS_AG_CNTL_Page", 0}})
addStrokeText("Weapon_Status_Ready_Top", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[6][1] - 165, PB_positions[6][2]}, RDY_PH.name)
addStrokeText("Weapon_Status_Ready_Bottom", "RDY", STROKE_FNT_DFLT_10_14, "CenterCenter",	{PB_positions[13][1], PB_positions[13][2] + 35}, RDY_PH.name)