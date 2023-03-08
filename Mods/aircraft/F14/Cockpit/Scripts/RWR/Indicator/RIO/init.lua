dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

end
-------------------------------------------------------------------------------------------z

-------PAGE IDs-------
PAGE_BASE 		= 1
PAGE_MAIN 		= 2
PAGE_BIT1		= 3
PAGE_BIT27		= 4
PAGE_BIT8		= 5

page_subsets= {
	[PAGE_BASE]		= LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/BASE_page.lua" ,
	[PAGE_MAIN]		= LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/RWR_page.lua" ,
	[PAGE_BIT1]		= LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/BIT_page_1.lua" ,
	[PAGE_BIT27]	= LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/BIT_page_2-7.lua" ,
	[PAGE_BIT8]		= LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/BIT_page_8.lua" ,
}

pages =
{
    {PAGE_BASE}, -- page 1
    {PAGE_MAIN}, -- page 2
	{PAGE_BIT1}, -- page 3
    {PAGE_BIT27}, -- page 4
	{PAGE_BIT8}, -- page 5
}

init_pageID     = PAGE_MAIN
