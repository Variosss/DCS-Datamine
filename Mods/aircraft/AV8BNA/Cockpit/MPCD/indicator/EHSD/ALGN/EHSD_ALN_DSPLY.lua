------------------------
-- EHSD Page          --
-- INS Alignment Mode --
------------------------
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/EHSD/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(mpcd_path.."Global/EHSD_MAP_VIDEO.lua")
dofile(mpcd_path.."Global/EHSD_Compass_Rose.lua")
dofile(mpcd_path.."Global/EHSD_Menu.lua")
dofile(mpcd_path.."ALGN/EHSD_ALN_DATA.lua")

-- Global Variables
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 3.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
Add_MPCD_Element(MPCD_center)

-- Navigation Arrows
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_12_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Up_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_12_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_up_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB12_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "EHSD_SPT_Number_OL"
		BTN_Label.material			= stroke_font_outline
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.165), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB12_PB13_Data"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "EHSD_SPT_Number"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= {PosX(0.95), PosY(0.165), 0}
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "RightCenter"
		BTN_Label.controllers		= {{"EHSD_PB12_PB13_Data"}}
Add_MPCD_Element(BTN_Label)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Down_Arrow_OL"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= mpcd_btn_13_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "EHSD_Down_Arrow"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= mpcd_btn_13_pos
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_down_arrow"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.controllers 	= {{"EHSD_PB13_Arrow"}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- TACAN Data Block
local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_brg_deg_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.80), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_brg_deg"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.80), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_rng_nm_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_rng_nm"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_ttg_ms_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_ttg_ms"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

-- WYPT Data Block
local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_brg_deg_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_brg_deg"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_rng_nm_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.85), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_rng_nm"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.85), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_ttg_ms_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_ttg_ms"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)


