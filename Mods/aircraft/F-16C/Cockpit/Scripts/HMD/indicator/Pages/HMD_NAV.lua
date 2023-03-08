dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

addStrokeSymbol("HMD_AG_AimingCross", {"stroke_symbols_HMD", "aiming-cross"}, "FromSet", {0, 0}, autoBlank.name, {{"HMD_AG_CROSS"}})

-- markpoint
local HMD_MARK_Cue_Root = addPlaceholder("HMD_MARK_Own_Root", nil, autoBlank.name, {{"HMD_MARK_CUE_Show", RadToMil()}})
	addStrokeSymbol("MARK_Own_Circle", {"stroke_symbols_HUD", "markpoint_cue"}, "FromSet", {0, 0}, HMD_MARK_Cue_Root.name)
	add_X_Over("MARK_X", 10, 8, nil, HMD_MARK_Cue_Root.name, {{"HMD_MARK_Limit"}})

local HMD_Diamond_PH = addPlaceholder("HMD_Diamond_PH", nil, autoBlank.name, {{"HMD_Diamond_Symbol", RadToMil()}})
	local HMD_Diamond_Sym = addStrokeBox("Reference point", 6, 6, "CenterCenter", nil, HMD_Diamond_PH.name)
		HMD_Diamond_Sym.init_rot	= {45}
	add_X_Over("Diamond_X", 10, 8, nil, HMD_Diamond_PH.name, {{"HMD_Diamond_Limit"}})