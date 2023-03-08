----------------------------
-- TPOD DATA DISPLAY PAGE
----------------------------

local	MPCD_Line_Thickness			= stroke_thickness * 2.5

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "TPOD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"TPOD_is_Operational"}}
Add_MPCD_Element(MPCD_center)

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "TPOD_TGT_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.parent_element	= "TPOD_center"
		MPCD_center.controllers		= {{"tpod_has_tgt"}}
Add_MPCD_Element(MPCD_center)

----------------------------
-- SYMBOLS & ICONS
----------------------------
local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_compass_N"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {PosX(-0.49),  PosY(0.30), 0}
		TPOD_Symbol.parent_element	= "TPOD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_compass_N"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_compass_rose"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_CompassRose				= CreateElement "ceSimpleLineObject"
		TPOD_CompassRose.name			= "TPOD_CompassRose_NS"
		TPOD_CompassRose.material  	 	= stroke_material
		TPOD_CompassRose.width			= MPCD_Line_Thickness
		TPOD_CompassRose.init_pos		= {0, 0, 0}
		TPOD_CompassRose.parent_element	= "tpod_compass_N"
		TPOD_CompassRose.controllers	= {{"tpod_compass_rose_NS_line"}}
Add_MPCD_Element(TPOD_CompassRose)

local	TPOD_CompassRose				= CreateElement "ceSimpleLineObject"
		TPOD_CompassRose.name			= "TPOD_CompassRose_WE"
		TPOD_CompassRose.material  	 	= stroke_material
		TPOD_CompassRose.width			= MPCD_Line_Thickness
		TPOD_CompassRose.init_pos		= {0, 0, 0}
		TPOD_CompassRose.parent_element	= "tpod_compass_N"
		TPOD_CompassRose.controllers	= {{"tpod_compass_rose_WE_line"}}
Add_MPCD_Element(TPOD_CompassRose)

local	TPOD_CompassRose				= CreateElement "ceSMultiLine"
		TPOD_CompassRose.name			= "TPOD_CompassRose_Arrow"
		TPOD_CompassRose.material		= stroke_material
		TPOD_CompassRose.init_pos		= {0, 0, 0}
		TPOD_CompassRose.parent_element	= "TPOD_CompassRose_NS"
		TPOD_CompassRose.points_set		= {"MPCD_stroke_symbols", "CompassRose_Arrow"}
		TPOD_CompassRose.scale			= MPCD_STRK_SCALE
		TPOD_CompassRose.controllers	= {{"tpod_compass_arrow_pos"}}
AddMPCDStrokeSymbol(TPOD_CompassRose)

local	TPOD_2DY_Symbol					= CreateElement "ceSimpleLineObject"
		TPOD_2DY_Symbol.name			= "TPOD_Yardstick"
		TPOD_2DY_Symbol.material  	 	= stroke_material
		TPOD_2DY_Symbol.width			= MPCD_Line_Thickness
		TPOD_2DY_Symbol.init_pos		= {0, 0, 0}
		TPOD_2DY_Symbol.parent_element	= "TPOD_center"
		TPOD_2DY_Symbol.controllers		= {{"tpod_2dy_ellipse"}}
Add_MPCD_Element(TPOD_2DY_Symbol)

----------------------------
-- TEXT DATA
----------------------------
local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_sensor_mode"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(-0.36), PosY(0.75), 0}
		TPOD_TEXT.formats		= {"%s"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment		= "LeftCenter"
		TPOD_TEXT.controllers	= {{"tpod_hotas_mode"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_lsr_code"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(-0.18), PosY(0.75), 0}
		TPOD_TEXT.formats		= {"%04d"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment		= "LeftCenter"
		TPOD_TEXT.controllers	= {{"tpod_lsr_code"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_aqi_range"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {PosX(-0.93), PosY(-0.80), 0}
		TPOD_TEXT.formats		= {"%1.f"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment		= "LeftCenter"
		TPOD_TEXT.controllers	= {{"tpod_aqi_rng"}}
Add_MPCD_Element(TPOD_TEXT)

-- DESIGNATION DATA
local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_desg_source"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.40), PosY(-0.45), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_desg_source"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_oprtl_mode"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.40), PosY(-0.55), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_oper_state"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_2DY_Radius"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(-0.35), PosY(0.06), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_2dy_radius"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_CH_size"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.35), PosY(0.06), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"%1.fM"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_CH_size"}}
Add_MPCD_Element(TPOD_TEXT)

-- TARGET DATA
local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_mgrs"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.30), PosY(0.65), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_mgrs"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_lat"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.40), PosY(0.75), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%s%3d %02d.%03d"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_lat"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_lon"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.40), PosY(0.65), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%s%03d %02d.%03d"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_lon"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_hgt"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.40), PosY(0.55), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"ELV %6dF"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_hgt"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_rng_brg"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(-0.65), PosY(-0.75), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%03d / %1.1f"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "CenterCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_brg_rng"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_tgt_os_rng_brg"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.65), PosY(-0.75), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%03d / %1.1f"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "CenterCenter"
		TPOD_TEXT.controllers		= {{"tpod_tgt_obrg_orng"}}
Add_MPCD_Element(TPOD_TEXT)

-- AIRCRAFT DATA
local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_ac_TAS"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(-0.65), PosY(-0.65), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"T%3d"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "LeftCenter"
		TPOD_TEXT.controllers		= {{"tpod_ac_TAS"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_ac_BALT"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.80), PosY(-0.65), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.formats			= {"%1.f"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "CenterCenter"
		TPOD_TEXT.controllers		= {{"tpod_ac_BALT"}}
Add_MPCD_Element(TPOD_TEXT)

-- TPOD MESSAGES
local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_lsr_fire_mode"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.30), PosY(-0.45), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_lsr_fmode"}, {"tpod_lsr_mstatus"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_lsr_lss_msg"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(-0.10), PosY(-0.45), 0}
		TPOD_TEXT.parent_element	= "TPOD_TGT_center"
		TPOD_TEXT.formats			= {"%s"}
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_trk_mode"}}
Add_MPCD_Element(TPOD_TEXT)

-- AGM65E2 MESSAGES
local	TPOD_TEXT					= CreateElement "ceStringSLine"
		TPOD_TEXT.name				= "tpod_agm65e2_inrng"
		TPOD_TEXT.material			= stroke_font
		TPOD_TEXT.init_pos			= {PosX(0.85), PosY( 0.30), 0}
		TPOD_TEXT.parent_element	= "TPOD_center"
		TPOD_TEXT.value				= "IN RNG"
		TPOD_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		TPOD_TEXT.alignment			= "RightCenter"
		TPOD_TEXT.controllers		= {{"tpod_agm65e2_inrng"}}
Add_MPCD_Element(TPOD_TEXT)

