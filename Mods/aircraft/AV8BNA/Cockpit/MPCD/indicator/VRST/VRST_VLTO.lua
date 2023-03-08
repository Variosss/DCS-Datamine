-- ***********************
--   V/STOL REST Display
--   VL/VTO PAGE
-- ***********************

local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/VRST/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- MENU
dofile(mpcd_path.."VRST_MENU.lua")

local	mpcd_mm_btn_04				= CreateElement "ceStringSLine"
		mpcd_mm_btn_04.name			= "mpcd_mm_btn_04"
		mpcd_mm_btn_04.material		= stroke_font
		mpcd_mm_btn_04.init_pos		= mpcd_btn_04_pos
		mpcd_mm_btn_04.alignment	= "CenterCenter"
		mpcd_mm_btn_04.value		= "T\nE\nM\nC"
		mpcd_mm_btn_04.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        mpcd_mm_btn_04.formats		= {"%s"}
        mpcd_mm_btn_04.controllers	= {{"temp_vlto_label"}}
Add_MPCD_Element(mpcd_mm_btn_04)

local	VL_VRST_Sel				= CreateElement "ceSMultiLine"
		VL_VRST_Sel.name		= "VL_VRST_Sel"
		VL_VRST_Sel.material	= stroke_material
		VL_VRST_Sel.init_pos	= mpcd_btn_06_pos
		VL_VRST_Sel.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		VL_VRST_Sel.scale		= MPCD_STRK_SCALE
        VL_VRST_Sel.controllers	= {{"vl_box_selected"}}
AddMPCDStrokeSymbol(VL_VRST_Sel)

local	VTO_VRST_Sel				= CreateElement "ceSMultiLine"
		VTO_VRST_Sel.name		= "VTO_VRST_Sel"
		VTO_VRST_Sel.material	= stroke_material
		VTO_VRST_Sel.init_pos	= mpcd_btn_07_pos
		VTO_VRST_Sel.points_set	= {"MPCD_stroke_symbols", "horz_box"}
		VTO_VRST_Sel.scale		= MPCD_STRK_SCALE
        VTO_VRST_Sel.controllers	= {{"vto_box_selected"}}
AddMPCDStrokeSymbol(VTO_VRST_Sel)

-- DATA
local	WET_Label				= CreateElement "ceStringSLine"
		WET_Label.name			= "WET_Label"
		WET_Label.material		= stroke_font
		WET_Label.init_pos		= {0.0, PosY(0.5), 0.00}
		WET_Label.alignment		= "CenterCenter"
		WET_Label.value			= "WET"
		WET_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(WET_Label)

local	DRY_Label				= CreateElement "ceStringSLine"
		DRY_Label.name			= "DRY_Label"
		DRY_Label.material		= stroke_font
		DRY_Label.init_pos		= {PosX(0.30), PosY(0.5), 0.00}
		DRY_Label.alignment		= "CenterCenter"
		DRY_Label.value			= "DRY"
		DRY_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DRY_Label)

-- AIRCRFAT DATA
local	F_W_Label				= CreateElement "ceStringSLine"
		F_W_Label.name			= "F_W_Label"
		F_W_Label.material		= stroke_font
		F_W_Label.init_pos		= {PosX(-0.33), PosY(0.4), 0.00}
		F_W_Label.alignment		= "LeftCenter"
		F_W_Label.value			= "F+W"
		F_W_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(F_W_Label)

local	F_W_W_Value				= CreateElement "ceStringSLine"
		F_W_W_Value.name		= "F_W_W_Value"
		F_W_W_Value.material	= stroke_font
		F_W_W_Value.init_pos	= {PosX(0.10), PosY(0.4), 0.00}
		F_W_W_Value.alignment	= "RightCenter"
		F_W_W_Value.value		= "5000"
		F_W_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        F_W_W_Value.formats		= {"%d"}
        F_W_W_Value.controllers	= {{"fw_vlto_wet"}}
Add_MPCD_Element(F_W_W_Value)

local	F_W_D_Value				= CreateElement "ceStringSLine"
		F_W_D_Value.name		= "F_W_D_Value"
		F_W_D_Value.material	= stroke_font
		F_W_D_Value.init_pos	= {PosX(0.40), PosY(0.4), 0.00}
		F_W_D_Value.alignment	= "RightCenter"
		F_W_D_Value.value		= "4250"
		F_W_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        F_W_D_Value.formats		= {"%d"}
        F_W_D_Value.controllers	= {{"fw_vlto_dry"}}
Add_MPCD_Element(F_W_D_Value)

-- ENVIRONMENTAL DATA
local	OATC_Label				= CreateElement "ceStringSLine"
		OATC_Label.name			= "OATC_Label"
		OATC_Label.material		= stroke_font
		OATC_Label.init_pos		= {PosX(-0.33), PosY(-0.2), 0.00}
		OATC_Label.alignment	= "LeftCenter"
		OATC_Label.value		= "OATC"
		OATC_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        OATC_Label.formats		= {"%s"}
        OATC_Label.controllers	= {{"oatc_vlto_label"}}
