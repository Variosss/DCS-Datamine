-- ***********************
--   V/STOL REST Display
--   BINGO PAGE
-- ***********************

local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/VRST/"

dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- MENU
dofile(mpcd_path.."VRST_MENU.lua")

local	BNGO_VRST_Sel				= CreateElement "ceSMultiLine"
		BNGO_VRST_Sel.name			= "BNGO_VRST_Sel"
        BNGO_VRST_Sel.material		= stroke_material
		BNGO_VRST_Sel.init_pos		= mpcd_btn_14_pos
        BNGO_VRST_Sel.points_set	= {"MPCD_stroke_symbols", "vert_box"}
        BNGO_VRST_Sel.scale		    = MPCD_STRK_SCALE
AddMPCDStrokeSymbol(BNGO_VRST_Sel)

-- DATA
local	ABNG_Label				= CreateElement "ceStringSLine"
		ABNG_Label.name			= "ABNG_Label"
		ABNG_Label.material		= stroke_font
		ABNG_Label.init_pos		= {0, PosY(0.5), 0}
		ABNG_Label.alignment	= "CenterCenter"
		ABNG_Label.value		= "ABNG"
		ABNG_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(ABNG_Label)

local	ABNG_Flag				= CreateElement "ceStringSLine"
		ABNG_Flag.name			= "ABNG_Flag"
		ABNG_Flag.material		= stroke_font
		ABNG_Flag.init_pos		= {PosX(0.13), PosY(0.5), 0}
		ABNG_Flag.alignment		= "RightCenter"
		ABNG_Flag.value			= "*"
		ABNG_Flag.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        ABNG_Flag.controllers   = {{"higher_than_opt_bingo"}}
Add_MPCD_Element(ABNG_Flag)

local	OBNG_Label				= CreateElement "ceStringSLine"
		OBNG_Label.name			= "OBNG_Label"
		OBNG_Label.material		= stroke_font
		OBNG_Label.init_pos		= {PosX(0.4), PosY(0.5), 0}
		OBNG_Label.alignment	= "CenterCenter"
		OBNG_Label.value		= "OBNG"
		OBNG_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(OBNG_Label)

-- AIRCRAFT DATA
local	CAS_Label				= CreateElement "ceStringSLine"
		CAS_Label.name			= "CAS_Label"
		CAS_Label.material		= stroke_font
		CAS_Label.init_pos		= {PosX(-0.33), PosY(0.4), 0}
		CAS_Label.alignment		= "LeftCenter"
		CAS_Label.value			= "CAS"
		CAS_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CAS_Label)

local	CAS_A_Value				= CreateElement "ceStringSLine"
		CAS_A_Value.name		= "CAS_A_Value"
		CAS_A_Value.material	= stroke_font
		CAS_A_Value.init_pos	= {PosX(0.1), PosY(0.4), 0}
		CAS_A_Value.alignment	= "RightCenter"
		CAS_A_Value.value		= "400"
		CAS_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        CAS_A_Value.formats	    = {"%d"}
        CAS_A_Value.controllers = {{"cas_bingo_alt"}}
Add_MPCD_Element(CAS_A_Value)

local	CAS_A_Unit				= CreateElement "ceStringSLine"
		CAS_A_Unit.name			= "CAS_A_Unit"
		CAS_A_Unit.material		= stroke_font
		CAS_A_Unit.init_pos		= {PosX(0.15), PosY(0.4), 0}
		CAS_A_Unit.alignment	= "LeftCenter"
		CAS_A_Unit.value		= "KT"
		CAS_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CAS_A_Unit)

local	CAS_O_Value				= CreateElement "ceStringSLine"
		CAS_O_Value.name		= "CAS_O_Value"
		CAS_O_Value.material	= stroke_font
		CAS_O_Value.init_pos	= {PosX(0.5), PosY(0.4), 0}
		CAS_O_Value.alignment	= "RightCenter"
		CAS_O_Value.value		= "450"
		CAS_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        CAS_O_Value.formats	    = {"%d"}
        CAS_O_Value.controllers = {{"cas_bingo_opt"}}
