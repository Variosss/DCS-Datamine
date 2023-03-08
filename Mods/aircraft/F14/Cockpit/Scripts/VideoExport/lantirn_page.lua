dofile(LockOn_Options.script_path.."Scripts/VideoExport/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

LANTIRN_FX_MATERIAL_NAME = "LANTIRNMaterialExport"
LANTIRN_MATERIAL_NAME = "LANTIRN_MAT_EXPORT"
LANTIRN_FONT_MATERIAL = "font_LANTIRN_EXPORT"

TV_LEVEL = VIDEO_EXPORT_DEFAULT_LEVEL

SetCustomScale(GetScale()*0.833)

forced_mask_shrink = 1.0

VIDEO_EXPORT = true

dofile(general_page_path.."lantirn_page.lua")
