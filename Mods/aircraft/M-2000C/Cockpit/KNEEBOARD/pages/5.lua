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

vcm_symbol_size = {general_font_scale* FontSizeY1*0.4, general_font_scale* FontSizeX1*0.37, 0.0, 0.0}

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

InitPosBase					= CreateElement "ceSimple"
InitPosBase.name				= "InitPosBase"
InitPosBase.init_pos			= {0, GetAspect() - 3.5 * FontSizeY1}
AddElement(InitPosBase)

-- Alignment Vars
local delta_pos_y = LineSizeY * 1.35

-- Page Title --

local PDA_Adjust_x = 0
local PDA_Adjust_y = -LineSizeY * 1.35

txt_PageTitle					= CreateElement "ceStringPoly"
txt_PageTitle.name				= "txt_PageTitle"
txt_PageTitle.material			= "font_hints_kneeboard"
txt_PageTitle.init_pos			= {PDA_Adjust_x,  PDA_Adjust_y, 0}
txt_PageTitle.value				= "MENACES VCM"
txt_PageTitle.alignment			= "CenterCenter"
txt_PageTitle.parent_element	= HintsBase.name
txt_PageTitle.stringdefs		= predefined_font_08
AddElement(txt_PageTitle)

-- Pilot & Aircraft Data --

local PAD_pos_x0 = 0
local PAD_pos_x1 = -0.8
local PAD_pos_x2 = -0.20
local PAD_pos_x3 = 0.0
local PAD_pos_y = -delta_pos_y * 2.3



for i = 0, 42 do
	vcm_symbol					= CreateElement "ceStringPoly"
	vcm_symbol.name				= "vcm_symbol_" .. (i)
	vcm_symbol.material			= "font_threats_kneeboard"
	vcm_symbol.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
	vcm_symbol.value			= ""
	vcm_symbol.alignment		= "LeftCenter"
	vcm_symbol.parent_element	= HintsBase.name
	vcm_symbol.stringdefs		= vcm_symbol_size
	vcm_symbol.controllers		= {{"pad_vcm_symbol",i}}
	AddElement(vcm_symbol)
	
	vcm_desc					= CreateElement "ceStringPoly"
	vcm_desc.name				= "vcm_desc_" .. (i)
	vcm_desc.material			= "font_hints_kneeboard"
	vcm_desc.init_pos			= {PAD_pos_x1 + ColumnSizeX*2,  PAD_pos_y, 0}
	vcm_desc.value				= ""
	vcm_desc.alignment			= "LeftCenter"
	vcm_desc.parent_element		= HintsBase.name
	vcm_desc.stringdefs			= predefined_font_05
	vcm_desc.controllers		= {{"pad_vcm_desc",i}}
	AddElement(vcm_desc)
	
	PAD_pos_y = PAD_pos_y - delta_pos_y * 0.705
end
