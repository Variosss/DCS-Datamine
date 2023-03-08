dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON----------------------
init_pageID     = 2
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
--subset ids
BASE    = 1
RADARTEST2 = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."Radar/Indicator/base_page.lua",
[RADARTEST2] = LockOn_Options.script_path.."Radar/Indicator/radar.lua",
}
pages = 
{
	{
	 BASE,
	 RADARTEST2
	 },
}

