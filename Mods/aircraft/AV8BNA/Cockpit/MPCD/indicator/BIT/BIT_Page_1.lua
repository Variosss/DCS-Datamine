dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")

-- Menu Options
local	mpcd_mm_btn_01				= CreateElement "ceStringSLine"
		mpcd_mm_btn_01.name			= "mpcd_mm_btn_01"
		mpcd_mm_btn_01.material		= stroke_font
		mpcd_mm_btn_01.init_pos		= mpcd_btn_01_pos
		mpcd_mm_btn_01.alignment	= "CenterCenter"
		mpcd_mm_btn_01.value		= "D\nS\nS"
		mpcd_mm_btn_01.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_01)

local	mpcd_mm_btn_02				= CreateElement "ceStringSLine"
		mpcd_mm_btn_02.name			= "mpcd_mm_btn_02"
		mpcd_mm_btn_02.material		= stroke_font
		mpcd_mm_btn_02.init_pos		= mpcd_btn_02_pos
		mpcd_mm_btn_02.alignment	= "CenterCenter"
		mpcd_mm_btn_02.value		= "D\nS\nP\nL\nY"
		mpcd_mm_btn_02.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_02)

local	mpcd_mm_btn_03				= CreateElement "ceStringSLine"
		mpcd_mm_btn_03.name			= "mpcd_mm_btn_03"
		mpcd_mm_btn_03.material		= stroke_font
		mpcd_mm_btn_03.init_pos		= mpcd_btn_03_pos
		mpcd_mm_btn_03.alignment	= "CenterCenter"
		mpcd_mm_btn_03.value		= "G\nP\nS"
		mpcd_mm_btn_03.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_03.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_03)

local	mpcd_mm_btn_04				= CreateElement "ceStringSLine"
		mpcd_mm_btn_04.name			= "mpcd_mm_btn_04"
		mpcd_mm_btn_04.material		= stroke_font
		mpcd_mm_btn_04.init_pos		= mpcd_btn_04_pos
		mpcd_mm_btn_04.alignment	= "CenterCenter"
		mpcd_mm_btn_04.value		= "C\nN\nI"
		mpcd_mm_btn_04.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_04)

local	mpcd_mm_btn_05				= CreateElement "ceStringSLine"
		mpcd_mm_btn_05.name			= "mpcd_mm_btn_05"
		mpcd_mm_btn_05.material		= stroke_font
		mpcd_mm_btn_05.init_pos		= mpcd_btn_05_pos
		mpcd_mm_btn_05.alignment	= "CenterCenter"
		mpcd_mm_btn_05.value		= "A\nD\nC"
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

local	mpcd_mm_btn_10				= CreateElement "ceStringSLine"
		mpcd_mm_btn_10.name			= "mpcd_mm_btn_10"
		mpcd_mm_btn_10.material		= stroke_font
		mpcd_mm_btn_10.init_pos		= mpcd_btn_10_pos
		mpcd_mm_btn_10.alignment	= "CenterCenter"
		mpcd_mm_btn_10.value		= "STOP"
		mpcd_mm_btn_10.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_10)

local	mpcd_mm_btn_11				= CreateElement "ceStringSLine"
		mpcd_mm_btn_11.name			= "mpcd_mm_btn_11"
		mpcd_mm_btn_11.material		= stroke_font
		mpcd_mm_btn_11.init_pos		= mpcd_btn_11_pos
		mpcd_mm_btn_11.alignment	= "CenterCenter"
		mpcd_mm_btn_11.value		= "I\nN\nS"
		mpcd_mm_btn_11.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_11.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_11)

local	mpcd_mm_btn_12				= CreateElement "ceStringSLine"
		mpcd_mm_btn_12.name			= "mpcd_mm_btn_12"
		mpcd_mm_btn_12.material		= stroke_font
		mpcd_mm_btn_12.init_pos		= mpcd_btn_12_pos
		mpcd_mm_btn_12.alignment	= "CenterCenter"
		mpcd_mm_btn_12.value		= "S\nA\nA\nH\nS"
		mpcd_mm_btn_12.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_12.controllers	= {{"BIT1_Option"}}
