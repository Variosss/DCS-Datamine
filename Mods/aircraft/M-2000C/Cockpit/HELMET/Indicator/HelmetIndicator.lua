dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type		= indicator_types.HELMET	-- center of indicator will always be positioned on camera  axis
purposes 	 		= {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

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
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."HELMET/Indicator/HelmetIndicator_page.lua"
  	
----------------------
pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON}
init_pageID     = id_Page.MAIN
