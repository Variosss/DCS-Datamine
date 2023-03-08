dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local range_bar_origin = create_origin()
range_bar_origin.isdraw = true

local range_bar = my_create_textured_box_2k(320,105,16,486,nil,nil,0.6*2048/486)
    range_bar.name 	= create_guid_string()
    range_bar.material = "VDI_WHITE_MAT"
    range_bar.init_pos = {-0.5, 0, 0}
    range_bar.parent_element = range_bar_origin.name
    range_bar.isdraw = true
AddElement(range_bar, false)

local target_rmin = my_create_textured_box_2k(341,305,35,14,347,311,0.6*2048/486)
    target_rmin.name = create_guid_string()
    target_rmin.material = "VDI_WHITE_MAT"
    target_rmin.init_pos = {0, -0.6, 0}
    target_rmin.parent_element = range_bar.name
    target_rmin.isdraw = true
AddElement(target_rmin, false)

local target_rmax = my_create_textured_box_2k(341,305,35,14,347,311,0.6*2048/486)
    target_rmax.name = create_guid_string()
    target_rmax.material = "VDI_WHITE_MAT"
    target_rmax.init_pos = {0, 0.4, 0}
    target_rmax.parent_element = range_bar.name
    target_rmax.isdraw = true
AddElement(target_rmax, false)

local target_range = my_create_textured_box_2k(257,345,57,16,308,353,0.6*2048/486)
    target_range.name = create_guid_string()
    target_range.material = "VDI_WHITE_MAT"
    target_range.init_pos = {0, -0.1, 0}
    target_range.parent_element = range_bar.name
    target_range.isdraw = true
AddElement(target_range, false)

local range_scale_str           = CreateElement "ceStringPoly"
    range_scale_str.name            = create_guid_string()
    range_scale_str.material        = "font_VDI"
    range_scale_str.parent_element = range_bar_origin.name
    range_scale_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    range_scale_str.init_pos = {-0.675,-0.69}
    range_scale_str.alignment     = "CenterCenter"
    range_scale_str.value = "5"
    range_scale_str.isdraw = true
AddElement(range_scale_str, false)

