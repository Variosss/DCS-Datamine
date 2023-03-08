dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type       = indicator_types.COMMON
init_pageID     = 1
purposes 	   = {render_purpose.HUD_ONLY_VIEW,render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.SCREENSPACE_OUTSIDE_COCKPIT}

--subset ids
BASE    = 1
INDICATION = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."EASYWEAPONS/Indicator/base_page.lua",
[INDICATION]    = LockOn_Options.script_path.."EASYWEAPONS/Indicator/ip",
}
pages = 
{
	{
	 BASE,
	 INDICATION
	 },
}


update_screenspace_diplacement(SelfWidth/SelfHeight,false)
dedicated_viewport_arcade = dedicated_viewport

