dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()
grid_origin.controllers = {{"vdi_visible"}}

local ase_circle 			= my_create_textured_box_2k(766,68,345,345,938,242,2048/826)
	ase_circle.name 	= create_guid_string()
	ase_circle.material = "VDI_VDARKGREEN_MAT"
	ase_circle.init_pos = {0, 0, 0}
	ase_circle.parent_element = grid_origin.name
    ase_circle.controllers 		= {{"vdi_ase"}}
    ase_circle.isdraw = false
AddElement(ase_circle, false)

local range_bar_origin = create_origin()
range_bar_origin.controllers = {{"range_bar"},{"vdi_visible"}}

local range_bar = my_create_textured_box_2k(320,105,16,486,nil,nil,0.6*2048/486)
    range_bar.name 	= create_guid_string()
    range_bar.material = "VDI_WHITE_MAT"
    range_bar.init_pos = {0, 0, 0}
    range_bar.parent_element = range_bar_origin.name
AddElement(range_bar, false)

local target_rmin = my_create_textured_box_2k(341,305,35,14,347,311,0.6*2048/486)
    target_rmin.name = create_guid_string()
    target_rmin.material = "VDI_WHITE_MAT"
    target_rmin.init_pos = {0, -0.6, 0}
    target_rmin.parent_element = range_bar.name
    target_rmin.controllers = {{"vdi_dlz", 0, -0.6, 0.6}}
AddElement(target_rmin, false)

local target_rmax = my_create_textured_box_2k(341,305,35,14,347,311,0.6*2048/486)
    target_rmax.name = create_guid_string()
    target_rmax.material = "VDI_WHITE_MAT"
    target_rmax.init_pos = {0, 0.4, 0}
    target_rmax.parent_element = range_bar.name
    target_rmax.controllers = {{"vdi_dlz", 1, -0.6, 0.6}}
AddElement(target_rmax, false)

local target_range = my_create_textured_box_2k(257,345,57,16,308,353,0.6*2048/486)
    target_range.name = create_guid_string()
    target_range.material = "VDI_WHITE_MAT"
    target_range.init_pos = {0, -0.1, 0}
    target_range.parent_element = range_bar.name
    target_range.controllers = {{"vdi_dlz", 2, -0.6, 0.6}}
AddElement(target_range, false)

local range_scale_str           = CreateElement "ceStringPoly"
    range_scale_str.name            = create_guid_string()
    range_scale_str.material        = "font_VDI"
    range_scale_str.parent_element = grid_origin.name
    range_scale_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    range_scale_str.init_pos = {-0.675,-0.69}
    range_scale_str.alignment     = "CenterCenter"
    range_scale_str.controllers = {{"range_str"}}
    range_scale_str.isdraw = false
AddElement(range_scale_str, false)

local weapon_str           = CreateElement "ceStringPoly"
    weapon_str.name            = create_guid_string()
    weapon_str.material        = "font_VDI"
    weapon_str.parent_element = grid_origin.name
    weapon_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    weapon_str.init_pos = {0.675,-0.69}
    weapon_str.alignment     = "CenterCenter" -- so that master arm off X is centered on this too
    weapon_str.controllers 		= {{"vdi_weapon"}}
    weapon_str.isdraw = false
    weapon_str.value = "SW"
AddElement(weapon_str, false)

local weapon_count_str           = CreateElement "ceStringPoly"
    weapon_count_str.name            = create_guid_string()
    weapon_count_str.material        = "font_VDI"
    weapon_count_str.parent_element = grid_origin.name
    weapon_count_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    weapon_count_str.init_pos = {0.78,-0.69}
    weapon_count_str.alignment     = "LeftCenter"
    weapon_count_str.controllers 		= {{"vdi_weapon_count"}}
    weapon_count_str.isdraw = false
AddElement(weapon_count_str, false)

