dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
--purposes 	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW} 
purposes	   = {100} -- direct render disabled

-------PAGE IDs-------
PAGE_OFF			= 0
PAGE_MAIN			= 1
PAGE_TEST			= 2

--Source files for page subsets
SRC_ALR_300_BACK	= 0
SRC_ALR_300_MAIN	= 1
SRC_ALR_300_TEST	= 2

--subsets declare lua indication source files which will be used to combines pages 
local my_path = LockOn_Options.script_path.."../../Common/ALR_300/Indicator/"

page_subsets = {
[SRC_ALR_300_BACK]		= my_path.."ALR_300_back.lua",
[SRC_ALR_300_MAIN] 		= my_path.."ALR_300_main.lua",
[SRC_ALR_300_TEST] 		= my_path.."ALR_300_test.lua",
}

----------------------
pages = {
[PAGE_OFF]				= {SRC_ALR_300_BACK},
[PAGE_MAIN]				= {SRC_ALR_300_BACK, SRC_ALR_300_MAIN},
[PAGE_TEST]				= {SRC_ALR_300_BACK, SRC_ALR_300_TEST},
}
-- set this page on start 
init_pageID				= PAGE_OFF
