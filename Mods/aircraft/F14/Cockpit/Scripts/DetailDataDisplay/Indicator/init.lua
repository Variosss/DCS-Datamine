dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

indicator_type = indicator_types.COMMON
init_pageID = 1
purposes = {render_purpose.GENERAL}

BASE= 1
DDDMAT = 2

page_subsets= {
    [BASE]		= LockOn_Options.script_path.."Scripts/DetailDataDisplay/Indicator/base_page.lua",
    [DDDMAT]= LockOn_Options.script_path.."Scripts/DetailDataDisplay/Indicator/indication_page.lua",
}

pages = 
{
    {BASE},  -- page 1
    {BASE, DDDMAT},  -- page 2
}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
try_find_assigned_viewport("F14_DDD")
