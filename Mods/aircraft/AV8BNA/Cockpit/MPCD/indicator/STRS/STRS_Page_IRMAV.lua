--------------------------------------------------
-- STRS IR Maverick Video Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Common Elements
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(mpcd_path.."STRS_IRMAV_Video.lua")
dofile(mpcd_path.."STRS_WPN_LST.lua")

local	MPCD_Scale = 0.5 * GetHalfHeight()
local	MPCD_Line_Thickness		= stroke_thickness * 3.5

--------------------------------------------------
-- IRMAV Main Menu
--------------------------------------------------
local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB01"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_01_pos
		STRS_PBTN.value			= "S\nH\nI\nP"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB05"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_05_pos
		STRS_PBTN.value			= "F\nO\nV"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB14"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_14_pos
		STRS_PBTN.value			= "S\nT\nE\nP"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"strs_step_btn"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB15"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_15_pos
		STRS_PBTN.value			= "E\nW"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB16"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_16_pos
		STRS_PBTN.value			= "POS/ING"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB17"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_17_pos
		STRS_PBTN.value			= "TBST"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB18"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_18_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB20"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_20_pos
		STRS_PBTN.value			= "PLTY"
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_READY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.08), 0}
		STRS_PBTN.parent_element	= "STRS_PB20"
		STRS_PBTN.formats			= {"%s"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_status"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_PRIORITY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.16), 0}
		STRS_PBTN.parent_element	= "STRS_PB20"
		STRS_PBTN.formats			= {"STA %d"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_station"}}
Add_MPCD_Element(STRS_PBTN)

-- Selection Boxes
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "SHIP_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_01_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"irmv_ship_mode"}}
AddMPCDStrokeSymbol(STRS_Symbol)

--------------------------------------------------
-- IRMAV Warnings
--------------------------------------------------
local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "safe_arm_indicator"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { PosX(-0.80),  PosY(0.80), 0}
		STRS_Label.formats		= {"%s"}
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		STRS_Label.alignment	= "LeftCenter"
		STRS_Label.controllers	= {{"ac_sel_sensor"}}
Add_MPCD_Element(STRS_Label)

local	STRS_Label				= CreateElement "ceStringSLine"
		STRS_Label.name			= "safe_arm_indicator"
		STRS_Label.material		= stroke_font
		STRS_Label.init_pos		= { PosX(0.80),  PosY(0.80), 0}
		STRS_Label.value		= "GIMBAL LIMIT"
		STRS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		STRS_Label.alignment	= "RightCenter"
		STRS_Label.controllers	= {{"irmv_gimbal_limit"}}
Add_MPCD_Element(STRS_Label)

--------------------------------------------------
-- IRMAV Symbols & Icons
--------------------------------------------------
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "irmav_narrow_fov"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "narrow_fov"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"irmav_polarity"}, {"irmv_wide_fov"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "irmav_crosshair"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "crosshair"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"irmav_polarity"}, {"irmv_lock_condition", 0.63}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "irmav_constrains"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, PosY(-0.30), 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "irmv_ret"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"irmav_polarity"}}
AddMPCDStrokeSymbol(STRS_Symbol)

-- Cross hairs
local	irmv_crosshairs_top				= CreateElement "ceSimpleLineObject"
		irmv_crosshairs_top.name		= "irmv_crosshairs_top"
		irmv_crosshairs_top.material   	= stroke_material
		irmv_crosshairs_top.width       = MPCD_Line_Thickness
		irmv_crosshairs_top.init_pos	= {0, PosY(0.8), 0}
		irmv_crosshairs_top.controllers	= {{"irmav_polarity"}, {"irmv_crosshairs_top"}}
Add_MPCD_Element(irmv_crosshairs_top)

local	irmv_crosshairs_btm				= CreateElement "ceSimpleLineObject"
		irmv_crosshairs_btm.name		= "irmv_crosshairs_btm"
		irmv_crosshairs_btm.material   	= stroke_material
		irmv_crosshairs_btm.width       = MPCD_Line_Thickness
		irmv_crosshairs_btm.init_pos	= {0, PosY(-0.8), 0}
		irmv_crosshairs_btm.controllers	= {{"irmav_polarity"}, {"irmv_crosshairs_bottom"}}
Add_MPCD_Element(irmv_crosshairs_btm)

local	irmv_crosshairs_lft				= CreateElement "ceSimpleLineObject"
		irmv_crosshairs_lft.name		= "irmv_crosshairs_lft"
		irmv_crosshairs_lft.material   	= stroke_material
		irmv_crosshairs_lft.width       = MPCD_Line_Thickness
		irmv_crosshairs_lft.init_pos	= {PosX(-0.8), 0.0, 0}
		irmv_crosshairs_lft.controllers	= {{"irmav_polarity"}, {"irmv_crosshairs_left"}}
Add_MPCD_Element(irmv_crosshairs_lft)

local	irmv_crosshairs_rgt				= CreateElement "ceSimpleLineObject"
		irmv_crosshairs_rgt.name		= "irmv_crosshairs_rgt"
		irmv_crosshairs_rgt.material   	= stroke_material
		irmv_crosshairs_rgt.width       = MPCD_Line_Thickness
		irmv_crosshairs_rgt.init_pos	= {PosX(0.8), 0.0, 0}
		irmv_crosshairs_rgt.controllers	= {{"irmav_polarity"}, {"irmv_crosshairs_right"}}
Add_MPCD_Element(irmv_crosshairs_rgt)

