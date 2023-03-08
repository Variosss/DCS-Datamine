dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COMMON

purposes 	 = {render_purpose.HUD_ONLY_VIEW,render_purpose.SCREENSPACE_INSIDE_COCKPIT}

dedicated_viewport        = make_viewport(SelfWidth/SelfHeight,
										  false,--is_left
										  true ,--is_top,
										  nil,  -- default width be as half of screen height
										  -0.8) --  width - 0.8 * 64
dedicated_viewport_arcade = dedicated_viewport     
						  
-------PAGE IDs-------
id_Page =
{
	PAGE_NULL = 0,
	PAGE_OFF  = 1,
	PAGE_MAIN = 2
}

id_pagesubset =
{
	COMMON  = 0,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."CARGO_CAM\\CARGO_CAM_base_page.lua"
  	
----------------------
pages = {}
pages[id_Page.PAGE_MAIN] = { id_pagesubset.COMMON}

init_pageID     = id_Page.PAGE_MAIN

always_show_ground = false
--use_parser      = false
