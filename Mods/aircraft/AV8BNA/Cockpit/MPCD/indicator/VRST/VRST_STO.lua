-- ***********************
--   V/STOL REST Display
--   STO PAGE
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
        mpcd_mm_btn_04.controllers	= {{"temp_sto_label"}}
Add_MPCD_Element(mpcd_mm_btn_04)

local	mpcd_mm_btn_16				= CreateElement "ceStringSLine"
		mpcd_mm_btn_16.name			= "mpcd_mm_btn_16"
		mpcd_mm_btn_16.material		= stroke_font
		mpcd_mm_btn_16.init_pos		= mpcd_btn_16_pos
		mpcd_mm_btn_16.alignment	= "CenterCenter"
		mpcd_mm_btn_16.value		= "ABRT"
		mpcd_mm_btn_16.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_16)

local	ABRT_STO_Sel				= CreateElement "ceSMultiLine"
		ABRT_STO_Sel.name			= "ABRT_STO_Sel"
		ABRT_STO_Sel.material		= stroke_material
		ABRT_STO_Sel.init_pos		= mpcd_btn_16_pos
		ABRT_STO_Sel.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		ABRT_STO_Sel.scale			= MPCD_STRK_SCALE
		ABRT_STO_Sel.controllers 	= {{"abrt_sto_sel"}}
AddMPCDStrokeSymbol(ABRT_STO_Sel)

local	STO_VRST_Sel				= CreateElement "ceSMultiLine"
		STO_VRST_Sel.name			= "STO_VRST_Sel"
		STO_VRST_Sel.material		= stroke_material
		STO_VRST_Sel.init_pos		= mpcd_btn_08_pos
		STO_VRST_Sel.points_set		= {"MPCD_stroke_symbols", "horz_box"}
		STO_VRST_Sel.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(STO_VRST_Sel)

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

-- AIRCRAFT DATA
local	NRAS_Label				= CreateElement "ceStringSLine"
		NRAS_Label.name			= "NRAS_Label"
		NRAS_Label.material		= stroke_font
		NRAS_Label.init_pos		= {PosX(-0.33), PosY(0.4), 0.00}
		NRAS_Label.alignment	= "LeftCenter"
		NRAS_Label.value		= "NRAS"
		NRAS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(NRAS_Label)

local	NRAS_W_Value			= CreateElement "ceStringSLine"
		NRAS_W_Value.name		= "NRAS_W_Value"
		NRAS_W_Value.material	= stroke_font
		NRAS_W_Value.init_pos	= {PosX(0.10), PosY(0.4), 0.00}
		NRAS_W_Value.alignment	= "RightCenter"
		NRAS_W_Value.value		= "80"
		NRAS_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        NRAS_W_Value.formats	= {"%d"}
        NRAS_W_Value.controllers= {{"nras_sto_wet"}}
Add_MPCD_Element(NRAS_W_Value)

local	NRAS_D_Value			= CreateElement "ceStringSLine"
		NRAS_D_Value.name		= "NRAS_D_Value"
		NRAS_D_Value.material	= stroke_font
		NRAS_D_Value.init_pos	= {PosX(0.40), PosY(0.4), 0.00}
		NRAS_D_Value.alignment	= "RightCenter"
		NRAS_D_Value.value		= "80"
		NRAS_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        NRAS_D_Value.formats	= {"%d"}
        NRAS_D_Value.controllers= {{"nras_sto_dry"}}
Add_MPCD_Element(NRAS_D_Value)

local	NOZ_Label				= CreateElement "ceStringSLine"
		NOZ_Label.name			= "NOZ_Label"
		NOZ_Label.material		= stroke_font
		NOZ_Label.init_pos		= {PosX(-0.33), PosY(0.3), 0.00}
		NOZ_Label.alignment		= "LeftCenter"
		NOZ_Label.value			= "NOZ"
		NOZ_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(NOZ_Label)