Add_MPCD_Element(CAS_O_Value)

local	CAS_O_Unit				= CreateElement "ceStringSLine"
		CAS_O_Unit.name			= "CAS_O_Unit"
		CAS_O_Unit.material		= stroke_font
		CAS_O_Unit.init_pos		= {PosX(0.55), PosY(0.4), 0}
		CAS_O_Unit.alignment	= "LeftCenter"
		CAS_O_Unit.value		= "KT"
		CAS_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CAS_O_Unit)

local	CAS_MValue				= CreateElement "ceStringSLine"
		CAS_MValue.name			= "CAS_MValue"
		CAS_MValue.material		= stroke_font
		CAS_MValue.init_pos		= {PosX(-0.35), PosY(0.4), 0}
		CAS_MValue.alignment	= "RightCenter"
		CAS_MValue.value		= "*"
		CAS_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        CAS_MValue.controllers  = {{"cas_bingo_opt_overridden"}}
Add_MPCD_Element(CAS_MValue)

local	MACH_Label				= CreateElement "ceStringSLine"
		MACH_Label.name			= "MACH_Label"
		MACH_Label.material		= stroke_font
		MACH_Label.init_pos		= {PosX(-0.33), PosY(0.3), 0}
		MACH_Label.alignment	= "LeftCenter"
		MACH_Label.value		= "MACH"
		MACH_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(MACH_Label)

local	MACH_A_Value			= CreateElement "ceStringSLine"
		MACH_A_Value.name		= "MACH_A_Value"
		MACH_A_Value.material	= stroke_font
		MACH_A_Value.init_pos	= {PosX(0.1), PosY(0.3), 0}
		MACH_A_Value.alignment	= "RightCenter"
		MACH_A_Value.value		= "0.55"
		MACH_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        MACH_A_Value.formats	= {"%1.2f"}
        MACH_A_Value.controllers= {{"mach_bingo_alt"}}
Add_MPCD_Element(MACH_A_Value)

local	MACH_O_Value			= CreateElement "ceStringSLine"
		MACH_O_Value.name		= "MACH_O_Value"
		MACH_O_Value.material	= stroke_font
		MACH_O_Value.init_pos	= {PosX(0.5), PosY(0.3), 0}
		MACH_O_Value.alignment	= "RightCenter"
		MACH_O_Value.value		= "0.58"
		MACH_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        MACH_O_Value.formats	= {"%1.2f"}
        MACH_O_Value.controllers= {{"mach_bingo_opt"}}
Add_MPCD_Element(MACH_O_Value)

local	CALT_Label				= CreateElement "ceStringSLine"
		CALT_Label.name			= "CALT_Label"
		CALT_Label.material		= stroke_font
		CALT_Label.init_pos		= {PosX(-0.33), PosY(0.2), 0}
		CALT_Label.alignment	= "LeftCenter"
		CALT_Label.value		= "CALT"
		CALT_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CALT_Label)

local	CALT_A_Value			= CreateElement "ceStringSLine"
		CALT_A_Value.name		= "CALT_A_Value"
		CALT_A_Value.material	= stroke_font
		CALT_A_Value.init_pos	= {PosX(0.1), PosY(0.2), 0}
		CALT_A_Value.alignment	= "RightCenter"
		CALT_A_Value.value		= "20000"
		CALT_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        CALT_A_Value.formats	= {"%d"}
        CALT_A_Value.controllers= {{"calt_bingo_alt"}}
Add_MPCD_Element(CALT_A_Value)

local	CALT_A_Unit				= CreateElement "ceStringSLine"
		CALT_A_Unit.name		= "CALT_A_Unit"
		CALT_A_Unit.material	= stroke_font
		CALT_A_Unit.init_pos	= {PosX(0.15), PosY(0.2), 0}
		CALT_A_Unit.alignment	= "LeftCenter"
		CALT_A_Unit.value		= "FT"
		CALT_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CALT_A_Unit)

