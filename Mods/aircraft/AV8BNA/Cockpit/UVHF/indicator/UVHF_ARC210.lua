dofile(LockOn_Options.script_path.."UVHF/indicator/UVHF_definitions.lua")

-- Alignment
-- local	uvhf_left_position				= CreateElement "ceStringPoly"
		-- uvhf_left_position.name			= "uvhf_left_position"
		-- uvhf_left_position.material		= UVHF_font_base
		-- uvhf_left_position.init_pos		= {0.8, 0.8, 0}
		-- uvhf_left_position.alignment	= "RightCenter"
		-- uvhf_left_position.value		= "000:000"
		-- uvhf_left_position.stringdefs	= {0.009, 0.009}
-- Add_Radio_Element(uvhf_left_position)

--Channels
local	uvhf_channel				= CreateElement "ceStringPoly"
		uvhf_channel.name			= "uvhf_channel"
		uvhf_channel.material		= UVHF_font_chnl
		uvhf_channel.init_pos		= {-0.24, 0.95, 0}
		uvhf_channel.alignment		= "RightCenter"
		uvhf_channel.formats		= {"%s"}
		uvhf_channel.stringdefs		= {0.015, 0.015}
		uvhf_channel.controllers	= {{"RCP_Channel"}}
Add_Radio_Element(uvhf_channel)

-- Frequency
local	uvhf_freq_left				= CreateElement "ceStringPoly"
		uvhf_freq_left.name			= "uvhf_freq_left"
		uvhf_freq_left.material		= UVHF_font_base
		uvhf_freq_left.init_pos		= {-0.22, 0.97, 0}
		uvhf_freq_left.alignment	= "LeftCenter"
		uvhf_channel.formats		= {"%s"}
		uvhf_freq_left.stringdefs	= {0.009, 0.009}
		uvhf_freq_left.controllers	= {{"RCP_Freq"}}
Add_Radio_Element(uvhf_freq_left)

-- local	uvhf_freq_scolon			= CreateElement "ceStringPoly"
		-- uvhf_freq_scolon.name		= "uvhf_freq_scolon"
		-- uvhf_freq_scolon.material	= UVHF_font_base
		-- uvhf_freq_scolon.init_pos	= {0.30, 0.97, 0}
		-- uvhf_freq_scolon.alignment	= "CenterCenter"
		-- uvhf_freq_scolon.value		= "."
		-- uvhf_freq_scolon.stringdefs	= {0.009, 0.009}
		-- uvhf_freq_scolon.controllers	= {{"RCP_Dot"}}
-- Add_Radio_Element(uvhf_freq_scolon)

-- local	uvhf_freq_right				= CreateElement "ceStringPoly"
		-- uvhf_freq_right.name		= "uvhf_freq_right"
		-- uvhf_freq_right.material	= UVHF_font_base
		-- uvhf_freq_right.init_pos	= {0.37, 0.97, 0}
		-- uvhf_freq_right.alignment	= "LeftCenter"
		-- uvhf_freq_right.value		= "500"
		-- uvhf_freq_right.stringdefs	= {0.009, 0.009}
		-- uvhf_freq_right.controllers	= {{"RCP_FreqDe"}}
-- Add_Radio_Element(uvhf_freq_right)

-- ACNIP
local	acnip_1_label_mode				= CreateElement "ceStringPoly"
		acnip_1_label_mode.name			= "acnip_1_label_mode"
		acnip_1_label_mode.material		= UVHF_font_chnl
		acnip_1_label_mode.init_pos		= {-0.75, -0.75, 0}
		acnip_1_label_mode.alignment	= "CenterCenter"
		acnip_1_label_mode.value		= "MODE"
		acnip_1_label_mode.stringdefs	= {0.005, 0.005}
		acnip_1_label_mode.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_1_label_mode)

local	acnip_1_mode				= CreateElement "ceStringPoly"
		acnip_1_mode.name			= "acnip_1_mode"
		acnip_1_mode.material		= UVHF_font_chnl
		acnip_1_mode.init_pos		= {-0.75, -0.85, 0}
		acnip_1_mode.alignment		= "CenterCenter"
		acnip_1_mode.value			= "PLN"
		acnip_1_mode.stringdefs		= {0.005, 0.005}
		acnip_1_mode.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_1_mode)

local	acnip_1_label_code				= CreateElement "ceStringPoly"
		acnip_1_label_code.name			= "acnip_1_label_code"
		acnip_1_label_code.material		= UVHF_font_chnl
		acnip_1_label_code.init_pos		= {-0.75, -0.97, 0}
		acnip_1_label_code.alignment	= "CenterCenter"
		acnip_1_label_code.value		= "CODE"
		acnip_1_label_code.stringdefs	= {0.005, 0.005}
		acnip_1_label_code.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_1_label_code)

local	acnip_1_code				= CreateElement "ceStringPoly"
		acnip_1_code.name			= "acnip_1_code"
		acnip_1_code.material		= UVHF_font_chnl
		acnip_1_code.init_pos		= {-0.75, -1.07, 0}
		acnip_1_code.alignment		= "CenterCenter"
		acnip_1_code.value			= "00"
		acnip_1_code.stringdefs		= {0.005, 0.005}
		acnip_1_code.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_1_code)

local	acnip_2_label_mode				= CreateElement "ceStringPoly"
		acnip_2_label_mode.name			= "acnip_2_label_mode"
		acnip_2_label_mode.material		= UVHF_font_chnl
		acnip_2_label_mode.init_pos		= {-0.45, -0.75, 0}
		acnip_2_label_mode.alignment	= "CenterCenter"
		acnip_2_label_mode.value		= "MODE"
		acnip_2_label_mode.stringdefs	= {0.005, 0.005}
		acnip_2_label_mode.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_2_label_mode)

local	acnip_2_mode				= CreateElement "ceStringPoly"
		acnip_2_mode.name			= "acnip_2_mode"
		acnip_2_mode.material		= UVHF_font_chnl
		acnip_2_mode.init_pos		= {-0.45, -0.85, 0}
		acnip_2_mode.alignment		= "CenterCenter"
		acnip_2_mode.value			= "CY"
		acnip_2_mode.stringdefs		= {0.005, 0.005}
		acnip_2_mode.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_2_mode)

local	acnip_2_label_code				= CreateElement "ceStringPoly"
		acnip_2_label_code.name			= "acnip_2_label_code"
		acnip_2_label_code.material		= UVHF_font_chnl
		acnip_2_label_code.init_pos		= {-0.45, -0.97, 0}
		acnip_2_label_code.alignment	= "CenterCenter"
		acnip_2_label_code.value		= "CODE"
		acnip_2_label_code.stringdefs	= {0.005, 0.005}
		acnip_2_label_code.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_2_label_code)

local	acnip_2_code				= CreateElement "ceStringPoly"
		acnip_2_code.name			= "acnip_2_code"
		acnip_2_code.material		= UVHF_font_chnl
		acnip_2_code.init_pos		= {-0.45, -1.07, 0}
		acnip_2_code.alignment		= "CenterCenter"
		acnip_2_code.value			= "03"
		acnip_2_code.stringdefs		= {0.005, 0.005}
		acnip_2_code.controllers	= {{"ACNIP_Enabled"}}
Add_Radio_Element(acnip_2_code)

