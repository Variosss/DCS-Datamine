dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type     = indicator_types.COMMON
purposes 	 = {render_purpose.HUD_ONLY_VIEW,render_purpose.SCREENSPACE_INSIDE_COCKPIT}

-------PAGE IDs-------
id_Page =
{
	PAGE   = 0
}

id_pagesubset =
{
	COMMON			= 0
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON]			= LockOn_Options.common_script_path.."PADLOCK/PADLOCK_page.lua"
----------------------
pages = {}
pages[id_Page.PAGE] = {id_pagesubset.COMMON}

init_pageID		= id_Page.PAGE
use_parser		= false
