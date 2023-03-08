-- RADIO OUTPUT

-- A: Radio 1
local	ufc_chnl_1_m				= CreateElement "ceStringPoly"
		ufc_chnl_1_m.name			= "ufc_chnl_1_m"
		ufc_chnl_1_m.material		= ufc_font_base
		ufc_chnl_1_m.init_pos		= {-0.65, -0.6, 0}
		ufc_chnl_1_m.alignment		= "RightCenter"
		ufc_chnl_1_m.formats		= {"%s"}
		ufc_chnl_1_m.stringdefs		= RADIO_default_font_size
		ufc_chnl_1_m.controllers	= {{"radio_1_chnl"}}
Add_UFC_Element(ufc_chnl_1_m)

-- B: Radio 2
local	ufc_chnl_2_m				= CreateElement "ceStringPoly"
		ufc_chnl_2_m.name			= "ufc_chnl_2_m"
		ufc_chnl_2_m.material		= ufc_font_base
		ufc_chnl_2_m.init_pos		= {1.011, -0.6, 0}
		ufc_chnl_2_m.alignment		= "RightCenter"
		ufc_chnl_2_m.formats		= {"%s"}
		ufc_chnl_2_m.stringdefs		= RADIO_default_font_size
		ufc_chnl_2_m.controllers	= {{"radio_2_chnl"}}
Add_UFC_Element(ufc_chnl_2_m)
