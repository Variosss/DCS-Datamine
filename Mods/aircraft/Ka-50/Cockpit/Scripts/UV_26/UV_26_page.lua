dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

txt_digits				= CreateElement "ceStringPoly"
txt_digits.name         = "txt_digits"
txt_digits.material     = "font_UV_26"
txt_digits.init_pos		= {-0.61, -0.052, 0.0}
txt_digits.alignment    = "LeftCenter"
txt_digits.stringdefs   = {0.011, 0.011, 0.0038, 0.0}
txt_digits.formats		= {"%03u"}
txt_digits.controllers	= {{"digits", 0, 99}}
Add(txt_digits)
