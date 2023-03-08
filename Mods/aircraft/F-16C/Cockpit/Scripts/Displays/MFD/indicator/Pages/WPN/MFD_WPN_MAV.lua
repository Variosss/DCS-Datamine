dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")
--dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/WPN/MAV/MAV_tools.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

-- A/C Reference symbol
local AC_Reference_root = addPlaceholder("AC_Reference_root", {-215, -210}, nil, {{"MFD_AC_Reference_Symbol"}})
addStrokeSymbol("AC_Reference_Symbol", {"stroke_symbols_MFD", "AC-reference"}, "FromSet", {0, 0}, AC_Reference_root.name, {{"MFD_SetColor_Group_1"}})
-- Steering line
addStrokeLine("AzimuthSteeringBar", 40, {0, -20}, 0, AC_Reference_root.name, {{"MFD_AzimuthSteeringBar", 20}, {"MFD_SetColor_Group_1"}})
addStrokeLine("Vertical_Steering_Bar", 40, {-20, 0}, -90, AC_Reference_root.name, {{"MFD_VerticalSteeringBar", 20}, {"MFD_SetColor_Group_1"}})

----------------------------------------------------------------- MAVERICK ---------------------------------------------------------------
local Maverick_Root = addPlaceholder("MAVERICK_ROOT", nil, nil, {{"SMS_AG_isMaverick"}})

local mavNTO_root = addPlaceholder("MAV_NTO_root", nil, nil, {{"WPN_MAV_NTO", 0}})

addStrokeText("RDY", "", STROKE_FNT_DFLT_14_18, "CenterCenter", {PB_positions[13][1], PB_positions[13][2] + 35}, nil, {{"WPN_MAV_RDY"},{"WPN_MAV_REL"}} )
local openingMaskRdy = openMaskArea(0, "RdyArea", {}, {}, {PB_positions[13][1], PB_positions[13][2] + 35}, nil, {{"WPN_MAV_RDY"}})
set_box_w_h(openingMaskRdy, 50, 25)

closeMaskArea(1, "RdyAreaClose", openingMaskRdy.vertices, openingMaskRdy.indices, openingMaskRdy.init_pos, nil)

addStrokeText("NTO", "NOT TIMED OUT", STROKE_FNT_DFLT_14_18, "CenterCenter", nil, nil, {{"WPN_MAV_NTO", 1}})

---------------------------------------------------------------- MAVERICK PAGE -----------------------------------------------------------
addWpnMaverickLoadedWeapon("WPN_AG_Mav", nil, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addWpnMaverickLoadedWeapon("WPN_AG_Mav", nil, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

max_pixels_count = 900

addStrokeText("TimeToStp", nil, STROKE_FNT_DFLT_8_12, "RightCenter", {200, -200}, mavNTO_root.name, {{"MFD_WPN_TimeToStp"}})

-- Handoff
addStrokeText("WPN_MAV_HandoffInProgress", "", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 180}, Maverick_Root.name, {{"WPN_MAV_HandoffInProgress"}}, {"HANDOFF IN PROGRESS\n  STATION %d"})

-- MLE
local mleWidth = 20
local mleRange = 200
local MLE_Offset = 240 - mleWidth
local MLE_root = addPlaceholder("WPN_MAV_MLE_root", {MLE_Offset, -140}, nil, {{"WPN_MAV_MLE_Show"}})

addStrokeLine("WPN_MAV_MLE_zeroRange", mleWidth, {0, 0}, -90, MLE_root.name)
addVarLenStrokeLine("WPN_MAV_MLE_Range", 0, {0, 0},		  0, MLE_root.name, {{"WPN_MAV_MLE_Range", mleRange}}, mleRange)

local mleRangeCaret = addStrokeSymbol("WPN_MAV_MLE_TgtRange_Caret",   {"stroke_symbols_HUD", "AA-DLZ-range"}, "FromSet", {0, 0}, MLE_root.name, {{"WPN_MAV_MLE_TgtRange_Caret", mleRange}}, 2.0)
addStrokeText("WPN_MAV_MLE_TgtRange", "", STROKE_FNT_DFLT_8_12, "RightCenter", {-15, 0}, mleRangeCaret.name, {{"WPN_MAV_MLE_TgtRange"}})

local rmin_root = addPlaceholder("MAV_MLE_Rmin_root",{0, 0}, MLE_root.name, {{"WPN_MAV_MLE_RMin", mleRange}})
addStrokeLine("WPN_MAV_MLE_Rmin",		mleWidth, {0, 0}, -90, rmin_root.name)
local rmax_root = addPlaceholder("MAV_MLE_Rmax_root", {0, 0}, MLE_root.name, {{"WPN_MAV_MLE_RMax", mleRange}})
addStrokeLine("WPN_MAV_MLE_Rmax",		mleWidth, {0, 0}, -90, rmax_root.name)

----------------------------------------------------------------- OSBs-----------------------------------------------------------------
add_PB_label(1, "    ", nil, {{"WPN_MAV_OperStatus"}}, nil, {"STBY", "OPER"})
add_PB_label(2, "   ", nil, {{"SMS_AG_SubmodeLabelShow"}, {"SMS_SubModeLabel"}}, {{"SMS_AG_SubmodeLabel_Mask"}}, AcftSubModeLbl)
add_PB_label(3, "FOV")
--add_PB_label(5, "CNTL")

add_Simple_PB_label(6, "      ", nil, {{"SMS_AG_SelectedWeapon"}})
add_Simple_PB_label(7, "    ", Maverick_Root.name, {{"WPN_MAV_Polarity"}}, nil, {"", "HOC", "COH", "WB", "BW", "AREA"})

add_Selectable_PB_Label(20, "BSGT", Maverick_Root.name, {{"WPN_MAV_BSGT_label", 0}}, {{"WPN_MAV_BSGT_label", 1}})
