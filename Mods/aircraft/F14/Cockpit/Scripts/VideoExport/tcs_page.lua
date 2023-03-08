dofile(LockOn_Options.script_path.."Scripts/VideoExport/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL
TV_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL

dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

TCS_FX_MATERIAL_NAME = "TCSMaterialExport"

TCS_MATERIAL_NAME = "TCS_WHITE_MAT_EXPORT"

SetCustomScale(GetScale()*0.8)

VIDEO_EXPORT = true

dofile(general_page_path.."tcs_page.lua")
