dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local id = 0
local function getUnicID()
	id = id + 1
	return "_id:"..id
end

-- It has a caret shape
local function addFuelAmountPointer(Pos, parent, controller)
	local LineLen = 30
	local LineAngle = 30
	local PH = addPlaceholder("Arrow_PH_"..getUnicID(), Pos, parent, controller)
	addStrokeLine(PH.name.."Up", LineLen, nil, -90 + LineAngle, PH.name)
	addStrokeLine(PH.name.."Down", LineLen, nil, -90 - LineAngle, PH.name)
end

local TK1YPos = 385
local TK1BoxHWidth = 350
local TK1BoxHeight = 160
addStrokeText("TK1", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, TK1YPos}, nil, {{"MPD_FUEL_Tank_1"}})
addStrokeBox("TK1_Box", TK1BoxHWidth, TK1BoxHeight, "CenterCenter", {0, TK1YPos})
addStrokeText("TK1_Label", "TK 1", STROKE_FNT_DFLT_100, "CenterCenter", {0, TK1YPos + TK1BoxHeight / 2 + 20})
addStrokeText("TK1_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {110, TK1YPos}, nil, {{"HideElement"}})
addFuelAmountPointer({TK1BoxHWidth / 2, TK1YPos - TK1BoxHeight / 2}, nil, {{"MPD_FUEL_Tank_1_Rel", TK1BoxHeight}})

local LFDYPos = 215
local LFDBoxHeight = 100
addStrokeText("LFD", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, LFDYPos}, nil, {{"MPD_FUEL_Tank_Feed", 0}})
addStrokeBox("LFD_Box", TK1BoxHWidth, LFDBoxHeight, "CenterCenter", {0, LFDYPos})
addStrokeText("LFD_Label", "L FD", STROKE_FNT_DFLT_100, "CenterCenter", {0, LFDYPos + LFDBoxHeight / 2 + 20})
addStrokeText("LFD_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {110, LFDYPos}, nil, {{"HideElement"}})
addFuelAmountPointer({TK1BoxHWidth / 2, LFDYPos - LFDBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Feed_Rel", LFDBoxHeight, 0}})

local RFDYPos = 90
local RFDBoxHeight = 70
addStrokeText("RFD", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, RFDYPos}, nil, {{"MPD_FUEL_Tank_Feed", 1}})
addStrokeBox("RFD_Box", TK1BoxHWidth, RFDBoxHeight, "CenterCenter", {0, RFDYPos})
addStrokeText("RFD_Label", "R FD", STROKE_FNT_DFLT_100, "CenterCenter", {0, RFDYPos + RFDBoxHeight / 2 + 20})
addStrokeText("RFD_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {110, RFDYPos}, nil, {{"HideElement"}})
addFuelAmountPointer({TK1BoxHWidth / 2, RFDYPos - RFDBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Feed_Rel", RFDBoxHeight, 1}})

local TK4YPos = -85
local TK4BoxHeight = 200
addStrokeText("TK4", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, TK4YPos}, nil, {{"MPD_FUEL_Tank_4", 0, 3}})
addStrokeBox("TK4_Box", TK1BoxHWidth, TK4BoxHeight, "CenterCenter", {0, TK4YPos})
addStrokeText("TK4_Label", "TK 4", STROKE_FNT_DFLT_100, "CenterCenter", {0, TK4YPos + TK4BoxHeight / 2 + 20})
addStrokeText("TK4_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {110, TK4YPos}, nil, {{"HideElement"}})
addFuelAmountPointer({TK1BoxHWidth / 2, TK4YPos - TK4BoxHeight / 2}, nil, {{"MPD_FUEL_Tank_4_Rel", TK4BoxHeight}})

local RWGYPos = 110
local RWGXPos = 350
local RWGBoxHeight = 100
local RWGBoxWidth = 150
addStrokeText("RWG", nil, STROKE_FNT_DFLT_200, "CenterCenter", {RWGXPos, RWGYPos}, nil, {{"MPD_FUEL_Tank_Wing", 1}})
addStrokeBox("RWG_Box", RWGBoxWidth, RWGBoxHeight, "CenterCenter", {RWGXPos, RWGYPos})
addStrokeText("RWG_Label", "R WG", STROKE_FNT_DFLT_100, "CenterCenter", {RWGXPos, RWGYPos + RWGBoxHeight / 2 + 20})
addStrokeText("RWG_valid", "EST", STROKE_FNT_DFLT_100, "CenterCenter", {RWGXPos, RWGYPos - RWGBoxHeight / 2 - 20}, nil, {{"HideElement"}})
addFuelAmountPointer({RWGXPos + RWGBoxWidth / 2, RWGYPos - RWGBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Wing_Rel", RWGBoxHeight, 1}})

addStrokeText("LWG", nil, STROKE_FNT_DFLT_200, "CenterCenter", {-RWGXPos, RWGYPos}, nil, {{"MPD_FUEL_Tank_Wing", 0}})
addStrokeBox("LWG_Box", RWGBoxWidth, RWGBoxHeight, "CenterCenter", {-RWGXPos, RWGYPos})
addStrokeText("LWG_Label", "L WG", STROKE_FNT_DFLT_100, "CenterCenter", {-RWGXPos, RWGYPos + RWGBoxHeight / 2 + 20})
addStrokeText("LWG_valid", "EST", STROKE_FNT_DFLT_100, "CenterCenter", {-RWGXPos, RWGYPos - RWGBoxHeight / 2 - 20}, nil, {{"HideElement"}})
addFuelAmountPointer({-RWGXPos + RWGBoxWidth / 2, RWGYPos - RWGBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Wing_Rel", RWGBoxHeight, 0}})

local BingoYPos = 350
local OffsetBetweenString = 45
addStrokeText("Bingo_Label", "BINGO", STROKE_FNT_DFLT_150, "CenterCenter", {RWGXPos, BingoYPos})
addStrokeText("Bingo", nil, STROKE_FNT_DFLT_200, "RightCenter", {RWGXPos + 100, BingoYPos - OffsetBetweenString}, nil, {{"MPD_FUEL_Bingo"}})

local LeftDataYPos = 430
local LeftDataXPos = -380
addStrokeText("Total_Label", "TOTAL", STROKE_FNT_DFLT_150, "CenterCenter", {LeftDataXPos, LeftDataYPos})
addStrokeText("Total", nil, STROKE_FNT_DFLT_200, "CenterCenter", {LeftDataXPos, LeftDataYPos - OffsetBetweenString}, nil, {{"MPD_FUEL_Total_Total"}})
addStrokeText("Total_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {LeftDataXPos + 110, LeftDataYPos - OffsetBetweenString}, nil, {{"HideElement"}})
addStrokeText("Internal_Label", "INTERNAL", STROKE_FNT_DFLT_150, "CenterCenter", {LeftDataXPos, LeftDataYPos - OffsetBetweenString * 2})
addStrokeText("Internal", nil, STROKE_FNT_DFLT_200, "CenterCenter", {LeftDataXPos, LeftDataYPos - OffsetBetweenString * 3}, nil, {{"MPD_FUEL_Total_Internal"}})
addStrokeText("Internal_valid", "EST", STROKE_FNT_DFLT_100, "LeftCenter", {LeftDataXPos + 110, LeftDataYPos - OffsetBetweenString * 3}, nil, {{"HideElement"}})

local ValidLabelsYPos = -60
local ValidLabelsXPos = -330
addStrokeText("CGDEGD", "CG DEGD", STROKE_FNT_DFLT_200, "CenterCenter", {ValidLabelsXPos, ValidLabelsYPos}, nil, {{"HideElement"}})
addStrokeText("INVALID", "INVALID", STROKE_FNT_DFLT_200, "CenterCenter", {-ValidLabelsXPos + 20, ValidLabelsYPos}, nil, {{"HideElement"}})
addStrokeText("Last_Update_Timer", "99:59", STROKE_FNT_DFLT_200, "CenterCenter", {-ValidLabelsXPos + 20, ValidLabelsYPos - 50}, nil, {{"HideElement"}})

local ExternalTanksYPos = -300
local ExternalTanksXPos = -300
local ExternalTanksBoxWidth = TK1BoxHWidth / 2 + 50
addStrokeText("CL", nil, STROKE_FNT_DFLT_200, "CenterCenter", {0, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 0}, {"MPD_FUEL_Tank_Ext", 2}})
addStrokeBox("CL_Box", ExternalTanksBoxWidth, RFDBoxHeight, "CenterCenter", {0, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 0}})
addStrokeText("C_Label", "C ", STROKE_FNT_DFLT_100, "CenterCenter", {0, ExternalTanksYPos + RFDBoxHeight / 2 + 30}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 0}})
addStrokeText("L_Label", " L", STROKE_FNT_DFLT_100, "CenterCenter", {0, ExternalTanksYPos + RFDBoxHeight / 2 + 20}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 0}})
addStrokeText("CL_valid", "INV", STROKE_FNT_DFLT_100, "CenterCenter", {0, ExternalTanksYPos - RFDBoxHeight / 2 - 20}, nil, {{"HideElement"}})
addFuelAmountPointer({ExternalTanksBoxWidth / 2, ExternalTanksYPos - RFDBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 0}, {"MPD_FUEL_Tank_External_Rel", RFDBoxHeight, 2}})

addStrokeText("Left_External", nil, STROKE_FNT_DFLT_200, "CenterCenter", {ExternalTanksXPos, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 1}, {"MPD_FUEL_Tank_Ext", 0}})
addStrokeBox("Left_External_Box", ExternalTanksBoxWidth, RFDBoxHeight, "CenterCenter", {ExternalTanksXPos, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 1}})
addStrokeText("Left_External_Label", "L EXT", STROKE_FNT_DFLT_100, "CenterCenter", {ExternalTanksXPos, ExternalTanksYPos + RFDBoxHeight / 2 + 20}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 1}})
addStrokeText("Left_External_valid", "INV", STROKE_FNT_DFLT_100, "CenterCenter", {ExternalTanksXPos, ExternalTanksYPos - RFDBoxHeight / 2 - 20}, nil, {{"HideElement"}})
addFuelAmountPointer({ExternalTanksXPos + ExternalTanksBoxWidth / 2, ExternalTanksYPos - RFDBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 1}, {"MPD_FUEL_Tank_External_Rel", RFDBoxHeight, 0}})

