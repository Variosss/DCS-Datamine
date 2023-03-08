dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

local function setMissleSymbol(name, pos, parent, controller)
	local symbol = addStrokeSymbol(name, {"stroke_symbols_MDI_AMPCD", "116-aim"}, "FromSet", pos, parent, controller)
	symbol.init_rot    = {45}
end

local Status_Set = 
{-- TODO when all statuses will be add in enum
	"",
	"FAIL",
	"DEGD",
	"HUNG",
	"STBY",
	"RDY",
	"SEL",
	"L SEL",
	"R SEL",
	"",--"Status_F_SEL",		
	"",--"Status_TF_AXED",
	"",--"Status_TM_AXED",
	"LKD",
	"UNLKD",
	"H+LKD",
	"H+ULK",
	"",--"Status_TSN",
	"",--"Status_H_TSN",
	"SDEGD",
	"WDEGD",
	"ERASE",
}

local UpNumberYPos = 330

local LSTYPos = 230
local OffsetBetweenStr = 28

local LittleAngle = 3
local BigAngle = 25
local LittleLineLen = 45
local BigLineLen = 350
local littleLineXOffset = 45
local RangeBetweenMissleSymbols = 15

local SelectiveBoxWidth = 26
local SelectiveBoxHeight = 110

addStrokeText("Gun_Data_Rounds", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, UpNumberYPos}, nil, {{"MPD_SMS_GunDataRound"}})
addStrokeText("Gun_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, UpNumberYPos - OffsetBetweenStr * 1.5}, nil, {{"MPD_SMS_GunStatus"}})

local BigLinePosRight = {littleLineXOffset + math.floor(math.cos(math.rad(-90 + LittleAngle)) * LittleLineLen), LSTYPos + 13 + math.floor(math.sin(math.rad(-90 + LittleAngle)) * LittleLineLen)}
addStrokeLine("MainLineRightUP", LittleLineLen, {littleLineXOffset, LSTYPos + 13}, 180 + LittleAngle)
addStrokeLine("MainLineRightBottom", BigLineLen, BigLinePosRight, -90 - BigAngle)

local BigLinePosLeft = {-littleLineXOffset + math.floor(math.cos(math.rad(-90 - LittleAngle)) * LittleLineLen), LSTYPos + 13 + math.floor(math.sin(math.rad(-90 - LittleAngle)) * LittleLineLen)}
addStrokeLine("MainLineLeftUP", LittleLineLen, {-littleLineXOffset, LSTYPos + 13}, 180 - LittleAngle)
addStrokeLine("MainLineLeftBottom", BigLineLen, BigLinePosLeft, 90 + BigAngle)

----------------------------------------------- Pylon 5 -----------------------------------------------------------------------------------------------------------------------------
addStrokeText("STA5_Label_01", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, LSTYPos})
addStrokeText("STA5_Label_02", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, LSTYPos - OffsetBetweenStr})
--symbols line
addStrokeSymbol("STA5_BRU_33", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {0, LSTYPos - OffsetBetweenStr * 2}, nil, {{"MPD_SMS_BRU_33_Symbol", 5}})
--amount line
addStrokeText("STA5_Label_AMOUNT", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, LSTYPos - OffsetBetweenStr * 2}, nil, {{"MPD_SMS_Pylon_Label_Amount", 5, -OffsetBetweenStr}})
--type line
addStrokeText("STA5_Label_TYPE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, LSTYPos - OffsetBetweenStr * 2}, nil, {{"MPD_SMS_Pylon_Label_Type", 5, -OffsetBetweenStr}})
addStrokeBox("STA5_Selective_Box_Line_02", SelectiveBoxHeight, SelectiveBoxWidth - 4, "CenterCenter", {0, 0}, "STA5_Label_TYPE", {{"MPD_SMS_CurrentLaunchPylon", 5}})
--status line
addStrokeText("STA5_Label_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -OffsetBetweenStr}, "STA5_Label_TYPE", {{"MPD_SMS_Pylon_Label_Status", 5}}, Status_Set)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 4 -----------------------------------------------------------------------------------------------------------------------------
addStrokeLine("STA4_Line", 5, {-littleLineXOffset, LSTYPos + 13}, 90)
setMissleSymbol("Missle_Symbol_STA4", {-littleLineXOffset - OffsetBetweenStr, LSTYPos + 13}, nil, {{"MPD_SMS_MissleSymbol", 4}})

addStrokeText("STA4_Label_01", nil, STROKE_FNT_DFLT_100, "RightCenter", {-littleLineXOffset - OffsetBetweenStr * 2, LSTYPos + 13}, nil, {{"MPD_SMS_Pylon_Label_02", 4}})
addStrokeText("STA4_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "RightCenter", {20, 0}, "STA4_Label_01", {{"MPD_AIM7_TEST", 4}})
addStrokeText("STA4_Label_02", nil, STROKE_FNT_DFLT_100, "RightCenter", {-littleLineXOffset - OffsetBetweenStr * 2, LSTYPos - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_04", 4}}, Status_Set)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 3 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosLeft = {BigLinePosLeft [1] - math.floor(math.cos(math.rad(BigAngle)) * BigLineLen / 3), BigLinePosLeft[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
addStrokeLine("STA3_Line", 5, BigLinePosLeft, -180)

--symbols line
setMissleSymbol("STA3_AA_Missile_Single", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_MissleSymbol", 3}})
setMissleSymbol("STA3_AIM-9_Left", {BigLinePosLeft[1] - RangeBetweenMissleSymbols, BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 3, 0}})
setMissleSymbol("STA3_AIM-9_Right", {BigLinePosLeft[1] + RangeBetweenMissleSymbols, BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 3, 1}})
addStrokeSymbol("STA3_BRU_33", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_BRU_33_Symbol", 3}})
--amount line
addStrokeText("STA3_Label_AMOUNT", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Amount", 3, -OffsetBetweenStr}})
--type line
addStrokeText("STA3_Label_TYPE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Type", 3, -OffsetBetweenStr}})
addStrokeBox("STA3_Selective_Box_Line_02", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA3_Label_TYPE", {{"MPD_SMS_CurrentLaunchPylon", 3}})
addStrokeText("STA3_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "CenterCenter", {0, 0}, "STA3_Label_TYPE", {{"MPD_AIM7_TEST", 3}})
--status line
addStrokeText("STA3_Label_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -OffsetBetweenStr}, "STA3_Label_TYPE", {{"MPD_SMS_Pylon_Label_Status", 3}}, Status_Set)


addStrokeText("STA3_IR_CODE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, - OffsetBetweenStr * 5}, "STA3_Label_TYPE", {{"MPD_SMS_IR_CODE", 3}})
addStrokeBox("STA3_IR_CODE_Box", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA3_IR_CODE", {{"MPD_SMS_IR_CODE_Box", 3}})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 2 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosLeft = {BigLinePosLeft [1] - math.floor(math.cos(math.rad(BigAngle)) * BigLineLen / 3), BigLinePosLeft[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
addStrokeLine("STA2_Line", 5, BigLinePosLeft, -180)

--symbols line
setMissleSymbol("STA2_AA_Missile_Single", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_MissleSymbol", 2}})
setMissleSymbol("STA2_AIM-9_Left", {BigLinePosLeft[1] - RangeBetweenMissleSymbols, BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 2, 0}})
setMissleSymbol("STA2_AIM-9_Right", {BigLinePosLeft[1] + RangeBetweenMissleSymbols, BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 2, 1}})
addStrokeSymbol("STA2_BRU_33", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_BRU_33_Symbol", 2}})
--amount line
addStrokeText("STA2_Label_AMOUNT", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Amount", 2, -OffsetBetweenStr}})
--type line
addStrokeText("STA2_Label_TYPE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1], BigLinePosLeft[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Type", 2, -OffsetBetweenStr}})
addStrokeBox("STA2_Selective_Box_Line_02", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA2_Label_TYPE", {{"MPD_SMS_CurrentLaunchPylon", 2, 2}})
addStrokeText("STA2_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "CenterCenter", {0, 0}, "STA2_Label_TYPE", {{"MPD_AIM7_TEST", 2}})
--status line
addStrokeText("STA2_Label_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -OffsetBetweenStr}, "STA2_Label_TYPE", {{"MPD_SMS_Pylon_Label_Status", 2}}, Status_Set)

addStrokeText("STA2_IR_CODE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, - OffsetBetweenStr * 5}, "STA2_Label_TYPE", {{"MPD_SMS_IR_CODE", 2}})
addStrokeBox("STA2_IR_CODE_Box", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA2_IR_CODE", {{"MPD_SMS_IR_CODE_Box", 2}})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

addStrokeText("Master_Arm_Status", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, 85}, nil, {{"MPD_SMS_MasterArm"}})

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
addStrokeText("MPD_HARM_PB_InRng",		"", STROKE_FNT_DFLT_120, "RightCenter", {400, 400}, nil, {{"MPD_HARM_PB_RNG", 0}}, {"A/C RNG", "HRM RNG"})
local tofLabel = addStrokeText("MPD_HARM_PB_Tof_Label",	"FLT", STROKE_FNT_DFLT_120, "RightCenter", {250, 303}, nil, {{"MPD_HARM_PB_RNG", 1}})
addStrokeText("MPD_HARM_PB_Ttt_up",		"15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, 34}, tofLabel.name, {{"MPD_HARM_PB_RNG", 1}}, {"%2d:%02d"})
addStrokeText("MPD_HARM_PB_Ttt_dn",		"15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, 0}, tofLabel.name, {{"MPD_HARM_PB_RNG", 2}}, {"%2d:%02d"})
addStrokeText("MPD_HARM_PB_Ttt_diff", 	"-15:00", STROKE_FNT_DFLT_120, "RightCenter", {150, -44}, tofLabel.name, {{"MPD_HARM_PB_RNG", 3}}, {"%s%2d:%02d"})
addStrokeLine("MPD_HARM_PB_Line", 130, {170, -20}, 90, tofLabel.name)

addStrokeText("STORES_HARM_SP_PB_Indication", nil, STROKE_FNT_DFLT_150, "CenterCenter", {0, 50}, nil, {{"MPD_HARM_SP_PB_Indication"}})
add_X_Over("STORES_HARM_SP_PB_Indication_X", 150, 36, {0, 0}, "STORES_HARM_SP_PB_Indication", {{"MPD_HARM_SP_PB_Indication_X"}})

----------------------------------------------- Pylon 1 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosLeft = {BigLinePosLeft [1] - math.floor(math.cos(math.rad(BigAngle)) * BigLineLen / 3), BigLinePosLeft[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
setMissleSymbol("Missle_Symbol_STA1", {BigLinePosLeft[1] - 8, BigLinePosLeft[2]}, nil, {{"MPD_SMS_MissleSymbol", 1}})

addStrokeText("STA1_Label_02", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1] - 10, BigLinePosLeft[2] + OffsetBetweenStr * 2}, nil, {{"MPD_SMS_Pylon_Label_02", 1}})
addStrokeText("STA1_Label_04", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosLeft[1] - 10, BigLinePosLeft[2] + OffsetBetweenStr * 3}, nil, {{"MPD_SMS_Pylon_Label_04", 1}}, Status_Set)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 6 -----------------------------------------------------------------------------------------------------------------------------
addStrokeLine("STA6_Line", 5, {littleLineXOffset, LSTYPos + 13}, -90)
setMissleSymbol("Missle_Symbol_STA6", {littleLineXOffset + OffsetBetweenStr, LSTYPos + 13}, nil, {{"MPD_SMS_MissleSymbol", 6}})

addStrokeText("STA6_Label_01", nil, STROKE_FNT_DFLT_100, "LeftCenter", {littleLineXOffset + OffsetBetweenStr * 2, LSTYPos + 13},nil , {{"MPD_SMS_Pylon_Label_02", 6}})
addStrokeText("STA6_Label_02", nil, STROKE_FNT_DFLT_100, "LeftCenter", {littleLineXOffset + OffsetBetweenStr * 2, LSTYPos - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_04", 6}}, Status_Set)
addStrokeText("STA6_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "LeftCenter", {-20, 0}, "STA6_Label_01", {{"MPD_AIM7_TEST", 6}})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 7 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosRight = {BigLinePosRight [1] + math.floor(math.cos(math.rad(-BigAngle)) * BigLineLen / 3), BigLinePosRight[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
addStrokeLine("STA7_Line", 5, BigLinePosRight, -180)

--symbols line
setMissleSymbol("STA7_AA_Missile_Single", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_MissleSymbol", 7}})
setMissleSymbol("STA7_AIM-9_Left", {BigLinePosRight[1] - RangeBetweenMissleSymbols, BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 7, 0}})
setMissleSymbol("STA7_AIM-9_Right", {BigLinePosRight[1] + RangeBetweenMissleSymbols, BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 7, 1}})
addStrokeSymbol("STA7_BRU_33", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_BRU_33_Symbol", 7}})
--amount line
addStrokeText("STA7_Label_AMOUNT", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Amount", 7, -OffsetBetweenStr}})
--type line
addStrokeText("STA7_Label_TYPE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Type", 7, -OffsetBetweenStr}})
addStrokeBox("STA7_Selective_Box_Line_02", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA7_Label_TYPE", {{"MPD_SMS_CurrentLaunchPylon", 7, 2}})
addStrokeText("STA7_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "CenterCenter", {0, 0}, "STA7_Label_TYPE", {{"MPD_AIM7_TEST", 7}})
--status line
addStrokeText("STA7_Label_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -OffsetBetweenStr}, "STA7_Label_TYPE", {{"MPD_SMS_Pylon_Label_Status", 7}}, Status_Set)

addStrokeText("STA7_IR_CODE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, - OffsetBetweenStr * 5}, "STA7_Label_TYPE", {{"MPD_SMS_IR_CODE", 7}})
addStrokeBox("STA7_IR_CODE_Box", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA7_IR_CODE", {{"MPD_SMS_IR_CODE_Box", 7}})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 8 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosRight = {BigLinePosRight [1] + math.floor(math.cos(math.rad(-BigAngle)) * BigLineLen / 3), BigLinePosRight[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
addStrokeLine("STA8_Line", 5, BigLinePosRight, -180)
--symbols line
setMissleSymbol("STA8_AA_Missile_Single", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_MissleSymbol", 8}})
setMissleSymbol("STA8_AIM-9_Left", {BigLinePosRight[1] - RangeBetweenMissleSymbols, BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 8, 0}})
setMissleSymbol("STA8_AIM-9_Right", {BigLinePosRight[1] + RangeBetweenMissleSymbols, BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_SidewinderOnLAU_115", 8, 1}})
addStrokeSymbol("STA8_BRU_33", {"stroke_symbols_MDI_AMPCD", "134-rhombus"}, "FromSet", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_BRU_33_Symbol", 8}})
--amount line
addStrokeText("STA8_Label_AMOUNT", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Amount", 8, -OffsetBetweenStr}})
--type line
addStrokeText("STA8_Label_TYPE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] - OffsetBetweenStr}, nil, {{"MPD_SMS_Pylon_Label_Type", 8, -OffsetBetweenStr}})
addStrokeBox("STA8_Selective_Box_Line_02", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA8_Label_TYPE", {{"MPD_SMS_CurrentLaunchPylon", 8, 2}})
addStrokeText("STA8_Label_TYPE_X", " X ", STROKE_FNT_DFLT_150, "CenterCenter", {0, 0}, "STA8_Label_TYPE", {{"MPD_AIM7_TEST", 8}})
--status line
addStrokeText("STA8_Label_Status", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -OffsetBetweenStr}, "STA8_Label_TYPE", {{"MPD_SMS_Pylon_Label_Status", 8}}, Status_Set)

addStrokeText("STA8_IR_CODE", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, - OffsetBetweenStr * 5}, "STA8_Label_TYPE", {{"MPD_SMS_IR_CODE", 8}})
addStrokeBox("STA8_IR_CODE_Box", SelectiveBoxHeight, SelectiveBoxWidth, "CenterCenter", {0, 0}, "STA8_IR_CODE", {{"MPD_SMS_IR_CODE_Box", 8}})
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------- Pylon 9 -----------------------------------------------------------------------------------------------------------------------------
BigLinePosRight = {BigLinePosRight [1] + math.floor(math.cos(math.rad(-BigAngle)) * BigLineLen / 3), BigLinePosRight[2] + math.floor(math.sin(math.rad(-BigAngle)) * BigLineLen / 3)}
setMissleSymbol("Missle_Symbol_STA9", {BigLinePosRight[1] + 8, BigLinePosRight[2]}, nil, {{"MPD_SMS_MissleSymbol", 9}})
addStrokeText("STA9_Label_02", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] + OffsetBetweenStr * 2}, nil, {{"MPD_SMS_Pylon_Label_02", 9}})
addStrokeText("STA9_Label_04", nil, STROKE_FNT_DFLT_100, "CenterCenter", {BigLinePosRight[1], BigLinePosRight[2] + OffsetBetweenStr * 3}, nil, {{"MPD_SMS_Pylon_Label_04", 9}}, Status_Set)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local ProgYPos = -180
local PROGUnderlineLen = 95

local ColumnYPos = -210
local BasicOffsetForColumn = -220
local OffsetBetweenColumn = 130

local Prgr_NUMB = 
{
	"1",
	"2",
	"3",
	"4",
	"5",
}



addPlaceholder("PROG_BASE", {0,0}, nil, {{"MPD_SMS_Prgr", 0}})
addPlaceholder("PROG_BASE_ROCKETS", {0,0}, nil, {{"MPD_SMS_Prgr", 1}})
addPlaceholder("PROG_BASE_GUN", {0,0}, nil, {{"MPD_SMS_Prgr", 2}})
addPlaceholder("PROG_BASE_JDAM", {0,0}, nil, {{"MPD_SMS_Prgr", 3}})
addPlaceholder("PROG_BASE_SLAM", {0,0}, nil, {{"MPD_SMS_Prgr", 4}})
addPlaceholder("PROG_BASE_HARPOON", {0,0}, nil, {{"MPD_SMS_Prgr", 5}})

addPlaceholder("PROG_BOMB", {0,15}, "PROG_BASE", {{"MPD_SMS_Show_Bomb_Prgm"}})

addStrokeText("PROG", "PROG ", STROKE_FNT_DFLT_100, "CenterCenter", {0, ProgYPos}, "PROG_BOMB")
addStrokeLine("PROG_Underline", PROGUnderlineLen, {-45, ProgYPos - OffsetBetweenStr / 2 - 3}, -90, "PROG_BOMB")

addPlaceholder("PROG_CROSS", {-45, ProgYPos}, "PROG_BOMB", {{"MPD_PROG_CROSS"}})
addStrokeLine("PROG_Cross1", PROGUnderlineLen * 0.83, {0, -OffsetBetweenStr / 2 - 1}, -68, "PROG_CROSS")
addStrokeLine("PROG_Cross2", PROGUnderlineLen * 0.83, {0, OffsetBetweenStr / 2 + 1}, -112, "PROG_CROSS")
addStrokeText("PROG_NUMB", nil, STROKE_FNT_DFLT_100, "CenterCenter", {40, 0}, "PROG", {{"MPD_SMS_Prgr_NUMB"}}, Prgr_NUMB)

addStrokeText("PROG_STR_1_Line_1", "MODE", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr}, "PROG_BOMB")
addStrokeText("PROG_STR_1_Line_2", "MFUZ", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 2}, "PROG_BOMB")
addStrokeText("PROG_STR_1_Line_3", "EFUZ", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 3}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 0}})
addStrokeText("PROG_STR_1_Line_4", "DRAG", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 0}})
--addStrokeText("PROG_STR_1_Line_4_gbu24", "LAR", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}})
addStrokeText("PROG_STR_1_Line_5", "HT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 5}, "PROG_BOMB", {{"MPD_SMS_HT_PBLabel"}})
--addStrokeText("PROG_STR_1_Line_5_gbu24", "ARM", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 5}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}})


local Prgr_MODE = 
{
	"AUTO",
	"FD",
	"CCIP",
	"MAN",
	"CLAR PP",
	"CLAR SL",
}

local Prgr_MFUZ = 
{
	"",
	"OFF",
	"NOSE",
	"TAIL",
	"N/T",
	"OFF",
	"PRI",
	"VT",
}

local Prgr_EFUZ = 
{
	"",
	"OFF",
	"VT",
	"INST",
	"DLY1",
	"DLY2",
}

local Prgr_DRAG = 
{
	"FF",
	"RET",
}

addStrokeText("PROG_STR_2_Line_1", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_1", {{"MPD_SMS_Prgr_MODE"}}, Prgr_MODE)
addStrokeText("PROG_STR_2_Line_2", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_2", {{"MPD_SMS_Prgr_MFUZ"}}, Prgr_MFUZ)
addStrokeText("PROG_STR_2_Line_3", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_3", {{"MPD_SMS_Prgr_EFUZ"}}, Prgr_EFUZ)
addStrokeText("PROG_STR_2_Line_4", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_4", {{"MPD_SMS_Prgr_DRAG"}}, Prgr_DRAG)

local Prgr_LAR = 
{
	"FULL",
	"DEG 1",
	"DEG 2",
}
--addStrokeText("PROG_STR_2_Line_4_gbu24", "DEG 1", STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_4_gbu24", {{"MPD_SMS_Prgr_GBU24_LAR"}}, Prgr_LAR)

local Prgr_ARM = 
{
	"5.5 S",
	"12 S"
}
--addStrokeText("PROG_STR_2_Line_5_gbu24", "5.5 S", STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0}, "PROG_STR_1_Line_5_gbu24", {{"MPD_SMS_Prgr_GBU24_ARM"}}, Prgr_ARM)




addStrokeText("PROG_STR_3_Line_1", "QTY", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr}, "PROG_BOMB")
addStrokeText("PROG_STR_3_Line_2", "MULT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 2}, "PROG_BOMB")
addStrokeText("PROG_STR_3_Line_3", "INT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 3}, "PROG_BOMB", {{"MPD_SMS_Prgr_Show_INTERVAL"}})

local Prgr_ADD = 
{
	"NONE",
	"BANK",
	"NONE",
	"RTCL",
}
addStrokeText("PROG_STR_3_Line_4", nil, STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BOMB", {{"MPD_SMS_Prgr_RTCL_BANK"}, {"ShowMFuzeModeGBU24", 0}}, Prgr_ADD)
addStrokeText("PROG_STR_3_Line_4_gbu24", "HDG", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BOMB", {{"MPD_SMS_Prgr_GBU24_HDG", 0}, {"ShowMFuzeModeGBU24", 1}})
--addStrokeText("PROG_STR_3_Line_5_gbu24", "BILT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 5}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}})
--addStrokeText("PROG_STR_3_Line_6_gbu24", "AILT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 6}, "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}})


addStrokeText("PROG_QTY", nil, STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 3, ColumnYPos - OffsetBetweenStr}, "PROG_BOMB", {{"MPD_SMS_Prgr_QTY"}})
addStrokeText("PROG_MULT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 3, ColumnYPos - OffsetBetweenStr * 2}, "PROG_BOMB", {{"MPD_SMS_Prgr_MULT"}})
addStrokeText("PROG_INTERVAL", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_3_Line_3", {{"MPD_SMS_Prgr_INTERVAL"}})
addStrokeText("PROG_RTCL", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_3_Line_4", {{"MPD_SMS_Prgr_RTCL_Val"}})
addStrokeText("PROG_HDG", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_3_Line_4_gbu24", {{"MPD_SMS_Prgr_GBU24_HDG", 1}}, {"%d°T"})
addStrokeText("PROG_HT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_1_Line_5", {{"MPD_SMS_Prgr_HT_Val"}})
--addStrokeText("PROG_BILT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_3_Line_5_gbu24", {{"MPD_SMS_Prgr_GBU24_BILT"}})
--addStrokeText("PROG_AILT", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_STR_3_Line_6_gbu24", {{"MPD_SMS_Prgr_GBU24_AILT"}})

addStrokeText("PROG_Rockets_STR_3_Line_4", nil, STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BASE_ROCKETS", {{"MPD_SMS_Prgr_RTCL_BANK"}}, Prgr_ADD)
addStrokeText("PROG_RTCL_ROCKETS", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_Rockets_STR_3_Line_4", {{"MPD_SMS_Prgr_RTCL_Val"}})

addStrokeText("PROG_Gun_STR_3_Line_4", nil, STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BASE_GUN", {{"MPD_SMS_Prgr_RTCL_BANK"}}, Prgr_ADD)
addStrokeText("PROG_RTCL_GUN", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_Gun_STR_3_Line_4", {{"MPD_SMS_Prgr_RTCL_Val"}})

addStrokeText("PROG_H", "PROG ", STROKE_FNT_DFLT_100, "CenterCenter", {0, ProgYPos}, "PROG_BASE_HARPOON")
addStrokeLine("PROG_H_Underline", PROGUnderlineLen, {-45, ProgYPos - OffsetBetweenStr / 2 - 3}, -90, "PROG_BASE_HARPOON")
addStrokeText("PROG_H_NUMB", nil, STROKE_FNT_DFLT_100, "CenterCenter", {40, 0}, "PROG_H", {{"MPD_SMS_Prgr_NUMB"}}, Prgr_NUMB)

addStrokeText("PROG_H_STR_1_Line_1", "MODE", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr}, "PROG_BASE_HARPOON")
addStrokeText("PROG_H_STR_1_Line_2", "FLT", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 2}, "PROG_BASE_HARPOON")
addStrokeText("PROG_H_STR_1_Line_3", "TERM", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 3}, "PROG_BASE_HARPOON")
addStrokeText("PROG_H_STR_1_Line_4", "SEEK", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BASE_HARPOON", {{"MPD_SMS_Harpoon_R_BL"}})

addStrokeText("PROG_H_STR_3_Line_1", "HPTP", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr}, "PROG_BASE_HARPOON", {{"MPD_SMS_HARPOON_HPTP_Label", 1}})
addStrokeText("PROG_H_STR_3_Line_2", "SRCH", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 2}, "PROG_BASE_HARPOON", {{"MPD_SMS_Harpoon_SRCH", 0}})
addStrokeText("PROG_H_STR_3_Line_3", "DSTR", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 3}, "PROG_BASE_HARPOON", {{"MPD_SMS_Harpoon_DSTR", 0}})
addStrokeText("PROG_H_STR_3_Line_4", "BRG", STROKE_FNT_DFLT_100, "LeftCenter", {BasicOffsetForColumn + OffsetBetweenColumn * 2, ColumnYPos - OffsetBetweenStr * 4}, "PROG_BASE_HARPOON", {{"MPD_SMS_Harpoon_BRG", 0}})


addStrokeText("PROG_H_SRCH", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_3_Line_2", {{"MPD_SMS_Harpoon_SRCH", 1}}, {"%d NM"})
addStrokeText("PROG_H_DSTR", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_3_Line_3", {{"MPD_SMS_Harpoon_DSTR", 1}}, {"%d NM"})
addStrokeText("PROG_H_BRG", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_3_Line_4",  {{"MPD_SMS_Harpoon_BRG", 1}}, {"%d°"})

local Harpoon_MODE = 
{
	"R/BL",
	"BOL",
}

local Harpoon_FLT = 
{
	"LOW",
	"MED",
	"HIGH",
}

local Harpoon_TERM = 
{
	"SKIM",
	"POP",
}

local Harpoon_SEEK = 
{
	"SML",
	"MED",
	"LRG",
}

addStrokeText("PROG_H_STR_2_Line_1", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_1_Line_1", {{"MPD_SMS_Harpoon_MODE"}}, Harpoon_MODE)
addStrokeText("PROG_H_STR_2_Line_2", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_1_Line_2", {{"MPD_SMS_Harpoon_FLT"}}, Harpoon_FLT)
addStrokeText("PROG_H_STR_2_Line_3", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_1_Line_3", {{"MPD_SMS_Harpoon_TERM"}}, Harpoon_TERM)
addStrokeText("PROG_H_STR_2_Line_4", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "PROG_H_STR_1_Line_4", {{"MPD_SMS_Harpoon_SEEK"}}, Harpoon_SEEK)


local HARPOON_STATUS_STORES = 
{
	"IN RNG",
	"IN ZONE",
	"INV SRCH",
	"INV TGT",
	"ALT",
	"OFF AXIS",
	"HPTP ANG",
	"A/C HPTP",
	"TGT/HPTP",
	"SCH/DSTR",
	"DSTR RNG",
	"TTMR %.2d",
	
}

addStrokeText("HARPOONInRng", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, "PROG_BASE_HARPOON", {{"HUD_AG_HARPOON_STATUS", 99}}, HARPOON_STATUS_STORES)

addStrokeText("Wingspan", "WSPN", STROKE_FNT_DFLT_100, "LeftCenter", {330, 390}, nil, {{"MPD_SMS_Gun_AA_WingSpan_Label"}})
addStrokeText("Wingspan_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {OffsetBetweenColumn, 0.0}, "Wingspan", {{"MPD_SMS_Wingspan_Val"}})

--add_PB_label(4, "MAN", "MODE   ")
--add_PB_label(5, "AUTO", "S")

local eMFuzeModes = 
{
	ERR_M = 0,
	OFF_M = 1,
	NOSE = 2,
	TAIL = 3,
	N_T = 4,
	CANISTER_OFF = 5,
	CANISTER_PRI = 6,
	CANISTER_VT = 7,
};

local eEFuzeModes =
{
	ERR_E = 0,
	OFF_E = 1,
	VT = 2,
	INST = 3,
	DLY1 = 4,
	DLY2 = 5
};

add_PB_label(1, {"DLY2", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 3, 0}, {"ShowEFuzeMode", eEFuzeModes.DLY2}}})
add_PB_label(1, {"HT",  "PROG_BASE", {{"MPD_SMS_HT_PBLabel"}}})
add_PB_label(1, {"CODE", nil, {{"MPD_SMS_CODE_PB1Label"}}})
                                                       
add_PB_label(2, {"DRAG", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 0, 0}, {"Show_DRAG"}}}) 
add_PB_label(2, {"MAN",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 1, 0}}})
add_PB_label(2, {"N/T",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 2, 0}, {"ShowMFuzeMode", eMFuzeModes.N_T}}})
add_PB_label(2, {"DLY1", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 3, 0}, {"ShowEFuzeMode", eEFuzeModes.DLY1}}})
				                                       
add_PB_label(3, {"EFUZ", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 0, 0}, {"Show_EFUZ"}}})
add_PB_label(3, {"CCIP", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 1, 0}}})
add_PB_label(3, {"TAIL", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 2, 0}, {"ShowMFuzeMode", eMFuzeModes.TAIL}}})
add_PB_label(3, {"INST", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 3, 0}, {"ShowEFuzeMode", eEFuzeModes.INST}}})
add_PB_label(3, {"VT",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels",  5, 0}}})
add_PB_label(3, {"MAN",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 6, 0}}})
add_PB_label(3, {"N/T",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 7, 0}, {"ShowMFuzeMode", eMFuzeModes.N_T}}})
				                                       
add_PB_label(4, {"MFUZ", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 0, 0}, {"Show_MFUZ"}}})
add_PB_label(4, {"FD",   "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 1, 0}}})
add_PB_label(4, {"NOSE", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 2, 0}, {"ShowMFuzeMode", eMFuzeModes.NOSE}}})
add_PB_label(4, {"VT",   "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 3, 0}, {"ShowEFuzeMode", eEFuzeModes.VT}}})
add_PB_label(4, {"RET",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 4, 0}}})
add_PB_label(4, {"PRI",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 5, 0}}})
add_PB_label(4, {"CLAR", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 6, 0}}}, {"SL", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 6, 0}}})
add_PB_label(4, {"TAIL", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 7, 0}, {"ShowMFuzeMode", eMFuzeModes.TAIL}}})
				                                       
