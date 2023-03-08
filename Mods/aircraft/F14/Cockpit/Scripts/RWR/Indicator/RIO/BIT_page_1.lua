dofile(LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/definitions.lua")

local screen_origin = create_origin()
screen_origin.init_pos = {cx, cy}

local grid_origin = create_origin()
grid_origin.parent_element = screen_origin.name
grid_origin.controllers = {{"RWR_display_RIO"}}

local bit_failure_v_str           = CreateElement "ceStringPoly"
	bit_failure_v_str.name            = create_guid_string()
	bit_failure_v_str.material        = "font_RWR"
	bit_failure_v_str.parent_element = grid_origin.name
	bit_failure_v_str.stringdefs    = {RWR_fontsize_y, RWR_fontsize_x, 0, 0.0056}
	bit_failure_v_str.init_pos = {0,0}
	bit_failure_v_str.alignment     = "CenterCenter"
	bit_failure_v_str.controllers = {{"RWR_bit_string"},{"RWR_brightness_RIO"}}
	bit_failure_v_str.value 			= "C\nS\nA\nL\nT"
AddRwrElement(bit_failure_v_str)

local bit_lib_ver_str           = CreateElement "ceStringPoly"
	bit_lib_ver_str.name            = create_guid_string()
	bit_lib_ver_str.material        = "font_RWR"
	bit_lib_ver_str.parent_element = grid_origin.name
	bit_lib_ver_str.stringdefs    = RWR_string_def
	bit_lib_ver_str.init_pos = {0,0.35*size}
	bit_lib_ver_str.alignment     = "CenterCenter"
	bit_lib_ver_str.controllers = {{"RWR_bit_library_ver"},{"RWR_brightness_RIO"}}
AddRwrElement(bit_lib_ver_str)

local bit_software_ver_str           = CreateElement "ceStringPoly"
	bit_software_ver_str.name            = create_guid_string()
	bit_software_ver_str.material        = "font_RWR"
	bit_software_ver_str.parent_element = grid_origin.name
	bit_software_ver_str.stringdefs    = RWR_string_def
	bit_software_ver_str.init_pos = {0,-0.35*size}
	bit_software_ver_str.alignment     = "CenterCenter"
	bit_software_ver_str.controllers = {{"RWR_brightness_RIO"}}
	bit_software_ver_str.value 			= "H1"
AddRwrElement(bit_software_ver_str)

local bit_config_str           = CreateElement "ceStringPoly"
	bit_config_str.name            = create_guid_string()
	bit_config_str.material        = "font_RWR"
	bit_config_str.parent_element = grid_origin.name
	bit_config_str.stringdefs    = RWR_string_def
	bit_config_str.init_pos = {-0.35*0.39*size,-0.35*0.92*size}
	bit_config_str.alignment     = "CenterCenter"
	bit_config_str.controllers = {{"RWR_brightness_RIO"}}
	bit_config_str.value 			= "14"
AddRwrElement(bit_config_str)

local bit_receiver_mode           = CreateElement "ceStringPoly"
	bit_receiver_mode.name            = create_guid_string()
	bit_receiver_mode.material        = "font_RWR"
	bit_receiver_mode.parent_element = grid_origin.name
	bit_receiver_mode.stringdefs    = RWR_string_def
	bit_receiver_mode.init_pos = {0.35*0.39*size,-0.35*0.92*size}
	bit_receiver_mode.alignment     = "CenterCenter"
	bit_receiver_mode.controllers = {{"RWR_brightness_RIO"}}
	bit_receiver_mode.value 			= "A"
AddRwrElement(bit_receiver_mode)


local bit_status_45           = CreateElement "ceStringPoly"
	bit_status_45.name            = create_guid_string()
	bit_status_45.material        = "font_RWR"
	bit_status_45.parent_element = grid_origin.name
	bit_status_45.stringdefs    = RWR_string_def
	bit_status_45.init_pos = {0.23*size,0.23*size}
	bit_status_45.alignment     = "CenterCenter"
	bit_status_45.controllers = {{"RWR_bit_rcvr_flag",0},{"RWR_brightness_RIO"}}
	bit_status_45.value 			= "R"
AddRwrElement(bit_status_45)

local bit_status_135           = CreateElement "ceStringPoly"
	bit_status_135.name            = create_guid_string()
	bit_status_135.material        = "font_RWR"
	bit_status_135.parent_element = grid_origin.name
	bit_status_135.stringdefs    = RWR_string_def
	bit_status_135.init_pos = {0.23*size,-0.23*size}
	bit_status_135.alignment     = "CenterCenter"
	bit_status_135.controllers = {{"RWR_bit_rcvr_flag",1},{"RWR_brightness_RIO"}}
	bit_status_135.value 			= "R"
AddRwrElement(bit_status_135)

local bit_status_225           = CreateElement "ceStringPoly"
	bit_status_225.name            = create_guid_string()
	bit_status_225.material        = "font_RWR"
	bit_status_225.parent_element = grid_origin.name
	bit_status_225.stringdefs    = RWR_string_def
	bit_status_225.init_pos = {-0.23*size,-0.23*size}
	bit_status_225.alignment     = "CenterCenter"
	bit_status_225.controllers = {{"RWR_bit_rcvr_flag",2},{"RWR_brightness_RIO"}}
	bit_status_225.value 			= "R"
AddRwrElement(bit_status_225)

local bit_status_315           = CreateElement "ceStringPoly"
	bit_status_315.name            = create_guid_string()
	bit_status_315.material        = "font_RWR"
	bit_status_315.parent_element = grid_origin.name
	bit_status_315.stringdefs    = RWR_string_def
	bit_status_315.init_pos = {-0.23*size,0.23*size}
	bit_status_315.alignment     = "CenterCenter"
	bit_status_315.controllers = {{"RWR_bit_rcvr_flag",3},{"RWR_brightness_RIO"}}
	bit_status_315.value 			= "R"
AddRwrElement(bit_status_315)
