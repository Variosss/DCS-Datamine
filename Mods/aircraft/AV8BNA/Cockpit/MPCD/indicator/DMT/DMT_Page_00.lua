--------------------------------------------------
-- DMT Page
--------------------------------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

dofile(mpcd_path.."DMT/DMT_CCD_Video.lua")
dofile(mpcd_path.."STRS/STRS_WPN_LST.lua")

local	MPCD_Scale = 0.5 * GetHalfHeight()
local	MPCD_Line_Thickness		= stroke_thickness * 3.5

--------------------------------------------------
-- PAGE MENU
--------------------------------------------------
local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "DMT_PB01"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_01_pos
		DMT_PBTN.value			= "N\nI\nT\nE"
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(DMT_PBTN)

local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "DMT_PB04"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_04_pos
		DMT_PBTN.formats		= {"%s"}
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
		DMT_PBTN.controllers	= {{"dmt_lsr_scan"}}
Add_MPCD_Element(DMT_PBTN)

local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "DMT_PB05"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_05_pos
		DMT_PBTN.value			= "C\nO\nD\nE"
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(DMT_PBTN)

local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "DMT_PB15"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_15_pos
		DMT_PBTN.value			= "E\nW"
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(DMT_PBTN)

local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "STRS_PB16"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_16_pos
		DMT_PBTN.formats		= {"%s"}
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
		DMT_PBTN.controllers	= {{"nav_pos_source"}}
Add_MPCD_Element(DMT_PBTN)

local	DMT_PBTN				= CreateElement "ceStringSLine"
		DMT_PBTN.name			= "DMT_PB18"
		DMT_PBTN.material		= stroke_font
		DMT_PBTN.init_pos		= mpcd_btn_18_pos
		DMT_PBTN.formats		= {"%s"}
		DMT_PBTN.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		DMT_PBTN.alignment		= "CenterCenter"
		DMT_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(DMT_PBTN)

-- Selection Boxes
local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_video_nite"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= mpcd_btn_01_pos
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_video_nite"}}
AddMPCDStrokeSymbol(DMT_Symbol)

local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_laser_code"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= mpcd_btn_05_pos
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "vert_box"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_lsr_code"}}
AddMPCDStrokeSymbol(DMT_Symbol)

--------------------------------------------------
-- SYMBOLS & INDICATORS
--------------------------------------------------
local	DMT_Symbol					= CreateElement "ceSMultiLine"
		DMT_Symbol.name				= "ac_vv_marker"
		DMT_Symbol.material			= stroke_material
		DMT_Symbol.init_pos			= {0.0, PosY(0.0225), 0}
		DMT_Symbol.points_set		= {"HUD_stroke_symbols", "FPM"}
		DMT_Symbol.scale			= MPCD_STRK_SCALE
		DMT_Symbol.controllers		= {{"dmt_not_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

local	DMT_Symbol					= CreateElement "ceSMultiLine"
		DMT_Symbol.name				= "ac_horizon"
		DMT_Symbol.material			= stroke_material
		DMT_Symbol.init_pos			= {0.0, PosY(-0.015), 0}
		DMT_Symbol.points_set		= {"HUD_stroke_symbols", "horizon"}
		DMT_Symbol.scale			= MPCD_STRK_SCALE
		DMT_Symbol.controllers		= {{"dmt_not_locked"}, {"ac_roll"}, {"dmt_ac_attitude", -0.07}}
AddMPCDStrokeSymbol(DMT_Symbol)

-- 

local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_laser_code"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "lsr_seeker"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_without_video"}, {"lss_sensor_head"}}
AddMPCDStrokeSymbol(DMT_Symbol)

-- Cross hairs No Target Lacked
local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_ret_u_vert"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "dmt_vret_unlocked"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_with_video"}, {"dmt_not_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_ret_u_horz"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "dmt_hret_unlocked"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_with_video"}, {"dmt_not_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

-- Cross hairs Target Locked
local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_ret_u_vert"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "dmt_vret_locked"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_with_video"}, {"dmt_is_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_ret_u_horz"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "dmt_hret_locked"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_with_video"}, {"dmt_is_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

local	DMT_Symbol				= CreateElement "ceSMultiLine"
		DMT_Symbol.name			= "dmt_ret_u_horz"
		DMT_Symbol.material		= stroke_material
		DMT_Symbol.init_pos		= {0, 0, 0}
		DMT_Symbol.points_set	= {"MPCD_stroke_symbols", "target_square"}
		DMT_Symbol.scale		= MPCD_STRK_SCALE
		DMT_Symbol.controllers	= {{"dmt_with_video"}, {"dmt_is_locked"}}
AddMPCDStrokeSymbol(DMT_Symbol)

--------------------------------------------------
-- INFORMATION WINDOWS
--------------------------------------------------
local	DMT_TEXT				= CreateElement "ceStringSLine"
		DMT_TEXT.name			= "ac_sensor"
		DMT_TEXT.material		= stroke_font
		DMT_TEXT.init_pos		= { PosX(-0.80),  PosY(0.80), 0}
		DMT_TEXT.formats		= {"%s"}
		DMT_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		DMT_TEXT.alignment		= "LeftCenter"
		DMT_TEXT.controllers	= {{"ac_sel_sensor"}}
Add_MPCD_Element(DMT_TEXT)

--

local	DMT_TEXT				= CreateElement "ceStringSLine"
		DMT_TEXT.name			= "ac_heading"
		DMT_TEXT.material		= stroke_font
		DMT_TEXT.init_pos		= { PosX(-0.60),  PosY(-0.80), 0}
		DMT_TEXT.formats		= {"%03d"}
		DMT_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		DMT_TEXT.alignment		= "RightCenter"
		DMT_TEXT.controllers	= {{"ac_hdg_value"}}
Add_MPCD_Element(DMT_TEXT)

local	DMT_TEXT				= CreateElement "ceStringSLine"
		DMT_TEXT.name			= "ac_hdg_type"
		DMT_TEXT.material		= stroke_font
		DMT_TEXT.init_pos		= { PosX(-0.18), 0.0, 0}
		DMT_TEXT.parent_element	= "ac_heading"
		DMT_TEXT.value			= "T"
		DMT_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		DMT_TEXT.alignment		= "LeftCenter"
		DMT_TEXT.controllers	= {{"ac_hdg_true"}}
Add_MPCD_Element(DMT_TEXT)

--

local	DMT_TEXT				= CreateElement "ceStringSLine"
		DMT_TEXT.name			= "ac_altitude"
		DMT_TEXT.material		= stroke_font
		DMT_TEXT.init_pos		= { PosX(0.80),  PosY(-0.80), 0}
		DMT_TEXT.formats		= {"%1.f%s"}
		DMT_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		DMT_TEXT.alignment		= "RightCenter"
		DMT_TEXT.controllers	= {{"ac_alt_value"}}
Add_MPCD_Element(DMT_TEXT)
