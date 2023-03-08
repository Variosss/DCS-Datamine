dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."HelperAI/HelperAI_page_common.lua")

local cross_size = 0.1
local compass_size = 0.25

create_and_add_elements(cross_size, compass_size, true)
