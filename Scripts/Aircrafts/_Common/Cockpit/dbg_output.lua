dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON
-------PAGE IDs-------
page_subsets 	= {LockOn_Options.common_script_path.."dbg_output_page.lua"}
----------------------
pages 			= {{1}}
init_pageID     = 1
purposes 	 	 		   = {render_purpose.HUD_ONLY_VIEW,
							  render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,
							  render_purpose.SCREENSPACE_INSIDE_COCKPIT}

dedicated_viewport 	      = {0,0,768,768}
dedicated_viewport_arcade = dedicated_viewport
