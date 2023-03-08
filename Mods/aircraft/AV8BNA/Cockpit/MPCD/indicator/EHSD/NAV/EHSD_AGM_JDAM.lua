---------------------
-- EHSD Page       --
-- Navigation      --
-- JDAM Data Block --
---------------------
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 2.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 2.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}}
Add_MPCD_Element(MPCD_center)

-- JDAM Data Block
local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_prtgt_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.55), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_16"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_prtgt"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.55), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_16"}}
Add_MPCD_Element(EHSD_Label)

--

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_rng_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.90), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "RightCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_17"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_rng"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.90), PosY(-0.67), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "RightCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_17"}}
Add_MPCD_Element(EHSD_Label)

--

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_rng2_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.50), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_18"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_rng2"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.50), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "LeftCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_18"}}
Add_MPCD_Element(EHSD_Label)

--

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_tof_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.90), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "RightCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_19"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_jdam_tof"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.90), PosY(-0.74), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "RightCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_19"}}
Add_MPCD_Element(EHSD_Label)

--

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_v_error_ol"
		EHSD_Label.material			= stroke_font_outline
		EHSD_Label.init_pos			= {PosX(0.70), PosY(-0.81), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_20"}}
Add_MPCD_Element(EHSD_Label)

local	EHSD_Label					= CreateElement "ceStringSLine"
		EHSD_Label.name				= "ehsd_gps_v_error"
		EHSD_Label.material			= stroke_font
		EHSD_Label.init_pos			= {PosX(0.70), PosY(-0.81), 0}
		EHSD_Label.formats			= {"%s"}
		EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		EHSD_Label.alignment		= "CenterCenter"
		EHSD_Label.controllers		= {{"EHSD_Data_Block_20"}}
Add_MPCD_Element(EHSD_Label)

-- JDAM Symbology (only first 4 are shown)
for i = 1, 4 do
	-- JDAM Pos
	local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
			EHSD_Symbol_Pos.name			= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol_Pos.parent_element	= "MPCD_center"
			EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
			EHSD_Symbol_Pos.controllers		= {{"JDAM_Target_Pos", i - 1, EHSD_Scale}}
	Add_MPCD_Element(EHSD_Symbol_Pos)
	
	local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
			EHSD_Symbol_Pos.name			= "JDAM_LAR_T" .. string.format("%02d", i)
			EHSD_Symbol_Pos.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
			EHSD_Symbol_Pos.controllers		= {{"JDAM_LARS_Min", i - 1, EHSD_Scale}}
	Add_MPCD_Element(EHSD_Symbol_Pos)
	
	--
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_ICON_OL_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material_outl
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_Icon"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_Mode", i - 1}}
	AddMPCDStrokeSymbol(EHSD_Symbol, true, false)
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_ICON_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_Icon"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_Mode", i - 1}}
	AddMPCDStrokeSymbol(EHSD_Symbol)
	
	--
	
	local	EHSD_Label					= CreateElement "ceStringSLine"
			EHSD_Label.name				= "JDAM_tgt_idx_ol_" .. string.format("%02d", i)
			EHSD_Label.material			= stroke_font_outline
			EHSD_Label.init_pos			= {0.0, PosY(0.07), 0}
			EHSD_Label.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Label.formats			= {"%d"}
			EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
			EHSD_Label.alignment		= "CenterCenter"
			EHSD_Label.controllers		= {{"JDAM_Target_Index", i - 1}}
	Add_MPCD_Element(EHSD_Label)

	local	EHSD_Label					= CreateElement "ceStringSLine"
			EHSD_Label.name				= "JDAM_tgt_idx_" .. string.format("%02d", i)
			EHSD_Label.material			= stroke_font
			EHSD_Label.init_pos			= {0.0, PosY(0.07), 0}
			EHSD_Label.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Label.formats			= {"%d"}
			EHSD_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
			EHSD_Label.alignment		= "CenterCenter"
			EHSD_Label.controllers		= {{"JDAM_Target_Index", i - 1}}
	Add_MPCD_Element(EHSD_Label)

	-- LAR REPRESENTATION
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_LARMIN_OL_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material_outl
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_LAR"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_LARS_Min", i - 1, EHSD_Scale}}
	AddMPCDStrokeSymbol(EHSD_Symbol, true, false)
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_LARMAX_OL_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material_outl
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_LAR"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_LARS_Max", i - 1, EHSD_Scale}}
	AddMPCDStrokeSymbol(EHSD_Symbol, true, false)
	
	local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "JDAM_LARLN_OL_T" .. string.format("%02d", i)
			EHSD_Symbol_Line.material		= stroke_material_outl
			EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol_Line.controllers	= {{"JDAM_LARS_LN", i - 1, EHSD_Scale}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	--
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_LARMIN_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_LAR"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_LARS_Min", i - 1, EHSD_Scale}, {"JDAM_LARS_Mode"}}
	AddMPCDStrokeSymbol(EHSD_Symbol)
	
	local	EHSD_Symbol					= CreateElement "ceSMultiLine"
			EHSD_Symbol.name			= "JDAM_LARMAX_T" .. string.format("%02d", i)
			EHSD_Symbol.material		= stroke_material
			EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
			EHSD_Symbol.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "JDAM_LAR"}
			EHSD_Symbol.scale			= MPCD_STRK_SCALE
			EHSD_Symbol.controllers		= {{"JDAM_LARS_Max", i - 1, EHSD_Scale}, {"JDAM_LARS_Mode"}}
	AddMPCDStrokeSymbol(EHSD_Symbol)
	
	local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "JDAM_LARLN_T" .. string.format("%02d", i)
			EHSD_Symbol_Line.material   	= stroke_material
			EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element	= "JDAM_T" .. string.format("%02d", i)
			EHSD_Symbol_Line.controllers    = {{"JDAM_LARS_LN", i - 1, EHSD_Scale}, {"JDAM_LARS_Mode"}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
end