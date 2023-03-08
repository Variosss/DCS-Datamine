dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("kneeboard_notepad_background.dds")

-- GENERAL SCALE
local general_font_scale = 1.0

FontSizeX1	= 0.0075 * general_font_scale
FontSizeY1	= FontSizeX1

predefined_font_08 = {general_font_scale* FontSizeY1*0.8, general_font_scale* FontSizeX1*0.8, 0.0, 0.0}
local predefinedfontsize = 0.65
predefined_font_0 = {general_font_scale * FontSizeY1 * predefinedfontsize, general_font_scale * FontSizeX1 * predefinedfontsize, 0.0, 0.0}
predefinedfontsize = 0.50
predefined_font_1 = {general_font_scale * FontSizeY1 * predefinedfontsize, general_font_scale * FontSizeX1 * predefinedfontsize, 0.0, 0.0}

function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end


local LineSizeY   = FontSizeY1 * 9
local ColumnSizeX = FontSizeX1 * 48 / 72 * 8

firstLineY = - LineSizeY

local hints_scale		= MakeMaterial("arcade.tga", {255, 128, 64, 255})

local base_size_x   = ColumnSizeX * 45.0
local base_size_y   = LineSizeY   * 17.0
local base_size_x05 = base_size_x * 0.5
local base_size_y05 = base_size_y * 0.5


aspect = 0.7

local dY = LineSizeY * 1.36
firstLineY = 1.215

function getLineY(line)
    return firstLineY - dY * (line - 1)
end

-- Weapon Status ------------------------------------------------
-----------------------------------------------------------------
local label_x = -0.3
local value_x = -0.1
local key_x = 0.1

txt_WeapStatus				= CreateElement "ceStringPoly"
txt_WeapStatus.name			= "txt_WeapStatus"
txt_WeapStatus.material		= "font_hints_kneeboard"
txt_WeapStatus.init_pos		= {0, getLineY(1), 0}
txt_WeapStatus.value		= "WEAPON STATUS:"
txt_WeapStatus.alignment	= "CenterCenter"
txt_WeapStatus.stringdefs	= predefined_font_0
txt_WeapStatus.controllers	= {{"show_weap_status"}}
AddElement(txt_WeapStatus)

txt_WeapStatus_M60D				= CreateElement "ceStringPoly"
txt_WeapStatus_M60D.name		= "txt_WeapStatus_M60"
txt_WeapStatus_M60D.material	= "font_hints_kneeboard"
txt_WeapStatus_M60D.init_pos	= {0.0, getLineY(2), 0}
txt_WeapStatus_M60D.formats		= {"",
								   "M134",
								   "XM158",
								   "M134 XM158"}
txt_WeapStatus_M60D.alignment  	= "CenterCenter"
txt_WeapStatus_M60D.stringdefs	= predefined_font_0
txt_WeapStatus_M60D.controllers = {{"show_weap_status"},{"M60D"}}
AddElement(txt_WeapStatus_M60D)

txt_Off_Safe_Armed				= CreateElement "ceStringPoly"
txt_Off_Safe_Armed.name			= "txt_Off_Safe_Armed"
txt_Off_Safe_Armed.material		= "font_hints_kneeboard"
txt_Off_Safe_Armed.init_pos		= {value_x, getLineY(4), 0}
txt_Off_Safe_Armed.formats		= {"OFF", "SAFE", "ARMED"}
txt_Off_Safe_Armed.alignment	= "RightCenter"
txt_Off_Safe_Armed.stringdefs	= predefined_font_0
txt_Off_Safe_Armed.controllers	= {{"show_weap_status"},{"Off_Safe_Armed"}}
AddElement(txt_Off_Safe_Armed)

txt_Off_Safe_Armed_key				= CreateElement "ceStringPoly"
txt_Off_Safe_Armed_key.name			= "txt_Off_Safe_Armed_key"
txt_Off_Safe_Armed_key.material		= "font_hints_kneeboard_keys"
txt_Off_Safe_Armed_key.init_pos		= {key_x, getLineY(4), 0}
txt_Off_Safe_Armed_key.value		= "RSHIFT+]/["
txt_Off_Safe_Armed_key.alignment	= "LeftCenter"
txt_Off_Safe_Armed_key.stringdefs	= predefined_font_0
txt_Off_Safe_Armed_key.controllers	= {{"show_weap_status"}}
AddElement(txt_Off_Safe_Armed_key)

