dofile(LockOn_Options.script_path.."UFC/indicator/UFC_definitions.lua")
dofile(LockOn_Options.script_path.."UFC/indicator/UFC_radios.lua")

local	ufc_numeric_output				= CreateElement "ceStringPoly"
		ufc_numeric_output.name			= "ufc_numeric_output"
		ufc_numeric_output.material		= ufc_font_base
		ufc_numeric_output.init_pos		= {-0.95, 0.5, 0}
		ufc_numeric_output.alignment	= "LeftCenter"
		ufc_numeric_output.value		= "ON"
		ufc_numeric_output.stringdefs	= UFC_default_string_font_size
Add_UFC_Element(ufc_numeric_output)