add_PB_label(5, {"MODE", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 0, 0}}}) 
add_PB_label(5, {"AUTO", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 1, 0}}})
add_PB_label(5, {"OFF",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 2, 0}}})
add_PB_label(5, {"OFF",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 3, 0}}})
add_PB_label(5, {"FF",   "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 4, 0}}})
add_PB_label(5, {"OFF",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 5, 0}}})
add_PB_label(5, {"CLAR", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 6, 0}}}, {"PP", "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 6, 0}}})
add_PB_label(5, {"OFF",  "PROG_BASE", {{"MPD_SMS_1_5PBLabels", 7, 0}}})


add_PB_label(2, {"SAL", "PROG_BASE_ROCKETS", {{"MPD_SMS_1_5PBLabels", 1, 2}}, {{"MPD_SMS_1_5PBLabels", 1, 1}}})
add_PB_label(3, {"SGL", "PROG_BASE_ROCKETS", {{"MPD_SMS_1_5PBLabels", 2, 2}}, {{"MPD_SMS_1_5PBLabels", 2, 1}}})
add_PB_label(4, {"MAN", "PROG_BASE_ROCKETS", {{"MPD_SMS_1_5PBLabels", 3, 2}}, {{"MPD_SMS_1_5PBLabels", 3, 1}}})
add_PB_label(5, {"CCIP","PROG_BASE_ROCKETS", {{"MPD_SMS_1_5PBLabels", 4, 2}}, {{"MPD_SMS_1_5PBLabels", 4, 1}}})


add_PB_label(1, {"PGU", "PROG_BASE_GUN", {{"MPD_SMS_1_5PBLabels", 1, 3}}, {{"MPD_SMS_1_5PBLabels", 1, 4}}}, {"RND     ", "PROG_BASE_GUN", {{"MPD_SMS_1_5PBLabels", 1, 3}}})
add_PB_label(2, {"M50", "PROG_BASE_GUN", {{"MPD_SMS_1_5PBLabels", 2, 3}}, {{"MPD_SMS_1_5PBLabels", 2, 4}}})
add_PB_label(4, {"MAN", "PROG_BASE_GUN", {{"MPD_SMS_1_5PBLabels", 3, 3}}, {{"MPD_SMS_1_5PBLabels", 3, 4}}})
add_PB_label(5, {"CCIP","PROG_BASE_GUN", {{"MPD_SMS_1_5PBLabels", 4, 3}}, {{"MPD_SMS_1_5PBLabels", 4, 4}}})

add_PB_label(1, {"ARM",   "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}})
add_PB_label(2, {"ERASE", "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}, {{"MPD_SMS_JDAM_1_5PBLabels", 0, 1}}} , {"JDAM", "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_SMS_IAM_TYPE", 0}}})
add_PB_label(2, "", {"JSOW", "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_SMS_IAM_TYPE", 1}}})
add_PB_label(3, {"EFUZ",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}})
add_PB_label(4, {"MFUZ",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_SMS_JDAM_MFUZ_Label"}}})
add_PB_label(5, {"MODE", "PROG_BASE_JDAM", 	{{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}}, {"PP", "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 0}}})
add_PB_label(5, "", {"TOO", "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}, {"MPD_JDAM_MODE", 1}}})

add_PB_label(1, {"ACPT",  "PROG_BASE_JDAM",  {{"MPD_SMS_JDAM_1_5PBLabels", 3, 0}}})

add_PB_label(2, {"DLY1",  "PROG_BASE_JDAM",  {{"MPD_SMS_JDAM_1_5PBLabels", 2, 0}}})--VT1 or DLY1 for FMU-139 fuze
add_PB_label(2, {"CNX",  "PROG_BASE_JDAM",  {{"MPD_SMS_JDAM_1_5PBLabels", 3, 0}}})

add_PB_label(3, {"TAIL",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 1, 0}}})
add_PB_label(3, {"INST",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 2, 0}}})

add_PB_label(5, {"OFF",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 1, 0}}})
add_PB_label(5, {"OFF",  "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_1_5PBLabels", 2, 0}}})


local IN_RNG_ZONE = 
{
	"%.2d TMR",
	"IN RNG",
	"IN ZONE",
}

local ALGN_QUAL = 
{
	"01 GOOD",
	"02 GOOD",
	"03 GOOD",
	"04 MARG",
	"05 MARG",
	"06 MARG",
	"07 UNST",
	"08 UNST",
	"09 UNST",
	"10 UNST",
}

addStrokeText("TimingJDAM", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_Timing"}}, {"TIMING %d:%.2d"})

addStrokeText("JDAMInRng", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, "PROG_BASE_JDAM", {{"HUD_AG_JDAM_IN_RNG", 99}}, IN_RNG_ZONE)

addStrokeText("JDAMFltTime1", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 327}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_TOF", 1}})
addStrokeText("JDAMFltTime2", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 297}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_TOF", 2}})

addStrokeText("JDAMFltTimeDelta", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 267}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_TOF", 3}})
addStrokeLine("JDAMFltLine", 70, {-65, 17}, -90, "JDAMFltTimeDelta")

addStrokeText("JDAMFlt", "FLT", STROKE_FNT_DFLT_100, "RightCenter", {290, 297}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_TOF", 0}})

addStrokeText("TOT_PP", nil, STROKE_FNT_DFLT_100, "CenterCenter", {0, -70}, "PROG_BASE_JDAM", {{"MPD_SMS_JDAM_TOT_PP", 0}} ,{"TOT-PP %.2d:%.2d:%.2d", "TOT-PP"})
add_X_Over("TOT_PP_X", 70, 26, {0, 0}, "TOT_PP", {{"MPD_SMS_JDAM_TOT_PP", 1}})


addStrokeText("ALGN_QUAL", "ALN QUAL", STROKE_FNT_DFLT_100, "RightCenter", {-10, -140}, "PROG_BASE_JDAM", {{"ALGN_QUAL", 0}})
addStrokeText("ALGN_QUAL_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, -140}, "PROG_BASE_JDAM", {{"ALGN_QUAL", 1}}, ALGN_QUAL)


local IN_RNG_ZONE_GBU24 = 
{
	"%d:%.2d TMR",
	"IN RNG",
	"IN ZONE",
}

addStrokeText("GBU24InRng", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, "PROG_BOMB", {{"HUD_AG_GBU24_IN_RNG", 600}}, IN_RNG_ZONE_GBU24)
addStrokeText("GBU24_TOT", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 327}, "PROG_BOMB", {{"HUD_GBU24_TOT"}}, {"%.2d:%.2d:%.2d TOT"})

local JDAM_FUZE = 
{
	"EFUZ",
	"MFUZ",
}

local JDAM_MFUZE = 
{
	"   ",
	"OFF",
	"NOSE",
	"TAIL",
}

local JDAM_EFUZE = 
{
	"   ",
	"OFF",
	"VT1",
	"INST",
	"DLY1",
}

addStrokeText("JDAM_FUZ", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -280}, "PROG_BASE_JDAM", {{"JDAM_FUZE", 0}}, JDAM_FUZE)
addStrokeText("JDAM_EFUZ_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-280, -280}, "PROG_BASE_JDAM", {{"JDAM_FUZE", 1}}, JDAM_EFUZE)
addStrokeText("JDAM_MFUZ_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-280, -280}, "PROG_BASE_JDAM", {{"JDAM_FUZE", 2}}, JDAM_MFUZE)



--add_PB_label(1, {"CDTRQ", "PROG_BASE_SLAM", {{"MPD_SMS_JDAM_1_5PBLabels", 0, 0}}})
add_PB_label(2, {"ERASE", "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}, {{"MPD_SMS_SLAM_1_5PBLabels", 0, 1}}} , {"", "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}, {"MPD_SLAM_SLAM_ER"}}})
add_PB_label(3, {"EFUZ",  "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}})
add_PB_label(4, {"FLT",  "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}})
add_PB_label(5, {"MODE", "PROG_BASE_SLAM", 	{{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}}}, {"PP", "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}, {"MPD_SLAM_MODE", 0}}})
add_PB_label(5, "", {"TOO", "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_1_5PBLabels", 0, 0}, {"MPD_SLAM_MODE", 1}}})

add_PB_label(1, {"WEP", "PROG_BASE_SLAM", {{"MPD_SMS_DATALINK_WPN"}}})
add_PB_label(2, {"    ", "PROG_BASE_SLAM", {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 7}}})
add_PB_label(3, {"    ", "PROG_BASE_SLAM", {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 6}}})
add_PB_label(4, {"    ", "PROG_BASE_SLAM", {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 2}}})
add_PB_label(5, {"    ", "PROG_BASE_SLAM", {{"MPD_SMS_DATALINK_1_5_PBLabels", 1, 1}}})

add_PB_label(1, {"ACPT",  "PROG_BASE_SLAM",  {{"MPD_SMS_SLAM_1_5PBLabels", 1, 0}}})
add_PB_label(2, {"CANCEL",  "PROG_BASE_SLAM",  {{"MPD_SMS_SLAM_1_5PBLabels", 1, 0}}})

add_PB_label(11, {"STP",  "PROG_BASE_SLAM", {}, {{"MPD_SMS_SLAM_STP_SELECTED"}}})
add_PB_label(12, {"DSPLY", "PROG_BASE_SLAM"}, {"", "PROG_BASE_SLAM", {{"MPD_SLAM_SLAM_ER"}}})

addStrokeText("TimingSLAM", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_Timing"}}, {"TIMING %d:%.2d"})

addStrokeText("SLAMInRng", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 357}, "PROG_BASE_SLAM", {{"HUD_AG_SLAM_IN_RNG", 99}}, IN_RNG_ZONE)
addStrokeText("SLAM_TTS", nil, STROKE_FNT_DFLT_100, "RightCenter", {380, 332}, nil, {{"MPD_SMS_SLAM_TTS", 999}}, {"%.3d TTS"})

addStrokeText("ALGN_QUAL_SLAM", "ALN QUAL", STROKE_FNT_DFLT_100, "RightCenter", {-10, -140}, "PROG_BASE_SLAM", {{"MPD_SLAM_ALGN_QUAL", 0}})
addStrokeText("ALGN_QUAL_SLAM_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {10, -140}, "PROG_BASE_SLAM", {{"MPD_SLAM_ALGN_QUAL", 1}}, ALGN_QUAL)


local Harpoon_FLT = 
{
	"LOW",
	"MED",
	"HIGH",
}

addStrokeText("SLAM_FLT", "FLT", STROKE_FNT_DFLT_100, "LeftCenter", {-380, -255}, "PROG_BASE_SLAM", {{"MPD_SLAM_FLT", 0}})
addStrokeText("SLAM_FLT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-280, -255}, "PROG_BASE_SLAM", {{"MPD_SLAM_FLT", 1}}, Harpoon_FLT)


local SLAM_EFUZE = 
{
	"   ",
	"OFF",
	"VT1",
	"INST",
}

addStrokeText("SLAM_FUZ", "EFUZ", STROKE_FNT_DFLT_100, "LeftCenter", {-380, -280}, "PROG_BASE_SLAM", {{"MPD_SLAM_FUZE", 0}})
addStrokeText("SLAM_EFUZ_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-280, -280}, "PROG_BASE_SLAM", {{"MPD_SLAM_FUZE", 1}}, SLAM_EFUZE)

addStrokeText("SLAM_SEEK_DIST", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -305}, "PROG_BASE_SLAM", {{"MPD_SMS_SLAM_SEEKER_DIST", 99}}, {"DIST  %.2d"})


add_PB_label(2, {"SEEK", "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 0}, {"MPD_SMS_Harpoon_R_BL"}}})
add_PB_label(3, {"TERM", "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 0}}})
add_PB_label(4, {"FLT",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 0}}})
add_PB_label(5, {"MODE", "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 0}}})

add_PB_label(4, {"R/BL",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 1}}})
add_PB_label(5, {"BOL", "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 1}}})

add_PB_label(3, {"LOW",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 2}}})
add_PB_label(4, {"MED",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 2}}})
add_PB_label(5, {"HIGH", "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 2}}})

add_PB_label(4, {"SKIM",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 3}}})
add_PB_label(5, {"POP",  "PROG_BASE_HARPOON", {{"MPD_SMS_1_5PB_HARPOON", 3}}})

add_PB_label(11, {"HPTP",  "PROG_BASE_HARPOON", {{"MPD_SMS_HARPOON_HPTP_Label", 0}}, {{"MPD_SMS_HARPOON_HPTP_Label", 1}}})
add_PB_label(12, {"FXP", "PROG_BASE_HARPOON", {{"MPD_SMS_HARPOON_FXP_Label", 0}}, {{"MPD_SMS_HARPOON_FXP_Label", 1}}})

addStrokeText("TimingHARPOON", "TIMING", STROKE_FNT_DFLT_100, "LeftCenter", {-380, 357}, "PROG_BASE_HARPOON", {{"MPD_SMS_HARPOON_Timing"}}, {"TIMING %d:%.2d"})


add_PB_label(6, {"SIZE", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_MAIN"}}}, "", {"   ", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_SIZE_Label"}}})
add_PB_label(6, {"SML", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Size_Menu"}}})
add_PB_label(6, {"SIZE", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_MAIN"}}}, "", {"   ", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_SIZE_Label"}}})
add_PB_label(6, {"SML", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_Size_Menu"}}})
add_PB_label(6, {"LOFT", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Mode_Menu"}}})


add_PB_label(7, {"MODE", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_MAIN"}}}, "", {"   ", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Mode_Label"}}})
add_PB_label(7, {"RCS", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_MAIN"}}}, "", {"   ", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_RCS_Label"}}})
add_PB_label(7, {"MED", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Size_Menu"}}})
add_PB_label(7, {"MED", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_Size_Menu"}}})
add_PB_label(7, {"NORM", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Mode_Menu"}}})


add_PB_label(8, {"HELO", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Mode_Menu"}}})
add_PB_label(8, {"LRG", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Size_Menu"}}})
add_PB_label(8, {"LRG", nil, {{"MPD_IS_AIM120"}, {"MPD_AIM120_Size_Menu"}}})

add_PB_label(9, {"HOJ", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_Mode_Menu"}, {"MPD_AIM7_HOJ"}}})

--add_X_Over("BP_7_AIM7_Break_X", 	154, 36, {-167, 488}, 	nil, {{"MPD_IS_AIM7"},{"MPD_AIM7_HELO", 1}})
--add_X_Over("BP_8_AIM7_Break_X", 	154, 36, {2, 488}, 		nil, {{"MPD_IS_AIM7"},{"MPD_AIM7_LOFT", 2}})

add_PB_label(4, {"MAN", nil, {{"MPD_IS_AIM120"}}, {{"MPD_IS_AIM120"}, {"MPD_IS_AIM120_MAN_AUTO",0}}}, "",   {"MODE  ", nil, {{"MPD_IS_AIM120"}}})
add_PB_label(5, {"AUTO", nil, {{"MPD_IS_AIM120"}}, {{"MPD_IS_AIM120"}, {"MPD_IS_AIM120_MAN_AUTO", 1}}}, "", {"   S", nil , {{"MPD_IS_AIM120"}}})

local pb6 = add_PB_label(6, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 0, 0}}, {{"MPD_SMS_6_10PBLabels", 0, 1}}}, {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 0}}})[1]
local pb7 = add_PB_label(7, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 1, 0}}, {{"MPD_SMS_6_10PBLabels", 1, 1}}}, {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 1}}})[1]
local pb8 = add_PB_label(8, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 2, 0}}, {{"MPD_SMS_6_10PBLabels", 2, 1}}}, {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 2}}})[1]
local pb9 = add_PB_label(9, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 3, 0}}, {{"MPD_SMS_6_10PBLabels", 3, 1}}}, {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 3}}})[1]
local pb10 = add_PB_label(10, {"       ", nil, {{"MPD_SMS_6_10PBLabels", 4, 0}}, {{"MPD_SMS_6_10PBLabels", 4, 1}}}, {"RDY", nil, {{"MPD_SMS_AG_RDY_Label", 4}}})[1]

