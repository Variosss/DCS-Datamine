dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."AOA/"

indicator_type = indicator_types.COMMON

page_subsets = { [0] = my_path.."AOA_base.lua" }
pages = { [0] = {0} }
init_pageID			= 0

brightness_sensitive_materials = { "SIMPLE_WHITE", "aoa_repeater" }