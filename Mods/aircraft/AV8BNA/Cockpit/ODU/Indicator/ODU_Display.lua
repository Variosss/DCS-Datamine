dofile(LockOn_Options.script_path.."ODU/indicator/ODU_definitions.lua")

--[[ 
	TO COMMENT PUT THE CODE BETWEEN THE BRACKETS
]]

local	ODU_Option_1_Slc				= CreateElement "ceStringPoly"
		ODU_Option_1_Slc.name			= "ODU_Option_1_Slc"
		ODU_Option_1_Slc.material		= odu_font_base
		ODU_Option_1_Slc.init_pos		= {0.2, 0.344, 0}
		ODU_Option_1_Slc.alignment		= "LeftCenter"
		ODU_Option_1_Slc.value			= ":"
		ODU_Option_1_Slc.stringdefs		= ODU_default_font_size
		ODU_Option_1_Slc.controllers	= {{"ODU_Opt_1_Slct"}}
Add_ODU_Element(ODU_Option_1_Slc)

local	ODU_Option_1_Text				= CreateElement "ceStringPoly"
		ODU_Option_1_Text.name			= "ODU_Option_1_Text"
		ODU_Option_1_Text.material		= odu_font_base
		ODU_Option_1_Text.init_pos		= {0.3, 0.344, 0}
		ODU_Option_1_Text.alignment		= "LeftCenter"
		ODU_Option_1_Text.formats		= {"%s"}
		ODU_Option_1_Text.stringdefs	= ODU_default_font_size
		ODU_Option_1_Text.controllers	= {{"ODU_Opt_1_Text"}}
Add_ODU_Element(ODU_Option_1_Text)

local	ODU_Option_2_Slc				= CreateElement "ceStringPoly"
		ODU_Option_2_Slc.name			= "ODU_Option_2_Slc"
		ODU_Option_2_Slc.material		= odu_font_base
		ODU_Option_2_Slc.init_pos		= {0.2, 0.0, 0}
		ODU_Option_2_Slc.alignment		= "LeftCenter"
		ODU_Option_2_Slc.value			= ":"
		ODU_Option_2_Slc.stringdefs		= ODU_default_font_size
		ODU_Option_2_Slc.controllers	= {{"ODU_Opt_2_Slct"}}
Add_ODU_Element(ODU_Option_2_Slc)

local	ODU_Option_2_Text				= CreateElement "ceStringPoly"
		ODU_Option_2_Text.name			= "ODU_Option_2_Text"
		ODU_Option_2_Text.material		= odu_font_base
		ODU_Option_2_Text.init_pos		= {0.3, 0.0, 0}
		ODU_Option_2_Text.alignment		= "LeftCenter"
		ODU_Option_2_Text.formats		= {"%s"}
		ODU_Option_2_Text.stringdefs	= ODU_default_font_size
		ODU_Option_2_Text.controllers	= {{"ODU_Opt_2_Text"}}
Add_ODU_Element(ODU_Option_2_Text)

local	ODU_Option_3_Slc				= CreateElement "ceStringPoly"
		ODU_Option_3_Slc.name			= "ODU_Option_3_Slc"
		ODU_Option_3_Slc.material		= odu_font_base
		ODU_Option_3_Slc.init_pos		= {0.2, -0.342, 0}
		ODU_Option_3_Slc.alignment		= "LeftCenter"
		ODU_Option_3_Slc.value			= ":"
		ODU_Option_3_Slc.stringdefs		= ODU_default_font_size
		ODU_Option_3_Slc.controllers	= {{"ODU_Opt_3_Slct"}}
Add_ODU_Element(ODU_Option_3_Slc)

local	ODU_Option_3_Text				= CreateElement "ceStringPoly"
		ODU_Option_3_Text.name			= "ODU_Option_3_Text"
		ODU_Option_3_Text.material		= odu_font_base
		ODU_Option_3_Text.init_pos		= {0.3, -0.342, 0}
		ODU_Option_3_Text.alignment		= "LeftCenter"
		ODU_Option_3_Text.formats		= {"%s"}
		ODU_Option_3_Text.stringdefs	= ODU_default_font_size
		ODU_Option_3_Text.controllers	= {{"ODU_Opt_3_Text"}}
