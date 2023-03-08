---------------
-- CONF      --
-- Page 3    --
---------------
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- Vars
local module_name = {}

module_name[1] = {}
module_name[1][1]	= "RAD 1"
module_name[1][2]	= "091-1567-002"

module_name[2] = {}
module_name[2][1]	= "RAD 2"
module_name[2][2]	= "091-1567-002"

module_name[3] = {}
module_name[3][1]	= "CNIDC"
module_name[3][2]	= "H"

module_name[4] = {}
module_name[4][1]	= "ATHS"
module_name[4][2]	= "0911411002"

-- MENU RIGHT
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CONF_PB12"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_12_pos
		BTN_Label.value				= "C\nO\nN\nF\n1"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"mm_tpod"}}
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CONF_PB13"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_13_pos
		BTN_Label.value				= "C\nO\nN\nF\n2"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CONF_PB15"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_15_pos
		BTN_Label.value				="E\nW"
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
Add_MPCD_Element(BTN_Label)

-- MENU BOTTOM
local	BTN_Label					= CreateElement "ceStringSLine"
		BTN_Label.name				= "CONF_PB18"
		BTN_Label.material			= stroke_font
		BTN_Label.init_pos			= mpcd_btn_18_pos
		BTN_Label.formats			= {"%s"}
		BTN_Label.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		BTN_Label.alignment			= "CenterCenter"
		BTN_Label.controllers		= {{"EHSD_PB18_Mode"}}
Add_MPCD_Element(BTN_Label)

-- Display
local	conf_page_title				= CreateElement "ceStringSLine"
		conf_page_title.name		= "conf_page_title"
		conf_page_title.material	= stroke_font
		conf_page_title.init_pos	= {0.0, PosY(0.8), 0.0}
		conf_page_title.value		= "SOFTWARE CONFIGURATION PAGE 3"
		conf_page_title.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		conf_page_title.alignment	= "CenterCenter"
Add_MPCD_Element(conf_page_title)

local dRow = 0.65

for i = 1, 4 do
	dRow = dRow - 0.10
	
	local	device_col_1				= CreateElement "ceStringSLine"
			device_col_1.name			= "device_col_1" .. string.format("%02d", i)
			device_col_1.material		= stroke_font
			device_col_1.init_pos		= {PosX(-0.7), PosY(dRow), 0.0}
			device_col_1.value			= module_name[i][1]
			device_col_1.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
			device_col_1.alignment		= "LeftCenter"
	Add_MPCD_Element(device_col_1)
	
	local	device_col_2				= CreateElement "ceStringSLine"
			device_col_2.name			= "device_col_2" .. string.format("%02d", i)
			device_col_2.material		= stroke_font
			device_col_2.init_pos		= {0.0, PosY(dRow), 0.0}
			device_col_2.value			= module_name[i][2]
			device_col_2.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
			device_col_2.alignment		= "LeftCenter"
	Add_MPCD_Element(device_col_2)
	
end