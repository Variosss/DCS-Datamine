dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

scale = 0.865853659

use_mipfilter	= true

local HorizontalSize	= scale * 0.00992
local VerticalSize		= scale * 0.0087
local HorOffset			= scale * 0.0069
local VertOffset		= scale * 0.0035

local base 				= CreateElement "ceSimple"
base.init_pos			= {0,VertOffset}
Add(base)

txtHours				= CreateElement "ceStringPoly"
txtHours.name			= "txtHours"
txtHours.material		= "font_DIGIT_CLK"
txtHours.init_pos		= {-HorOffset,0,0}
txtHours.alignment		= "CenterCenter"
txtHours.controllers	= {{"txtHours"}}
txtHours.stringdefs		= {VerticalSize, HorizontalSize, 0.0, 0.0}
txtHours.use_mipfilter	= use_mipfilter
txtHours.parent_element	= base.name
Add(txtHours)

txtColon				= CreateElement "ceStringPoly"
txtColon.name			= "txtColon"
txtColon.material		= "font_DIGIT_CLK"
txtColon.alignment		= "CenterCenter"
txtColon.value			= ":"
txtColon.stringdefs		= {VerticalSize, HorizontalSize, 0.0, 0.0}
txtColon.use_mipfilter	= use_mipfilter
txtColon.parent_element	= base.name
Add(txtColon)

txtMinutes				= CreateElement "ceStringPoly"
txtMinutes.name			= "txtMinutes"
txtMinutes.material		= "font_DIGIT_CLK"
txtMinutes.init_pos		= {HorOffset, 0, 0}
txtMinutes.alignment	= "CenterCenter"
txtMinutes.controllers	= {{"txtMinutes"}}
txtMinutes.stringdefs	= {VerticalSize, HorizontalSize, 0.0, 0.0}
txtMinutes.use_mipfilter= use_mipfilter
txtMinutes.parent_element	= base.name
Add(txtMinutes)

txtSeconds					= CreateElement "ceStringPoly"
txtSeconds.name				= "txtSeconds"
txtSeconds.material			= "font_DIGIT_CLK"
txtSeconds.init_pos			= {0.0,-VerticalSize, 0.0}
txtSeconds.alignment		= "CenterCenter"
txtSeconds.controllers		= {{"txtSeconds"}}
txtSeconds.stringdefs		= {VerticalSize, HorizontalSize, 0.0, 0.0}
txtSeconds.use_mipfilter	= use_mipfilter
txtSeconds.parent_element	= base.name
Add(txtSeconds)

local ETCHorizontalSize = scale * 0.0051
local ETCVerticalSize	= scale * 0.0051
local ETCVertOffset		= scale * 0.012

txtET					= CreateElement "ceStringPoly"
txtET.name				= "txtET"
txtET.material			= "font_DIGIT_CLK"
txtET.init_pos			= {scale * (-0.0018), -ETCVertOffset, 0.0}
txtET.alignment			= "CenterCenter"
txtET.value				= "ET"
txtET.controllers		= {{"txtET"}}
txtET.stringdefs		= {ETCVerticalSize, ETCHorizontalSize, 0.0, 0.0}
txtET.use_mipfilter		= use_mipfilter
Add(txtET)

txtC					= CreateElement "ceStringPoly"
txtC.name				= "txtC"
txtC.material			= "font_DIGIT_CLK"
txtC.init_pos			= {scale * 0.0028, -ETCVertOffset, 0.0}
txtC.alignment			= "CenterCenter"
txtC.value				= "C"
txtC.controllers		= {{"txtC"}}
txtC.stringdefs			= {ETCVerticalSize, ETCHorizontalSize, 0.0, 0.0}
txtC.use_mipfilter		= use_mipfilter
Add(txtC)

local needle_min_x = scale * (-0.00065)  
local needle_min_y = scale * (-0.0025) 
local needle_max_y = scale * 0.0045
local needle_max_x = scale * 0.00065



secondsNeedle				= CreateElement "ceTexPoly"
secondsNeedle.name			= "secondsNeedle"
secondsNeedle.vertices		= {{needle_min_x,needle_min_y},
							   {needle_min_x,needle_max_y},
 							   {needle_max_x,needle_max_y}, 
							   {needle_max_x,needle_min_y}}
secondsNeedle.indices		= default_box_indices
secondsNeedle.init_pos		= {0.0, 0.0, 0}
secondsNeedle.material		= "INDICATION_DIGIT_CLOCK"
secondsNeedle.tex_coords	= {{0,1},{0,0},{1,0},{1,1}}
secondsNeedle.controllers	= {{"secondsNeedle", 0.0154}}
secondsNeedle.use_mipfilter	= use_mipfilter
Add(secondsNeedle)

local SmallHorizontalSize	= 0.0027 * scale
local SmallVerticalSize		= 0.0027 * scale

local DigitsStep		= 5
local DegreesStep		= math.rad(30.0)

function rotatePos(x, y, Angle)
	sinang = math.sin(Angle);
	cosang = math.cos(Angle);
	return y * sinang + x * cosang, y * cosang - x * sinang
end

InitPosX = 0.0 * scale
InitPosY = 0.0244 * scale

for i = 1, 12 do
	local x,y = rotatePos(InitPosX, InitPosY, DegreesStep * i)
	local txt5MinStepDigits			= CreateElement "ceStringPoly"
	txt5MinStepDigits.name			= "txt5MinStepDigits_" .. string.format("%d", DigitsStep * i)
	txt5MinStepDigits.material		= "font_DIGIT_CLK"
	txt5MinStepDigits.init_pos		= {x,y,0.0}
	txt5MinStepDigits.alignment		= "CenterCenter"
	txt5MinStepDigits.value			= string.format("%d", DigitsStep * i)
	txt5MinStepDigits.stringdefs	= {SmallVerticalSize, SmallHorizontalSize, 0.0, 0.0}
	txt5MinStepDigits.use_mipfilter	= use_mipfilter
	Add(txt5MinStepDigits)
end