txt_WeaponType				= CreateElement "ceStringPoly"
txt_WeaponType.name			= "txt_WeaponType"
txt_WeaponType.material		= "font_hints_kneeboard"
txt_WeaponType.init_pos		= {label_x, getLineY(5), 0}
txt_WeaponType.formats		= {"7.62/", "2.75/", "40/"}
txt_WeaponType.alignment	= "RightCenter"
txt_WeaponType.stringdefs	= predefined_font_0
txt_WeaponType.controllers	= {{"show_weap_status"},{"WeaponType"}}
AddElement(txt_WeaponType)

txt_WeaponNum				= CreateElement "ceStringPoly"
txt_WeaponNum.name			= "txt_WeaponNum"
txt_WeaponNum.material		= "font_hints_kneeboard"
txt_WeaponNum.init_pos		= {value_x, getLineY(5), 0}
txt_WeaponNum.alignment		= "RightCenter"
txt_WeaponNum.stringdefs	= predefined_font_0
txt_WeaponNum.controllers	= {{"show_weap_status"},{"WeaponNum"}}
AddElement(txt_WeaponNum)

txt_WeaponType_key				= CreateElement "ceStringPoly"
txt_WeaponType_key.name			= "txt_WeaponType_key"
txt_WeaponType_key.material		= "font_hints_kneeboard_keys"
txt_WeaponType_key.init_pos		= {key_x, getLineY(5), 0}
txt_WeaponType_key.value		= "RALT+]/["
txt_WeaponType_key.alignment	= "LeftCenter"
txt_WeaponType_key.stringdefs	= predefined_font_0
txt_WeaponType_key.controllers	= {{"show_weap_status"}}
AddElement(txt_WeaponType_key)

txt_NumPairs				= CreateElement "ceStringPoly"
txt_NumPairs.name			= "txt_NumPairs"
txt_NumPairs.material		= "font_hints_kneeboard"
txt_NumPairs.init_pos		= {value_x, getLineY(6), 0}
txt_NumPairs.formats		= {"X0","X1","X2","X3","X4","X5","X6","X7","LEFT","BOTH","RIGHT"}
txt_NumPairs.alignment		= "RightCenter"
txt_NumPairs.stringdefs		= predefined_font_0
txt_NumPairs.controllers	= {{"show_weap_status"},{"NumPairs"}}
AddElement(txt_NumPairs)

txt_NumPairs_key				= CreateElement "ceStringPoly"
txt_NumPairs_key.name			= "txt_NumPairs_key"
txt_NumPairs_key.material		= "font_hints_kneeboard_keys"
txt_NumPairs_key.init_pos		= {key_x, getLineY(6), 0}
txt_NumPairs_key.formats		= {"RALT+RCTRL+]/[", "RCTRL+]/["}
txt_NumPairs_key.alignment		= "LeftCenter"
txt_NumPairs_key.stringdefs		= predefined_font_0
txt_NumPairs_key.controllers	= {{"show_weap_status"},{"WeaponType"}}
AddElement(txt_NumPairs_key)

txt_Flex				= CreateElement "ceStringPoly"
txt_Flex.name			= "txt_Flex"
txt_Flex.material		= "font_hints_kneeboard"
txt_Flex.init_pos		= {0.0, getLineY(7), 0}
txt_Flex.value			= "FLEXIBLE MODE ACTIVE"
txt_Flex.alignment		= "CenterCenter"
txt_Flex.stringdefs		= predefined_font_1
txt_Flex.controllers	= {{"show_msg"},{"show_weap_status"}}
AddElement(txt_Flex)

local PilotSightAngle_x = 0.5

txt_PilotSight				= CreateElement "ceStringPoly"
txt_PilotSight.name			= "txt_PilotSight"
txt_PilotSight.material		= "font_hints_kneeboard"
txt_PilotSight.init_pos		= {PilotSightAngle_x, getLineY(8), 0}
txt_PilotSight.value		= "PILOT SIGHT ELEVATION  "
txt_PilotSight.alignment	= "RightCenter"
txt_PilotSight.stringdefs	= predefined_font_0
txt_PilotSight.controllers	= {{"show_weap_status"}}
AddElement(txt_PilotSight)

