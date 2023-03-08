dofile(LockOn_Options.common_script_path.."devices_defs.lua")
local my_path = LockOn_Options.script_path.."FUEL/"

indicator_type = indicator_types.COMMON

PAGE_0		= 0

FUEL_BASE	= 0
FUEL_0		= 1

page_subsets = {
	[FUEL_BASE] = my_path.."FUEL_base.lua",
	[FUEL_0]	= my_path.."FUEL_gauge.lua",
}

----------------------
pages = {
	[PAGE_0]	= {FUEL_BASE,FUEL_0},
}

init_pageID		= PAGE_0

collimator_default_distance_factor = {0.6,0,0}

brightness_sensitive_materials	= { "fuel_gauge_font", }
