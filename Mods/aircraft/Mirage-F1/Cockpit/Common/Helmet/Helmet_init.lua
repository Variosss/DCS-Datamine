dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.HELMET
--purposes 	   = {render_purpose.SCREENSPACE_INSIDE_COCKPIT}
purposes 	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-------PAGE IDs-------
PAGE_MAIN		 = 0

SUB_HELMET_BASE = 0

--subsets declare lua indication source files which will be used to combines pages 
local my_path = LockOn_Options.script_path.."../../Common/Helmet/"

page_subsets = {
	[SUB_HELMET_BASE] = my_path .. "Helmet_base.lua",
}

----------------------
pages = {
	[PAGE_MAIN]	= {SUB_HELMET_BASE},
}
-- set this page on start 
init_pageID			= PAGE_MAIN
