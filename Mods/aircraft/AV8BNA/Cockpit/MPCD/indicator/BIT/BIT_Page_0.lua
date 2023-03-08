dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Menu Options
local	mpcd_mm_btn_01				= CreateElement "ceStringSLine"
		mpcd_mm_btn_01.name			= "mpcd_mm_btn_01"
		mpcd_mm_btn_01.material		= stroke_font
		mpcd_mm_btn_01.init_pos		= mpcd_btn_01_pos
		mpcd_mm_btn_01.alignment	= "CenterCenter"
		mpcd_mm_btn_01.value		= "F\nL\nI\nR"
		mpcd_mm_btn_01.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_01)

local	mpcd_mm_btn_03				= CreateElement "ceStringSLine"
		mpcd_mm_btn_03.name			= "mpcd_mm_btn_03"
		mpcd_mm_btn_03.material		= stroke_font
		mpcd_mm_btn_03.init_pos		= mpcd_btn_03_pos
		mpcd_mm_btn_03.alignment	= "CenterCenter"
		mpcd_mm_btn_03.value		= "D\nM\nT"
		mpcd_mm_btn_03.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_03)

local	mpcd_mm_btn_04				= CreateElement "ceStringSLine"
		mpcd_mm_btn_04.name			= "mpcd_mm_btn_04"
		mpcd_mm_btn_04.material		= stroke_font
		mpcd_mm_btn_04.init_pos		= mpcd_btn_04_pos
		mpcd_mm_btn_04.alignment	= "CenterCenter"
		mpcd_mm_btn_04.value		= "S\nM\nS"
		mpcd_mm_btn_04.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_04.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_04)

local	mpcd_mm_btn_05				= CreateElement "ceStringSLine"
		mpcd_mm_btn_05.name			= "mpcd_mm_btn_05"
		mpcd_mm_btn_05.material		= stroke_font
		mpcd_mm_btn_05.init_pos		= mpcd_btn_05_pos
		mpcd_mm_btn_05.alignment	= "CenterCenter"
		mpcd_mm_btn_05.value		= "M\nS\nC"
		mpcd_mm_btn_05.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_05.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_05)

local	mpcd_mm_btn_06				= CreateElement "ceStringSLine"
		mpcd_mm_btn_06.name			= "mpcd_mm_btn_06"
		mpcd_mm_btn_06.material		= stroke_font
		mpcd_mm_btn_06.init_pos		= mpcd_btn_06_pos
		mpcd_mm_btn_06.alignment	= "CenterCenter"
		mpcd_mm_btn_06.value		= "AUTO"
		mpcd_mm_btn_06.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_06.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_06)

local	mpcd_mm_btn_07				= CreateElement "ceStringSLine"
		mpcd_mm_btn_07.name			= "mpcd_mm_btn_07"
		mpcd_mm_btn_07.material		= stroke_font
		mpcd_mm_btn_07.init_pos		= mpcd_btn_07_pos
		mpcd_mm_btn_07.alignment	= "CenterCenter"
		mpcd_mm_btn_07.value		= "MAINT"
		mpcd_mm_btn_07.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_07.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_07)

local	mpcd_mm_btn_08				= CreateElement "ceStringSLine"
		mpcd_mm_btn_08.name			= "mpcd_mm_btn_08"
		mpcd_mm_btn_08.material		= stroke_font
		mpcd_mm_btn_08.init_pos		= mpcd_btn_08_pos
		mpcd_mm_btn_08.alignment	= "CenterCenter"
		mpcd_mm_btn_08.value		= "MI"
		mpcd_mm_btn_08.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_08)

local	mpcd_mm_btn_09				= CreateElement "ceStringSLine"
		mpcd_mm_btn_09.name			= "mpcd_mm_btn_09"
		mpcd_mm_btn_09.material		= stroke_font
		mpcd_mm_btn_09.init_pos		= mpcd_btn_09_pos
		mpcd_mm_btn_09.alignment	= "CenterCenter"
		mpcd_mm_btn_09.value		= "ATHS"
		mpcd_mm_btn_09.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_09)

local	mpcd_mm_btn_10				= CreateElement "ceStringSLine"
		mpcd_mm_btn_10.name			= "mpcd_mm_btn_10"
		mpcd_mm_btn_10.material		= stroke_font
		mpcd_mm_btn_10.init_pos		= mpcd_btn_10_pos
		mpcd_mm_btn_10.alignment	= "CenterCenter"
		mpcd_mm_btn_10.value		= "STOP"
		mpcd_mm_btn_10.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_10)

local	mpcd_mm_btn_13				= CreateElement "ceStringSLine"
		mpcd_mm_btn_13.name			= "mpcd_mm_btn_13"
		mpcd_mm_btn_13.material		= stroke_font
		mpcd_mm_btn_13.init_pos		= mpcd_btn_13_pos
		mpcd_mm_btn_13.alignment	= "CenterCenter"
		mpcd_mm_btn_13.value		= "C\nM\nD\nS"
		mpcd_mm_btn_13.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_13)