Add_ODU_Element(ODU_Option_3_Text)

local	ODU_Option_4_Slc				= CreateElement "ceStringPoly"
		ODU_Option_4_Slc.name			= "ODU_Option_4_Slc"
		ODU_Option_4_Slc.material		= odu_font_base
		ODU_Option_4_Slc.init_pos		= {-0.93, 0.0, 0}
		ODU_Option_4_Slc.alignment		= "LeftCenter"
		ODU_Option_4_Slc.value			= ":"
		ODU_Option_4_Slc.stringdefs		= ODU_default_font_size
		ODU_Option_4_Slc.controllers	= {{"ODU_Opt_4_Slct"}}
Add_ODU_Element(ODU_Option_4_Slc)

local	ODU_Option_4_Text				= CreateElement "ceStringPoly"
		ODU_Option_4_Text.name			= "ODU_Option_4_Text"
		ODU_Option_4_Text.material		= odu_font_base
		ODU_Option_4_Text.init_pos		= {-0.83, 0.0, 0}
		ODU_Option_4_Text.alignment		= "LeftCenter"
		ODU_Option_4_Text.formats		= {"%s"}
		ODU_Option_4_Text.stringdefs	= ODU_default_font_size
		ODU_Option_4_Text.controllers	= {{"ODU_Opt_4_Text"}}
Add_ODU_Element(ODU_Option_4_Text)

local	ODU_Option_5_Slc				= CreateElement "ceStringPoly"
		ODU_Option_5_Slc.name			= "ODU_Option_5_Slc"
		ODU_Option_5_Slc.material		= odu_font_base
		ODU_Option_5_Slc.init_pos		= {-0.93, -0.342, 0}
		ODU_Option_5_Slc.alignment		= "LeftCenter"
		ODU_Option_5_Slc.value			= ":"
		ODU_Option_5_Slc.stringdefs		= ODU_default_font_size
		ODU_Option_5_Slc.controllers	= {{"ODU_Opt_5_Slct"}}
Add_ODU_Element(ODU_Option_5_Slc)

local	ODU_Option_5_Text				= CreateElement "ceStringPoly"
		ODU_Option_5_Text.name			= "ODU_Option_5_Text"
		ODU_Option_5_Text.material		= odu_font_base
		ODU_Option_5_Text.init_pos		= {-0.83, -0.342, 0}
		ODU_Option_5_Text.alignment		= "LeftCenter"
		ODU_Option_5_Text.formats		= {"%s"}
		ODU_Option_5_Text.stringdefs	= ODU_default_font_size
		ODU_Option_5_Text.controllers	= {{"ODU_Opt_5_Text"}}
Add_ODU_Element(ODU_Option_5_Text)

-- FOR FONT ALIGNMENT PURPOSES --

