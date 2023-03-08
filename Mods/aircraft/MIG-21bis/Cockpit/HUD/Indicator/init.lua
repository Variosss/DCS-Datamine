--/N/ rev feb. 2014

dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COLLIMATOR
init_pageID = 1
purposes = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW} --/N/ HUD_ONLY_VIEW will enable Alt+F1 view (no cockpit, HUD only)

BASE= 1
INDICATION = 2

page_subsets= {
	[BASE]		= LockOn_Options.script_path.."HUD/Indicator/base_page.lua",
	[INDICATION]= LockOn_Options.script_path.."HUD/Indicator/ip",
}

pages = 
{
	{
		BASE,
		INDICATION
	},
}