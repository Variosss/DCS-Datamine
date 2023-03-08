dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

--
local FCR_NotModeMenu = addPlaceholder("FCR_NotModeMenu_Root", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})

-- Menu labels
add_PB_label(5, "CNTL", FCR_NotModeMenu.name, nil, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}})

--
addStrokeSymbol("FCR_Horizon_Line", {"stroke_symbols_MFD", "Horizon-Line"}, "FromSet", {0, 0}, noParent, {{"FCR_HorizonLine"}, {"MFD_SetColor_Group_3"}})

-- Range buttons
local RangeScaleRoot = addPlaceholder("Range_Scale_Root", {PB_positions[20][1] + 10 , (PB_positions[20][2] - PB_positions[19][2]) / 2 + PB_positions[19][2]}, FCR_NotModeMenu.name, noControllers)
addStrokeText("Range_Scale_Value", 40, STROKE_FNT_DFLT_10_14, "CenterCenter", nil, RangeScaleRoot.name, {{"FCR_RangeVelScale"}})
local RangeScaleOffset = 25
local RangeScaleSymbolScale = 3.5
addStrokeSymbol("Decrement_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, -RangeScaleOffset}, RangeScaleRoot.name, {{"FCR_ShowDecreaseScaleSymbol"}}, RangeScaleSymbolScale)
local Increment = addStrokeSymbol("Increment_Range_Scale_Symbol", {"stroke_symbols_MFD", "Decrement-symbol"}, "FromSet", {0, RangeScaleOffset}, RangeScaleRoot.name, {{"FCR_ShowIncreaseScaleSymbol"}}, RangeScaleSymbolScale)
Increment.init_rot = {180}
addSizeClipMask(RangeScaleRoot, 2, 72, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}}, {-19, 0})

-- Azimuth/Elevation carets
function addCaret(name, rotation, position, parent, controllers)
    local Caret_PH = addPlaceholder(name.."_Caret_PH", position, parent, controllers)
    local LineLen = 13
    for i = 0, 2 do
        addStrokeLine(name.."_Caret_VerticalLine_"..i, LineLen, {-1 + i, 0}, -180, Caret_PH.name, {{"MFD_SetColor_Group_1"}})
    end
    for i = 0, 2 do
        addStrokeLine(name.."_Caret_HorizontalLine_"..i, LineLen, {-LineLen / 2, 1 - i}, -90, Caret_PH.name, {{"MFD_SetColor_Group_1"}})
    end

    Caret_PH.init_rot   = {rotation or 0}
end

addCaret("Radar_Azimuth_Pointer", 0, {0, -218}, noParent, {{"FCR_AntennaAzimuth"}} )
addCaret("Radar_Elevation_Pointer", -90, {-203, 0}, noParent, {{"FCR_AntennaElevation"}} )

-- SAM Azimuth/Elevation Target carets
local FCR_SAM_TargetCarest = addPlaceholder("FCR_SAM_TargetCarest", {0, 0}, noParent, {{"FCR_SAM_TargetCaretsState"}})
addCaret("FCR_SAM_TargetAzimuth_Pointer", 180, {0, -218}, FCR_SAM_TargetCarest.name, {{"FCR_SAM_TargetAzimuth"}})
addCaret("FCR_SAM_TargetElevation_Pointer", 90, {-203, 0}, FCR_SAM_TargetCarest.name, {{"FCR_SAM_TargetElevation"}})

-- Bullseye
local Bullseye_LOS = addPlaceholder("Bullseye_LOS", {-213, -194}, noParent, {{"HSD_BullseyeLOS_VisibleState", 1}})
local Bullseye_LOS_Radius = 17
addStrokeCircle("Bullseye_LOS_Cirle", Bullseye_LOS_Radius, nil, Bullseye_LOS.name, {{"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Range", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", nil, Bullseye_LOS.name, {{"HSD_BullseyeLOS_Range"}, {"MFD_SetColor_Group_1"}})
addStrokeText("Bullseye_LOS_Bearing", nil, STROKE_FNT_DFLT_8_12, "CenterCenter", {0, -Bullseye_LOS_Radius * 1.8}, Bullseye_LOS.name, {{"HSD_BullseyeLOS_Bearing"}, {"MFD_SetColor_Group_1"}})
local Bullseye_LOS_Pointer = addPlaceholder("Bullseye_LOS_Pointer", nil, Bullseye_LOS.name, {{"HSD_Heading"}, {"HSD_BullseyeLOS_PointerRotation"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}})
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_1", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.8)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_2", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.6)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_3", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.4)
addStrokeSymbol("Bullseye_LOS_Pointer_Symbol_Filler_4", {"stroke_symbols_MFD", "Bullseye-LOS-Pointer"}, "FromSet", {0, Bullseye_LOS_Radius}, Bullseye_LOS_Pointer.name, {{"MFD_SetColor_Group_1"}}, 0.2)

local Aircraft_reference_symbol_Root = addPlaceholder("Aircraft_reference_symbol_Root", {0,0}, noParent, {{"HSD_BullseyeLOS_VisibleState", 0}})
-- A/C Reference symbol
local AC_Reference_PH = addPlaceholder("AC_Reference_root", {-215, -210}, Aircraft_reference_symbol_Root.name, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("Aircraft_reference_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_PH.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("Azimuth_Steering_Bar", 40, {0, -20}, 0, AC_Reference_PH.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_PH.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

-- MODE MENU page
local FCR_ModeMenu = addPlaceholder("FCR_ModeMenu_Root", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MODE}})

local FCR_Modes_AA = addPlaceholder("FCR_ModeMenuAA_Root", {0, 0}, FCR_ModeMenu.name, {{"FCR_ShowModes_AA"}})
local FCR_Modes_AG = addPlaceholder("FCR_ModeMenuAG_Root", {0, 0}, FCR_ModeMenu.name, {{"FCR_ShowModes_AG"}})
local FCR_Mode_AGR = addPlaceholder("FCR_ModeMenuAGR_Root", {0, 0}, FCR_ModeMenu.name, {{"FCR_ShowMode_AGR"}})

add_Selectable_PB_Label(20, "CRM",	FCR_Modes_AA.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.CRM}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.CRM}})
add_Selectable_PB_Label(19, "ACM",	FCR_Modes_AA.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.ACM}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.ACM}})