--[[

local	ODU_Option_1_Slc				= CreateElement "ceStringPoly"
		ODU_Option_1_Slc.name			= "ODU_Option_1_Slc"
		ODU_Option_1_Slc.material		= odu_font_base
		ODU_Option_1_Slc.init_pos		= {0.2, 0.35, 0}
		ODU_Option_1_Slc.alignment		= "LeftCenter"
		ODU_Option_1_Slc.value			= ":"
		ODU_Option_1_Slc.stringdefs		= ODU_default_font_size
Add_ODU_Element(ODU_Option_1_Slc)

local	ODU_Option_1_Text				= CreateElement "ceStringPoly"
		ODU_Option_1_Text.name			= "ODU_Option_1_Text"
		ODU_Option_1_Text.material		= odu_font_base
		ODU_Option_1_Text.init_pos		= {0.3, 0.35, 0}
		ODU_Option_1_Text.alignment		= "LeftCenter"
		ODU_Option_1_Text.value			= "OOOO"	-- YOU CAN TYPE ANY VALUE YOU WANT BETWEEN THE DOUBLE QUOTES
		ODU_Option_1_Text.stringdefs	= ODU_default_font_size
Add_ODU_Element(ODU_Option_1_Text)

local	ODU_Option_2_Slc				= CreateElement "ceStringPoly"
		ODU_Option_2_Slc.name			= "ODU_Option_2_Slc"
		ODU_Option_2_Slc.material		= odu_font_base
		ODU_Option_2_Slc.init_pos		= {0.2, 0.0, 0}
		ODU_Option_2_Slc.alignment		= "LeftCenter"
		ODU_Option_2_Slc.value			= ":"
		ODU_Option_2_Slc.stringdefs		= ODU_default_font_size
Add_ODU_Element(ODU_Option_2_Slc)

local	ODU_Option_2_Text				= CreateElement "ceStringPoly"
		ODU_Option_2_Text.name			= "ODU_Option_2_Text"
		ODU_Option_2_Text.material		= odu_font_base
		ODU_Option_2_Text.init_pos		= {0.3, 0.0, 0}
		ODU_Option_2_Text.alignment		= "LeftCenter"
		ODU_Option_2_Text.value			= "OOOO"
		ODU_Option_2_Text.stringdefs	= ODU_default_font_size
Add_ODU_Element(ODU_Option_2_Text)

local	ODU_Option_3_Slc				= CreateElement "ceStringPoly"
		ODU_Option_3_Slc.name			= "ODU_Option_3_Slc"
		ODU_Option_3_Slc.material		= odu_font_base
		ODU_Option_3_Slc.init_pos		= {0.2, -0.35, 0}
		ODU_Option_3_Slc.alignment		= "LeftCenter"
		ODU_Option_3_Slc.value			= ":"
		ODU_Option_3_Slc.stringdefs		= ODU_default_font_size
Add_ODU_Element(ODU_Option_3_Slc)

local	ODU_Option_3_Text				= CreateElement "ceStringPoly"
		ODU_Option_3_Text.name			= "ODU_Option_3_Text"
		ODU_Option_3_Text.material		= odu_font_base
		ODU_Option_3_Text.init_pos		= {0.3, -0.35, 0}
		ODU_Option_3_Text.alignment		= "LeftCenter"
		ODU_Option_3_Text.value			= "OOOO"
		ODU_Option_3_Text.stringdefs	= ODU_default_font_size
Add_ODU_Element(ODU_Option_3_Text)

local	ODU_Option_4_Slc				= CreateElement "ceStringPoly"
		ODU_Option_4_Slc.name			= "ODU_Option_4_Slc"
		ODU_Option_4_Slc.material		= odu_font_base
		ODU_Option_4_Slc.init_pos		= {-0.95, 0.0, 0}
		ODU_Option_4_Slc.alignment		= "LeftCenter"
		ODU_Option_4_Slc.value			= ":"
		ODU_Option_4_Slc.stringdefs		= ODU_default_font_size
Add_ODU_Element(ODU_Option_4_Slc)

local	ODU_Option_4_Text				= CreateElement "ceStringPoly"
		ODU_Option_4_Text.name			= "ODU_Option_4_Text"
		ODU_Option_4_Text.material		= odu_font_base
		ODU_Option_4_Text.init_pos		= {-0.85, 0.0, 0}
		ODU_Option_4_Text.alignment		= "LeftCenter"
		ODU_Option_4_Text.value			= "OOOO"
		ODU_Option_4_Text.stringdefs	= ODU_default_font_size
Add_ODU_Element(ODU_Option_4_Text)

local	ODU_Option_5_Slc				= CreateElement "ceStringPoly"
		ODU_Option_5_Slc.name			= "ODU_Option_5_Slc"
		ODU_Option_5_Slc.material		= odu_font_base
		ODU_Option_5_Slc.init_pos		= {-0.95, -0.35, 0}
		ODU_Option_5_Slc.alignment		= "LeftCenter"
		ODU_Option_5_Slc.value			= ":"
		ODU_Option_5_Slc.stringdefs		= ODU_default_font_size
Add_ODU_Element(ODU_Option_5_Slc)

local	ODU_Option_5_Text				= CreateElement "ceStringPoly"
		ODU_Option_5_Text.name			= "ODU_Option_5_Text"
		ODU_Option_5_Text.material		= odu_font_base
		ODU_Option_5_Text.init_pos		= {-0.85, -0.35, 0}
		ODU_Option_5_Text.alignment		= "LeftCenter"
		ODU_Option_5_Text.value			= "OOOO"
		ODU_Option_5_Text.stringdefs	= ODU_default_font_size
Add_ODU_Element(ODU_Option_5_Text)

]]