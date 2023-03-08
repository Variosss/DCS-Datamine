dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."PCA_PPA/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

SRC_PPA_BASE	= 0
SRC_PPA			= 1

page_subsets = {
	[SRC_PPA_BASE]	= my_path.."PPA_base.lua",
	[SRC_PPA]		= my_path.."PPA_display.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_PPA_BASE,SRC_PPA},
}

init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

brightness_sensitive_materials = { "PPA_gauge_font", }
