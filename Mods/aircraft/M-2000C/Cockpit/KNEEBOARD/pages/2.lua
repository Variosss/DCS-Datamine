dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/notepad.dds")

-- GENERAL SCALE
local general_font_scale = 1.0

FontSizeX1	= 0.0075 * general_font_scale
FontSizeY1	= FontSizeX1

predefined_font_20 = {general_font_scale* FontSizeY1*2.0, general_font_scale* FontSizeX1*2.0, 0.0, 0.0}
predefined_font_10 = {general_font_scale* FontSizeY1, 	  general_font_scale* FontSizeX1	, 0.0, 0.0}
predefined_font_09 = {general_font_scale* FontSizeY1*0.9, general_font_scale* FontSizeX1*0.9, 0.0, 0.0}
predefined_font_08 = {general_font_scale* FontSizeY1*0.8, general_font_scale* FontSizeX1*0.8, 0.0, 0.0}
predefined_font_07 = {general_font_scale* FontSizeY1*0.7, general_font_scale* FontSizeX1*0.7, 0.0, 0.0}
predefined_font_06 = {general_font_scale* FontSizeY1*0.6, general_font_scale* FontSizeX1*0.6, 0.0, 0.0}
predefined_font_05 = {general_font_scale* FontSizeY1*0.5, general_font_scale* FontSizeX1*0.5, 0.0, 0.0}

function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end


local LineSizeY   = FontSizeY1 * 9
local ColumnSizeX = FontSizeX1 * 48 / 72 * 8 

firstLineY = - LineSizeY

local hints_scale		= MakeMaterial("arcade.tga", {255, 128, 64, 255})

local base_size_x   = ColumnSizeX * 45.0
local base_size_y   = LineSizeY   * 17.0
local base_size_x05 = base_size_x * 0.5
local base_size_y05 = base_size_y * 0.5

HintsBase					= CreateElement "ceSimple"
HintsBase.name				= "HintsBase"
HintsBase.init_pos			= {0, GetAspect() - 3.5 * FontSizeY1}
AddElement(HintsBase)

-- Alignment Vars
local delta_pos_y = LineSizeY * 1.35

-- Page Title --

local PAGE_Adjust_x = 0
local PAGE_Adjust_y = -LineSizeY * 1.35

txt_PageTitle					= CreateElement "ceStringPoly"
txt_PageTitle.name				= "txt_PageTitle"
txt_PageTitle.material			= "font_hints_kneeboard"
txt_PageTitle.init_pos			= {PAGE_Adjust_x,  PAGE_Adjust_y, 0}
txt_PageTitle.value				= "RADIO PRESET CHANNELS"
txt_PageTitle.alignment			= "CenterCenter"
txt_PageTitle.parent_element	= HintsBase.name
txt_PageTitle.stringdefs		= predefined_font_08
AddElement(txt_PageTitle)

-- Radio Data --

local PAGE_pos_x0 = 0
local PAGE_pos_x1 = -0.95
local PAGE_pos_x2 = -0.20
local PAGE_pos_x3 = -0.30
local PAGE_pos_y = -delta_pos_y * 2.2

local VUHF_pos_y  = PAGE_pos_y - delta_pos_y * 1
local UHF_pos_y  =  PAGE_pos_y - delta_pos_y * 14

-- V/UHF Radio Data --
txt_VUHF_Title1					= CreateElement "ceStringPoly"
txt_VUHF_Title1.name			= "txt_VUHF_Title1"
txt_VUHF_Title1.material		= "font_hints_kneeboard"
txt_VUHF_Title1.init_pos		= {PAGE_pos_x1,  PAGE_pos_y, 0}
txt_VUHF_Title1.value			= "RADIO:  V/UHF"
txt_VUHF_Title1.alignment		= "LeftCenter"
txt_VUHF_Title1.parent_element	= HintsBase.name
txt_VUHF_Title1.stringdefs		= predefined_font_06
AddElement(txt_VUHF_Title1)

txt_VUHF_Title2					= CreateElement "ceStringPoly"
txt_VUHF_Title2.name			= "txt_VUHF_Title2"
txt_VUHF_Title2.material		= "font_hints_kneeboard"
txt_VUHF_Title2.init_pos		= {-PAGE_pos_x1,  PAGE_pos_y, 0}
txt_VUHF_Title2.value			= "FREQ:  118.00 TO 140.00 MHZ"
txt_VUHF_Title2.alignment		= "RightCenter"
txt_VUHF_Title2.parent_element	= HintsBase.name
txt_VUHF_Title2.stringdefs		= predefined_font_06
AddElement(txt_VUHF_Title2)

txt_VUHF_Title3					= CreateElement "ceStringPoly"
txt_VUHF_Title3.name			= "txt_VUHF_Title3"
txt_VUHF_Title3.material		= "font_hints_kneeboard"
txt_VUHF_Title3.init_pos		= {-PAGE_pos_x1,  PAGE_pos_y - delta_pos_y * 1, 0}
txt_VUHF_Title3.value			= "225.00 TO 400.00 MHZ"
txt_VUHF_Title3.alignment		= "RightCenter"
txt_VUHF_Title3.parent_element	= HintsBase.name
txt_VUHF_Title3.stringdefs		= predefined_font_06
AddElement(txt_VUHF_Title3)

