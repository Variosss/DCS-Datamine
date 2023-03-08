dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

--__USE_SCREENSPACE = true

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 1;

-------PAGE IDs-------
id_Page =
{
	EMPTY = 0,
	TCS = 1,
	LANTIRN = 2,
}

id_pagesubset =
{
	BASE = 0,
	TCS   = 1,
	LANTIRN   = 2,
}

page_subsets = {}
page_subsets[id_pagesubset.BASE] = LockOn_Options.script_path.."Scripts/VideoExport/base_page.lua"
page_subsets[id_pagesubset.TCS] = LockOn_Options.script_path.."Scripts/VideoExport/tcs_page.lua"
page_subsets[id_pagesubset.LANTIRN] = LockOn_Options.script_path.."Scripts/VideoExport/lantirn_page.lua"
  	
----------------------
pages = {}
pages[id_Page.EMPTY] = { }
pages[id_Page.TCS] = { id_pagesubset.BASE, id_pagesubset.TCS }
pages[id_Page.LANTIRN] = { id_pagesubset.BASE, id_pagesubset.LANTIRN}
init_pageID     = id_Page.EMPTY
