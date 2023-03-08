dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local weapon_str           = CreateElement "ceStringPoly"
    weapon_str.name            = create_guid_string()
    weapon_str.material        = "font_VDI"
    weapon_str.parent_element = grid_origin.name
    weapon_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    weapon_str.init_pos = {0.675,-0.69}
    weapon_str.alignment     = "CenterCenter" -- so that master arm off X is centered on this too
    weapon_str.isdraw = true
    weapon_str.value = "SW"
AddElement(weapon_str, false)

local weapon_count_str           = CreateElement "ceStringPoly"
    weapon_count_str.name            = create_guid_string()
    weapon_count_str.material        = "font_VDI"
    weapon_count_str.parent_element = grid_origin.name
    weapon_count_str.stringdefs    = {0.09 * half_width, 0.09 * half_height, 0, 0}
    weapon_count_str.init_pos = {0.78,-0.69}
    weapon_count_str.alignment     = "LeftCenter"
    weapon_count_str.value = "4"
    weapon_count_str.isdraw = true
AddElement(weapon_count_str, false)

-- TODO replace with texture
local master_arm_off           = CreateElement "ceStringPoly"
    master_arm_off.name            = create_guid_string()
    master_arm_off.material        = "font_VDI"
    master_arm_off.parent_element = grid_origin.name
    master_arm_off.stringdefs    = {0.14 * half_width, 0.14 * half_height, 0, 0}
    master_arm_off.init_pos = {0.675,-0.69}
    master_arm_off.alignment     = "CenterCenter"
    master_arm_off.isdraw = true
    master_arm_off.value = "X"
AddElement(master_arm_off, false)

