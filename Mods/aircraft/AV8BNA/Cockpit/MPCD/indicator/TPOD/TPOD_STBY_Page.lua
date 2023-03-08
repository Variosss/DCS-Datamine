--------------------------------------------------
-- TPOD STANDBY MODE Messages
--------------------------------------------------

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_flir_notrdy"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(0.35), 0}
		TPOD_TEXT.value			= "F-NOTRDY"
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"FLIR_not_ready"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_sw_version"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(0.2), 0}
		TPOD_TEXT.formats		= {"SW VER %04d"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"TPOD_Standby_Msg"}, {"TPOD_STBY_SW_VER"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_sw_version"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(0.1), 0}
		TPOD_TEXT.formats		= {"MARK VER %03d"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"TPOD_Standby_Msg"}, {"TPOD_STBY_MKS_VER"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_lsr_version"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(0.0), 0}
		TPOD_TEXT.formats		= {"LSR VER %03d"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"TPOD_Standby_Msg"}, {"TPOD_STBY_LSR_VER"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_lsr_version"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(-0.1), 0}
		TPOD_TEXT.formats		= {"SW CHSUM %s"}
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"TPOD_Standby_Msg"}, {"TPOD_STBY_CHKSUM"}}
Add_MPCD_Element(TPOD_TEXT)

local	TPOD_TEXT				= CreateElement "ceStringSLine"
		TPOD_TEXT.name			= "tpod_ac_type"
		TPOD_TEXT.material		= stroke_font
		TPOD_TEXT.init_pos		= {0.0, PosY(-0.2), 0}
		TPOD_TEXT.value			= "AC TYPE NA"
		TPOD_TEXT.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		TPOD_TEXT.alignment		= "CenterCenter"
		TPOD_TEXT.controllers	= {{"TPOD_Standby_Msg"}}
Add_MPCD_Element(TPOD_TEXT)