local	CALT_O_Value			= CreateElement "ceStringSLine"
		CALT_O_Value.name		= "CALT_O_Value"
		CALT_O_Value.material	= stroke_font
		CALT_O_Value.init_pos	= {PosX(0.5), PosY(0.2), 0}
		CALT_O_Value.alignment	= "RightCenter"
		CALT_O_Value.value		= "25000"
		CALT_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        CALT_O_Value.formats	= {"%d"}
        CALT_O_Value.controllers= {{"calt_bingo_opt"}}
Add_MPCD_Element(CALT_O_Value)

local	CALT_O_Unit				= CreateElement "ceStringSLine"
		CALT_O_Unit.name		= "CALT_O_Unit"
		CALT_O_Unit.material	= stroke_font
		CALT_O_Unit.init_pos	= {PosX(0.55), PosY(0.2), 0}
		CALT_O_Unit.alignment	= "LeftCenter"
		CALT_O_Unit.value		= "FT"
		CALT_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(CALT_O_Unit)

local	CALT_MValue				= CreateElement "ceStringSLine"
		CALT_MValue.name		= "CALT_MValue"
		CALT_MValue.material	= stroke_font
		CALT_MValue.init_pos	= {PosX(-0.35), PosY(0.2), 0}
		CALT_MValue.alignment	= "RightCenter"
		CALT_MValue.value		= "*"
		CALT_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        CALT_MValue.controllers = {{"calt_bingo_opt_overridden"}}
Add_MPCD_Element(CALT_MValue)

local	RANG_Label				= CreateElement "ceStringSLine"
		RANG_Label.name			= "RANG_Label"
		RANG_Label.material		= stroke_font
		RANG_Label.init_pos		= {PosX(-0.33), PosY(0.1), 0}
		RANG_Label.alignment	= "LeftCenter"
		RANG_Label.value		= "RANG"
		RANG_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(RANG_Label)

local	RANG_A_Value			= CreateElement "ceStringSLine"
		RANG_A_Value.name		= "RANG_A_Value"
		RANG_A_Value.material	= stroke_font
		RANG_A_Value.init_pos	= {PosX(0.1), PosY(0.1), 0}
		RANG_A_Value.alignment	= "RightCenter"
		RANG_A_Value.value		= "20"
		RANG_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        RANG_A_Value.formats	= {"%d"}
        RANG_A_Value.controllers= {{"rang_bingo_alt"}}
Add_MPCD_Element(RANG_A_Value)

local	RANG_A_Unit				= CreateElement "ceStringSLine"
		RANG_A_Unit.name		= "RANG_A_Unit"
		RANG_A_Unit.material	= stroke_font
		RANG_A_Unit.init_pos	= {PosX(0.15), PosY(0.1), 0}
		RANG_A_Unit.alignment	= "LeftCenter"
		RANG_A_Unit.value		= "NM"
		RANG_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(RANG_A_Unit)

local	RANG_O_Value			= CreateElement "ceStringSLine"
		RANG_O_Value.name		= "RANG_O_Value"
		RANG_O_Value.material	= stroke_font
		RANG_O_Value.init_pos	= {PosX(0.5), PosY(0.1), 0}
		RANG_O_Value.alignment	= "RightCenter"
		RANG_O_Value.value		= "20"
		RANG_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        RANG_O_Value.formats	= {"%d"}
        RANG_O_Value.controllers= {{"rang_bingo_opt"}}
Add_MPCD_Element(RANG_O_Value)

local	RANG_O_Unit				= CreateElement "ceStringSLine"
		RANG_O_Unit.name		= "RANG_O_Unit"
		RANG_O_Unit.material	= stroke_font
		RANG_O_Unit.init_pos	= {PosX(0.55), PosY(0.1), 0}
		RANG_O_Unit.alignment	= "LeftCenter"
		RANG_O_Unit.value		= "NM"
		RANG_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(RANG_O_Unit)