addStrokeText("Right_External", nil, STROKE_FNT_DFLT_200, "CenterCenter", {-ExternalTanksXPos, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 2}, {"MPD_FUEL_Tank_Ext", 1}})
addStrokeBox("Right_External_Box", ExternalTanksBoxWidth, RFDBoxHeight, "CenterCenter", {-ExternalTanksXPos, ExternalTanksYPos}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 2}})
addStrokeText("Right_External_Label", "R EXT", STROKE_FNT_DFLT_100, "CenterCenter", {-ExternalTanksXPos, ExternalTanksYPos + RFDBoxHeight / 2 + 20}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 2}})
addStrokeText("Right_External_valid", "INV", STROKE_FNT_DFLT_100, "CenterCenter", {-ExternalTanksXPos, ExternalTanksYPos - RFDBoxHeight / 2 - 20}, nil, {{"HideElement"}})
addFuelAmountPointer({-ExternalTanksXPos + ExternalTanksBoxWidth / 2, ExternalTanksYPos - RFDBoxHeight / 2}, nil, {{"MPD_FUEL_Tank_Ext_Installed", 2}, {"MPD_FUEL_Tank_External_Rel", RFDBoxHeight, 1}})

add_PB_label(10, "RESET", "SDC")
add_PB_label(20, {"FLBIT", nil, nil, {{"MPD_FUEL_FLBIT_Box"}}})