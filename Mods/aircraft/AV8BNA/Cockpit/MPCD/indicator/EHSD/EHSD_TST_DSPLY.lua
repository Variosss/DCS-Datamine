-------------------
-- EHSD Page     --
-- INS TEST Mode --
-------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EHSD/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- BOTTOM
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB16_OL"
		BTN_Label.material		= stroke_font_outline
		BTN_Label.init_pos		= mpcd_btn_16_pos
		BTN_Label.value			= "DEG/   "
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB16"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_16_pos
		BTN_Label.value			= "DEG/   "
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB18_OL"
		BTN_Label.material		= stroke_font_outline
		BTN_Label.init_pos		= mpcd_btn_18_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "EHSD_PB18"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_18_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

