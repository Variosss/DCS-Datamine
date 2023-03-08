local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"

dofile(mpcd_path.."MPCD_definitions.lua")
dofile(mpcd_path.."FLIR/FLIR_Video.lua")

-- MENU
local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB17"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_17_pos
		FLIR_PBTN.value			= "FBST"
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
Add_MPCD_Element(FLIR_PBTN)

local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB17_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_17_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)

local	FLIR_PBTN				= CreateElement "ceStringSLine"
		FLIR_PBTN.name			= "FLIR_PB18"
		FLIR_PBTN.material		= stroke_font
		FLIR_PBTN.init_pos		= mpcd_btn_18_pos
		FLIR_PBTN.formats		= {"%s"}
		FLIR_PBTN.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_PBTN.alignment		= "CenterCenter"
		FLIR_PBTN.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(FLIR_PBTN)

-- ALIGNMENT
local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "video_az_align"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {0.0,  PosY(0.70), 0}
		FLIR_TEXT.formats			= {"AZ %2.1f MR"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_hud_az_align"}}
Add_MPCD_Element(FLIR_TEXT)

local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "video_el_align"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {0.0,  PosY(0.60), 0}
		FLIR_TEXT.formats			= {"EL %2.1f MR"}
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"flir_hud_el_align"}}
Add_MPCD_Element(FLIR_TEXT)

-- WARNINGS
local	FLIR_TEXT					= CreateElement "ceStringSLine"
		FLIR_TEXT.name				= "video_el_align"
		FLIR_TEXT.material			= stroke_font
		FLIR_TEXT.init_pos			= {0.0,  PosY(-0.40), 0}
		FLIR_TEXT.value				= "NOT READY"
		FLIR_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		FLIR_TEXT.alignment			= "CenterCenter"
		FLIR_TEXT.controllers 		= {{"navflir_not_ready"}}
Add_MPCD_Element(FLIR_TEXT)