add_PB_label(6, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 0}}})
add_PB_label(7, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 1}}})
add_PB_label(8, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 2}}})
add_PB_label(9, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 3}}})
add_PB_label(10, "", "", {"    ", nil, {{"MPD_SMS_DATALINK_WEDL", 4}}})

local X_sizeX = 154
local X_sizeY = 36
local X_offsetY = -12
add_X_Over("BP_6_Break_X", 	X_sizeX, X_sizeY, {0, X_offsetY}, pb6.name, {{"MPD_SMS_AG_X_Breaker", 0}})
add_X_Over("BP_7_Break_X", 	X_sizeX, X_sizeY, {0, X_offsetY}, pb7.name, {{"MPD_SMS_AG_X_Breaker", 1}})
add_X_Over("BP_8_Break_X", 	X_sizeX, X_sizeY, {0, X_offsetY}, pb8.name, {{"MPD_SMS_AG_X_Breaker", 2}})
add_X_Over("BP_9_Break_X", 	X_sizeX, X_sizeY, {0, X_offsetY}, pb9.name, {{"MPD_SMS_AG_X_Breaker", 3}})
add_X_Over("BP_10_Break_X", X_sizeX, X_sizeY, {0, X_offsetY}, pb10.name, {{"MPD_SMS_AG_X_Breaker", 4}})

