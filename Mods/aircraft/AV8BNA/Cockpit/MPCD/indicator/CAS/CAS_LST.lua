--------------------------------------------------
-- CAS Page: Briefing list display
--------------------------------------------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/CAS/CAS_LST_MENU.lua")


-- DISPLAY
local Col_00 = PosX(-0.90)
local Col_01 = PosX(-0.85)
local Col_02 = PosX(-0.75)
local Col_03 = PosX(-0.60)
local Col_04 = PosX(-0.20)
local Col_05 = PosX(0.40)
local Col_06 = PosX(0.75)

local Row_01 = 0.7

--------------------------------------------------
-- Table Header
--------------------------------------------------
local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "label_req_ident"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_03,  PosY(Row_01), 0}
		CAS_TEXT.value			= "REQ#"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "label_req_position"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_04,  PosY(Row_01), 0}
		CAS_TEXT.value			= "UTM"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

local	CAS_TEXT				= CreateElement "ceStringSLine"
		CAS_TEXT.name			= "label_req_time"
		CAS_TEXT.material		= stroke_font
		CAS_TEXT.init_pos		= {Col_05,  PosY(Row_01), 0}
		CAS_TEXT.value			= "TIME"
		CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
		CAS_TEXT.alignment		= "LeftCenter"
Add_MPCD_Element(CAS_TEXT)

--------------------------------------------------
-- Table Rows
--------------------------------------------------
Row_01 = Row_01 - 0.08

for i = 1, 18 do
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_slct" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_00,  PosY(Row_01), 0}
			CAS_TEXT.value			= "*"
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
			CAS_TEXT.controllers	= {{"CAS_BRIEF_Selected", i - 1}}
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_ident" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_01,  PosY(Row_01), 0}
			CAS_TEXT.value			= string.format("%d", i)
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_cas" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_02,  PosY(Row_01), 0}
			CAS_TEXT.value			= "CAS"
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_name" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_03,  PosY(Row_01), 0}
			CAS_TEXT.formats		= {"%d"}
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
			CAS_TEXT.controllers	= {{"CAS_BRIEF_Req_Ident", i - 1}}
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_MGRS" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_04,  PosY(Row_01), 0}
			CAS_TEXT.formats		= {"%s %s %d%d"}
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
			CAS_TEXT.controllers	= {{"CAS_BRIEF_Req_MGRS", i - 1}}
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_req_time" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_05,  PosY(Row_01), 0}
			CAS_TEXT.formats		= {"%02d:%02d:%02d.%d"}
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
			CAS_TEXT.controllers	= {{"CAS_BRIEF_Req_Time", i - 1}}
	Add_MPCD_Element(CAS_TEXT)
	
	local	CAS_TEXT				= CreateElement "ceStringSLine"
			CAS_TEXT.name			= "rcrd_tgt_nmbr" .. string.format("%02d", i)
			CAS_TEXT.material		= stroke_font
			CAS_TEXT.init_pos		= {Col_06,  PosY(Row_01), 0}
			CAS_TEXT.formats		= {"%s"}
			CAS_TEXT.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
			CAS_TEXT.alignment		= "LeftCenter"
			CAS_TEXT.controllers	= {{"CAS_BRIEF_TGT_Number", i - 1}}
	Add_MPCD_Element(CAS_TEXT)
	
	Row_01 = Row_01 - 0.08
end
