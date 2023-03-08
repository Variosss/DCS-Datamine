dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

----------------------------------------------------------------- HARM WPN -----------------------------------------------------------------
addPlaceholder("WPN_ROOT", nil, nil, {{"WPN_isHarm"}})

----------------------------------------------------------------- HARM_NONE-----------------------------------------------------------------
addPlaceholder("HARM_WPN_NONE", nil, "WPN_ROOT", {{"WPN_HARM_isNONESelect", 1}})

----------------------------------------------------------------- HARM_HAS -----------------------------------------------------------------
addPlaceholder("HARM_WPN_HAS_SRCH_PH", nil, "WPN_ROOT", {{"WPN_HARM_isSRCHShow"}})
add_Selectable_PB_Label(16, "  ", "HARM_WPN_HAS_SRCH_PH", {{"WPN_HARM_HAS_PBThreats", 0,1,4}}, {{"WPN_HARM_HAS_PBThreats", 1,0,4}},{{"WPN_HARM_HAS_PBThreats", 1,1,4}})
add_Selectable_PB_Label(17, "  ", "HARM_WPN_HAS_SRCH_PH", {{"WPN_HARM_HAS_PBThreats", 0,1,3}}, {{"WPN_HARM_HAS_PBThreats", 1,0,3}},{{"WPN_HARM_HAS_PBThreats", 1,1,3}})
add_Selectable_PB_Label(18, "  ", "HARM_WPN_HAS_SRCH_PH", {{"WPN_HARM_HAS_PBThreats", 0,1,2}}, {{"WPN_HARM_HAS_PBThreats", 1,0,2}},{{"WPN_HARM_HAS_PBThreats", 1,1,2}})
add_Selectable_PB_Label(19, "  ", "HARM_WPN_HAS_SRCH_PH", {{"WPN_HARM_HAS_PBThreats", 0,1,1}}, {{"WPN_HARM_HAS_PBThreats", 1,0,1}},{{"WPN_HARM_HAS_PBThreats", 1,1,1}})
add_Selectable_PB_Label(20, "  ", "HARM_WPN_HAS_SRCH_PH", {{"WPN_HARM_HAS_PBThreats", 0,1,0}}, {{"WPN_HARM_HAS_PBThreats", 1,0,0}},{{"WPN_HARM_HAS_PBThreats", 1,1,0}})

addPlaceholder("HARM_WPN_HAS_PH", nil, "WPN_ROOT", {{"WPN_HARM_isHASShow"}})
local wpnHarmHas_root = addPlaceholder("HARM_WPN_HAS", nil, "HARM_WPN_HAS_PH", {{"WPN_HARM_isHASSelect", 1}})
add_PB_label(3, "WIDE", "HARM_WPN_HAS", {{}, {"WPN_HARM_HAS_FOVSelectionLabel"}}, nil, HarmFOVSelectionLabel)		-- TODO: FIX ME
add_PB_label(4, "SRCH", "HARM_WPN_HAS", {{"WPN_HARM_HAS_SRCH"}})

add_Selectable_PB_Label(7, "R\nS", "HARM_WPN_HAS", {{"WPN_HARM_HAS_RestartSearch",0}}, {{"WPN_HARM_HAS_RestartSearch",1}})

for i = 0,4 do
	local num = i
	addStrokeText("","", STROKE_FNT_DFLT_8_12, "CenterCenter",{-150 + 75 * i, 180},"HARM_WPN_HAS", {{"WPN_HARM_HAS_DTSB_Threats",num}})
end

for i = 1, 9 do
	local num = i-1
	addPlaceholder("WPN_HAS_SymbolPlacer"..num,nil,"HARM_WPN_HAS",{{"WPN_HARM_HAS_ThreatPos", num}})
	addStrokeText("WPN_HAS_Symbol"..num, "",STROKE_FNT_DFLT_8_12, "CenterCenter", nil,"WPN_HAS_SymbolPlacer"..num,{{"WPN_HARM_HAS_ThreatSymbol",num}})
end
addStrokeBox("Box_", 330, 49, "CenterCenter", {0, 180}, "HARM_WPN_HAS", nil,"INDICATION_COMMON_GREEN")