Add_MPCD_Element(OATC_Label)

local	OATC_Value				= CreateElement "ceStringSLine"
		OATC_Value.name			= "OATC_Value"
		OATC_Value.material		= stroke_font
		OATC_Value.init_pos		= {PosX(0.10), PosY(-0.2), 0.00}
		OATC_Value.alignment	= "RightCenter"
		OATC_Value.value		= "15"
		OATC_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        OATC_Value.formats		= {"%d"}
        OATC_Value.controllers	= {{"oatc_vlto"}}
Add_MPCD_Element(OATC_Value)

local	OATC_MValue				= CreateElement "ceStringSLine"
		OATC_MValue.name		= "OATC_MValue"
		OATC_MValue.material	= stroke_font
		OATC_MValue.init_pos	= {PosX(-0.35), PosY(-0.2), 0.00}
		OATC_MValue.alignment	= "RightCenter"
		OATC_MValue.value		= "*"
		OATC_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        OATC_MValue.controllers	= {{"oatc_vlto_overridden"}}
Add_MPCD_Element(OATC_MValue)

local	ALTM_Label				= CreateElement "ceStringSLine"
		ALTM_Label.name			= "ALTM_Label"
		ALTM_Label.material		= stroke_font
		ALTM_Label.init_pos		= {PosX(-0.33), PosY(-0.3), 0.00}
		ALTM_Label.alignment	= "LeftCenter"
		ALTM_Label.value		= "ALTM"
		ALTM_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(ALTM_Label)

local	ALTM_Value				= CreateElement "ceStringSLine"
		ALTM_Value.name			= "ALTM_Value"
		ALTM_Value.material		= stroke_font
		ALTM_Value.init_pos		= {PosX(0.10), PosY(-0.3), 0.00}
		ALTM_Value.alignment	= "RightCenter"
		ALTM_Value.value		= "29.92"
		ALTM_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        ALTM_Value.formats		= {"%2.2f"}
        ALTM_Value.controllers	= {{"altm_vlto"}}
Add_MPCD_Element(ALTM_Value)

local	FELV_Label				= CreateElement "ceStringSLine"
		FELV_Label.name			= "FELV_Label"
		FELV_Label.material		= stroke_font
		FELV_Label.init_pos		= {PosX(-0.33), PosY(-0.4), 0.00}
		FELV_Label.alignment	= "LeftCenter"
		FELV_Label.value		= "FELV"
		FELV_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(FELV_Label)

local	FELV_Value				= CreateElement "ceStringSLine"
		FELV_Value.name			= "FELV_Value"
		FELV_Value.material		= stroke_font
		FELV_Value.init_pos		= {PosX(0.10), PosY(-0.4), 0.00}
		FELV_Value.alignment	= "RightCenter"
		FELV_Value.value		= "50"
		FELV_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        FELV_Value.formats		= {"%d"}
        FELV_Value.controllers	= {{"felv_vlto"}}
Add_MPCD_Element(FELV_Value)

local	FELV_MValue				= CreateElement "ceStringSLine"
		FELV_MValue.name		= "FELV_MValue"
		FELV_MValue.material	= stroke_font
		FELV_MValue.init_pos	= {PosX(-0.35), PosY(-0.4), 0.00}
		FELV_MValue.alignment	= "RightCenter"
		FELV_MValue.value		= "*"
		FELV_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        FELV_MValue.controllers	= {{"felv_vlto_overridden"}}
Add_MPCD_Element(FELV_MValue)

local	GWT_Label				= CreateElement "ceStringSLine"
		GWT_Label.name			= "GWT_Label"
		GWT_Label.material		= stroke_font
		GWT_Label.init_pos		= {PosX(-0.33), PosY(-0.5), 0.00}
		GWT_Label.alignment		= "LeftCenter"
		GWT_Label.value			= "GWT"
		GWT_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(GWT_Label)

local	GWT_Value				= CreateElement "ceStringSLine"
		GWT_Value.name			= "GWT_Value"
		GWT_Value.material		= stroke_font
		GWT_Value.init_pos		= {PosX(0.10), PosY(-0.5), 0.00}
		GWT_Value.alignment		= "RightCenter"
		GWT_Value.value			= "27000"
		GWT_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        GWT_Value.formats		= {"%d"}
        GWT_Value.controllers	= {{"gwt_vlto"}}
Add_MPCD_Element(GWT_Value)

local	GWT_MValue				= CreateElement "ceStringSLine"
		GWT_MValue.name			= "GWT_MValue"
		GWT_MValue.material		= stroke_font
		GWT_MValue.init_pos		= {PosX(-0.35), PosY(-0.5), 0.00}
		GWT_MValue.alignment	= "RightCenter"
		GWT_MValue.value		= "*"
		GWT_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        GWT_MValue.controllers	= {{"gwt_vlto_overridden"}}
Add_MPCD_Element(GWT_MValue)