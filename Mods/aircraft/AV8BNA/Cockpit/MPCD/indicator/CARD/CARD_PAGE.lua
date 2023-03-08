---------------
-- CARD      --
-- Main Menu --
---------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/Classified_Page.lua")

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CARD_PB15"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_15_pos
		BTN_Label.value				="E\nW"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CARD_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- Navigation Arrows
local	CARD_Symbol					= CreateElement "ceSMultiLine"
		CARD_Symbol.name			= "CARD_PG_Up_Arrow"
		CARD_Symbol.material		= stroke_material
		CARD_Symbol.init_pos		= mpcd_btn_11_pos
		CARD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		CARD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(CARD_Symbol)

local	CARD_Symbol					= CreateElement "ceSMultiLine"
		CARD_Symbol.name			= "CARD_PG_Down_Arrow"
		CARD_Symbol.material		= stroke_material
		CARD_Symbol.init_pos		= mpcd_btn_12_pos
		CARD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		CARD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(CARD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CARD_Line_Selector"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.45), 0}
		BTN_Label.value				= "PG"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

--