local pb11 = add_PB_label(11, {"GUN", nil, {{"MPD_SMS_Gun_AG_Label"}}, {{"MPD_SMS_Gun_PushButton_Box"}}})
addStrokeText("Gun_Pushbutton_RDY", "RDY", STROKE_FNT_DFLT_120, "CenterCenter", {420, 310}, nil, {{"MPD_SMS_Gun_PushButton_Box"}, {"MPD_SMS_AG_RDY_Label", 5}})

add_PB_label(11, {"DSPLY", nil, {{"JDAM_JSOW", 0}}}, {"JDAM", nil, {{"JDAM_JSOW", 0}}})
add_PB_label(12, {"DSPLY", nil, {{"JDAM_JSOW", 1}}}, {"JSOW", nil, {{"JDAM_JSOW", 1}}})


add_PB_label(12, {"LOAD", nil, {{"MPD_SMS_LOAD_Label"}}})
add_PB_label(12, {"OVR", "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}, {"ShowGBU24_CLAR_Ovr"}}, {{"ShowGBU24_CLAR_Ovr"}, {"ShowGBU24_CLAR_Ovr_Box"}}}, {"CLAR", "PROG_BOMB", {{"ShowMFuzeModeGBU24", 1}, {"ShowGBU24_CLAR_Ovr"}}})

add_PB_label(13, {"STEP", nil, {{"MPD_SMS_STEP_Label"}}})
add_PB_label(14, {"UFC", nil, {{"MPD_SMS_UFC_Label", 0}}, {{"MPD_SMS_UFC_Label", 1, 1}}})
add_PB_label(14, {"TEST", nil, {{"MPD_IS_AIM7"}}, {{"MPD_AIM7_TEST"}}}, "", {"SP", nil, {{"MPD_IS_AIM7"}}})
add_PB_label(15, {"SIM", nil, {{"MPD_SMS_PB_Label_SimMode", 0}}, {{"MPD_SMS_PB_Label_SimMode", 1}}})
add_Harm_Ovrd_PB16()
--add_PB_label(17, "WIND")
add_PB_label(17, {"DATA", nil, {{"MPD_SMS_PB_DATA_Label", 0}}, {{"MPD_SMS_PB_DATA_Label", 1}}})
--add_PB_label(18, {"MENU", PROG_BASE})

add_PB_label(19, {"TONE", nil, {{"MPD_SMS_PB_TONE_Label", 0}}})
add_PB_label(19, {"TONE1", nil, {{"MPD_SMS_PB_TONE_Label", 1}}, {{"MPD_SMS_PB_TONE_Label", 1}}})
add_PB_label(19, {"TONE2", nil, {{"MPD_SMS_PB_TONE_Label", 2}}, {{"MPD_SMS_PB_TONE_Label", 2}}})

add_PB_label(20, {"7F", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_TYPE", 0}}})
add_PB_label(20, {"7M", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_TYPE", 1}}})
add_PB_label(20, {"7H", nil, {{"MPD_IS_AIM7"}, {"MPD_AIM7_TYPE", 2}}})



add_PB_label(20, {"PROG", "PROG_BASE", {{"MPD_SMS_PROG_Label"}}})
add_PB_label(20, {"PROG", "PROG_BASE_HARPOON", {{"MPD_SMS_PROG_Label"}}})

add_PB_label(20, {"HI  LO", "PROG_BASE_GUN", {{"MPD_SMS_PROG_GUN_HI_Label"}}})
addStrokeBox("GUN_Box_HI", 50, 40, "CenterCenter", {-378, -488}, "PROG_BASE_GUN", {{"MPD_SMS_Gun_HI_LO_Box", 0}})
addStrokeBox("GUN_Box_LO", 50, 40, "CenterCenter", {-296, -488}, "PROG_BASE_GUN", {{"MPD_SMS_Gun_HI_LO_Box", 1}})

add_PB_label(20, {"M4  M66", "PROG_BASE_ROCKETS", {{"MPD_SMS_RKT_MOTOR"}}}, {" MTR  ", "PROG_BASE_ROCKETS", {{"MPD_SMS_RKT_MOTOR"}}})
addStrokeBox("MOTOR_Box_M4", 60, 40, "CenterCenter", {-380, -488}, "PROG_BASE_ROCKETS", {{"MPD_SMS_RKT_MOTOR"}, {"MPD_SMS_RKT_MOTOR_Box", 0}})
addStrokeBox("MOTOR_Box_M66", 70, 40, "CenterCenter", {-296, -488}, "PROG_BASE_ROCKETS", {{"MPD_SMS_RKT_MOTOR"}, {"MPD_SMS_RKT_MOTOR_Box", 1}})

addPlaceholder("STT_Info", {0,-100}, nil, {{"MPD_AA_STT_MODE"}})
local shift_y = 40

addStrokeText("STT_RNG", "RNG", STROKE_FNT_DFLT_100, "LeftCenter", {-380, -shift_y}, "STT_Info")
addStrokeText("STT_RNG_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_RNG", {{"MPD_STT_RNG"}})

addStrokeText("STT_VC", "VC", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*2}, "STT_Info")
addStrokeText("STT_VC_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_VC", {{"MPD_STT_VC"}})

addStrokeText("STT_V", "V", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*3}, "STT_Info")
addStrokeText("STT_V_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_V", {{"MPD_STT_V"}})

addStrokeText("STT_DELTA_ALT", " ALT", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*4}, "STT_Info")
addStrokeText("STT_DELTA_ALT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_DELTA_ALT", {{"MPD_STT_DELTA_ALT"}})

addStrokeText("STT_ASPCT", "ASPCT", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*5}, "STT_Info")
addStrokeText("STT_ASPCT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_ASPCT", {{"MPD_STT_ASPCT"}}, {"%d°"})

addStrokeText("STT_RMAX", "RMAX", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*6}, "STT_Info")
addStrokeText("STT_RMAX_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {80, 0}, "STT_RMAX", {{"MPD_STT_RMAX"}})

addStrokeText("STT_RNE", "RNE", STROKE_FNT_DFLT_100, "LeftCenter", {-50,  -shift_y*6}, "STT_Info")
addStrokeText("STT_RNE_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {80, 0}, "STT_RNE", {{"MPD_STT_RNE"}})

addStrokeText("STT_RMIN", "RMIN", STROKE_FNT_DFLT_100, "LeftCenter", {180,  -shift_y*6}, "STT_Info")
addStrokeText("STT_RMIN_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {80, 0}, "STT_RMIN", {{"MPD_STT_RMIN"}})

addStrokeText("STT_ERROR", "ERROR U  123 R  123", STROKE_FNT_DFLT_100, "LeftCenter", {0, -shift_y * 5}, "STT_Info", {{"MPD_STT_ERROR"}})
addStrokeText("STT_BEAM", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-50, -shift_y * 5}, "STT_Info", {{"MPD_STT_BEAM"}}, {"BEAM   %d  FPS"})
addStrokeText("STT_TOF", nil, STROKE_FNT_DFLT_100, "LeftCenter", {250, -shift_y * 5}, "STT_Info", {{"MPD_STT_TOF"}}, {"TOF  %d:%d"})



addPlaceholder("General_DATA_FREEZE_Info", {0,-100}, nil, {{"MPD_SMS_GENERAL_DATA_FREEZE"}})
addStrokeLine("DATA_FREEZELine", 800, {-400, 0}, -90.0, "General_DATA_FREEZE_Info")

addStrokeText("STT_ALT", "ALT", STROKE_FNT_DFLT_100, "LeftCenter", {0, -shift_y}, "General_DATA_FREEZE_Info")
addStrokeText("STT_ALT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_ALT", {{"MPD_STT_ALT"}})

addStrokeText("STT_TAS", "TAS", STROKE_FNT_DFLT_100, "LeftCenter", {0,  -shift_y*2}, "General_DATA_FREEZE_Info")
addStrokeText("STT_TAS_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_TAS", {{"MPD_STT_TAS"}})

addStrokeText("STT_FPA", "ASPCT", STROKE_FNT_DFLT_100, "LeftCenter", {0,  -shift_y*3}, "General_DATA_FREEZE_Info")
addStrokeText("STT_FPA_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "STT_FPA", {{"MPD_STT_FPA"}}, {"%d°"})

local ROLL = 
{
	"R   %d°",
	"L   %d°"
}

addStrokeText("STT_ROLL", "ROLL", STROKE_FNT_DFLT_100, "LeftCenter", {0,  -shift_y*4}, "General_DATA_FREEZE_Info")
addStrokeText("STT_ROLL_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {80, 0}, "STT_ROLL", {{"MPD_STT_ROLL"}}, ROLL)


addPlaceholder("AG_DATA_FREEZE_Info", {0,0}, "General_DATA_FREEZE_Info", {{"MPD_SMS_AG_DATA_FREEZE"}})

addStrokeText("AG_RNG", "RNG", STROKE_FNT_DFLT_100, "LeftCenter", {-380, -shift_y}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_RNG", 0}})
addStrokeText("AG_RNG_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "AG_RNG", {{"MPD_AG_DATA_FREEZE_RNG", 1}})

addStrokeText("AG_G", "G", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*3}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_G", 0}})
addStrokeText("AG_G_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "AG_G", {{"MPD_AG_DATA_FREEZE_G", 1}})

addStrokeText("AG_D_RNG", "D/ANG", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*6}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_D_RNG", 0}})
addStrokeText("AG_D_RNG_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {90, 0}, "AG_D_RNG", {{"MPD_AG_DATA_FREEZE_D_RNG", 1}})

addStrokeText("AG_D_ALT", "D/ALT", STROKE_FNT_DFLT_100, "LeftCenter", {180,  -shift_y*6}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_D_ALT", 0}})
addStrokeText("AG_D_ALT_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {90, 0}, "AG_D_ALT", {{"MPD_AG_DATA_FREEZE_D_ALT", 1}})


addStrokeText("AG_ROUNDS", "RNDS", STROKE_FNT_DFLT_100, "LeftCenter", {-50,  -shift_y*6}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_GUN_ROUNDS", 0}})
addStrokeText("AG_ROUNDS_Val", nil, STROKE_FNT_DFLT_100, "LeftCenter", {80, 0}, "AG_ROUNDS", {{"MPD_AG_DATA_FREEZE_GUN_ROUNDS", 1}})

addStrokeText("AG_GUN_RMAX", "RMAX", STROKE_FNT_DFLT_100, "LeftCenter", {-380,  -shift_y*2}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_GUN_RMAX", 0}})
addStrokeText("AG_GUN_RMAX_Val", "6000 FT", STROKE_FNT_DFLT_100, "LeftCenter", {100, 0}, "AG_GUN_RMAX", {{"MPD_AG_DATA_FREEZE_GUN_RMAX", 1}})

addStrokeText("AG_GUN_ERROR", nil, STROKE_FNT_DFLT_100, "LeftCenter", {0, -shift_y * 5}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_GUN_ERROR"}})

addStrokeText("AG_ERROR", nil, STROKE_FNT_DFLT_100, "LeftCenter", {-380, -shift_y * 2}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_AG_ERROR"}})
addStrokeText("AG_TOF", nil, STROKE_FNT_DFLT_100, "LeftCenter", {200, -shift_y * 5}, "AG_DATA_FREEZE_Info", {{"MPD_AG_DATA_FREEZE_AG_TOF"}})