add_Selectable_PB_Label(6,  "GM",	FCR_Modes_AG.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.GM}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GM}})
add_Selectable_PB_Label(6,  "AGR",	FCR_Mode_AGR.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.AGR}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.AGR}})
add_Selectable_PB_Label(7,  "GMT",	FCR_Modes_AG.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.GMT}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.GMT}})
add_Selectable_PB_Label(8,  "SEA",	FCR_Modes_AG.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.SEA}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.SEA}})
add_Selectable_PB_Label(9,  "BCN",	FCR_Modes_AG.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.BCN}},	{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.BCN}})
add_Selectable_PB_Label(10, "STBY",	FCR_ModeMenu.name, {{"FCR_SelectedMode", 0, FCR_SELECT_MODES.STBY}},{{"FCR_SelectedMode", 1, FCR_SELECT_MODES.STBY}})

local FCR_CNTLModeMenu = addPlaceholder("FCR_CNTLModeMenu", {0, 0}, noParent, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.CNTL}})
--add_Simple_PB_label(1, "GM",            FCR_CNTLModeMenu.name, {{"FCR_CNTL_MODE"}},           nil, {"", "GM", "SEA", "BCN", "GMT"})
add_PB_label(5,        "CNTL",          FCR_CNTLModeMenu.name, nil, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.CNTL}})
add_Simple_PB_label(6, "CHAN\n1",       FCR_CNTLModeMenu.name, {{"FCR_CNTL_CHAN"}},           nil, {"", "CHAN\n1", "CHAN\n2", "CHAN\n3", "CHAN\n4"})
add_Simple_PB_label(7, "MK INT\n1",     FCR_CNTLModeMenu.name, {{"FCR_CNTL_MK_INT"}},         nil, {"", "MK INT\n1", "MK INT\n2", "MK INT\n3", "MK INT\n4"})
add_Simple_PB_label(8, "BAND\nWIDE",    FCR_CNTLModeMenu.name, {{"FCR_CNTL_BAND_WIDE_NARO"}}, nil, {"", "BAND\nWIDE", "BAND\nNARO"})
add_Simple_PB_label(9, "BCN DLY",       FCR_CNTLModeMenu.name)
addStrokeText("BCN_DLY_Label", "00:0", STROKE_FNT_DFLT_10_14, "RightCenter", {235, -100}, FCR_CNTLModeMenu.name, {{"FCR_CNTL_BCN_DLY"}})
add_Simple_PB_label(10, "PM\nOFF",      FCR_CNTLModeMenu.name, {{"FCR_CNTL_PM_OFF_ON"}},      nil, {"", "PM\nOFF", "PM\nON"})
add_Simple_PB_label(17, "LVL",          FCR_CNTLModeMenu.name)
addStrokeText("LVL_Label", "1", STROKE_FNT_DFLT_10_14, "LeftCenter", {-237, -100}, FCR_CNTLModeMenu.name, {{"FCR_CNTL_LVL"}})
add_Simple_PB_label(18, "TGT HIS",      FCR_CNTLModeMenu.name)
addStrokeText("TGT_HIS_Label", "3", STROKE_FNT_DFLT_10_14, "LeftCenter", {-237, -20}, FCR_CNTLModeMenu.name, {{"FCR_CNTL_TGT_HIS"}})
add_Simple_PB_label(19, "ALT TRK\nOFF", FCR_CNTLModeMenu.name, {{"FCR_CNTL_ALT_TRK_OFF_ON"}}, nil, {"", "ALT TRK\nOFF", "ALT TRK\nON"})
add_Simple_PB_label(20, "MTR\nHI",      FCR_CNTLModeMenu.name, {{"FCR_CNTL_MTR_HI_LO"}},      nil, {"", "MTR\nHI", "MTR\nLO"})