Add_MPCD_Element(mpcd_mm_btn_12)

local	mpcd_mm_btn_13				= CreateElement "ceStringSLine"
		mpcd_mm_btn_13.name			= "mpcd_mm_btn_13"
		mpcd_mm_btn_13.material		= stroke_font
		mpcd_mm_btn_13.init_pos		= mpcd_btn_13_pos
		mpcd_mm_btn_13.alignment	= "CenterCenter"
		mpcd_mm_btn_13.value		= "E\nM\nS"
		mpcd_mm_btn_13.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_13)

local	mpcd_mm_btn_14				= CreateElement "ceStringSLine"
		mpcd_mm_btn_14.name			= "mpcd_mm_btn_14"
		mpcd_mm_btn_14.material		= stroke_font
		mpcd_mm_btn_14.init_pos		= mpcd_btn_14_pos
		mpcd_mm_btn_14.alignment	= "CenterCenter"
		mpcd_mm_btn_14.value		= "V\nI\nD\nE\nO"
		mpcd_mm_btn_14.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_14)

local	mpcd_mm_btn_15				= CreateElement "ceStringSLine"
		mpcd_mm_btn_15.name			= "mpcd_mm_btn_15"
		mpcd_mm_btn_15.material		= stroke_font
		mpcd_mm_btn_15.init_pos		= mpcd_btn_15_pos
		mpcd_mm_btn_15.alignment	= "CenterCenter"
		mpcd_mm_btn_15.value		= "D\nV\nM\nS"
		mpcd_mm_btn_15.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_15)

local	mpcd_mm_btn_18				= CreateElement "ceStringSLine"
		mpcd_mm_btn_18.name			= "mpcd_mm_btn_18"
		mpcd_mm_btn_18.material		= stroke_font
		mpcd_mm_btn_18.init_pos		= mpcd_btn_18_pos
		mpcd_mm_btn_18.alignment	= "CenterCenter"
		mpcd_mm_btn_18.formats		= {"%s"}
		mpcd_mm_btn_18.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
		mpcd_mm_btn_18.controllers	= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(mpcd_mm_btn_18)

local	mpcd_mm_btn_20				= CreateElement "ceStringSLine"
		mpcd_mm_btn_20.name			= "mpcd_mm_btn_20"
		mpcd_mm_btn_20.material		= stroke_font
		mpcd_mm_btn_20.init_pos		= mpcd_btn_20_pos
		mpcd_mm_btn_20.alignment	= "CenterCenter"
		mpcd_mm_btn_20.value		= "BIT1"
		mpcd_mm_btn_20.stringdefs	= stringdefs[STROKE_FNT_DFLT_100]
Add_MPCD_Element(mpcd_mm_btn_20)

-- DATA
local	device_sashs				= CreateElement "ceStringSLine"
		device_sashs.name			= "device_sashs"
		device_sashs.material		= stroke_font
		device_sashs.init_pos		= {PosX(-0.70), PosY(0.65), 0.0}
		device_sashs.alignment		= "LeftCenter"
		device_sashs.value			= "SAAHS"
		device_sashs.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_sashs)

-- COLUMN A
local	device_gps					= CreateElement "ceStringSLine"
		device_gps.name				= "device_gps"
		device_gps.material			= stroke_font
		device_gps.init_pos			= {PosX(-0.70), PosY(0.55), 0.0}
		device_gps.alignment		= "LeftCenter"
		device_gps.value			= "GPS"
		device_gps.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_gps)

local	device_comm_1				= CreateElement "ceStringSLine"
		device_comm_1.name			= "device_comm_1"
		device_comm_1.material		= stroke_font
		device_comm_1.init_pos		= {PosX(-0.70), PosY(0.45), 0.0}
		device_comm_1.alignment		= "LeftCenter"
		device_comm_1.value			= "1 COMM"
		device_comm_1.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_comm_1)

local	device_comm_2				= CreateElement "ceStringSLine"
		device_comm_2.name			= "device_comm_2"
		device_comm_2.material		= stroke_font
		device_comm_2.init_pos		= {PosX(-0.70), PosY(0.35), 0.0}
		device_comm_2.alignment		= "LeftCenter"
		device_comm_2.value			= "2 COMM"
		device_comm_2.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_comm_2)

