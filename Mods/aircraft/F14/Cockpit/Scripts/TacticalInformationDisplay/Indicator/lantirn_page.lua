dofile(LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = TID_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

SetCustomScale(GetScale()*0.833)

LANTIRN_FX_MATERIAL_NAME = "LANTIRNMaterialTID"
LANTIRN_MATERIAL_NAME = "LANTIRN_MAT_TID"
LANTIRN_FONT_MATERIAL = "font_LANTIRN_TID"

TV_LEVEL = TID_DEFAULT_LEVEL

dofile(general_page_path.."lantirn_page.lua")
