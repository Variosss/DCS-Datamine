--------------------------------------------------
-- STRS Weapons Symbology
--------------------------------------------------

-- Air-to-Air Symbols & Codes
local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "aim_9_l_1_icon"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(-0.73), PosY(-0.22), 0}
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "aim_icon"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta1_aim9"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_WPN_Code					= CreateElement "ceStringSLine"
		STRS_WPN_Code.name				= "aim_9_l_1_code"
		STRS_WPN_Code.material			= stroke_font
		STRS_WPN_Code.init_pos			= {0.0, PosY(-0.20), 0}
		STRS_WPN_Code.parent_element	= "aim_9_l_1_icon"
		STRS_WPN_Code.value				= "9M"
		STRS_WPN_Code.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment			= "CenterCenter"
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "sta1_priority_aa"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(-0.05), PosY(0.15), 0}
		STRS_Symbol.parent_element		= "aim_9_l_1_icon"
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta1_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

--

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "aim_9_l_2_icon"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(-0.50), 0.0, 0}
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "aim_icon"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta2_aim9"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_WPN_Code					= CreateElement "ceStringSLine"
		STRS_WPN_Code.name				= "aim_9_l_2_code"
		STRS_WPN_Code.material			= stroke_font
		STRS_WPN_Code.init_pos			= {0.0, PosY(-0.20), 0}
		STRS_WPN_Code.parent_element	= "aim_9_l_2_icon"
		STRS_WPN_Code.value				= "9M"
		STRS_WPN_Code.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment			= "CenterCenter"
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "sta2_priority_aa"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(-0.05), PosY(0.15), 0}
		STRS_Symbol.parent_element		= "aim_9_l_2_icon"
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta2_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

--

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "aim_9_r_6_icon"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(0.50), 0.0, 0}
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "aim_icon"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta6_aim9"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_WPN_Code					= CreateElement "ceStringSLine"
		STRS_WPN_Code.name				= "aim_9_r_6_code"
		STRS_WPN_Code.material			= stroke_font
		STRS_WPN_Code.init_pos			= {0.0, PosY(-0.20), 0}
		STRS_WPN_Code.parent_element	= "aim_9_r_6_icon"
		STRS_WPN_Code.value				= "9M"
		STRS_WPN_Code.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment			= "CenterCenter"
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "sta6_priority_aa"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(0.05), PosY(0.15), 0}
		STRS_Symbol.parent_element		= "aim_9_r_6_icon"
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta6_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

--

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "aim_9_r_7_icon"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(0.73), PosY(-0.22), 0}
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "aim_icon"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta7_aim9"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_WPN_Code					= CreateElement "ceStringSLine"
		STRS_WPN_Code.name				= "aim_9_r_7_code"
		STRS_WPN_Code.material			= stroke_font
		STRS_WPN_Code.init_pos			= {0.0, PosY(-0.20), 0}
		STRS_WPN_Code.parent_element	= "aim_9_r_7_icon"
		STRS_WPN_Code.value				= "9M"
		STRS_WPN_Code.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment			= "CenterCenter"
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol						= CreateElement "ceSMultiLine"
		STRS_Symbol.name				= "sta7_priority_aa"
		STRS_Symbol.material			= stroke_material
		STRS_Symbol.init_pos			= {PosX(0.05), PosY(0.15), 0}
		STRS_Symbol.parent_element		= "aim_9_r_7_icon"
		STRS_Symbol.points_set			= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale				= MPCD_STRK_SCALE
		STRS_Symbol.controllers			= {{"strs_sta7_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- GAU-12 Gun pod ammo
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "GAU12_ammo_count"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {0.0, PosY(0.55), 0}
		STRS_WPN_Code.formats		= {"%d"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_gun_ammo"}}
Add_MPCD_Element(STRS_WPN_Code)

---------------------------------------------
-- Air-to-Ground Symbols & Codes
---------------------------------------------
-- STA 1
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta1_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(-0.70), PosY(-0.16), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta1_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta1_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta1_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta1_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta1_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(-0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta1_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta1_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- STA 2
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta2_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(-0.50), PosY(0.08), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta2_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta2_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta2_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta2_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta2_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(-0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta2_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta2_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- STA 3
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta3_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(-0.30), PosY(0.31), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta3_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta3_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta3_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta3_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta3_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(-0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta3_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta3_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)


-- STA 4
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta4_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {0, PosY(0.45), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta4_code"}}
Add_MPCD_Element(STRS_WPN_Code)


-- STA 5
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta5_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(0.30), PosY(0.31), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta5_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta5_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta5_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta5_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta5_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta5_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta5_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- STA 6
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta6_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(0.50), PosY(0.08), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers	= {{"strs_sta6_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta6_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta6_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta6_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta6_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta6_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta6_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- STA 7
local	STRS_WPN_Code				= CreateElement "ceStringSLine"
		STRS_WPN_Code.name			= "sta7_wp_code"
		STRS_WPN_Code.material		= stroke_font
		STRS_WPN_Code.init_pos		= {PosX(0.70), PosY(-0.16), 0}
		STRS_WPN_Code.formats		= {"%s"}
		STRS_WPN_Code.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Code.alignment		= "CenterCenter"
		STRS_WPN_Code.controllers		= {{"strs_sta7_code"}}
Add_MPCD_Element(STRS_WPN_Code)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta7_wpn_selected"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.parent_element	= "sta7_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta7_sel"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "sta7_priority_ag"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {PosX(0.13), PosY(0.10), 0}
		STRS_Symbol.parent_element	= "sta7_wp_code"
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "wpn_priority"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"strs_sta7_priority"}}
AddMPCDStrokeSymbol(STRS_Symbol)
