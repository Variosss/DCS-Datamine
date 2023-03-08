dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."EVF/"

indicator_type = indicator_types.COMMON

page_subsets = { [0] = my_path.."EVF.lua" }
pages = { [0] = {0} }
init_pageID			= 0

--Use the same font as PCN
opacity_sensitive_materials = { "evf_lcd_font" }
