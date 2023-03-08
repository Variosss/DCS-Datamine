--------------------------------------------------
-- FLIR Main Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- 
dofile(mpcd_path.."FLIR/FLIR_Video.lua")
dofile(mpcd_path.."STRS/STRS_WPN_LST.lua")
dofile(mpcd_path.."FLIR/FLIR_Menu.lua")

--------------------------------------------------
-- SYMBOLS & INDICATORS
--------------------------------------------------
local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "ac_horizon"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {0.0, 0.0, 0.0}
		FLIR_Symbol.points_set		= {"HUD_stroke_symbols", "horizon"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers		= {{"flir_horiz"}, {"ac_roll"}, {"flir_pitch"}}	
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "ac_vv_marker"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {0.0, 0.0, 0.0}
		FLIR_Symbol.points_set		= {"HUD_stroke_symbols", "FPM"}
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
		FLIR_Symbol.controllers		= {{"flir_fpm"}} 
AddMPCDStrokeSymbol(FLIR_Symbol)

local	FLIR_Symbol					= CreateElement "ceSMultiLine"
		FLIR_Symbol.name			= "ac_water_line"
		FLIR_Symbol.material		= stroke_material
		FLIR_Symbol.init_pos		= {0, 0, 0}
		FLIR_Symbol.points_set		= {"HUD_stroke_symbols", "waterline"}		
		FLIR_Symbol.scale			= MPCD_STRK_SCALE
        FLIR_Symbol.controllers		= {{"flir_horiz"}, {"flir_waterline"}} 
AddMPCDStrokeSymbol(FLIR_Symbol)

--------------------------------------------------
-- DATA
--------------------------------------------------
local	FLIR_TEXT				= CreateElement "ceStringSLine"
		FLIR_TEXT.name			= "safe_arm_indicator"
		FLIR_TEXT.material		= stroke_font
		FLIR_TEXT.init_pos		= { PosX(-0.80),  PosY(0.80), 0}
		FLIR_TEXT.formats		= {"%s"}
		FLIR_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment		= "LeftCenter"
		FLIR_TEXT.controllers	= {{"strs_master_arm"}}
Add_MPCD_Element(FLIR_TEXT)

local	FLIR_TEXT				= CreateElement "ceStringSLine"
		FLIR_TEXT.name			= "ac_sensor"
		FLIR_TEXT.material		= stroke_font
		FLIR_TEXT.init_pos		= { PosX(-0.80),  PosY(0.70), 0}
		FLIR_TEXT.formats		= {"%s"}
		FLIR_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment		= "LeftCenter"
		FLIR_TEXT.controllers	= {{"ac_sel_sensor"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_TEXT				= CreateElement "ceStringSLine"
		FLIR_TEXT.name			= "ac_heading"
		FLIR_TEXT.material		= stroke_font
		FLIR_TEXT.init_pos		= { PosX(-0.60),  PosY(-0.80), 0}
		FLIR_TEXT.formats		= {"%03d"}
		FLIR_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment		= "RightCenter"
		FLIR_TEXT.controllers	= {{"ac_hdg_value"}}
Add_MPCD_Element(FLIR_TEXT)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "ac_hdg_type"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= { PosX(-0.18), 0.0, 0}
		FLIR_TEXT.parent_element	= "ac_heading"
		FLIR_TEXT.value				= "T"
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment			= "LeftCenter"
		FLIR_TEXT.controllers		= {{"ac_hdg_true"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_TEXT				= CreateElement "ceStringSLine"
		FLIR_TEXT.name			= "ac_altitude"
		FLIR_TEXT.material		= stroke_font
		FLIR_TEXT.init_pos		= { PosX(0.80),  PosY(-0.80), 0}
		FLIR_TEXT.formats		= {"%1.f%s"}
		FLIR_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment		= "RightCenter"
		FLIR_TEXT.controllers	= {{"ac_alt_value"}}
Add_MPCD_Element(FLIR_TEXT)

--

local	FLIR_TEXT				= CreateElement "ceStringSLine"
		FLIR_TEXT.name			= "not_ready_warn"
		FLIR_TEXT.material		= stroke_font
		FLIR_TEXT.init_pos		= { 0.0,  PosY(-0.40), 0}
		FLIR_TEXT.value			= "NOT READY"
		FLIR_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		FLIR_TEXT.alignment		= "CenterCenter"
		FLIR_TEXT.controllers	= {{"navflir_not_ready"}}
Add_MPCD_Element(FLIR_TEXT)