txt_PilotSightAng				= CreateElement "ceStringPoly"
txt_PilotSightAng.name			= "txt_PilotSightAng"
txt_PilotSightAng.material		= "font_hints_kneeboard"
txt_PilotSightAng.init_pos		= {PilotSightAngle_x, getLineY(8), 0}
txt_PilotSightAng.alignment		= "LeftCenter"
txt_PilotSightAng.stringdefs	= predefined_font_0
txt_PilotSightAng.controllers	= {{"show_weap_status"},{"PilotSightAngle"}}
AddElement(txt_PilotSightAng)

txt_AutoPilot_txt				= CreateElement "ceStringPoly"
txt_AutoPilot_txt.name			= "txt_AutoPilot_txt"
txt_AutoPilot_txt.material		= "font_hints_kneeboard"
txt_AutoPilot_txt.init_pos		= {0, getLineY(10), 0}
txt_AutoPilot_txt.value			= "AUTOPILOT MODE:"
txt_AutoPilot_txt.alignment		= "CenterCenter"
txt_AutoPilot_txt.stringdefs	= predefined_font_0
txt_AutoPilot_txt.controllers	= {{"AutoPilot_show"}}
AddElement(txt_AutoPilot_txt)

txt_Multicrew_txt				= Copy(txt_AutoPilot_txt)
txt_Multicrew_txt.name			= "txt_Multicrew_txt"
txt_Multicrew_txt.value			= "MULTICREW"
txt_Multicrew_txt.controllers	= {{"Multicrew_show"}}
AddElement(txt_Multicrew_txt)

txt_AutoPilot_mode				= CreateElement "ceStringPoly"
txt_AutoPilot_mode.name			= "txt_AutoPilot_mode"
txt_AutoPilot_mode.material		= "font_hints_kneeboard"
txt_AutoPilot_mode.init_pos		= {0, getLineY(11), 0}
txt_AutoPilot_mode.formats		= {"ATTITUDE HOLD", 
								   "LEVEL FLIGHT", 
								   "ORBIT"}
txt_AutoPilot_mode.alignment	= "CenterCenter"
txt_AutoPilot_mode.stringdefs	= predefined_font_0
txt_AutoPilot_mode.controllers	= {{"AutoPilot_mode"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_mode)


txt_AutoPilot				= CreateElement "ceStringPoly"
txt_AutoPilot.name			= "txt_AutoPilot"
txt_AutoPilot.material		= "font_hints_kneeboard"
txt_AutoPilot.init_pos		= {value_x, getLineY(13), 0}
txt_AutoPilot.formats		= {"OFF","ON"}
txt_AutoPilot.alignment		= "RightCenter"
txt_AutoPilot.stringdefs	= predefined_font_0
txt_AutoPilot.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot)

txt_AutoPilot_key				= CreateElement "ceStringPoly"
txt_AutoPilot_key.name			= "txt_AutoPilot_key"
txt_AutoPilot_key.material		= "font_hints_kneeboard_keys"
txt_AutoPilot_key.init_pos		= {key_x, getLineY(13), 0}
txt_AutoPilot_key.value			= "LWIN+A"
txt_AutoPilot_key.alignment		= "LeftCenter"
txt_AutoPilot_key.stringdefs	= predefined_font_0
txt_AutoPilot_key.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_key)

txt_Multicrew					= Copy(txt_AutoPilot)
txt_Multicrew.name				= "txt_Multicrew"
txt_Multicrew.formats			= nil
txt_Multicrew.value				= "REQUEST CONTROL"
txt_Multicrew.controllers		= {{"Multicrew_show"}}
AddElement(txt_Multicrew)


txt_Multicrew_key				= Copy(txt_AutoPilot_key)
txt_Multicrew_key.name			= "txt_Multicrew_key"
txt_Multicrew_key.value			= "C"
txt_Multicrew_key.controllers	= {{"Multicrew_show"}}
AddElement(txt_Multicrew_key)

txt_AutoPilot_KEEP_AS_IS				= CreateElement "ceStringPoly"
txt_AutoPilot_KEEP_AS_IS.name			= "txt_KEEP_AS_IS"
txt_AutoPilot_KEEP_AS_IS.material		= "font_hints_kneeboard"
txt_AutoPilot_KEEP_AS_IS.init_pos		= {value_x, getLineY(15), 0}
txt_AutoPilot_KEEP_AS_IS.value			= "ATTITUDE HOLD"
txt_AutoPilot_KEEP_AS_IS.alignment		= "RightCenter"
txt_AutoPilot_KEEP_AS_IS.stringdefs		= predefined_font_1
txt_AutoPilot_KEEP_AS_IS.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_KEEP_AS_IS)

