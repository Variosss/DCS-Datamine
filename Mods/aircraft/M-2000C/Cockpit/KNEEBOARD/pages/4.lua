dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/notepad.dds")

-- GENERAL SCALE
local general_font_scale = 1.0

FontSizeX1	= 0.0075 * general_font_scale
FontSizeY1	= FontSizeX1

title_font = {FontSizeY1*0.8, FontSizeX1*0.8, 0.0, 0.0 }
buts_font = {FontSizeY1*0.6, FontSizeX1*0.6, 0.0, 0.0 }

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
txt_PageTitle.value				= "BUTS / WAYPOINTS"
txt_PageTitle.alignment			= "CenterCenter"
txt_PageTitle.parent_element	= HintsBase.name
txt_PageTitle.stringdefs		= title_font
AddElement(txt_PageTitle)

-- Pilot & Aircraft Data --

local PAD_pos_x0 = 0
local PAD_pos_x1 = -0.8
local PAD_pos_x2 = -0.20
local PAD_pos_x3 = 0.0
local PAD_pos_y = -delta_pos_y * 3.0



for i = 1, 20 do
	txt_but						= CreateElement "ceStringPoly"
	txt_but.name				= "txt_but_" .. (i)
	txt_but.material			= "font_hints_kneeboard"
	txt_but.init_pos			= {PAD_pos_x1,  PAD_pos_y, 0}
	txt_but.formats				= {"%02d %s"}
	txt_but.alignment			= "LeftCenter"
	txt_but.parent_element		= HintsBase.name
	txt_but.stringdefs			= buts_font
	txt_but.controllers			= {{"pad_but",i}}
	AddElement(txt_but)
	
	PAD_pos_y = PAD_pos_y - delta_pos_y * 1		
end