local	RFUL_Label				= CreateElement "ceStringSLine"
		RFUL_Label.name			= "RFUL_Label"
		RFUL_Label.material		= stroke_font
		RFUL_Label.init_pos		= {PosX(-0.33), 0, 0}
		RFUL_Label.alignment	= "LeftCenter"
		RFUL_Label.value		= "RFUL"
		RFUL_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(RFUL_Label)

local	RFUL_A_Value			= CreateElement "ceStringSLine"
		RFUL_A_Value.name		= "RFUL_A_Value"
		RFUL_A_Value.material	= stroke_font
		RFUL_A_Value.init_pos	= {PosX(0.1), 0, 0}
		RFUL_A_Value.alignment	= "RightCenter"
		RFUL_A_Value.value		= "2000"
		RFUL_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        RFUL_A_Value.formats	= {"%d"}
        RFUL_A_Value.controllers= {{"rfuel_bingo_alt"}}
Add_MPCD_Element(RFUL_A_Value)

local	RFUL_A_Unit				= CreateElement "ceStringSLine"
		RFUL_A_Unit.name		= "RFUL_A_Unit"
		RFUL_A_Unit.material	= stroke_font
		RFUL_A_Unit.init_pos	= {PosX(0.15), 0, 0}
		RFUL_A_Unit.alignment	= "LeftCenter"
		RFUL_A_Unit.value		= "#"
		RFUL_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(RFUL_A_Unit)

local	RFUL_O_Value			= CreateElement "ceStringSLine"
		RFUL_O_Value.name		= "RFUL_O_Value"
		RFUL_O_Value.material	= stroke_font
		RFUL_O_Value.init_pos	= {PosX(0.5), 0, 0}
		RFUL_O_Value.alignment	= "RightCenter"
		RFUL_O_Value.value		= "2250"
		RFUL_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        RFUL_O_Value.formats	= {"%d"}
        RFUL_O_Value.controllers= {{"rfuel_bingo_opt"}}
Add_MPCD_Element(RFUL_O_Value)

local	RFUL_O_Unit				= CreateElement "ceStringSLine"
		RFUL_O_Unit.name		= "RFUL_O_Unit"
		RFUL_O_Unit.material	= stroke_font
		RFUL_O_Unit.init_pos	= {PosX(0.55), 0, 0}
		RFUL_O_Unit.alignment	= "LeftCenter"
		RFUL_O_Unit.value		= "#"
		RFUL_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(RFUL_O_Unit)

local	MRNG_Label				= CreateElement "ceStringSLine"
		MRNG_Label.name			= "MRNG_Label"
		MRNG_Label.material		= stroke_font
		MRNG_Label.init_pos		= {PosX(-0.33), PosY(-0.1), 0}
		MRNG_Label.alignment	= "LeftCenter"
		MRNG_Label.value		= "MRNG"
		MRNG_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(MRNG_Label)

local	MRNG_A_Value			= CreateElement "ceStringSLine"
		MRNG_A_Value.name		= "MRNG_A_Value"
		MRNG_A_Value.material	= stroke_font
		MRNG_A_Value.init_pos	= {PosX(0.1), PosY(-0.1), 0}
		MRNG_A_Value.alignment	= "RightCenter"
		MRNG_A_Value.value		= "325"
		MRNG_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        MRNG_A_Value.formats	= {"%d"}
        MRNG_A_Value.controllers= {{"mrng_bingo_alt"}}
Add_MPCD_Element(MRNG_A_Value)

local	MRNG_A_Unit				= CreateElement "ceStringSLine"
		MRNG_A_Unit.name		= "MRNG_A_Unit"
		MRNG_A_Unit.material	= stroke_font
		MRNG_A_Unit.init_pos	= {PosX(0.15), PosY(-0.1), 0}
		MRNG_A_Unit.alignment	= "LeftCenter"
		MRNG_A_Unit.value		= "NM"
		MRNG_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(MRNG_A_Unit)

