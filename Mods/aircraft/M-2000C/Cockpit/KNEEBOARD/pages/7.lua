dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

add_picture("Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/notepad.dds")

-- GENERAL SCALE
local general_font_scale = 1.0

FontSizeX1	= 0.0075 * general_font_scale
FontSizeY1	= FontSizeX1

predefined_font_20 = {FontSizeX1*2.0, FontSizeY1*2.0, 0.0, 0.0}
predefined_font_10 = {FontSizeX1, 	  FontSizeY1	, 0.0, 0.0}
predefined_font_09 = {FontSizeX1*0.9, FontSizeY1*0.9, 0.0, 0.0}
predefined_font_08 = {FontSizeX1*0.8, FontSizeY1*0.8, 0.0, 0.0}
predefined_font_07 = {FontSizeX1*0.7, FontSizeY1*0.7, 0.0, 0.0}
predefined_font_06 = {FontSizeX1*0.6, FontSizeY1*0.6, 0.0, 0.0}
predefined_font_05 = {FontSizeX1*0.5, FontSizeY1*0.5, 0.0, 0.0}

notice_font =  {FontSizeX1*0.5, FontSizeY1*0.5, -FontSizeX1*0.11, 0.0}

function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end


local LineSizeY   = FontSizeY1 * 9
local ColumnSizeX = FontSizeX1 * 48 / 72 * 8 

firstLineY = - LineSizeY

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
local delta_pos_y = LineSizeY

-- Page Title --

local PDA_Adjust_x = 0
local PDA_Adjust_y = -LineSizeY * 1.35

txt_PageTitle					= CreateElement "ceStringPoly"
txt_PageTitle.name				= "txt_PageTitle"
txt_PageTitle.material			= "font_hints_kneeboard"
txt_PageTitle.init_pos			= {PDA_Adjust_x,  PDA_Adjust_y, 0}
txt_PageTitle.value				= "GROUND CREW NOTICES"
txt_PageTitle.alignment			= "CenterCenter"
txt_PageTitle.parent_element	= HintsBase.name
txt_PageTitle.stringdefs		= predefined_font_08
AddElement(txt_PageTitle)

-- Pilot & Aircraft Data --

local PAD_pos_x0 = 0
local PAD_pos_x1 = -0.88
local PAD_pos_x2 = -0.20
local PAD_pos_x3 = 0.0
local PAD_pos_y = -delta_pos_y * 5.0


lines = {}

table.insert(lines, "NEW M53-P2 ENGINE")
table.insert(lines, " - PERFORMANCE IS DIFFERENT FROM THE OLD M53-5 ENGINE")
table.insert(lines, " - CALC ALARM MEANS THE FADEC SWITCHED TO ALT MODE AUTOMATICALLY")
table.insert(lines, "   YOU MAY RESET IT WITH REARM SWITCH")
table.insert(lines, "   MORE THAN 3 RESETS THE ENGINE IS DAMAGED - RETURN TO BASE")
table.insert(lines, " - NEVER UNLOCK THROTTLE CUTOFF BEFORE 11 PCT RPM")
table.insert(lines, "   THIS WOULD DAMAGE OR DESTROY THE ENGINE")
table.insert(lines, " - READ MANUAL FOR MORE DETAILS")
table.insert(lines, "")

table.insert(lines, "")
table.insert(lines, "ALREADY IN PREVIOUS OPENBETA")
table.insert(lines, "")

table.insert(lines, "CHAFF/FLARE AMOUNT")
table.insert(lines, " - INTERNAL AMOUNT IS FIXED TO 112/16")
table.insert(lines, " - CHOOSE AN ECLAIR POD FOR ADDING MORE")
table.insert(lines, " - SLIDERS SHOULD ALWAYS SET TO 234/64")
table.insert(lines, "")

table.insert(lines, "STARTUP : TPL/TPC FBW TEST")
table.insert(lines, " - THE TEST WILL FAIL ON COLD FBW HYDRAULICS")
table.insert(lines, " - WIPE THE CONTROLS A FEW TIMES BEFORE STARTING THE TEST")
table.insert(lines, " - THIS IS ESPECIALLY IMPORTANT DURING THE COLD SEASON")
table.insert(lines, "")





for i, line in ipairs(lines) do
	txt_notice						= CreateElement "ceStringPoly"
	txt_notice.name					= "txt_notices_" .. (i)
	txt_notice.material				= "font_hints_kneeboard"
	txt_notice.init_pos				= {PAD_pos_x1,  PAD_pos_y, 0}
	txt_notice.value				= line
	txt_notice.alignment			= "LeftCenter"
	txt_notice.parent_element		= HintsBase.name
	txt_notice.stringdefs			= notice_font
	AddElement(txt_notice)	
	PAD_pos_y = PAD_pos_y - delta_pos_y * 1	
end
