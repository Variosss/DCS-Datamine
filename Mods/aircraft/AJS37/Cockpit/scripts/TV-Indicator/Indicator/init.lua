dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type       = indicator_types.COMMON----------------------
init_pageID     = 2
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
--subset ids
BASE    = 1
FUSELAGE_LEFT_INV = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."TV-Indicator/Indicator/base_page.lua",
[FUSELAGE_LEFT_INV] = LockOn_Options.script_path.."TV-Indicator/Indicator/fuselage_left_inv.lua",
}
pages = 
{
	{
	 BASE,
	 FUSELAGE_LEFT_INV
	 },
}

