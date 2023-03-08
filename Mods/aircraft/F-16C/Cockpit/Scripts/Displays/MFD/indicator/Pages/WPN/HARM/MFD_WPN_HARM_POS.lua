dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

addPlaceholder("WPN_ROOT", nil, nil, {{"WPN_isHarm"}})

----------------------------------------------------------------- HARM_POS -----------------------------------------------------------------
addPlaceholder("HARM_WPN_POS_PH", nil, "WPN_ROOT", {{"WPN_HARM_isPOSShow"}})
addPlaceholder("HARM_WPN_POS", nil, "HARM_WPN_POS_PH", {{"WPN_HARM_isPOSSelect", 1}})
add_PB_label(3, "", "HARM_WPN_POS", {{"WPN_HARM_FlightProfileLabelShow"}, {"WPN_HARM_FlightProfileLabel"}}, nil, HarmFlightProfileLabel)


add_Simple_PB_label(10, "T\nI", "HARM_WPN_POS", {{"WPN_HARM_TI"}})	--Target Isolate (TI) 

----------------------------------------------------------------- HARM_POS_FLIGHTPROFILE -----------------------------------------------------------------
addPlaceholder("HARM_FLIGHTMODE_SELECT", nil, "HARM_WPN_POS", {{"WPN_HARM_isFlightProfileSelect", 1}})
add_Selectable_PB_Label(20, "EOM", "HARM_FLIGHTMODE_SELECT", {{"WPN_HARM_FlightProfileSelected", 0, HarmFlightProfile.EOM}}, {{"WPN_HARM_FlightProfileSelected", 1, HarmFlightProfile.EOM}})
add_Selectable_PB_Label(19, "RUK", "HARM_FLIGHTMODE_SELECT", {{"WPN_HARM_FlightProfileSelected", 0, HarmFlightProfile.RUK}}, {{"WPN_HARM_FlightProfileSelected", 1, HarmFlightProfile.RUK}})
add_Selectable_PB_Label(18, "PB", "HARM_FLIGHTMODE_SELECT", {{"WPN_HARM_FlightProfileSelected", 0, HarmFlightProfile.PB}}, {{"WPN_HARM_FlightProfileSelected", 1, HarmFlightProfile.PB}})


add_Selectable_PB_Label(16, "  ", "HARM_WPN_POS", {{"WPN_HARM_POS_PBThreats", 0,1,4}}, {{"WPN_HARM_POS_PBThreats", 1,0,4}},{{"WPN_HARM_POS_PBThreats", 1,1,4}})
add_Selectable_PB_Label(17, "  ", "HARM_WPN_POS", {{"WPN_HARM_POS_PBThreats", 0,1,3}}, {{"WPN_HARM_POS_PBThreats", 1,0,3}},{{"WPN_HARM_POS_PBThreats", 1,1,3}})
add_Selectable_PB_Label(18, "  ", "HARM_WPN_POS", {{"WPN_HARM_POS_PBThreats", 0,1,2}}, {{"WPN_HARM_POS_PBThreats", 1,0,2}},{{"WPN_HARM_POS_PBThreats", 1,1,2}})
add_Selectable_PB_Label(19, "  ", "HARM_WPN_POS", {{"WPN_HARM_POS_PBThreats", 0,1,1}}, {{"WPN_HARM_POS_PBThreats", 1,0,1}},{{"WPN_HARM_POS_PBThreats", 1,1,1}})
add_Selectable_PB_Label(20, "  ", "HARM_WPN_POS", {{"WPN_HARM_POS_PBThreats", 0,1,0}}, {{"WPN_HARM_POS_PBThreats", 1,0,0}},{{"WPN_HARM_POS_PBThreats", 1,1,0}})


addStrokeLine("LaunchStatusDividerLine", 400, {-200,40},-90, "HARM_WPN_POS", {{}},false, 0, 0,"INDICATION_COMMON_GREEN")

