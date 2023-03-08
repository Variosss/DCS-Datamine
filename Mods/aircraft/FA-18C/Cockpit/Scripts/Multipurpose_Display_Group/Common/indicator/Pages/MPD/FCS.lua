dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local customStringDef = {fontScaleY_120, fontScaleX_120, 14 * GetScale(), fontInterlineDflt120 * GetScale()}

local counter = -1
local function count()
	counter = counter + 1
	return counter
end

local BoxHeightTopTables = 48
local BoxHeightBottomTables = 40
local BoxWidth = 32

-------------------------------------- Left top table --------------------------------------
local LTTablePosX = -300	-- LT - left top table
local LTTablePosY = 440		-- LT - left top table

addStrokeText("LT_1", "1", STROKE_FNT_DFLT_120, "CenterCenter", {LTTablePosX, LTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("LT_2", "2", STROKE_FNT_DFLT_120, "CenterCenter", {LTTablePosX + 1 * BoxWidth, LTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("LT_3", "3", STROKE_FNT_DFLT_120, "CenterCenter", {LTTablePosX + 2 * BoxWidth, LTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("LT_4", "4", STROKE_FNT_DFLT_120, "CenterCenter", {LTTablePosX + 3 * BoxWidth, LTTablePosY - 7 * BoxHeightTopTables})

addStrokeText("LT_SV11", "SV1", customStringDef, "RightCenter", {LTTablePosX - BoxWidth, LTTablePosY - 1 * BoxHeightTopTables})
addStrokeText("LT_SV12", "SV2", customStringDef, "RightCenter", {LTTablePosX - BoxWidth, LTTablePosY - 2 * BoxHeightTopTables})
addStrokeText("LT_SV21", "SV1", customStringDef, "RightCenter", {LTTablePosX - BoxWidth, LTTablePosY - 5 * BoxHeightTopTables})
addStrokeText("LT_SV22", "SV2", customStringDef, "RightCenter", {LTTablePosX - BoxWidth, LTTablePosY - 6 * BoxHeightTopTables})

-------------------------------------- Right top table --------------------------------------
local RTTablePosX = -LTTablePosX
local RTTablePosY = LTTablePosY

addStrokeText("RT_4", "4", STROKE_FNT_DFLT_120, "CenterCenter", {RTTablePosX, RTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("RT_3", "3", STROKE_FNT_DFLT_120, "CenterCenter", {RTTablePosX - 1 * BoxWidth, RTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("RT_2", "2", STROKE_FNT_DFLT_120, "CenterCenter", {RTTablePosX - 2 * BoxWidth, RTTablePosY - 7 * BoxHeightTopTables})
addStrokeText("RT_1", "1", STROKE_FNT_DFLT_120, "CenterCenter", {RTTablePosX - 3 * BoxWidth, RTTablePosY - 7 * BoxHeightTopTables})

addStrokeText("RT_SV11", "SV1", customStringDef, "LeftCenter", {RTTablePosX + BoxWidth, RTTablePosY - 1 * BoxHeightTopTables})
addStrokeText("RT_SV12", "SV2", customStringDef, "LeftCenter", {RTTablePosX + BoxWidth, RTTablePosY - 2 * BoxHeightTopTables})
addStrokeText("RT_SV21", "SV1", customStringDef, "LeftCenter", {RTTablePosX + BoxWidth, RTTablePosY - 5 * BoxHeightTopTables})
addStrokeText("RT_SV22", "SV2", customStringDef, "LeftCenter", {RTTablePosX + BoxWidth, RTTablePosY - 6 * BoxHeightTopTables})

-------------------------------------- Right bottom table -----------------------------------
local RBTablePosX = RTTablePosX
local RBLabelsPosX = 88
local RBTablePosY = RTTablePosY - 8 * BoxHeightTopTables

counter = -1
addStrokeText("RB_CASP",  "CAS P",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_R",	  "    R",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_Y",	  "    Y",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_NACC",  "N ACC",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_LACC",  "L ACC",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_STICK", "STICK",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_PEDAL", "PEDAL",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_AOA",	  "AOA",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_BADSA", "BADSA",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_PROC",  "PROC",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})
addStrokeText("RB_DEGD",  "DEGD",	STROKE_FNT_DFLT_120, "LeftCenter", {RBLabelsPosX, RBTablePosY - count() * BoxHeightBottomTables})


-------------------------------------- Table X ----------------------------------------------
local tableLeft = { {1,0,0,1},
					{1,1,1,1},
					{1,1,1,1},
					{1,0,0,1},
					{1,0,0,1},
					{1,1,1,1},
					{1,1,1,1}}
local tableRight = {{0,1,1,0},
					{1,1,1,1},
					{1,1,1,1},
					{0,1,1,0},
					{0,1,1,0},
					{1,1,1,1},
					{1,1,1,1}}
				

counter = -1
for i = 0, 6 do
	for j = 0, 3 do
		if tableLeft[i+1][j+1] == 1 then
			addStrokeSymbol("LT_X_Test_1"..i..j, {"stroke_symbols_MDI_AMPCD", "151-cross"}, "CenterCenter", {LTTablePosX + j * BoxWidth, LTTablePosY - i * BoxHeightTopTables}, nil, {{"MPD_FCS_Status_Table", count()}})
			addStrokeBox("LT_X_box_1"..i..j, BoxWidth, BoxHeightTopTables, "CenterCenter", {LTTablePosX + j * BoxWidth, LTTablePosY - i * BoxHeightTopTables})
		end
	end
end

for i = 0, 6 do
	for j = 3, 0, -1 do
		if tableRight[i+1][j+1] == 1 then
			addStrokeSymbol("RT_X_Test_2"..i..j, {"stroke_symbols_MDI_AMPCD", "151-cross"}, "CenterCenter", {RTTablePosX - j * BoxWidth, RTTablePosY - i * BoxHeightTopTables}, nil, {{"MPD_FCS_Status_Table", count()}})
			addStrokeBox("RT_X_box_2"..i..j, BoxWidth, BoxHeightTopTables, "CenterCenter", {RTTablePosX - j * BoxWidth, RTTablePosY - i * BoxHeightTopTables})
		end
	end
end

for i = 0, 10 do
	for j = 3, 0, -1 do
		addStrokeSymbol("RB_X_Test_3"..i..j, {"stroke_symbols_MDI_AMPCD", "151-cross"}, "CenterCenter", {RBTablePosX - j * BoxWidth, RBTablePosY - i * BoxHeightBottomTables}, nil, {{"MPD_FCS_Status_Table", count()}})
		addStrokeBox("RB_X_box_3"..i..j, BoxWidth, BoxHeightBottomTables, "CenterCenter", {RBTablePosX - j * BoxWidth, RBTablePosY - i * BoxHeightBottomTables})
	end
end

-------------------------------------- Big lines --------------------------------------------
local LinePosX = RBTablePosX - 4 * BoxWidth + BoxWidth / 2
local LinePosY = RBTablePosY + BoxHeightBottomTables / 2
local BigLineLen = 110
local LittleLineLen = 30

counter = -1
addStrokeLine("RB_Line_"..count(), BigLineLen, {LinePosX, LinePosY}, 90)
for i = 1, 4 do
	addStrokeLine("RB_Line_"..count(), LittleLineLen, {LinePosX, LinePosY - counter * BoxHeightBottomTables}, 90)
end
for i = 1, 7 do
	addStrokeLine("RB_Line_"..count(), BigLineLen, {LinePosX, LinePosY - counter * BoxHeightBottomTables}, 90)
end

-------------------------------------- G-LIM display --------------------------------------
local function AddCross( pos, parent, controller )
	local len = 75
	local angle = 17
	addStrokeLine("G_lim_Cross_1", len, pos, 90 + angle, parent, controller)
	addStrokeLine("G_lim_Cross_2", len, pos, 90 - angle, parent, controller)
	addStrokeLine("G_lim_Cross_3", len, pos, -90 + angle, parent, controller)
	addStrokeLine("G_lim_Cross_4", len, pos, -90 - angle, parent, controller)
end
local GLIMPosY = 15
addStrokeText("G_lim_display",	"G-LIM    G", STROKE_FNT_DFLT_200, "LeftCenter", {-422, GLIMPosY}, nil, {{"MPD_FCS_GlimitSymbols", 0}})
addStrokeText("G_lim_value",	nil, STROKE_FNT_DFLT_200, "LeftCenter", {-206, GLIMPosY}, nil, {{"MPD_FCS_GlimitSymbols", 0}, {"MPD_FCS_GlimitNumerics"}})
addStrokeText("G_invalid",		"INVALID", STROKE_FNT_DFLT_200, "LeftCenter", {-380, GLIMPosY}, nil, {{"MPD_FCS_GlimitSymbols", 2}})
AddCross({-230, 30}, nil, {{"MPD_FCS_GlimitSymbols", 1}})

-------------------------------------- Blin code data --------------------------------------
--TODO
local BlinCodeFont = {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), 6 * GetScale()}
addStrokeText("Blin_code_data", "", BlinCodeFont, "LeftCenter", {-345, -190}, nil, {{"MPD_FCS_BLIN_Code_Data"}})

-------------------------------------- AOA --------------------------------------
local AOAPosY = -415
local AOAPosX = 300
addStrokeBox("AOA_Center_box", 194, 35, "CenterCenter", {-3, AOAPosY})
addStrokeText("AOA_Center",   "AOA", STROKE_FNT_DFLT_120, "LeftCenter", {     -83, AOAPosY})--, nil, {{"MPD_FCS_AngleOfAttackShow", 0}})
addStrokeText("AOA_Center_value","-99.9", STROKE_FNT_DFLT_120, "RightCenter", {       83, AOAPosY})--, nil, {{"MPD_FCS_AngleOfAttackShow", 0}, {"MPD_FCS_AngleOfAttackNumerics", 0}})
addStrokeText("AOA_Left", 		"L", STROKE_FNT_DFLT_120, "LeftCenter", {-AOAPosX, AOAPosY})
addStrokeText("AOA_Left_value",  nil, STROKE_FNT_DFLT_120, "RightCenter", {-AOAPosX + 104, AOAPosY}, nil, {{"MPD_FCS_AngleOfAttackNumerics", 1}})
addStrokeText("AOA_Right", 		"R", STROKE_FNT_DFLT_120, "LeftCenter", {180, AOAPosY}	)
addStrokeText("AOA_Right_value", nil, STROKE_FNT_DFLT_120, "RightCenter", {180 + 104, AOAPosY}, nil, {{"MPD_FCS_AngleOfAttackNumerics", 2}})

-------------------------------------- Aircraft surface position --------------------------------------
counter = -1
local CentralLineLen = 315
addStrokeLine("ASP_Line_"..count(), CentralLineLen, {CentralLineLen / 2, LTTablePosY - BoxHeightTopTables / 2}, 90)
for i = 0, 2 do
	addStrokeLine("ASP_Line_"..count(), CentralLineLen, {CentralLineLen / 2, LTTablePosY - BoxHeightTopTables / 2 - BoxHeightTopTables * 2 - BoxHeightTopTables * i}, 90)
end

local function addArrowsUpDn(name, pos, controller_name, num)
	-- positive direction (arrow up) - trailing edge down (leading edge down for Leading Edge Flaps)
	local arrUp       = addStrokeSymbol(name.."Up", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "CenterCenter", pos, nil, {{controller_name, num, -1}})
	
	local arrDn       = Copy(arrUp)
	arrDn.name        = name.."Dn"
	arrDn.controllers = {{controller_name, num, 1}}
	arrDn.init_rot    = {180}
	Add(arrDn)
end

local function addArrowsLtRt(name, pos, controller_name, num)
	-- positive direction (arrow right) - TE ??
	local arrLeft        = addStrokeSymbol(name.."Lt", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "CenterCenter", pos, nil, {{controller_name, num, -1}})
	arrLeft.init_rot     = {90}
	
	local arrRight       = Copy(arrLeft)
	arrRight.name        = name.."Rt"
	arrRight.controllers = {{controller_name, num, 1}}
	arrRight.init_rot    = {-90}
	Add(arrRight)
end

local ASPPosXL = -86
local ASPPosXR = 152

local ArrowVXR = 82
local ArrowVXL = -153

local ArrowHXR = 82
local ArrowHXL = -158

addStrokeText("ASP_LEF", "LEF", customStringDef, "CenterCenter", {0, LTTablePosY})
addStrokeText("ASP_LEF_L", "30", customStringDef, "RightCenter", {ASPPosXL, LTTablePosY}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 0}})
addArrowsUpDn("ASP_LEF_L_Arrow", {ArrowVXL, LTTablePosY}, "MPD_FCS_ControlSurfaceDirArrow", 0)
addStrokeText("ASP_LEF_R", "30", customStringDef, "RightCenter", { ASPPosXR, LTTablePosY}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 1}})
addArrowsUpDn("ASP_LEF_R_Arrow", { ArrowVXR, LTTablePosY}, "MPD_FCS_ControlSurfaceDirArrow", 1)

addStrokeText("ASP_TEF", "TEF", customStringDef, "CenterCenter", {0, LTTablePosY - BoxHeightTopTables * 1.5})
addStrokeText("ASP_TEF_L", nil, customStringDef, "RightCenter", {ASPPosXL, LTTablePosY - BoxHeightTopTables * 1.5}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 2}})
addArrowsUpDn("ASP_TEF_L_Arrow", {ArrowVXL, LTTablePosY - BoxHeightTopTables * 1.5}, "MPD_FCS_ControlSurfaceDirArrow", 2)
addStrokeText("ASP_TEF_R", nil, customStringDef, "RightCenter", { ASPPosXR, LTTablePosY - BoxHeightTopTables * 1.5}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 3}})
addArrowsUpDn("ASP_TEF_R_Arrow", {ArrowVXR, LTTablePosY - BoxHeightTopTables * 1.5}, "MPD_FCS_ControlSurfaceDirArrow", 3)

