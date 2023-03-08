--------------------------------------------------
-- WEAPONS PROGRAMING
--------------------------------------------------

-- Region Centers
local	WPN_PRG_Line				= CreateElement "ceSimple"
		WPN_PRG_Line.name			= "PRG_Line_1"
		WPN_PRG_Line.init_pos		= {0, PosY(-0.50), 0}
Add_MPCD_Element(WPN_PRG_Line)

local	WPN_PRG_Line				= CreateElement "ceSimple"
		WPN_PRG_Line.name			= "PRG_Line_2"
		WPN_PRG_Line.init_pos		= {0, PosY(-0.07), 0}
		WPN_PRG_Line.parent_element	= "PRG_Line_1"
Add_MPCD_Element(WPN_PRG_Line)

local	WPN_PRG_Line				= CreateElement "ceSimple"
		WPN_PRG_Line.name			= "PRG_Line_3"
		WPN_PRG_Line.init_pos		= {0, PosY(-0.14), 0}
		WPN_PRG_Line.parent_element	= "PRG_Line_1"
Add_MPCD_Element(WPN_PRG_Line)

local	WPN_PRG_Line				= CreateElement "ceSimple"
		WPN_PRG_Line.name			= "PRG_Line_4"
		WPN_PRG_Line.init_pos		= {0, PosY(-0.21), 0}
		WPN_PRG_Line.parent_element	= "PRG_Line_1"
Add_MPCD_Element(WPN_PRG_Line)

local	WPN_PRG_Line				= CreateElement "ceSimple"
		WPN_PRG_Line.name			= "PRG_Line_5"
		WPN_PRG_Line.init_pos		= {0, PosY(-0.28), 0}
		WPN_PRG_Line.parent_element	= "PRG_Line_1"
Add_MPCD_Element(WPN_PRG_Line)

-- All Weapons
local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln1_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_1"
		STRS_WPN_Prog.value				= "MODE"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_active"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln1_col_2"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.20), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_1"
		STRS_WPN_Prog.formats			= {"%s"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_active"}, {"acp_armt_mode"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln2_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_2"
		STRS_WPN_Prog.value				= "FUZE"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_fuze"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln2_col_2"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.20), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_2"
		STRS_WPN_Prog.formats			= {"%s"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_fuze"}, {"acp_armt_fuze"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln3_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_3"
		STRS_WPN_Prog.value				= "TGT ELEV"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_elev"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln3_col_2"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.20), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_3"
		STRS_WPN_Prog.formats			= {"%1.f"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_elev"}, {"acp_tgt_elev"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln4_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_4"
		STRS_WPN_Prog.value				= "ANGLE"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"STRS_LOFT_selection"}}
Add_MPCD_Element(STRS_WPN_Prog)

--

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln1_col_3"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.15), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_1"
		STRS_WPN_Prog.value				= "QTY"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_qty"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln1_col_4"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_1"
		STRS_WPN_Prog.formats			= {"%d"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "RightCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_qty"}, {"acp_rel_qty"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln2_col_3"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.15), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_2"
		STRS_WPN_Prog.value				= "MULT"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_mult"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln2_col_4"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_2"
		STRS_WPN_Prog.formats			= {"%d"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "RightCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_mult"}, {"acp_mult_qty"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln3_col_3"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.15), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_3"
		STRS_WPN_Prog.value				= "INT"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_intvl"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "wpn_prog_ln3_col_4"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_3"
		STRS_WPN_Prog.formats			= {"%d"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "RightCenter"
		STRS_WPN_Prog.controllers		= {{"acp_has_intvl"}, {"acp_rel_intvl"}}
Add_MPCD_Element(STRS_WPN_Prog)

-- GUN && ROCKETS
local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "gun_prog_ln4_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_4"
		STRS_WPN_Prog.value				= "MAX"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"wpn_is_gun_rkt"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "gun_prog_ln4_col_2"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.20), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_4"
		STRS_WPN_Prog.formats			= {"%1.f"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"wpn_is_gun_rkt"}, {"acp_gr_max_rng"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "gun_prog_ln5_col_1"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.60), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_5"
		STRS_WPN_Prog.value				= "MIN"
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"wpn_is_gun_rkt"}}
Add_MPCD_Element(STRS_WPN_Prog)

local	STRS_WPN_Prog					= CreateElement "ceStringSLine"
		STRS_WPN_Prog.name				= "gun_prog_ln5_col_2"
		STRS_WPN_Prog.material			= stroke_font
		STRS_WPN_Prog.init_pos			= {PosX(-0.20), 0.0, 0}
		STRS_WPN_Prog.parent_element	= "PRG_Line_5"
		STRS_WPN_Prog.formats			= {"%1.f"}
		STRS_WPN_Prog.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		STRS_WPN_Prog.alignment			= "LeftCenter"
		STRS_WPN_Prog.controllers		= {{"wpn_is_gun_rkt"}, {"acp_gr_min_rng"}}
Add_MPCD_Element(STRS_WPN_Prog)
