dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."PCA_PPA/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

SRC_PCA_UR_BASE	= 0
SRC_PCA_UR		= 1

page_subsets = {
	[SRC_PCA_UR_BASE]	= my_path.."PCA_UR_base.lua",
	[SRC_PCA_UR]	= my_path.."PCA_UR.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_PCA_UR_BASE,SRC_PCA_UR},
}

init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

brightness_sensitive_materials = { "pca_gauge_font", }