addStrokeText("ASP_AIL", "AIL", customStringDef, "CenterCenter", {0, LTTablePosY - BoxHeightTopTables * 3})
addStrokeText("ASP_AIL_L", nil, customStringDef, "RightCenter", {ASPPosXL, LTTablePosY - BoxHeightTopTables * 3}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 4}})
addArrowsUpDn("ASP_AIL_L_Arrow", {ArrowVXL, LTTablePosY - BoxHeightTopTables * 3}, "MPD_FCS_ControlSurfaceDirArrow", 4)
addStrokeText("ASP_AIL_R", nil, customStringDef, "RightCenter", {ASPPosXR, LTTablePosY - BoxHeightTopTables * 3}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 5}})
addArrowsUpDn("ASP_AIL_R_Arrow", {ArrowVXR, LTTablePosY - BoxHeightTopTables * 3}, "MPD_FCS_ControlSurfaceDirArrow", 5)

addStrokeText("ASP_RUD", "RUD", customStringDef, "CenterCenter", {0, LTTablePosY - BoxHeightTopTables * 4})
addStrokeText("ASP_RUD_L", nil, customStringDef, "RightCenter", {ASPPosXL, LTTablePosY - BoxHeightTopTables * 4}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 6}})
addArrowsLtRt("ASP_RUD_L_Arrow", {ArrowHXL, LTTablePosY - BoxHeightTopTables * 4}, "MPD_FCS_ControlSurfaceDirArrow", 6)
addStrokeText("ASP_RUD_R", nil, customStringDef, "RightCenter", {ASPPosXR, LTTablePosY - BoxHeightTopTables * 4}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 7}})
addArrowsLtRt("ASP_RUD_R_Arrow", {ArrowHXR, LTTablePosY - BoxHeightTopTables * 4}, "MPD_FCS_ControlSurfaceDirArrow", 7)

addStrokeText("ASP_STAB", "STAB", customStringDef, "CenterCenter", {0, LTTablePosY - BoxHeightTopTables * 5.5})
addStrokeText("ASP_STAB_L", nil, customStringDef, "RightCenter", {ASPPosXL, LTTablePosY - BoxHeightTopTables * 5.5}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 8}})
addArrowsUpDn("ASP_STAB_L_Arrow", {ArrowVXL, LTTablePosY - BoxHeightTopTables * 5.5}, "MPD_FCS_ControlSurfaceDirArrow", 8)
addStrokeText("ASP_STAB_R", nil, customStringDef, "RightCenter", {ASPPosXR, LTTablePosY - BoxHeightTopTables * 5.5}, nil, {{"MPD_FCS_ControlSurfacePosNumerics", 9}})
addArrowsUpDn("ASP_STAB_R_Arrow", {ArrowVXR, LTTablePosY - BoxHeightTopTables * 5.5}, "MPD_FCS_ControlSurfaceDirArrow", 9)

-------------------------------------- Menu --------------------------------------
add_PB_label(2, "BLIN", "", "", {"", nil, {{"MPD_FCS_Channel_Ident"}}})
add_PB_label(16, "AOA")
