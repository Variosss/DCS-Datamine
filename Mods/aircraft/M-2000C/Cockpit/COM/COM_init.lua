dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."COM/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

SRC_COM_BASE	= 0
SRC_PPA			= 1

page_subsets = {
	[SRC_COM_BASE]	= my_path.."COM_base.lua",
	[SRC_PPA]		= my_path.."COM_display.lua",
}

----------------------
pages = {
	[PAGE_0]		= {SRC_COM_BASE,SRC_PPA},
}

init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

brightness_sensitive_materials	= { "COM_gauge_font", "COM_greenbox_font", }