txt_AutoPilot_KEEP_AS_IS_key				= CreateElement "ceStringPoly"
txt_AutoPilot_KEEP_AS_IS_key.name			= "txt_AutoPilot_KEEP_AS_IS_key"
txt_AutoPilot_KEEP_AS_IS_key.material		= "font_hints_kneeboard_keys"
txt_AutoPilot_KEEP_AS_IS_key.init_pos		= {key_x, getLineY(15), 0}
txt_AutoPilot_KEEP_AS_IS_key.value			= "LSHIFT+LALT+A"
txt_AutoPilot_KEEP_AS_IS_key.alignment		= "LeftCenter"
txt_AutoPilot_KEEP_AS_IS_key.stringdefs		= predefined_font_1
txt_AutoPilot_KEEP_AS_IS_key.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_KEEP_AS_IS_key)

txt_AutoPilot_H_AS_AB				= CreateElement "ceStringPoly"
txt_AutoPilot_H_AS_AB.name			= "txt_AutoPilot_H_AS_AB"
txt_AutoPilot_H_AS_AB.material		= "font_hints_kneeboard"
txt_AutoPilot_H_AS_AB.init_pos		= {value_x, getLineY(16), 0}
txt_AutoPilot_H_AS_AB.value			= "LEVEL FLIGHT"
txt_AutoPilot_H_AS_AB.alignment		= "RightCenter"
txt_AutoPilot_H_AS_AB.stringdefs	= predefined_font_1
txt_AutoPilot_H_AS_AB.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_H_AS_AB)

txt_AutoPilot_H_AS_AB_key				= CreateElement "ceStringPoly"
txt_AutoPilot_H_AS_AB_key.name			= "txt_AutoPilot_H_AS_AB_key"
txt_AutoPilot_H_AS_AB_key.material		= "font_hints_kneeboard_keys"
txt_AutoPilot_H_AS_AB_key.init_pos		= {key_x, getLineY(16), 0}
txt_AutoPilot_H_AS_AB_key.value			= "LCTRL+A"
txt_AutoPilot_H_AS_AB_key.alignment		= "LeftCenter"
txt_AutoPilot_H_AS_AB_key.stringdefs	= predefined_font_1
txt_AutoPilot_H_AS_AB_key.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_H_AS_AB_key)

txt_AutoPilot_TURN_IN				= CreateElement "ceStringPoly"
txt_AutoPilot_TURN_IN.name			= "txt_AutoPilot_TURN_IN"
txt_AutoPilot_TURN_IN.material		= "font_hints_kneeboard"
txt_AutoPilot_TURN_IN.init_pos		= {value_x, getLineY(17), 0}
txt_AutoPilot_TURN_IN.value			= "ORBIT"
txt_AutoPilot_TURN_IN.alignment		= "RightCenter"
txt_AutoPilot_TURN_IN.stringdefs	= predefined_font_1
txt_AutoPilot_TURN_IN.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_TURN_IN)

txt_AutoPilot_TURN_IN_key				= CreateElement "ceStringPoly"
txt_AutoPilot_TURN_IN_key.name			= "txt_AutoPilot_TURN_IN_key"
txt_AutoPilot_TURN_IN_key.material		= "font_hints_kneeboard_keys"
txt_AutoPilot_TURN_IN_key.init_pos		= {key_x, getLineY(17), 0}
txt_AutoPilot_TURN_IN_key.value			= "LALT+A"
txt_AutoPilot_TURN_IN_key.alignment		= "LeftCenter"
txt_AutoPilot_TURN_IN_key.stringdefs	= predefined_font_1
txt_AutoPilot_TURN_IN_key.controllers	= {{"AutoPilot"}, {"AutoPilot_show"}}
AddElement(txt_AutoPilot_TURN_IN_key)


-- CARGO ------------------------------
---------------------------------------


local cargo_first_line_y = firstLineY - dY * 19
local cargo_line1_y = cargo_first_line_y
local cargo_line2_y = cargo_first_line_y - dY * 1
local cargo_line3_y = cargo_first_line_y - dY * 2
local cargo_line4_y = cargo_first_line_y - dY * 3
local cargo_line5_y = cargo_first_line_y - dY * 4
local cargo_line6_y = cargo_first_line_y - dY * 5
local cargo_line7_y = cargo_first_line_y - dY * 6
local cargo_line8_y = cargo_first_line_y - dY * 7
local cargo_line9_y = cargo_first_line_y - dY * 8

