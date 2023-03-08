--------------------------------------------------
-- STRS AGM-65E Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/STRS/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Common Elements
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(mpcd_path.."STRS_WPN_LST.lua")	-- Weapons Selection

--------------------------------------------------
-- STRS Main Menu
--------------------------------------------------
local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB04"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_04_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"dmt_lsr_scan"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN				= CreateElement "ceStringSLine"
		STRS_PBTN.name			= "STRS_PB05"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_05_pos
		STRS_PBTN.value			= "C\nO\nD\nE"
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
		STRS_PBTN.name			= "STRS_PB18"
		STRS_PBTN.material		= stroke_font
		STRS_PBTN.init_pos		= mpcd_btn_18_pos
		STRS_PBTN.formats		= {"%s"}
		STRS_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment		= "CenterCenter"
		STRS_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_TONE"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= mpcd_btn_20_pos
		STRS_PBTN.value				= "TONE"
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_READY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.08), 0}
		STRS_PBTN.parent_element	= "STRS_PB20_TONE"
		STRS_PBTN.formats			= {"%s"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_status"}}
Add_MPCD_Element(STRS_PBTN)

local	STRS_PBTN					= CreateElement "ceStringSLine"
		STRS_PBTN.name				= "STRS_PB20_PRIORITY"
		STRS_PBTN.material			= stroke_font
		STRS_PBTN.init_pos			= {0, PosY(0.16), 0}
		STRS_PBTN.parent_element	= "STRS_PB20_TONE"
		STRS_PBTN.formats			= {"STA %d"}
		STRS_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		STRS_PBTN.alignment			= "CenterCenter"
		STRS_PBTN.controllers		= {{"mav_rdy_station"}}
Add_MPCD_Element(STRS_PBTN)

-- Selection Boxes
local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "lmav_laser_code"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_05_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "vert_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"dmt_lsr_code"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "TONE_selection"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= mpcd_btn_20_pos
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"STRS_TONE_selection"}}
AddMPCDStrokeSymbol(STRS_Symbol)

--------------------------------------------------
-- SYMBOLS & INDICATORS
--------------------------------------------------
-- Status
local	STRS_Text				= CreateElement "ceStringPoly"
		STRS_Text.name			= "lsmv_laser_code"
		STRS_Text.material		= mpcd_lmav_font
		STRS_Text.init_pos		= {0, PosY(0.7), 0}
		STRS_Text.alignment		= "CenterCenter"
		STRS_Text.formats		= {"%d%s"}
		STRS_Text.stringdefs	= {0.0200, 0.0200}
		STRS_Text.controllers	= {{"lmav_lsr_code"}}
Add_MPCD_Element(STRS_Text)

local	STRS_Text					= CreateElement "ceStringPoly"
		STRS_Text.name				= "lsmv_slaved_sts"
		STRS_Text.material			= mpcd_lmav_font
		STRS_Text.init_pos			= {PosY(0.7), PosY(0.35), 0}
		STRS_Text.alignment			= "CenterCenter"
		STRS_Text.value				= "S"
		STRS_Text.stringdefs		= {0.0200, 0.0200}
		STRS_Text.controllers		= {{"lmav_is_slaved"}}
Add_MPCD_Element(STRS_Text)

-- Reticle

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "lmav_reticle"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, PosY(-0.07), 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "lmav_reticle"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"lmav_uncaged"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "lmav_reticle"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "lsr_seeker"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"lmav_seeking"}}
AddMPCDStrokeSymbol(STRS_Symbol)

local	STRS_Symbol					= CreateElement "ceSMultiLine"
		STRS_Symbol.name			= "lmav_reticle"
		STRS_Symbol.material		= stroke_material
		STRS_Symbol.init_pos		= {0.0, 0.0, 0}
		STRS_Symbol.points_set		= {"MPCD_stroke_symbols", "lockon_cue"}
		STRS_Symbol.scale			= MPCD_STRK_SCALE
		STRS_Symbol.controllers		= {{"lmav_lock_cue"}}
AddMPCDStrokeSymbol(STRS_Symbol)