addPlaceholder("HandedoffThreat_PreLaunch_3", {-160,20}, "HARM_WPN_POS",{{"WPN_HARM_POS_PreLaunchSymbolPos", 3}})
	addFillBox("Fill Box_3", 27, 20, "CenterCenter", nil, "HandedoffThreat_PreLaunch_3")
	addBlackText("PreLaunchSymb_3", "  ", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, "HandedoffThreat_PreLaunch_3", {{"WPN_HARM_POS_PreLaunchSymbol"}})	
	addStrokeText("SteerPointNum_3", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {0,-25},"HandedoffThreat_PreLaunch_3",{{"WPN_HARM_POS_PreLaunch_SteerPointNum"}})
	addStrokeText("TOF_3", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-75},"HandedoffThreat_PreLaunch_3",{{"WPN_HARM_POS_PreLaunch_TOF"}})
	addStrokeText("TOT_3", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-100},"HandedoffThreat_PreLaunch_3",{{"WPN_HARM_POS_PreLaunch_TOT"}})
	
	addStrokeText("WPN_HARM_POS_PostLaunch_TargetType_3", "",STROKE_FNT_DFLT_8_12, "CenterCenter", {-160,60},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TargetType",0}})
	addStrokeText("WPN_HARM_POS_PostLaunch_SteerPointNum_3", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-160,80},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_SteerPointNum",0}})
	addStrokeText("WPN_HARM_POS_PostLaunch_TUI_3", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-180,120},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TUI",0}})

addPlaceholder("HandedoffThreat_PreLaunch_4", {-60,20}, "HARM_WPN_POS",{{"WPN_HARM_POS_PreLaunchSymbolPos", 4}})
	addFillBox("Fill Box_4", 27, 20, "CenterCenter", nil, "HandedoffThreat_PreLaunch_4")
	addBlackText("PreLaunchSymb_4", "  ", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, "HandedoffThreat_PreLaunch_4", {{"WPN_HARM_POS_PreLaunchSymbol"}})	
	addStrokeText("SteerPointNum_4", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {0,-25},"HandedoffThreat_PreLaunch_4",{{"WPN_HARM_POS_PreLaunch_SteerPointNum"}})
	addStrokeText("TOF_4", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-75},"HandedoffThreat_PreLaunch_4",{{"WPN_HARM_POS_PreLaunch_TOF"}})
	addStrokeText("TOT_4", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-100},"HandedoffThreat_PreLaunch_4",{{"WPN_HARM_POS_PreLaunch_TOT"}})
	
	addStrokeText("WPN_HARM_POS_PostLaunch_TargetType_4", "",STROKE_FNT_DFLT_8_12, "CenterCenter", {-60,60},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TargetType",1}})
	addStrokeText("WPN_HARM_POS_PostLaunch_SteerPointNum_4", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-60,80},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_SteerPointNum",1}})
	addStrokeText("WPN_HARM_POS_PostLaunch_TUI_4", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-80,120},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TUI",1}})
	
addPlaceholder("HandedoffThreat_PreLaunch_6", {60,20}, "HARM_WPN_POS",{{"WPN_HARM_POS_PreLaunchSymbolPos", 6}})
	addFillBox("Fill Box_6", 27, 20, "CenterCenter", nil, "HandedoffThreat_PreLaunch_6")
	addBlackText("PreLaunchSymb_6", "  ", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, "HandedoffThreat_PreLaunch_6", {{"WPN_HARM_POS_PreLaunchSymbol"}})	
	addStrokeText("SteerPointNum_6", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {0,-25},"HandedoffThreat_PreLaunch_6",{{"WPN_HARM_POS_PreLaunch_SteerPointNum"}})
	addStrokeText("TOF_6", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-75},"HandedoffThreat_PreLaunch_6",{{"WPN_HARM_POS_PreLaunch_TOF"}})
	addStrokeText("TOT_6", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-100},"HandedoffThreat_PreLaunch_6",{{"WPN_HARM_POS_PreLaunch_TOT"}})
	
	addStrokeText("WPN_HARM_POS_PostLaunch_TargetType_6", "",STROKE_FNT_DFLT_8_12, "CenterCenter", {60,60},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TargetType",2}})
	addStrokeText("WPN_HARM_POS_PostLaunch_SteerPointNum_6", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {60,80},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_SteerPointNum",2}})
	addStrokeText("WPN_HARM_POS_PostLaunch_TUI_6", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {40,120},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TUI",2}})

addPlaceholder("HandedoffThreat_PreLaunch_7", {160, 20}, "HARM_WPN_POS",{{"WPN_HARM_POS_PreLaunchSymbolPos", 7}})
	addFillBox("Fill Box_7", 27, 20, "CenterCenter", nil, "HandedoffThreat_PreLaunch_7")
	addBlackText("PreLaunchSymb_7", "  ", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, "HandedoffThreat_PreLaunch_7", {{"WPN_HARM_POS_PreLaunchSymbol"}})	
	addStrokeText("SteerPointNum_7", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {0,-25},"HandedoffThreat_PreLaunch_7",{{"WPN_HARM_POS_PreLaunch_SteerPointNum"}})
	addStrokeText("TOF_7", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-75},"HandedoffThreat_PreLaunch_7",{{"WPN_HARM_POS_PreLaunch_TOF"}})
	addStrokeText("TOT_7", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-20,-100},"HandedoffThreat_PreLaunch_7",{{"WPN_HARM_POS_PreLaunch_TOT"}})
	
	addStrokeText("WPN_HARM_POS_PostLaunch_TargetType_7", "",STROKE_FNT_DFLT_8_12, "CenterCenter", {160,60},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TargetType",3}})
	addStrokeText("WPN_HARM_POS_PostLaunch_SteerPointNum_7", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {160,80},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_SteerPointNum",3}})
	addStrokeText("WPN_HARM_POS_PostLaunch_TUI_7", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {140,120},"HARM_WPN_POS",{{"WPN_HARM_POS_PostLaunch_TUI",3}})