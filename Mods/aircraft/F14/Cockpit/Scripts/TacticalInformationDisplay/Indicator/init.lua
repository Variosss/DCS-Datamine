dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")

--local __USE_SCREENSPACE = true

indicator_type = indicator_types.COMMON
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
TCS = 2
TID = 3
EXTRA = 4
LANTIRN = 5

page_subsets= {
	[BASE]		= LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/base_page.lua",
	[TCS]= LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/tcs_page.lua",
	[TID]= LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/tid_page.lua",
	[EXTRA]= LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/extra_page.lua",
	[LANTIRN]= LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/lantirn_page.lua",
}

pages =
{
    {BASE}, -- page 1
    {BASE, TCS}, -- page 2
    {BASE, TID}, -- page 3
    {BASE, EXTRA}, -- page 4
    {BASE, LANTIRN}, -- page 5
}

opacity_sensitive_materials =
{
"TID_MAT","TID_MAT2","font_TID","TCS_WHITE_MAT_TID", "LANTIRN_MAT_TID", "font_LANTIRN_TID", "TID_ASE_COLOR", "TID_NAVGRID_COLOR"
}

color_sensitive_materials =
{
"TID_MAT","TID_MAT2","font_TID","TCS_WHITE_MAT_TID", "LANTIRN_MAT_TID", "font_LANTIRN_TID", "TID_ASE_COLOR", "TID_NAVGRID_COLOR"
}

brightness_sensitive_materials =
{
"TID_MAT","TID_MAT2","font_TID","TCS_WHITE_MAT_TID", "LANTIRN_MAT_TID", "font_LANTIRN_TID", "TID_ASE_COLOR", "TID_NAVGRID_COLOR"
}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("F14_TID")
