-- init
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

 -- __USE_SCREENSPACE = 1

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW} --{render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

end
-------------------------------------------------------------------------------------------

------PAGE IDs-------
PAGE_MAIN 		= 1

page_subsets= 
{
	[PAGE_MAIN]		= LockOn_Options.script_path.."Scripts/EGIT/RPM/BASE_page.lua" ,
}

pages =
{
    {PAGE_MAIN}, 
}

init_pageID     = PAGE_MAIN