local	NOZ_W_Value				= CreateElement "ceStringSLine"
		NOZ_W_Value.name		= "NOZ_W_Value"
		NOZ_W_Value.material	= stroke_font
		NOZ_W_Value.init_pos	= {PosX(0.10), PosY(0.3), 0.00}
		NOZ_W_Value.alignment	= "RightCenter"
		NOZ_W_Value.value		= "55"
		NOZ_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        NOZ_W_Value.formats	    = {"%d"}
        NOZ_W_Value.controllers = {{"noz_sto_wet"}}
Add_MPCD_Element(NOZ_W_Value)

local	NOZ_D_Value				= CreateElement "ceStringSLine"
		NOZ_D_Value.name		= "NOZ_D_Value"
		NOZ_D_Value.material	= stroke_font
		NOZ_D_Value.init_pos	= {PosX(0.40), PosY(0.3), 0.00}
		NOZ_D_Value.alignment	= "RightCenter"
		NOZ_D_Value.value		= "55"
		NOZ_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        NOZ_D_Value.formats	    = {"%d"}
        NOZ_D_Value.controllers = {{"noz_sto_dry"}}
Add_MPCD_Element(NOZ_D_Value)

local	GROL_Label				= CreateElement "ceStringSLine"
		GROL_Label.name			= "GROL_Label"
		GROL_Label.material		= stroke_font
		GROL_Label.init_pos		= {PosX(-0.33), PosY(0.2), 0.00}
		GROL_Label.alignment	= "LeftCenter"
		GROL_Label.value		= "GROL"
		GROL_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(GROL_Label)

local	GROL_W_Value			= CreateElement "ceStringSLine"
		GROL_W_Value.name		= "GROL_W_Value"
		GROL_W_Value.material	= stroke_font
		GROL_W_Value.init_pos	= {PosX(0.10), PosY(0.2), 0.00}
		GROL_W_Value.alignment	= "RightCenter"
		GROL_W_Value.value		= "100"
		GROL_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        GROL_W_Value.formats	= {"%d"}
        GROL_W_Value.controllers= {{"grol_sto_wet"}}
Add_MPCD_Element(GROL_W_Value)

local	GROL_D_Value			= CreateElement "ceStringSLine"
		GROL_D_Value.name		= "GROL_D_Value"
		GROL_D_Value.material	= stroke_font
		GROL_D_Value.init_pos	= {PosX(0.40), PosY(0.2), 0.00}
		GROL_D_Value.alignment	= "RightCenter"
		GROL_D_Value.value		= "120"
		GROL_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        GROL_D_Value.formats	= {"%d"}
        GROL_D_Value.controllers= {{"grol_sto_dry"}}
Add_MPCD_Element(GROL_D_Value)

local	DT50_Label				= CreateElement "ceStringSLine"
		DT50_Label.name			= "DT50_Label"
		DT50_Label.material		= stroke_font
		DT50_Label.init_pos		= {PosX(-0.33), PosY(0.1), 0.00}
		DT50_Label.alignment	= "LeftCenter"
		DT50_Label.value		= "DT50"
		DT50_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DT50_Label)

local	DT50_W_Value			= CreateElement "ceStringSLine"
		DT50_W_Value.name		= "DT50_W_Value"
		DT50_W_Value.material	= stroke_font
		DT50_W_Value.init_pos	= {PosX(0.10), PosY(0.1), 0.00}
		DT50_W_Value.alignment	= "RightCenter"
		DT50_W_Value.value		= "750"
		DT50_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        DT50_W_Value.formats	= {"%d"}
        DT50_W_Value.controllers= {{"dt50_sto_wet"}}
Add_MPCD_Element(DT50_W_Value)

local	DT50_D_Value			= CreateElement "ceStringSLine"
		DT50_D_Value.name		= "DT50_D_Value"
		DT50_D_Value.material	= stroke_font
		DT50_D_Value.init_pos	= {PosX(0.40), PosY(0.1), 0.00}
		DT50_D_Value.alignment	= "RightCenter"
		DT50_D_Value.value		= "850"
		DT50_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        DT50_D_Value.formats	= {"%d"}
        DT50_D_Value.controllers= {{"dt50_sto_dry"}}
