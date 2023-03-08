dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/HUD/HUD_FLIR_Video.lua")

-- MENU RIGHT
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "HUD_PB15"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_15_pos
		BTN_Label.value			="E\nW"
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label				= CreateElement "ceStringSLine"
		BTN_Label.name			= "HUD_PB18"
		BTN_Label.material		= stroke_font
		BTN_Label.init_pos		= mpcd_btn_18_pos
		BTN_Label.formats		= {"%s"}
		BTN_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment		= "CenterCenter"
		BTN_Label.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

