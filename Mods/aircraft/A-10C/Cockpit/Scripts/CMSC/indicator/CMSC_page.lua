dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

SetScale(METERS) -- scale factor modifier
use_mipfilter	= true

local hor_size_scale = 0.95

local horizontal_size    = hor_size_scale * 0.007
local vertical_size      = 0.007
local vertical_alignment = 0.0075
local second_row 		 = -0.0135

local font_defs = {vertical_size, horizontal_size, 0.0, 0.0}
local font 		= "font_CMS"
if shape_201912 then 
	vertical_alignment  =   0.0075
	second_row			=  -0.0143
end

txt_CHAFF_FLARE					= CreateElement "ceStringPoly"
txt_CHAFF_FLARE.name			= "txt_CHAFF_FLARE"
txt_CHAFF_FLARE.material		= font
txt_CHAFF_FLARE.init_pos		= {0.0042, vertical_alignment, 0.0}
txt_CHAFF_FLARE.alignment		= "LeftCenter"
txt_CHAFF_FLARE.controllers		= {{"txt_CHAFF_FLARE"}}
txt_CHAFF_FLARE.stringdefs		= font_defs
txt_CHAFF_FLARE.use_mipfilter	= use_mipfilter
Add(txt_CHAFF_FLARE)

txt_JMR							= CreateElement "ceStringPoly"
txt_JMR.name					= "txt_JMR"
txt_JMR.material				= font
txt_JMR.init_pos				= {-0.0453, vertical_alignment, 0.0}
txt_JMR.alignment				= "LeftCenter"
txt_JMR.controllers				= {{"txt_JMR"}}
txt_JMR.stringdefs				= font_defs
txt_JMR.use_mipfilter			= use_mipfilter
Add(txt_JMR)


txt_MWS							= CreateElement "ceStringPoly"
txt_MWS.name					= "txt_MWS"
txt_MWS.material				= font
txt_MWS.init_pos				= {-0.0453, vertical_alignment + second_row, 0.0}
txt_MWS.alignment				= "LeftCenter"
txt_MWS.controllers				= {{"txt_MWS"}}
txt_MWS.stringdefs				= font_defs
txt_MWS.use_mipfilter			= use_mipfilter
Add(txt_MWS)


--[[
ML_Lamp_Hint			= CreateElement "ceHint"
ML_Lamp_Hint.value		= _("Missile Launch Alert")
ML_Lamp_Hint.hint_name  = "EW-LGT-R1"
Add(ML_Lamp_Hint)
--]]