Add_MPCD_Element(DT50_D_Value)

local	ASPD_Label				= CreateElement "ceStringSLine"
		ASPD_Label.name			= "ASPD_Label"
		ASPD_Label.material		= stroke_font
		ASPD_Label.init_pos		= {PosX(-0.33), -0.0, 0.00}
		ASPD_Label.alignment	= "LeftCenter"
		ASPD_Label.value		= "ASPD"
		ASPD_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(ASPD_Label)

local	ASPD_W_Value			= CreateElement "ceStringSLine"
		ASPD_W_Value.name		= "ASPD_W_Value"
		ASPD_W_Value.material	= stroke_font
		ASPD_W_Value.init_pos	= {PosX(0.10), -0.0, 0.00}
		ASPD_W_Value.alignment	= "RightCenter"
		ASPD_W_Value.value		= "175"
		ASPD_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        ASPD_W_Value.formats	= {"%s"}
        ASPD_W_Value.controllers= {{"aspd_sto_wet"}}
Add_MPCD_Element(ASPD_W_Value)

local	ASPD_D_Value			= CreateElement "ceStringSLine"
		ASPD_D_Value.name		= "ASPD_D_Value"
		ASPD_D_Value.material	= stroke_font
		ASPD_D_Value.init_pos	= {PosX(0.40), -0.0, 0.00}
		ASPD_D_Value.alignment	= "RightCenter"
		ASPD_D_Value.value		= "175"
		ASPD_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        ASPD_D_Value.formats	= {"%s"}
        ASPD_D_Value.controllers= {{"aspd_sto_dry"}}
Add_MPCD_Element(ASPD_D_Value)

local	SDST_Label				= CreateElement "ceStringSLine"
		SDST_Label.name			= "SDST_Label"
		SDST_Label.material		= stroke_font
		SDST_Label.init_pos		= {PosX(-0.33), PosY(-0.1), 0.00}
		SDST_Label.alignment	= "LeftCenter"
		SDST_Label.value		= "SDST"
		SDST_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(SDST_Label)

local	SDST_W_Value			= CreateElement "ceStringSLine"
		SDST_W_Value.name		= "SDST_W_Value"
		SDST_W_Value.material	= stroke_font
		SDST_W_Value.init_pos	= {PosX(0.10), PosY(-0.1), 0.00}
		SDST_W_Value.alignment	= "RightCenter"
		SDST_W_Value.value		= "1500"
		SDST_W_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        SDST_W_Value.formats	= {"%s"}
        SDST_W_Value.controllers= {{"sdst_sto_wet"}}
Add_MPCD_Element(SDST_W_Value)

local	SDST_D_Value			= CreateElement "ceStringSLine"
		SDST_D_Value.name		= "SDST_D_Value"
		SDST_D_Value.material	= stroke_font
		SDST_D_Value.init_pos	= {PosX(0.40), PosY(-0.1), 0.00}
		SDST_D_Value.alignment	= "RightCenter"
		SDST_D_Value.value		= "1500"
		SDST_D_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        SDST_D_Value.formats	= {"%s"}
        SDST_D_Value.controllers= {{"sdst_sto_dry"}}
Add_MPCD_Element(SDST_D_Value)

-- ENVIRONMENTAL DATA
local	OATC_Label				= CreateElement "ceStringSLine"
		OATC_Label.name			= "OATC_Label"
		OATC_Label.material		= stroke_font
		OATC_Label.init_pos		= {PosX(-0.33), PosY(-0.2), 0.00}
		OATC_Label.alignment	= "LeftCenter"
		OATC_Label.value		= "OATC"
		OATC_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        OATC_Label.formats		= {"%s"}
        OATC_Label.controllers	= {{"oatc_sto_label"}}
Add_MPCD_Element(OATC_Label)

