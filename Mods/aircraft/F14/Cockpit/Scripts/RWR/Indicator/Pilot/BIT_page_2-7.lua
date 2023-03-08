dofile(LockOn_Options.script_path.."Scripts/RWR/Indicator/Pilot/definitions.lua")

local screen_origin = create_origin()
screen_origin.init_pos = {cx, cy}

local grid_origin = create_origin()
grid_origin.parent_element = screen_origin.name
grid_origin.controllers = {{"RWR_display_pilot"}}

local bit_str           = CreateElement "ceStringPoly"
	bit_str.name            = create_guid_string()
	bit_str.material        = "font_RWR"
	bit_str.parent_element = grid_origin.name
	bit_str.stringdefs    = RWR_string_def_BIT
	bit_str.init_pos = {0,0}
	bit_str.alignment     = "CenterCenter"
	bit_str.controllers = {{"RWR_bit_string"},{"RWR_brightness_pilot"}}
AddRwrElement(bit_str)

local bit_str2           = CreateElement "ceStringPoly"
	bit_str2.name            = create_guid_string()
	bit_str2.material        = "font_RWR"
	bit_str2.parent_element = grid_origin.name
	bit_str2.stringdefs    = RWR_string_def_BIT
	bit_str2.init_pos = {0,0}
	bit_str2.alignment     = "CenterCenter"
	bit_str2.controllers = {{"RWR_bit_string2"},{"RWR_brightness_pilot"}}
	bit_str2.value 			= "\n\n .     . "
AddRwrElement(bit_str2)

local bit_str3           = CreateElement "ceStringPoly"
	bit_str3.name            = create_guid_string()
	bit_str3.material        = "font_RWR"
	bit_str3.parent_element = grid_origin.name
	bit_str3.stringdefs    = RWR_string_def_BIT
	bit_str3.init_pos = {0,0}
	bit_str3.alignment     = "CenterCenter"
	bit_str3.controllers = {{"RWR_bit_string2"},{"RWR_brightness_pilot"}}
	bit_str3.value 			= "\n\n    :  : "
AddRwrElement(bit_str3)
