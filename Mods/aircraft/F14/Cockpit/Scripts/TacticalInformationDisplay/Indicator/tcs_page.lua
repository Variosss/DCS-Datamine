dofile(LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = TID_DEFAULT_LEVEL

SetCustomScale(GetScale()*0.8)
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

TV_LEVEL = TID_DEFAULT_LEVEL

TCS_FX_MATERIAL_NAME = "TCSMaterialTID"
TCS_MATERIAL_NAME = "TCS_WHITE_MAT_TID"

dofile(general_page_path.."tcs_page.lua")