local cargo_label_x = 0.2
local cargo_value_x = 0.4
local cargo_key_x = 0.4

txt_CARGO				= CreateElement "ceStringPoly"
txt_CARGO.name			= "txt_CARGO"
txt_CARGO.material		= "font_hints_kneeboard"
txt_CARGO.init_pos		= {0,  cargo_line1_y, 0}
txt_CARGO.value			= "CARGO:"
txt_CARGO.alignment		= "CenterCenter"
txt_CARGO.stringdefs	= predefined_font_08
txt_CARGO.controllers	= {{"show_cargo_status"}}
AddElement(txt_CARGO)

txt_Hook				= CreateElement "ceStringPoly"
txt_Hook.name			= "txt_Hook"
txt_Hook.material		= "font_hints_kneeboard"
txt_Hook.init_pos		= {cargo_label_x,  cargo_line2_y, 0}
txt_Hook.value			= "CARGO HOOK COMBO"
txt_Hook.alignment		= "RightCenter"
txt_Hook.stringdefs		= predefined_font_0
txt_Hook.controllers	= {{"show_cargo_status"}}
AddElement(txt_Hook)

txt_Hook_Key			= CreateElement "ceStringPoly"
txt_Hook_Key.name		= "txt_Hook_Key"
txt_Hook_Key.material	= "font_hints_kneeboard_keys"
txt_Hook_Key.init_pos	= {cargo_key_x,  cargo_line2_y, 0}
txt_Hook_Key.value    	= "RC+RS+L"
txt_Hook_Key.alignment  = "LeftCenter"
txt_Hook_Key.stringdefs	= predefined_font_0
txt_Hook_Key.controllers    = {{"show_cargo_status"}}
AddElement(txt_Hook_Key)

txt_AutoUnhook				= CreateElement "ceStringPoly"
txt_AutoUnhook.name			= "txt_AutoUnhook"
txt_AutoUnhook.material		= "font_hints_kneeboard"
txt_AutoUnhook.init_pos		= {cargo_label_x,  cargo_line3_y, 0}
txt_AutoUnhook.value		= "CARGO AUTOUNHOOK COMBO"
txt_AutoUnhook.alignment	= "RightCenter"
txt_AutoUnhook.stringdefs	= predefined_font_0
txt_AutoUnhook.controllers	= {{"show_cargo_status"}}
AddElement(txt_AutoUnhook)

txt_AutoUnhook_Key				= CreateElement "ceStringPoly"
txt_AutoUnhook_Key.name			= "txt_AutoUnhook_Key"
txt_AutoUnhook_Key.material		= "font_hints_kneeboard_keys"
txt_AutoUnhook_Key.init_pos		= {cargo_key_x,  cargo_line3_y, 0}
txt_AutoUnhook_Key.value		= "RC+RS+K"
txt_AutoUnhook_Key.alignment	= "LeftCenter"
txt_AutoUnhook_Key.stringdefs	= predefined_font_0
txt_AutoUnhook_Key.controllers	= {{"show_cargo_status"}}
AddElement(txt_AutoUnhook_Key)

txt_TacUnook				= CreateElement "ceStringPoly"
txt_TacUnook.name			= "txt_TacUnook"
txt_TacUnook.material		= "font_hints_kneeboard"
txt_TacUnook.init_pos		= {cargo_label_x,  cargo_line4_y, 0}
txt_TacUnook.value			= "UNHOOK COMBO"
txt_TacUnook.alignment		= "RightCenter"
txt_TacUnook.stringdefs		= predefined_font_0
txt_TacUnook.controllers	= {{"show_cargo_status"}}
AddElement(txt_TacUnook)

txt_TacUnook_Key			= CreateElement "ceStringPoly"
txt_TacUnook_Key.name		= "txt_TacUnook_Key"
txt_TacUnook_Key.material	= "font_hints_kneeboard_keys"
txt_TacUnook_Key.init_pos	= {cargo_key_x,  cargo_line4_y, 0}
txt_TacUnook_Key.value    	= "RC+RS+:"
txt_TacUnook_Key.alignment  = "LeftCenter"
txt_TacUnook_Key.stringdefs	= predefined_font_0
txt_TacUnook_Key.controllers    = {{"show_cargo_status"}}
AddElement(txt_TacUnook_Key)

