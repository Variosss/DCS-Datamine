dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local breakaway           = CreateElement "ceStringPoly"
    breakaway.name            = create_guid_string()
    breakaway.material        = "font_VDI"
    breakaway.parent_element = grid_origin.name
    breakaway.stringdefs    = {0.8 * half_width, 0.8 * half_height, 0, 0}
    breakaway.alignment     = "CenterCenter"
    breakaway.isdraw = true
    breakaway.value = "X"
AddElement(breakaway, false)