local	device_dc_pwr				= CreateElement "ceStringSLine"
		device_dc_pwr.name			= "device_dc_pwr"
		device_dc_pwr.material		= stroke_font
		device_dc_pwr.init_pos		= {PosX(-0.70), PosY(0.25), 0.0}
		device_dc_pwr.alignment		= "LeftCenter"
		device_dc_pwr.value			= "DC"
		device_dc_pwr.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_dc_pwr)

local	device_hud					= CreateElement "ceStringSLine"
		device_hud.name				= "device_hud"
		device_hud.material			= stroke_font
		device_hud.init_pos			= {PosX(-0.70), PosY(0.15), 0.0}
		device_hud.alignment		= "LeftCenter"
		device_hud.value			= "HUD"
		device_hud.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_hud)

local	device_mpcd					= CreateElement "ceStringSLine"
		device_mpcd.name			= "device_mpcd"
		device_mpcd.material		= stroke_font
		device_mpcd.init_pos		= {PosX(-0.70), PosY(0.05), 0.0}
		device_mpcd.alignment		= "LeftCenter"
		device_mpcd.value			= "MPCD"
		device_mpcd.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_mpcd)

local	device_ins					= CreateElement "ceStringSLine"
		device_ins.name				= "device_ins"
		device_ins.material			= stroke_font
		device_ins.init_pos			= {PosX(-0.70), PosY(-0.05), 0.0}
		device_ins.alignment		= "LeftCenter"
		device_ins.value			= "INS"
		device_ins.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_ins)

local	device_adc					= CreateElement "ceStringSLine"
		device_adc.name				= "device_adc"
		device_adc.material			= stroke_font
		device_adc.init_pos			= {PosX(-0.70), PosY(-0.15), 0.0}
		device_adc.alignment		= "LeftCenter"
		device_adc.value			= "ADC"
		device_adc.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_adc)

local	device_ems					= CreateElement "ceStringSLine"
		device_ems.name				= "device_ems"
		device_ems.material			= stroke_font
		device_ems.init_pos			= {PosX(-0.70), PosY(-0.25), 0.0}
		device_ems.alignment		= "LeftCenter"
		device_ems.value			= "EMS"
		device_ems.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_ems)

local	device_igv					= CreateElement "ceStringSLine"
		device_igv.name				= "device_igv"
		device_igv.material			= stroke_font
		device_igv.init_pos			= {PosX(-0.70), PosY(-0.35), 0.0}
		device_igv.alignment		= "LeftCenter"
		device_igv.value			= "IGV"
		device_igv.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_igv)

-- COLUMN B
local	device_dvms					= CreateElement "ceStringSLine"
		device_dvms.name			= "device_dvms"
		device_dvms.material		= stroke_font
		device_dvms.init_pos		= {PosX(0.20), PosY(0.55), 0.0}
		device_dvms.alignment		= "LeftCenter"
		device_dvms.value			= "DVMS"
		device_dvms.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_dvms)

local	device_acnip				= CreateElement "ceStringSLine"
		device_acnip.name			= "device_acnip"
		device_acnip.material		= stroke_font
		device_acnip.init_pos		= {PosX(0.20), PosY(0.45), 0.0}
		device_acnip.alignment		= "LeftCenter"
		device_acnip.value			= "ACNIP"
		device_acnip.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_acnip)

local	device_awls					= CreateElement "ceStringSLine"
		device_awls.name			= "device_awls"
		device_awls.material		= stroke_font
		device_awls.init_pos		= {PosX(0.20), PosY(0.35), 0.0}
		device_awls.alignment		= "LeftCenter"
		device_awls.value			= "AWLS"
		device_awls.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_awls)

local	device_bcn					= CreateElement "ceStringSLine"
		device_bcn.name				= "device_bcn"
		device_bcn.material			= stroke_font
		device_bcn.init_pos			= {PosX(0.20), PosY(0.25), 0.0}
		device_bcn.alignment		= "LeftCenter"
		device_bcn.value			= "BCN"
		device_bcn.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_bcn)