local	OATC_Value				= CreateElement "ceStringSLine"
		OATC_Value.name			= "OATC_Value"
		OATC_Value.material		= stroke_font
		OATC_Value.init_pos		= {PosX(0.10), PosY(-0.2), 0.00}
		OATC_Value.alignment	= "RightCenter"
		OATC_Value.value		= "15"
		OATC_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        OATC_Value.formats		= {"%d"}
        OATC_Value.controllers	= {{"oatc_sto"}}
Add_MPCD_Element(OATC_Value)

local	OATC_MValue				= CreateElement "ceStringSLine"
		OATC_MValue.name		= "OATC_MValue"
		OATC_MValue.material	= stroke_font
		OATC_MValue.init_pos	= {PosX(-0.35), PosY(-0.2), 0.00}
		OATC_MValue.alignment	= "RightCenter"
		OATC_MValue.value		= "*"
		OATC_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        OATC_MValue.controllers	= {{"oatc_sto_overridden"}}
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
        ALTM_Value.controllers	= {{"altm_sto"}}
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
        FELV_Value.controllers	= {{"felv_sto"}}
Add_MPCD_Element(FELV_Value)

local	FELV_MValue				= CreateElement "ceStringSLine"
		FELV_MValue.name		= "FELV_MValue"
		FELV_MValue.material	= stroke_font
		FELV_MValue.init_pos	= {PosX(-0.35), PosY(-0.4), 0.00}
		FELV_MValue.alignment	= "RightCenter"
		FELV_MValue.value		= "*"
		FELV_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        FELV_MValue.controllers	= {{"felv_sto_overridden"}}
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
        GWT_Value.controllers	= {{"gwt_sto"}}
Add_MPCD_Element(GWT_Value)

local	GWT_MValue				= CreateElement "ceStringSLine"
		GWT_MValue.name			= "GWT_MValue"
		GWT_MValue.material		= stroke_font
		GWT_MValue.init_pos		= {PosX(-0.35), PosY(-0.5), 0.00}
		GWT_MValue.alignment	= "RightCenter"
		GWT_MValue.value		= "*"
		GWT_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        GWT_MValue.controllers	= {{"gwt_sto_overridden"}}
Add_MPCD_Element(GWT_MValue)

local	RUNW_Label				= CreateElement "ceStringSLine"
		RUNW_Label.name			= "RUNW_Label"
		RUNW_Label.material		= stroke_font
		RUNW_Label.init_pos		= {PosX(-0.33), PosY(-0.6), 0.00}
		RUNW_Label.alignment	= "LeftCenter"
		RUNW_Label.value		= "RUNW"
		RUNW_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(RUNW_Label)

local	RUNW_Value				= CreateElement "ceStringSLine"
		RUNW_Value.name			= "RUNW_Value"
		RUNW_Value.material		= stroke_font
		RUNW_Value.init_pos		= {PosX(-0.10), PosY(-0.6), 0.00}
		RUNW_Value.alignment	= "LeftCenter"
		RUNW_Value.value		= "07500/135DRY"
		RUNW_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        RUNW_Value.formats		= {"%s"}
        RUNW_Value.controllers	= {{"runw_sto"}}
Add_MPCD_Element(RUNW_Value)

local	GWND_Label				= CreateElement "ceStringSLine"
		GWND_Label.name			= "GWND_Label"
		GWND_Label.material		= stroke_font
		GWND_Label.init_pos		= {PosX(-0.33), PosY(-0.7), 0.00}
		GWND_Label.alignment	= "LeftCenter"
		GWND_Label.value		= "GWIND"
		GWND_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(GWND_Label)

local	GWND_Value				= CreateElement "ceStringSLine"
		GWND_Value.name			= "GWND_Value"
		GWND_Value.material		= stroke_font
		GWND_Value.init_pos		= {PosX(-0.10), PosY(-0.7), 0.00}
		GWND_Value.alignment	= "LeftCenter"
		GWND_Value.value		= "155/005"
		GWND_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        GWND_Value.formats		= {"%s"}
        GWND_Value.controllers	= {{"gwnd_sto"}}
Add_MPCD_Element(GWND_Value)

