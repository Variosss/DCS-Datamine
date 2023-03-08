dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."PCN/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0
SRC_PCN_UR	= 0

page_subsets = {
	[SRC_PCN_UR]		= my_path.."PCN_UR.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_PCN_UR},
}

init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

opacity_sensitive_materials = { "pcn_gauge_font" }
