dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL}


id_pagesubset = {
    MAIN = 0
}
    
page_subsets = {
	[id_pagesubset.MAIN] = LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/FreqChart/base_page.lua"
}

pages = {
    {id_pagesubset.MAIN},
}


