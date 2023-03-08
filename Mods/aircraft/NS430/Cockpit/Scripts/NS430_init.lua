dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL}--,render_purpose.HUD_ONLY_VIEW}  -- HUD will be rendered on hud only view 

local my_path = LockOn_Options.script_path

page_subsets = {
[1]			= my_path.."NS430_page.lua",
}
pages = {
[1]			= {1}
}

-- set this page on start 
init_pageID			= 1