local	device_cnidc				= CreateElement "ceStringSLine"
		device_cnidc.name			= "device_cnidc"
		device_cnidc.material		= stroke_font
		device_cnidc.init_pos		= {PosX(0.20), PosY(0.15), 0.0}
		device_cnidc.alignment		= "LeftCenter"
		device_cnidc.value			= "CNIDC"
		device_cnidc.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_cnidc)

local	device_ralt					= CreateElement "ceStringSLine"
		device_ralt.name			= "device_ralt"
		device_ralt.material		= stroke_font
		device_ralt.init_pos		= {PosX(0.20), PosY(0.05), 0.0}
		device_ralt.alignment		= "LeftCenter"
		device_ralt.value			= "RALT"
		device_ralt.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_ralt)

local	device_tcn					= CreateElement "ceStringSLine"
		device_tcn.name				= "device_tcn"
		device_tcn.material			= stroke_font
		device_tcn.init_pos			= {PosX(0.20), PosY(-0.05), 0.0}
		device_tcn.alignment		= "LeftCenter"
		device_tcn.value			= "TCN"
		device_tcn.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_tcn)

local	device_iff					= CreateElement "ceStringSLine"
		device_iff.name				= "device_iff"
		device_iff.material			= stroke_font
		device_iff.init_pos			= {PosX(0.20), PosY(-0.15), 0.0}
		device_iff.alignment		= "LeftCenter"
		device_iff.value			= "IFF"
		device_iff.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_iff)

local	device_dss					= CreateElement "ceStringSLine"
		device_dss.name				= "device_dss"
		device_dss.material			= stroke_font
		device_dss.init_pos			= {PosX(0.20), PosY(-0.25), 0.0}
		device_dss.alignment		= "LeftCenter"
		device_dss.value			= "DSS"
		device_dss.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
Add_MPCD_Element(device_dss)

-- Device Status
local dRow = 0.65

for i = 2, 11 do
	dRow = dRow - 0.10
	
	local	device_status				= CreateElement "ceStringSLine"
			device_status.name			= "device_status_" .. string.format("%02d", i)
			device_status.material		= stroke_font
			device_status.init_pos		= {PosX(-0.45), PosY(dRow), 0.0}
			device_status.alignment		= "LeftCenter"
			device_status.formats		= {"%s"}
			device_status.controllers	= {{"BIT2_Device_Status", i}}
			device_status.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_status)
	
	local	device_errcode				= CreateElement "ceStringSLine"
			device_errcode.name			= "device_errcode_" .. string.format("%02d", i)
			device_errcode.material		= stroke_font
			device_errcode.init_pos		= {PosX(-0.30), PosY(dRow), 0.0}
			device_errcode.alignment	= "LeftCenter"
			device_errcode.formats		= {"%s"}
			device_errcode.controllers	= {{"BIT2_Failure_Code", i}}
			device_errcode.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_errcode)
	
end

local dRow = 0.65

for i = 12, 20 do
	dRow = dRow - 0.10
	
	local	device_status				= CreateElement "ceStringSLine"
			device_status.name			= "device_status_" .. string.format("%02d", i)
			device_status.material		= stroke_font
			device_status.init_pos		= {PosX(0.45), PosY(dRow), 0.0}
			device_status.alignment		= "LeftCenter"
			device_status.formats		= {"%s"}
			device_status.controllers	= {{"BIT2_Device_Status", i}}
			device_status.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_status)
	
	local	device_errcode				= CreateElement "ceStringSLine"
			device_errcode.name			= "device_errcode_" .. string.format("%02d", i)
			device_errcode.material		= stroke_font
			device_errcode.init_pos		= {PosX(0.60), PosY(dRow), 0.0}
			device_errcode.alignment	= "LeftCenter"
			device_errcode.formats		= {"%s"}
			device_errcode.controllers	= {{"BIT2_Failure_Code", i}}
			device_errcode.stringdefs	= stringdefs[STROKE_FNT_DFLT_120]
	Add_MPCD_Element(device_errcode)
	
end

