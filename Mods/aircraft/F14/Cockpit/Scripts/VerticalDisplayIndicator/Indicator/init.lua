dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")

--local __USE_SCREENSPACE = true

indicator_type = indicator_types.COMMON
init_pageID = 2
purposes = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

indicator_type       = indicator_types.COMMON
purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
screenspace_scale    = 4;

end
-------------------------------------------------------------------------------------------

BASE = 1
INDICATION = 2
TCS = 3
OVERLAY = 4
OVERLAY_MASK = 5
VDI_FOV = 6
LANTIRN = 7
TEST1 = 8
TEST2 = 9
TEST3 = 10
TEST4 = 11
OVERLAY_BORKED = 12

page_subsets= {
	[BASE]		= LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/base_page.lua",
	[INDICATION]= LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/indication_page.lua",
    [TCS] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/tcs.lua",
    [OVERLAY] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/overlay.lua",
	[OVERLAY_MASK] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/overlay_mask.lua",
	[OVERLAY_BORKED] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/overlay_borked.lua",
    [VDI_FOV] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/vdi_fov.lua",
    [LANTIRN]= LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/lantirn_page.lua",
    [TEST1] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/test_page1.lua",
    [TEST2] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/test_page2.lua",
    [TEST3] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/test_page3.lua",
    [TEST4] = LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/test_page4.lua",
}

pages =
{
    {BASE, OVERLAY_MASK }, -- page 1  (off)
    {BASE, INDICATION, VDI_FOV, OVERLAY, OVERLAY_MASK}, -- page 2
    {BASE, TCS, OVERLAY, OVERLAY_MASK}, -- page 3
    {BASE, LANTIRN, OVERLAY_MASK}, -- page 4
    {BASE, TEST1, OVERLAY, OVERLAY_MASK}, -- page 5
    {BASE, TEST2, OVERLAY, OVERLAY_MASK}, -- page 6
    {BASE, TEST3, OVERLAY, OVERLAY_MASK}, -- page 7
    {BASE, TEST4, OVERLAY, OVERLAY_MASK}, -- page 8
	{BASE, INDICATION, VDI_FOV, OVERLAY_BORKED, OVERLAY_MASK}, -- page 9, ADI broken
}

opacity_sensitive_materials =
{
"VDI_WHITE_MAT",
"VDI_BLACK_MAT",
"LIGHT_GREEN_MAT",
"DARK_GREEN_MAT",
"VDI_VDARKGREEN_MAT",
"TCS_WHITE_MAT_VDI",
"VDI_CRT_TEX_MAT",
"VDI_CRT_TEX_BORKED",
"LANTIRN_MAT_VDI",
"font_LANTIRN_VDI",
"font_VDI",
}

color_sensitive_materials =
{
"VDI_WHITE_MAT",
"VDI_BLACK_MAT",
"LIGHT_GREEN_MAT",
"DARK_GREEN_MAT",
"VDI_VDARKGREEN_MAT",
"TCS_WHITE_MAT_VDI",
"VDI_CRT_TEX_MAT",
"VDI_CRT_TEX_BORKED",
"LANTIRN_MAT_VDI",
"font_LANTIRN_VDI",
"font_VDI",
}

brightness_sensitive_materials =
{
"VDI_WHITE_MAT",
"VDI_BLACK_MAT",
"LIGHT_GREEN_MAT",
"DARK_GREEN_MAT",
"VDI_VDARKGREEN_MAT",
"TCS_WHITE_MAT_VDI",
"VDI_CRT_TEX_MAT",
"VDI_CRT_TEX_BORKED",
"LANTIRN_MAT_VDI",
"font_LANTIRN_VDI",
"font_VDI",
}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("F14_VDI")
