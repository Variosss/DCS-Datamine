dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")


-- Aiming Cross
addStrokeSymbol("HMD_AG_AimingCross", {"stroke_symbols_HMD", "aiming-cross"}, "FromSet", {0, 0}, autoBlank.name, {{"HMD_AG_CROSS"}})

local HMD_TD_Box_root = addPlaceholder("HMD_TD_Diamond_root", nil, autoBlank.name, {{"HMD_AG_DesignatedWaypointMarkerShow", RadToMil()}})
	local TGT_Box = addStrokeBox("TGT", 10, 10, "CenterCenter", nil, HMD_TD_Box_root.name)
	addStrokeBox("Target dot", 0.1, 0.1, "CenterCenter", nil, TGT_Box.name)
	add_X_Over("TGT X", 10, 8, nil, TGT_Box.name, {{"HMD_TGT_Limit"}})
		
addVarLenStrokeLine("HMD_AG_TLL", 30, {0,0}, 0, autoBlank.name, {{"HMD_AG_TargetLocatorLine"}})	

-- Diamond - STPT, STR, RP, IP point
local HMD_Diamond_PH = addPlaceholder("HMD_Diamond_PH", nil, autoBlank.name, {{"HMD_Diamond_Symbol", RadToMil()}})
	local HMD_Diamond_Sym = addStrokeBox("Reference point", 6, 6, "CenterCenter", nil, HMD_Diamond_PH.name)
		HMD_Diamond_Sym.init_rot	= {45}
	add_X_Over("Diamond_X", 10, 8, nil, HMD_Diamond_PH.name, {{"HMD_Diamond_Limit"}})
		
-- markpoint
local HMD_MARK_Cue_Root = addPlaceholder("HMD_MARK_Own_Root", nil, autoBlank.name, {{"HMD_MARK_CUE_Show", RadToMil()}})
	addStrokeSymbol("MARK_Own_Circle", {"stroke_symbols_HUD", "markpoint_cue"}, "FromSet", {0, 0}, HMD_MARK_Cue_Root.name)
	add_X_Over("MARK_X", 10, 8, nil, HMD_MARK_Cue_Root.name, {{"HMD_MARK_Limit"}})

local HMD_TGT_Mask = openMaskArea(0, "HMD_TGT_Mask", nil, nil, nil, HMD_MARK_Cue_Root.name)
	set_box_w_h(HMD_TGT_Mask, 10, 10)
	
local HMD_MAV_Reticle = addStrokeCircle("HMD_MAV_Reticle", 5, {0,0}, autoBlank.name, {{"HMD_MAV_Reticle", RadToMil()}})
	addStrokeBox("HMD_MAV_Reticle_Box_1", 4, 4, "CenterTop", {0, -5}, HMD_MAV_Reticle.name)

-- MAV MLE
local mleWidth = 6
local mleRange = 74
local MLE_root = addPlaceholder("HMD_AG_MLE_root", {63, -34}, autoBlank.name, {{"HMD_AG_MLE_Show"}})

addStrokeLine("HMD_AG_MLE_RangeScale_line", mleWidth, {0, mleRange}, -90, MLE_root.name)
addStrokeLine("HMD_AG_MLE_zeroRange", mleWidth, {0, 0}, -90, MLE_root.name)

local mleRangeCaret = addStrokeSymbol("HMD_AG_MLE_TgtRange_Caret",   {"stroke_symbols_HUD", "AA-DLZ-range"}, "FromSet", {0, 0}, MLE_root.name, {{"HMD_AG_MLE_TgtRange_Caret", mleRange}})
addStrokeText("HMD_AG_MLE_TgtRange", "", STROKE_FNT_DFLT_100, "RightCenter", {-6, 0}, mleRangeCaret.name, {{"HMD_AG_MLE_TgtRange"}})

local rmin_root = addPlaceholder("HMD_AG_MLE_Rmin_root",{0, 0}, MLE_root.name, {{"HMD_AG_MLE_RMin", mleRange}})
addStrokeLine("HMD_AG_MLE_Rmin",		mleWidth, {0, 0}, -90, rmin_root.name)
local rmax_root = addPlaceholder("HMD_AG_MLE_Rmax_root", {0, 0}, MLE_root.name, {{"HMD_AG_MLE_RMax", mleRange}})
addStrokeLine("HMD_AG_MLE_Rmax",		mleWidth, {0, 0}, -90, rmax_root.name)
addVarLenStrokeLine("HMD_AG_MLE_Range",	0, {0, 0},		  0, MLE_root.name, {{"HMD_AG_MLE_Range", mleRange}}, mleRange)