txt_CargoIndicator			= CreateElement "ceStringPoly"
txt_CargoIndicator.name		= "txt_CargoIndicator"
txt_CargoIndicator.material	= "font_hints_kneeboard"
txt_CargoIndicator.init_pos	= {cargo_label_x,  cargo_line5_y, 0}
txt_CargoIndicator.value		= "CARGO INDICATOR COMBO"
txt_CargoIndicator.alignment	= "RightCenter"
txt_CargoIndicator.stringdefs	= predefined_font_0
txt_CargoIndicator.controllers	= {{"show_cargo_status"}}
AddElement(txt_CargoIndicator)

txt_CargoIndicator_Key				= CreateElement "ceStringPoly"
txt_CargoIndicator_Key.name		= "txt_CargoIndicator_Key"
txt_CargoIndicator_Key.material	= "font_hints_kneeboard_keys"
txt_CargoIndicator_Key.init_pos	= {cargo_key_x,  cargo_line5_y, 0}
txt_CargoIndicator_Key.value		= "RC+RS+P"
txt_CargoIndicator_Key.alignment	= "LeftCenter"
txt_CargoIndicator_Key.stringdefs	= predefined_font_0
txt_CargoIndicator_Key.controllers	= {{"show_cargo_status"}}
AddElement(txt_CargoIndicator_Key)


txt_Cargo_Rope_Length				= CreateElement "ceStringPoly"
txt_Cargo_Rope_Length.name			= "txt_Cargo_Rope_Length"
txt_Cargo_Rope_Length.material		= "font_hints_kneeboard"
txt_Cargo_Rope_Length.init_pos		= {cargo_label_x,  cargo_line6_y, 0}
txt_Cargo_Rope_Length.value			= "ROPE LENGTH"
txt_Cargo_Rope_Length.alignment		= "RightCenter"
txt_Cargo_Rope_Length.stringdefs	= predefined_font_0
txt_Cargo_Rope_Length.controllers	= {{"show_cargo_status"}}
AddElement(txt_Cargo_Rope_Length)

txt_Cargo_Rope_Length_Value				= CreateElement "ceStringPoly"
txt_Cargo_Rope_Length_Value.name		= "txt_Cargo_Rope_Length_Value"
txt_Cargo_Rope_Length_Value.material	= "font_hints_kneeboard"
txt_Cargo_Rope_Length_Value.init_pos	= {cargo_value_x,  cargo_line6_y, 0}
txt_Cargo_Rope_Length_Value.alignment	= "LeftCenter"
txt_Cargo_Rope_Length_Value.stringdefs	= predefined_font_0
txt_Cargo_Rope_Length_Value.controllers	= {{"show_cargo_status"}, {"cargo_rope_length"}}
AddElement(txt_Cargo_Rope_Length_Value)

txt_Cargo_Status				= CreateElement "ceStringPoly"
txt_Cargo_Status.name			= "txt_Cargo_Status"
txt_Cargo_Status.material		= "font_hints_kneeboard"
txt_Cargo_Status.init_pos		= {cargo_label_x,  cargo_line7_y, 0}
txt_Cargo_Status.formats		= {"CARGO IS NOT CHOSEN", "CARGO IS CHOSEN", "CARGO IS HOOKED"}
txt_Cargo_Status.alignment		= "RightCenter"
txt_Cargo_Status.stringdefs		= predefined_font_0
txt_Cargo_Status.controllers	= {{"show_cargo_status"}, {"cargo_status"}}
AddElement(txt_Cargo_Status)

txt_Cargo_Mass_Value				= CreateElement "ceStringPoly"
txt_Cargo_Mass_Value.name			= "txt_Cargo_Mass_Value"
txt_Cargo_Mass_Value.material		= "font_hints_kneeboard"
txt_Cargo_Mass_Value.init_pos		= {cargo_value_x,  cargo_line7_y, 0}
txt_Cargo_Mass_Value.alignment		= "LeftCenter"
txt_Cargo_Mass_Value.stringdefs		= predefined_font_0
txt_Cargo_Mass_Value.controllers	= {{"show_cargo_status"}, {"cargo_mass"}}
AddElement(txt_Cargo_Mass_Value)