----------------------------------------------------------------- HARM_HAS_Search -----------------------------------------------------------------
addPlaceholder("HARM_WPN_HAS_Search", nil, "HARM_WPN_HAS", {{"WPN_HARM_isHASSearch", 1}})
addStrokeText("MaxSearchTime", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {-70,140},"HARM_WPN_HAS_Search",{{"WPN_HARM_HAS_MaxSearchTime"}})
addStrokeText("CycleNum", "",STROKE_FNT_DFLT_8_12, "LeftCenter", {20,140},"HARM_WPN_HAS_Search",{{"WPN_HARM_HAS_CycleNum"}})

addStrokeLine("LFV", 300, {-180,-175},0, "HARM_WPN_HAS_Search", {{}},true, 22, 22,"INDICATION_COMMON_RED")
addStrokeLine("RTV", 300, {180,-175},0, "HARM_WPN_HAS_Search", {{}},true, 22, 22,"INDICATION_COMMON_RED")
addStrokeLine("TPH", 360, {-180,125},-90, "HARM_WPN_HAS_Search", {{}},true, 22, 22,"INDICATION_COMMON_RED")
addStrokeLine("BTH", 360, {-180,-175},-90, "HARM_WPN_HAS_Search", {{}},true, 22, 22,"INDICATION_COMMON_RED")

addPlaceholder("VerticalLine_", {0, 0}, "HARM_WPN_HAS_Search",{{"WHP_HARM_HAS_VerticalLinePosition"}})
addStrokeLine("VTL", 300,{0,-175},0,"VerticalLine_",nil)
addStrokeLine("HTL_1", 26,{-13,5},-90,"VerticalLine_",nil)
addStrokeLine("HTL_2", 26,{-13,-55},-90,"VerticalLine_",nil)
addStrokeLine("HTL_3", 26,{-13,-115},-90,"VerticalLine_",nil)

addPlaceholder("HorisontalLine_", {0, 0}, "HARM_WPN_HAS_Search")
addStrokeLine("HTL", 360,{-180,65},-90,"HorisontalLine_",nil)
addStrokeLine("VTL_1", 26,{-180,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_2", 26,{-120,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_3", 26,{-60,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_4", 26,{0,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_5", 26,{60,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_6", 26,{120,52},0,"HorisontalLine_",nil)
addStrokeLine("VTL_7", 26,{180,52},0,"HorisontalLine_",nil)

--TDC cursor
addPlaceholder("Cursor_", {0, 0}, "HARM_WPN_HAS_Search", {{"WPN_HARM_HAS_TDC_position"}, {"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Left", 20, {10, -10}, 0, "Cursor_", {{"MFD_SetColor_Group_2"}})
addStrokeLine("Cursor_Line_Right", 20, {-10, -10}, 0, "Cursor_", {{"MFD_SetColor_Group_2"}})

----------------------------------------------------------------- HARM_HAS_Handoff -----------------------------------------------------------------

addPlaceholder("HARM_WPN_HAS_Handoff", nil, "HARM_WPN_HAS", {{"WPN_HARM_isHASHandoff", 1}})
addPlaceholder("Aim_", {0, 0}, "HARM_WPN_HAS_Handoff")
addStrokeLine("VerticalAimLine_1", 140,{0,-175},0,"Aim_",nil)
addStrokeLine("VerticalAimLine_2", 140,{0,-15},0,"Aim_",nil)
addStrokeLine("HTL_", 26,{-13,125},-90,"Aim_",nil)
addStrokeLine("HBL_", 26,{-13,-175},-90,"Aim_",nil)

addStrokeLine("HorisontalAimLine_1", 140,{-150,-25},-90,"Aim_",nil)
addStrokeLine("HorisontalAimLine_2", 140,{10,-25},-90,"Aim_",nil)
addStrokeLine("VLL_", 26,{-150,-38},0,"Aim_",nil)
addStrokeLine("VRL_", 26,{150,-38},0,"Aim_",nil)

addPlaceholder("HandedoffThreat_", nil, "HARM_WPN_HAS_Handoff",{{"WPN_HARM_HAS_HandedoffSymbolPos"}})
	addFillBox("Fill Box", 27, 20, "CenterCenter", nil, "HandedoffThreat_")
	addBlackText("HandedoffSymb", "  ", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, "HandedoffThreat_", {{"WPN_HARM_HAS_HandedoffSymbol"}})
	


