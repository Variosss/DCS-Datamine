---------------------
-- EHSD Page       --
-- Alignment Datra --
---------------------
-- Symbols Centers
local	ALIGN_center				= CreateElement "ceSimple"
		ALIGN_center.name			= "ALIGN_center"
		ALIGN_center.init_pos		= {0, 0, 0}
		ALIGN_center.controllers	= {{"EHSD_ALIGN_Mode"}}
Add_MPCD_Element(ALIGN_center)

-- Aircraft Position
local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "AC_latitude_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {0.0, PosY(0.35), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.formats			= {"%s"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "CenterCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_AC_LAT"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "AC_latitude"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {0.0, PosY(0.35), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.formats				= {"%s"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "CenterCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_AC_LAT"}}
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "AC_longitude_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {0.0, PosY(0.27), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.formats			= {"%s"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "CenterCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_AC_LON"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "AC_longitude"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {0.0, PosY(0.27), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.formats				= {"%s"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "CenterCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_AC_LON"}}
Add_MPCD_Element(EHSD_ALGN_Data)

-- Carrier Alignment Data
local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "CV_HDG_Label_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(-0.325), PosY(0.05), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.value				= "CV HDG:"
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "LeftCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_MODE_SEA_MANUAL"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "CV_HDG_Label"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(-0.325), PosY(0.05), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.value				= "CV HDG:"
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "LeftCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_MODE_SEA_MANUAL"}}
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "CV_HDG_Value_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(0.40), 0.0, 0}
		EHSD_ALGN_Data_OL.parent_element	= "CV_HDG_Label_OL"
		EHSD_ALGN_Data_OL.formats			= {"%03d;"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "RightCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_CV_HDG"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "CV_HDG_Value"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(0.40), 0.0, 0}
		EHSD_ALGN_Data.parent_element		= "CV_HDG_Label"
		EHSD_ALGN_Data.formats				= {"%03d;"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "RightCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_CV_HDG"}}
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "CV_SPD_Label_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(-0.325), PosY(-0.05), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.value				= "CV SPD:"
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "LeftCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_MODE_SEA_MANUAL"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "CV_SPD_Label"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(-0.325), PosY(-0.05), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.value				= "CV SPD:"
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "LeftCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_MODE_SEA_MANUAL"}}
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "CV_SPD_Value_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(0.40), 0.0, 0}
		EHSD_ALGN_Data_OL.parent_element	= "CV_HDG_Label_OL"
		EHSD_ALGN_Data_OL.formats			= {"%02d KTS"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "RightCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_CV_SPD"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "CV_SPD_Value"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(0.40), 0.0, 0}
		EHSD_ALGN_Data.parent_element		= "CV_HDG_Label"
		EHSD_ALGN_Data.formats				= {"%02d KTS"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "RightCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_CV_SPD"}}
Add_MPCD_Element(EHSD_ALGN_Data)

-- ALIGNMENT QUALITY
local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "QUAL_NMB_Label_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(-0.325), PosY(-0.25), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.value				= "QUAL:"
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "LeftCenter"
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "QUAL_NMB_Label"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(-0.325), PosY(-0.25), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.value				= "QUAL:"
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "LeftCenter"
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "QUAL_NMB_Value_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(0.20), PosY(-0.25), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.formats			= {"%1.1f"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "RightCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_QUAL_VAL"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "QUAL_NMB_Value"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(0.20), PosY(-0.25), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.formats				= {"%1.1f"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "RightCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_QUAL_VAL"}}
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "QUAL_NMB_Mesage_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(0.45), PosY(-0.25), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.formats			= {"%s"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "RightCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_QUAL_MSG"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "QUAL_NMB_Mesage"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(0.45), PosY(-0.25), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.formats				= {"%s"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "RightCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_QUAL_MSG"}}
Add_MPCD_Element(EHSD_ALGN_Data)

-- ALignment Elpased Time
local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "ALIGN_ETIME_Label_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(-0.325), PosY(-0.35), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.value				= "TIME:"
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "LeftCenter"
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "ALIGN_ETIME_Label"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(-0.325), PosY(-0.35), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.value				= "TIME:"
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "LeftCenter"
Add_MPCD_Element(EHSD_ALGN_Data)

--

local	EHSD_ALGN_Data_OL					= CreateElement "ceStringSLine"
		EHSD_ALGN_Data_OL.name				= "ALIGN_ETIME_Value_OL"
		EHSD_ALGN_Data_OL.material			= stroke_font_outline
		EHSD_ALGN_Data_OL.init_pos			= {PosX(0.25), PosY(-0.35), 0}
		EHSD_ALGN_Data_OL.parent_element	= "ALIGN_center"
		EHSD_ALGN_Data_OL.formats			= {"%02d:%02d"}
		EHSD_ALGN_Data_OL.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data_OL.alignment			= "RightCenter"
		EHSD_ALGN_Data_OL.controllers		= {{"EHSD_INS_ALIGN_ELAPSED_TIME"}}
Add_MPCD_Element(EHSD_ALGN_Data_OL)

local	EHSD_ALGN_Data						= CreateElement "ceStringSLine"
		EHSD_ALGN_Data.name					= "ALIGN_ETIME_Value"
		EHSD_ALGN_Data.material				= stroke_font
		EHSD_ALGN_Data.init_pos				= {PosX(0.25), PosY(-0.35), 0}
		EHSD_ALGN_Data.parent_element		= "ALIGN_center"
		EHSD_ALGN_Data.formats				= {"%02d:%02d"}
		EHSD_ALGN_Data.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_ALGN_Data.alignment			= "RightCenter"
		EHSD_ALGN_Data.controllers			= {{"EHSD_INS_ALIGN_ELAPSED_TIME"}}
Add_MPCD_Element(EHSD_ALGN_Data)