local	mpcd_mm_btn_16				= CreateElement "ceStringSLine"
		mpcd_mm_btn_16.name			= "mpcd_mm_btn_16"
		mpcd_mm_btn_16.material		= stroke_font
		mpcd_mm_btn_16.init_pos		= mpcd_btn_16_pos
		mpcd_mm_btn_16.alignment	= "CenterCenter"
		mpcd_mm_btn_16.value		= "DBST"
		mpcd_mm_btn_16.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_16)

local	mpcd_mm_btn_17				= CreateElement "ceStringSLine"
		mpcd_mm_btn_17.name			= "mpcd_mm_btn_17"
		mpcd_mm_btn_17.material		= stroke_font
		mpcd_mm_btn_17.init_pos		= mpcd_btn_17_pos
		mpcd_mm_btn_17.alignment	= "CenterCenter"
		mpcd_mm_btn_17.value		= "FBST"
		mpcd_mm_btn_17.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_17)

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

local	mpcd_mm_btn_20				= CreateElement "ceStringSLine"
		mpcd_mm_btn_20.name			= "mpcd_mm_btn_20"
		mpcd_mm_btn_20.material		= stroke_font
		mpcd_mm_btn_20.init_pos		= mpcd_btn_20_pos
		mpcd_mm_btn_20.alignment	= "CenterCenter"
		mpcd_mm_btn_20.value		= "BIT2"
		mpcd_mm_btn_20.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_20)

-- DATA
local	device_sms					= CreateElement "ceStringSLine"
		device_sms.name				= "device_sms"
		device_sms.material			= stroke_font
		device_sms.init_pos			= {PosX(-0.70), PosY(0.65), 0.0}
		device_sms.alignment		= "LeftCenter"
		device_sms.value			= "SMS"
		device_sms.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_sms)

local	device_rwr					= CreateElement "ceStringSLine"
		device_rwr.name				= "device_rwr"
		device_rwr.material			= stroke_font
		device_rwr.init_pos			= {PosX(-0.70), PosY(0.55), 0.0}
		device_rwr.alignment		= "LeftCenter"
		device_rwr.value			= "RWR"
		device_rwr.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_rwr)

local	device_flir					= CreateElement "ceStringSLine"
		device_flir.name			= "device_flir"
		device_flir.material		= stroke_font
		device_flir.init_pos		= {PosX(-0.70), PosY(0.45), 0.0}
		device_flir.alignment		= "LeftCenter"
		device_flir.value			= "FLIR"
		device_flir.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_flir)

local	device_dmt					= CreateElement "ceStringSLine"
		device_dmt.name				= "device_dmt"
		device_dmt.material			= stroke_font
		device_dmt.init_pos			= {PosX(-0.70), PosY(0.35), 0.0}
		device_dmt.alignment		= "LeftCenter"
		device_dmt.value			= "DMT"
		device_dmt.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_dmt)

local	device_tacts				= CreateElement "ceStringSLine"
		device_tacts.name			= "device_tacts"
		device_tacts.material		= stroke_font
		device_tacts.init_pos		= {PosX(-0.70), PosY(0.25), 0.0}
		device_tacts.alignment		= "LeftCenter"
		device_tacts.value			= "TACTS"
		device_tacts.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_tacts)

local	device_msc					= CreateElement "ceStringSLine"
		device_msc.name				= "device_msc"
		device_msc.material			= stroke_font
		device_msc.init_pos			= {PosX(-0.70), PosY(0.15), 0.0}
		device_msc.alignment		= "LeftCenter"
		device_msc.value			= "MSC"
		device_msc.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_msc)

local	device_aths					= CreateElement "ceStringSLine"
		device_aths.name			= "device_aths"
		device_aths.material		= stroke_font
		device_aths.init_pos		= {PosX(-0.70), PosY(0.05), 0.0}
		device_aths.alignment		= "LeftCenter"
		device_aths.value			= "ATHS"
		device_aths.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_aths)

local	device_cmds					= CreateElement "ceStringSLine"
		device_cmds.name			= "device_cmds"
		device_cmds.material		= stroke_font
		device_cmds.init_pos		= {PosX(-0.70), PosY(-0.05), 0.0}
		device_cmds.alignment		= "LeftCenter"
		device_cmds.value			= "CMDS"
		device_cmds.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_cmds)

-- Device Status
local dRow = 0.75

for i = 1, 8 do
	dRow = dRow - 0.10
		
	local	device_status				= CreateElement "ceStringSLine"
			device_status.name			= "device_status_" .. string.format("%02d", i)
			device_status.material		= stroke_font
			device_status.init_pos		= {PosX(-0.45), PosY(dRow), 0.0}
			device_status.alignment		= "LeftCenter"
			device_status.formats		= {"%s"}
			device_status.controllers	= {{"BIT1_Device_Status", i}}
			device_status.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_status)
	
	local	device_errcode				= CreateElement "ceStringSLine"
			device_errcode.name			= "device_errcode_" .. string.format("%02d", i)
			device_errcode.material		= stroke_font
			device_errcode.init_pos		= {PosX(-0.30), PosY(dRow), 0.0}
			device_errcode.alignment	= "LeftCenter"
			device_errcode.formats		= {"%s"}
			device_errcode.controllers	= {{"BIT1_Failure_Code", i}}
			device_errcode.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_errcode)
end