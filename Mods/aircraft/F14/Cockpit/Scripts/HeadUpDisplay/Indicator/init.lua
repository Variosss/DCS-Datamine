dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

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
HUD_MAIN = 2
HUD_TEST1 = 3
HUD_TEST2 = 4
HUD_TEST3 = 5
HUD_TEST4 = 6
GLOW = 7

page_subsets= {
	[BASE]		= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/base_page.lua",
	[HUD_MAIN]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/indication_page.lua",
	[HUD_TEST1]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/test_page1.lua",
	[HUD_TEST2]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/test_page2.lua",
	[HUD_TEST3]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/test_page3.lua",
	[HUD_TEST4]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/test_page4.lua",
	[GLOW]= LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/glow_page.lua",
}

pages = 
{
	{BASE },  -- page 1 (off)
	{BASE, HUD_MAIN, GLOW },  -- page 2
	{BASE, HUD_TEST1, GLOW },  -- page 3
	{BASE, HUD_TEST2, GLOW },  -- page 4
	{BASE, HUD_TEST3, GLOW },  -- page 5
	{BASE, HUD_TEST4, GLOW },  -- page 6
}

opacity_sensitive_materials =
{
"HUD_MAT",
"HUD_MAT2",
"HUD_GLOW_C",
"HUD_GLOW_NC",
}

color_sensitive_materials =
{
"HUD_MAT",
"HUD_MAT2",
"HUD_GLOW_C",
"HUD_GLOW_NC",
}

brightness_sensitive_materials =
{
"HUD_MAT",
"HUD_MAT2",
"HUD_GLOW_C",
"HUD_GLOW_NC",
}