-- TODO replace with texture
local master_arm_off           = CreateElement "ceStringPoly"
    master_arm_off.name            = create_guid_string()
    master_arm_off.material        = "font_VDI"
    master_arm_off.parent_element = grid_origin.name
    master_arm_off.stringdefs    = {0.14 * half_width, 0.14 * half_height, 0, 0}
    master_arm_off.init_pos = {0.675,-0.69}
    master_arm_off.alignment     = "CenterCenter"
    master_arm_off.controllers 		= {{"vdi_masterarm"}}
    master_arm_off.isdraw = false
    master_arm_off.value = "X"
AddElement(master_arm_off, false)

-- TODO replace with texture
-- TODO: D/L bright breakaway X (small) vs WCS bright breakaway X (large)
local breakaway           = CreateElement "ceStringPoly"
    breakaway.name            = create_guid_string()
    breakaway.material        = "font_VDI"
    breakaway.parent_element = grid_origin.name
    breakaway.stringdefs    = {0.8 * half_width, 0.8 * half_height, 0, 0}
    breakaway.alignment     = "CenterCenter"
    breakaway.controllers 		= {{"vdi_breakaway"}}
    breakaway.isdraw = false
    breakaway.value = "X"
AddElement(breakaway, false)

local tacan_from = my_create_textured_box_2k(141,226,35,406,nil,nil,0.5*2048/406)
	tacan_from.name = create_guid_string()
	tacan_from.material = "VDI_BLACK_MAT"
	tacan_from.parent_element = grid_origin.name
    tacan_from.controllers = {{"vdi_tacan",1}}
    tacan_from.isdraw = false
    tacan_from.init_pos = {0.0,0.2}
AddElement(tacan_from, false)

local tacan_to = my_create_textured_box_2k(141,226,35,406,nil,nil,0.5*2048/406)
	tacan_to.name = create_guid_string()
	tacan_to.material = "VDI_WHITE_MAT"
	tacan_to.parent_element = grid_origin.name
    tacan_to.controllers = {{"vdi_tacan",0}}
    tacan_to.isdraw = false
    tacan_to.init_pos = {0.0,0.2}
AddElement(tacan_to, false)

local vector_vert = my_create_textured_box_2k(1460,131,15,488,nil,nil,0.5*2048/420)
	vector_vert.name = create_guid_string()
	vector_vert.material = "VDI_WHITE_MAT"
	vector_vert.parent_element = grid_origin.name
    vector_vert.controllers = {{"vdi_pcd",0}}
    vector_vert.isdraw = true
AddElement(vector_vert, false)

local vector_horiz = my_create_textured_box_2k(1460,131,15,488,nil,nil,0.5*2048/420)
	vector_horiz.name = create_guid_string()
	vector_horiz.material = "VDI_WHITE_MAT"
	vector_horiz.parent_element = grid_origin.name
    vector_horiz.controllers = {{"vdi_pcd",1}}
    vector_horiz.isdraw = true
    vector_horiz.init_rot = {90}
AddElement(vector_horiz, false)

local steering_tee 			= my_create_textured_box_2k(84,1068,124,77,143,1134,2048/826)
	steering_tee.name 	= create_guid_string()
	steering_tee.material = "VDI_WHITE_MAT"
	steering_tee.init_pos = {0, 0, 0}
	steering_tee.parent_element = grid_origin.name
    steering_tee.controllers 		= {{"vdi_steering"}}
    steering_tee.isdraw = false
AddElement(steering_tee, false)

-- aircraft reticle and airspeed&altitude reference marks
local aircraft_reticle_reference 			= my_create_textured_box_2k(527,418,826,39,938,428,2048/826)
	aircraft_reticle_reference.name 	= create_guid_string()
	aircraft_reticle_reference.material = "VDI_WHITE_MAT"
	aircraft_reticle_reference.init_pos = {0, 0, 0}
	aircraft_reticle_reference.parent_element = grid_origin.name
AddElement(aircraft_reticle_reference, false)

-- TODO: D/L command altitude & command altitude error
-- TODO: D/L command airspeed & command airspeed error
