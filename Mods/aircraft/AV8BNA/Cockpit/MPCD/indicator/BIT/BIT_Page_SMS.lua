--------------------------------------------------
-- SMS BIT Page
--------------------------------------------------

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

--------------------------------------------------
-- SYMBOLS & INDICATORS
--------------------------------------------------
local	strs_wing_form				= CreateElement "ceSMultiLine"
		strs_wing_form.name			= "strs_wing_form"
		strs_wing_form.material		= stroke_material
		strs_wing_form.init_pos		= {0, PosY(0.25), 0}
		strs_wing_form.points_set	= {"MPCD_stroke_symbols", "stores_wingform"}
		strs_wing_form.scale		= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(strs_wing_form)

dofile(LockOn_Options.script_path.."MPCD/indicator/STRS/STRS_WPN_SYMB.lua")

-- MENU
local	mpcd_mm_btn_18				= CreateElement "ceStringSLine"
		mpcd_mm_btn_18.name			= "mpcd_mm_btn_18"
		mpcd_mm_btn_18.material		= stroke_font
		mpcd_mm_btn_18.init_pos		= mpcd_btn_18_pos
		mpcd_mm_btn_18.alignment	= "CenterCenter"
		mpcd_mm_btn_18.formats		= {"%s"}
		mpcd_mm_btn_18.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_18.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(mpcd_mm_btn_18)

local	mpcd_mm_btn_19				= CreateElement "ceStringSLine"
		mpcd_mm_btn_19.name			= "mpcd_mm_btn_19"
		mpcd_mm_btn_19.material		= stroke_font
		mpcd_mm_btn_19.init_pos		= mpcd_btn_19_pos
		mpcd_mm_btn_19.alignment	= "CenterCenter"
		mpcd_mm_btn_19.value		= "SMSFF"
		mpcd_mm_btn_19.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_19)

local	mpcd_btn_19_boxed				= CreateElement "ceSMultiLine"
		mpcd_btn_19_boxed.name			= "mpcd_btn_19_boxed"
		mpcd_btn_19_boxed.material		= stroke_material
		mpcd_btn_19_boxed.init_pos		= mpcd_btn_19_pos
		mpcd_btn_19_boxed.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		mpcd_btn_19_boxed.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(mpcd_btn_19_boxed)