local	MRNG_O_Value			= CreateElement "ceStringSLine"
		MRNG_O_Value.name		= "MRNG_O_Value"
		MRNG_O_Value.material	= stroke_font
		MRNG_O_Value.init_pos	= {PosX(0.5), PosY(-0.1), 0}
		MRNG_O_Value.alignment	= "RightCenter"
		MRNG_O_Value.value		= "375"
		MRNG_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        MRNG_O_Value.formats	= {"%d"}
        MRNG_O_Value.controllers= {{"mrng_bingo_opt"}}
Add_MPCD_Element(MRNG_O_Value)

local	MRNG_O_Unit				= CreateElement "ceStringSLine"
		MRNG_O_Unit.name		= "MRNG_O_Unit"
		MRNG_O_Unit.material	= stroke_font
		MRNG_O_Unit.init_pos	= {PosX(0.55), PosY(-0.1), 0}
		MRNG_O_Unit.alignment	= "LeftCenter"
		MRNG_O_Unit.value		= "NM"
		MRNG_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(MRNG_O_Unit)

local	WIND_Label				= CreateElement "ceStringSLine"
		WIND_Label.name			= "WIND_Label"
		WIND_Label.material		= stroke_font
		WIND_Label.init_pos		= {PosX(-0.33), PosY(-0.2), 0}
		WIND_Label.alignment	= "LeftCenter"
		WIND_Label.value		= "WIND"
		WIND_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(WIND_Label)

local	WIND_A_Value			= CreateElement "ceStringSLine"
		WIND_A_Value.name		= "WIND_A_Value"
		WIND_A_Value.material	= stroke_font
		WIND_A_Value.init_pos	= {PosX(0.15), PosY(-0.2), 0}
		WIND_A_Value.alignment	= "RightCenter"
		WIND_A_Value.value		= "215/015"
		WIND_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        WIND_A_Value.formats	= {"%s"}
        WIND_A_Value.controllers= {{"wind_bingo_alt"}}
Add_MPCD_Element(WIND_A_Value)

local	WIND_O_Value			= CreateElement "ceStringSLine"
		WIND_O_Value.name		= "WIND_O_Value"
		WIND_O_Value.material	= stroke_font
		WIND_O_Value.init_pos	= {PosX(0.55), PosY(-0.2), 0}
		WIND_O_Value.alignment	= "RightCenter"
		WIND_O_Value.value		= "210/010"
		WIND_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        WIND_O_Value.formats	= {"%s"}
        WIND_O_Value.controllers= {{"wind_bingo_opt"}}
Add_MPCD_Element(WIND_O_Value)

local	DCRG_Label				= CreateElement "ceStringSLine"
		DCRG_Label.name			= "DCRG_Label"
		DCRG_Label.material		= stroke_font
		DCRG_Label.init_pos		= {PosX(-0.33), PosY(-0.3), 0}
		DCRG_Label.alignment	= "LeftCenter"
		DCRG_Label.value		= "DCRG"
		DCRG_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DCRG_Label)

local	DCRG_A_Value			= CreateElement "ceStringSLine"
		DCRG_A_Value.name		= "DCRG_A_Value"
		DCRG_A_Value.material	= stroke_font
		DCRG_A_Value.init_pos	= {PosX(0.1), PosY(-0.3), 0}
		DCRG_A_Value.alignment	= "RightCenter"
		DCRG_A_Value.value		= "10"
		DCRG_A_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        DCRG_A_Value.formats	= {"%d"}
        DCRG_A_Value.controllers= {{"dcrg_bingo_alt"}}
Add_MPCD_Element(DCRG_A_Value)

local	DCRG_A_Unit				= CreateElement "ceStringSLine"
		DCRG_A_Unit.name		= "DCRG_A_Unit"
		DCRG_A_Unit.material	= stroke_font
		DCRG_A_Unit.init_pos	= {PosX(0.15), PosY(-0.3), 0}
		DCRG_A_Unit.alignment	= "LeftCenter"
		DCRG_A_Unit.value		= "NM"
		DCRG_A_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DCRG_A_Unit)

