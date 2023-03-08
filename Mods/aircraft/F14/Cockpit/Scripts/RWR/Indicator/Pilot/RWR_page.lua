dofile(LockOn_Options.script_path.."Scripts/RWR/Indicator/Pilot/definitions.lua")

local screen_origin = create_origin()
screen_origin.init_pos = {cx, cy}

local grid_origin = create_origin()
grid_origin.parent_element = screen_origin.name
grid_origin.controllers = {{"RWR_display_pilot"}}

function create_threat(num)
    local threat_origin = create_origin("RWR_threat_"..tostring(num))
    threat_origin.controllers = {{"RWR_threat_position",num,size}}
    threat_origin.parent_element = grid_origin.name
	threat_origin.init_pos = { 0, 0 }
	local threat_str           = CreateElement "ceStringPoly"
		threat_str.name            = create_guid_string()
		threat_str.material        = "font_RWR"
		threat_str.parent_element = threat_origin.name
		threat_str.stringdefs    = RWR_string_def
		threat_str.init_pos = {0,0}
		threat_str.alignment     = "CenterCenter"
		threat_str.controllers = {{"RWR_threat_string",num},{"RWR_brightness_pilot"}}
	AddRwrElement(threat_str)
	local threat_naval = my_create_textured_box_1k(470,872,228,148,nil,nil,0.200*size)
        threat_naval.name = create_guid_string()
        threat_naval.parent_element = threat_origin.name
		threat_naval.init_pos = {0,-0.022*size}
        threat_naval.controllers = {{"RWR_threat_naval",num},{"RWR_brightness_pilot"}}
        threat_naval.material = "RWR_MAT"
    AddRwrElement(threat_naval)
end

for i = 1, 15 do
	create_threat(i-1)
end

local category_str           = CreateElement "ceStringPoly"
	category_str.name            = create_guid_string()
	category_str.material        = "font_RWR"
	category_str.parent_element = grid_origin.name
	category_str.stringdefs    = RWR_string_def
	category_str.init_pos = {-status_dist,status_dist}
	category_str.alignment     = "CenterCenter"
	category_str.controllers = {{"RWR_category_string"},{"RWR_brightness_pilot"}}
AddRwrElement(category_str)

local mode_str           = CreateElement "ceStringPoly"
	mode_str.name            = create_guid_string()
	mode_str.material        = "font_RWR"
	mode_str.parent_element = grid_origin.name
	mode_str.stringdefs    = RWR_string_def
	mode_str.init_pos = {status_dist,status_dist}
	mode_str.alignment     = "CenterCenter"
	mode_str.controllers = {{"RWR_mode_string"},{"RWR_brightness_pilot"}}
AddRwrElement(mode_str)


local bit_str           = CreateElement "ceStringPoly"
	bit_str.name            = create_guid_string()
	bit_str.material        = "font_RWR"
	bit_str.parent_element = grid_origin.name
	bit_str.stringdefs    = RWR_string_def
	bit_str.init_pos = {0,-status_dist}
	bit_str.alignment     = "CenterCenter"
	bit_str.controllers = {{"RWR_system_status_string"},{"RWR_brightness_pilot"}}
AddRwrElement(bit_str)
