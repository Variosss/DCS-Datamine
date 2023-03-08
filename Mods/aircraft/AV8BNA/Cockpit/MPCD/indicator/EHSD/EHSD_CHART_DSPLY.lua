----------------
-- EHSD       --
-- CHART Page --
----------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- DISPLAY
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/Classified_Page.lua")

-- MENU
-- TOP
local	BTN_Label					= CreateElement "ceStringSLine" 
		BTN_Label.name				= "EHSD_PB08"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_08_pos
		BTN_Label.value				= "CHRT"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine" 
		BTN_Label.name				= "EHSD_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- BOXED SELECTION
local	Selection_Box				= CreateElement "ceSMultiLine"
		Selection_Box.name			= "PB08_Selection_Box"
		Selection_Box.material		= stroke_material
		Selection_Box.init_pos		= mpcd_btn_08_pos
		Selection_Box.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		Selection_Box.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(Selection_Box)