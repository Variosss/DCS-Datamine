dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
-------PAGE IDs-------
id_Page =
{
	MAIN = 0,
}

id_pagesubset =
{
	COMMON   = 0,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."AIHelper\\AIHelper_page.lua"

pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON}
init_pageID     = id_Page.MAIN


local x,y,w,h = get_UIMainView()

dedicated_viewport		  = {x,y,w,h}
dedicated_viewport_arcade = dedicated_viewport
