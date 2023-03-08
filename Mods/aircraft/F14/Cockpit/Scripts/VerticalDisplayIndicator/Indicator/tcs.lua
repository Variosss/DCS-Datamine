dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)

half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

TV_LEVEL = VDI_DEFAULT_LEVEL

TCS_FX_MATERIAL_NAME = "TCSMaterialVDI"
TCS_MATERIAL_NAME = "TCS_WHITE_MAT_VDI"

dofile(general_page_path.."tcs_page.lua")
