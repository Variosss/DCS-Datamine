dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(METERS) -- scale factor modifier
use_mipfilter	= true

local horizontal_size = 0.0067
local vertical_size   = 0.0074
local vertical_alignment_down = -0.0047

txt_UP					= CreateElement "ceStringPoly"
txt_UP.name				= "txt_UP"
txt_UP.material			= "font_CMSP"
txt_UP.init_pos			= {-0.043, 0.004, 0.0}--{-0.045, 0.004, 0.0}
txt_UP.alignment		= "LeftCenter"
txt_UP.controllers		= {{"txt_UP"}}
txt_UP.stringdefs		= {vertical_size, horizontal_size, 0.0004, 0.0}
txt_UP.use_mipfilter	= use_mipfilter
Add(txt_UP)

local delta_pos 	 = 0.0215
local pos1 			 = -0.043
local hor_space_down = 0.00057

local pos2 = pos1 +   delta_pos
local pos3 = pos1 + 2*delta_pos
local pos4 = pos1 + 3*delta_pos


txt_DOWN1				= CreateElement "ceStringPoly"
txt_DOWN1.name			= "txt_DOWN1"
txt_DOWN1.material		= "font_CMSP"
txt_DOWN1.init_pos		= {pos1, vertical_alignment_down, 0.0}
txt_DOWN1.alignment		= "LeftCenter"
txt_DOWN1.controllers	= {{"txt_DOWN1"}}
txt_DOWN1.stringdefs	= {vertical_size * 0.81, horizontal_size * 0.81, hor_space_down, 0.0}
txt_DOWN1.use_mipfilter	= use_mipfilter
Add(txt_DOWN1)


txt_DOWN2				= CreateElement "ceStringPoly"
txt_DOWN2.name			= "txt_DOWN2"
txt_DOWN2.material		= "font_CMSP"
txt_DOWN2.init_pos		= {pos2, vertical_alignment_down, 0.0}
txt_DOWN2.alignment		= "LeftCenter"
txt_DOWN2.controllers	= {{"txt_DOWN2"}}
txt_DOWN2.stringdefs	= {vertical_size * 0.81, horizontal_size * 0.81, hor_space_down, 0.0}
txt_DOWN2.use_mipfilter	= use_mipfilter
Add(txt_DOWN2)

txt_DOWN3				= CreateElement "ceStringPoly"
txt_DOWN3.name			= "txt_DOWN3"
txt_DOWN3.material		= "font_CMSP"
txt_DOWN3.init_pos		= {pos3, vertical_alignment_down, 0.0}
txt_DOWN3.alignment		= "LeftCenter"
txt_DOWN3.controllers	= {{"txt_DOWN3"}}
txt_DOWN3.stringdefs	= {vertical_size * 0.81, horizontal_size * 0.81, hor_space_down, 0.0}
txt_DOWN3.use_mipfilter	= use_mipfilter
Add(txt_DOWN3)


txt_DOWN4				= CreateElement "ceStringPoly"
txt_DOWN4.name			= "txt_DOWN4"
txt_DOWN4.material		= "font_CMSP"
txt_DOWN4.init_pos		= {pos4, vertical_alignment_down, 0.0}
txt_DOWN4.alignment		= "LeftCenter"
txt_DOWN4.controllers	= {{"txt_DOWN4"}}
txt_DOWN4.stringdefs	= {vertical_size * 0.81, horizontal_size * 0.81, hor_space_down, 0.0}
txt_DOWN4.use_mipfilter	= use_mipfilter
Add(txt_DOWN4)

--[[
function cp(elem)
local t =  Copy(elem)
	  t.controllers = {}
	  t.value 		= "XXXX"
	  local i = elem.init_pos
	  t.init_pos = {i[1],i[2] + 0.02,i[3]}
	  Add(t)
end

cp(txt_DOWN1)
cp(txt_DOWN2)
cp(txt_DOWN3)
cp(txt_DOWN4)
--]]