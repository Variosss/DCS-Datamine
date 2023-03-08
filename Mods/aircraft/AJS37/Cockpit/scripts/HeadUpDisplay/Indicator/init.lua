--/N/ rev feb. 2014

dofile(LockOn_Options.common_script_path.."devices_defs.lua")

--local __USE_SCREENSPACE = true

indicator_type = indicator_types.COLLIMATOR
init_pageID = 1
purposes = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

end
-------------------------------------------------------------------------------------------

BASE= 1
INDICATION = 2

page_subsets= {
	[BASE]		= LockOn_Options.script_path.."HeadUpDisplay/Indicator/base_page.lua",
	[INDICATION]= LockOn_Options.script_path.."HeadUpDisplay/Indicator/indication_page.lua",
}

pages = 
{
	{
		BASE,
		INDICATION
	},
}