dofile(LockOn_Options.script_path.."UFC/indicator/UFC_definitions.lua")
dofile(LockOn_Options.script_path.."UFC/indicator/UFC_radios.lua")

-- SCRATCHPAD
-- LEFT VALUES
local	ufc_left_position				= CreateElement "ceStringPoly"
		ufc_left_position.name			= "ufc_left_position"
		ufc_left_position.material		= ufc_font_base
		ufc_left_position.init_pos		= {-0.55, 0.5, 0}
		ufc_left_position.alignment		= "LeftCenter"
		ufc_left_position.formats		= {"%s"}
		ufc_left_position.stringdefs	= UFC_default_string_font_size
		ufc_left_position.controllers	= {{"ufc_scrpad_left"}}
Add_UFC_Element(ufc_left_position)

-- RIGHT VALUES
local	ufc_right_position				= CreateElement "ceStringPoly"
		ufc_right_position.name			= "ufc_right_position"
		ufc_right_position.material		= ufc_font_base
		ufc_right_position.init_pos		= {0.55, 0.5, 0}
		ufc_right_position.alignment	= "RightCenter"
		ufc_right_position.formats		= {"%s"}
		ufc_right_position.stringdefs	= UFC_default_numeric_font_size
		ufc_right_position.controllers	= {{"ufc_scrpad_right"}}
Add_UFC_Element(ufc_right_position)

local	ufc_right_alpha_position				= CreateElement "ceStringPoly"
		ufc_right_alpha_position.name			= "ufc_right_alpha_position"
		ufc_right_alpha_position.material		= ufc_font_base
		ufc_right_alpha_position.init_pos		= {0.55, 0.5, 0}
		ufc_right_alpha_position.alignment		= "RightCenter"
		ufc_right_alpha_position.formats		= {"%s"}
		ufc_right_alpha_position.stringdefs		= UFC_default_string_font_size
		ufc_right_alpha_position.controllers	= {{"ufc_scrpad_right_alpha"}}
Add_UFC_Element(ufc_right_alpha_position)