for i = 1, 10 do
	local c1 = i
	txt_VUHF_CH_A					= CreateElement "ceStringPoly"
	txt_VUHF_CH_A.name				= "txt_VUHF_CH_"..c1
	txt_VUHF_CH_A.material			= "font_hints_kneeboard"
	txt_VUHF_CH_A.init_pos			= {PAGE_pos_x1,  VUHF_pos_y - delta_pos_y * (i+1), 0}
	txt_VUHF_CH_A.formats			= {"CHNL %02d: %3.2f MHZ"}
	txt_VUHF_CH_A.alignment			= "LeftCenter"
	txt_VUHF_CH_A.parent_element	= HintsBase.name
	txt_VUHF_CH_A.stringdefs		= predefined_font_06
	txt_VUHF_CH_A.controllers		= {{"VUHF_CHNL", c1}}
	AddElement(txt_VUHF_CH_A)
	
	local c2 = i+10
	txt_VUHF_CH_B					= CreateElement "ceStringPoly"
	txt_VUHF_CH_B.name				= "txt_VUHF_CH_"..c2
	txt_VUHF_CH_B.material			= "font_hints_kneeboard"
	txt_VUHF_CH_B.init_pos			= {-PAGE_pos_x1,  VUHF_pos_y - delta_pos_y * (i+1), 0}
	txt_VUHF_CH_B.formats			= {"CHNL %02d: %3.2f MHZ"}
	txt_VUHF_CH_B.alignment			= "RightCenter"
	txt_VUHF_CH_B.parent_element	= HintsBase.name
	txt_VUHF_CH_B.stringdefs		= predefined_font_06
	txt_VUHF_CH_B.controllers		= {{"VUHF_CHNL", c2}}
	AddElement(txt_VUHF_CH_B)
end


-- UHF Radio Data --
txt_UHF_Title1					= CreateElement "ceStringPoly"
txt_UHF_Title1.name				= "txt_UHF_Title1"
txt_UHF_Title1.material			= "font_hints_kneeboard"
txt_UHF_Title1.init_pos			= {PAGE_pos_x1,  UHF_pos_y, 0}
txt_UHF_Title1.value			= "RADIO:  UHF"
txt_UHF_Title1.alignment		= "LeftCenter"
txt_UHF_Title1.parent_element	= HintsBase.name
txt_UHF_Title1.stringdefs		= predefined_font_06
AddElement(txt_UHF_Title1)

txt_UHF_Title2					= CreateElement "ceStringPoly"
txt_UHF_Title2.name				= "txt_UHF_Title2"
txt_UHF_Title2.material			= "font_hints_kneeboard"
txt_UHF_Title2.init_pos			= {-PAGE_pos_x1,  UHF_pos_y, 0}
txt_UHF_Title2.value			= "FREQ:  225.00 TO 400.00 MHZ"
txt_UHF_Title2.alignment		= "RightCenter"
txt_UHF_Title2.parent_element	= HintsBase.name
txt_UHF_Title2.stringdefs		= predefined_font_06
AddElement(txt_UHF_Title2)

for i = 1, 10 do
	local c1 = i
	txt_UHF_CH_A				= CreateElement "ceStringPoly"
	txt_UHF_CH_A.name			= "txt_UHF_CH_"..c1
	txt_UHF_CH_A.material		= "font_hints_kneeboard"
	txt_UHF_CH_A.init_pos		= {PAGE_pos_x1,  UHF_pos_y - delta_pos_y * (i+1), 0}
	txt_UHF_CH_A.formats		= {"CHNL %02d: %3.2f MHZ"}
	txt_UHF_CH_A.alignment		= "LeftCenter"
	txt_UHF_CH_A.parent_element	= HintsBase.name
	txt_UHF_CH_A.stringdefs		= predefined_font_06
	txt_UHF_CH_A.controllers	= {{"UHF_CHNL", c1}}
	AddElement(txt_UHF_CH_A)
	
	local c2 = i+10
	txt_UHF_CH_B				= CreateElement "ceStringPoly"
	txt_UHF_CH_B.name			= "txt_UHF_CH_"..c2
	txt_UHF_CH_B.material		= "font_hints_kneeboard"
	txt_UHF_CH_B.init_pos		= {-PAGE_pos_x1,  UHF_pos_y - delta_pos_y * (i+1), 0}
	txt_UHF_CH_B.formats		= {"CHNL %02d: %3.2f MHZ"}
	txt_UHF_CH_B.alignment		= "RightCenter"
	txt_UHF_CH_B.parent_element	= HintsBase.name
	txt_UHF_CH_B.stringdefs		= predefined_font_06
	txt_UHF_CH_B.controllers	= {{"UHF_CHNL", c2}}
	AddElement(txt_UHF_CH_B)
end