local	DCRG_O_Value			= CreateElement "ceStringSLine"
		DCRG_O_Value.name		= "DCRG_O_Value"
		DCRG_O_Value.material	= stroke_font
		DCRG_O_Value.init_pos	= {PosX(0.5), PosY(-0.3), 0}
		DCRG_O_Value.alignment	= "RightCenter"
		DCRG_O_Value.value		= "15"
		DCRG_O_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        DCRG_O_Value.formats	= {"%d"}
        DCRG_O_Value.controllers= {{"dcrg_bingo_opt"}}
Add_MPCD_Element(DCRG_O_Value)

local	DCRG_O_Unit				= CreateElement "ceStringSLine"
		DCRG_O_Unit.name		= "DCRG_O_Unit"
		DCRG_O_Unit.material	= stroke_font
		DCRG_O_Unit.init_pos	= {PosX(0.55), PosY(-0.3), 0}
		DCRG_O_Unit.alignment	= "LeftCenter"
		DCRG_O_Unit.value		= "NM"
		DCRG_O_Unit.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DCRG_O_Unit)

local	GWT_Label				= CreateElement "ceStringSLine"
		GWT_Label.name			= "GWT_Label"
		GWT_Label.material		= stroke_font
		GWT_Label.init_pos		= {PosX(-0.33), PosY(-0.5), 0}
		GWT_Label.alignment		= "LeftCenter"
		GWT_Label.value			= "GWT"
		GWT_Label.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(GWT_Label)

local	GWT_Value				= CreateElement "ceStringSLine"
		GWT_Value.name			= "GWT_Value"
		GWT_Value.material		= stroke_font
		GWT_Value.init_pos		= {PosX(0.1), PosY(-0.5), 0}
		GWT_Value.alignment		= "RightCenter"
		GWT_Value.value			= "27000"
		GWT_Value.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
        GWT_Value.formats		= {"%d"}
        GWT_Value.controllers	= {{"gwt_bingo"}}
Add_MPCD_Element(GWT_Value)

local	GWT_MValue				= CreateElement "ceStringSLine"
		GWT_MValue.name			= "GWT_MValue"
		GWT_MValue.material		= stroke_font
		GWT_MValue.init_pos		= {PosX(-0.35), PosY(-0.5), 0}
		GWT_MValue.alignment	= "RightCenter"
		GWT_MValue.value		= "*"
		GWT_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        GWT_MValue.controllers	= {{"gwt_bingo_overridden"}}
Add_MPCD_Element(GWT_MValue)

local	DI_Label				= CreateElement "ceStringSLine"
		DI_Label.name			= "DI_Label"
		DI_Label.material		= stroke_font
		DI_Label.init_pos		= {PosX(0.30), PosY(-0.5), 0}
		DI_Label.alignment		= "LeftCenter"
		DI_Label.value			= "DI"
		DI_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(DI_Label)

local	DI_Value				= CreateElement "ceStringSLine"
		DI_Value.name			= "DI_Value"
		DI_Value.material		= stroke_font
		DI_Value.init_pos		= {PosX(0.55), PosY(-0.5), 0}
		DI_Value.alignment		= "RightCenter"
		DI_Value.value			= "22.1"
		DI_Value.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
        DI_Value.formats		= {"%2.1f"}
        DI_Value.controllers	= {{"bingo_drag_index"}}
Add_MPCD_Element(DI_Value)

local	DI_MValue				= CreateElement "ceStringSLine"
		DI_MValue.name			= "DI_MValue"
		DI_MValue.material		= stroke_font
		DI_MValue.init_pos		= {PosX(0.25), PosY(-0.5), 0}
		DI_MValue.alignment		= "RightCenter"
		DI_MValue.value			= "*"
		DI_MValue.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
        DI_MValue.controllers	= {{"bingo_drag_index_overridden"}}
Add_MPCD_Element(DI_MValue)
