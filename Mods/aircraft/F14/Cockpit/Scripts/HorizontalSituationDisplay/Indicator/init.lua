dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL}

--local __USE_SCREENSPACE = true
-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then
    indicator_type       = indicator_types.COMMON
    purposes 	 = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
    screenspace_scale    = 4;
end
-------------------------------------------------------------------------------------------

local hsd_page_path = LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/"

id_Page = {
    PAGE_HSD_OFF = 0,
    PAGE_HSD_NAV_TACAN = 1,
    PAGE_HSD_NAV_DEST = 2,
    PAGE_HSD_NAV_VECT = 3,
    PAGE_HSD_NAV_MAN = 4,
    PAGE_HSD_NAV_AWL_PCD = 5,
    PAGE_HSD_TID_REPEAT = 6,
    PAGE_HSD_TEST = 7,
}

id_pagesubset = {
    HSD_OFF = 0,
    HSD_NAV_BASE = 1,
    HSD_NAV_TACAN = 2,
    HSD_NAV_DEST = 3,
    HSD_NAV_VECT = 4,
    HSD_NAV_MAN = 5,
    HSD_TEST = 6,
    HSD_TID = 7,
}
    
page_subsets = {
	[id_pagesubset.HSD_OFF]		= hsd_page_path.."base_page.lua",
	[id_pagesubset.HSD_NAV_BASE]= hsd_page_path.."nav_base_page.lua",
	[id_pagesubset.HSD_NAV_TACAN]= hsd_page_path.."nav_tacan_page.lua",
	[id_pagesubset.HSD_NAV_DEST]= hsd_page_path.."nav_dest_page.lua",
	[id_pagesubset.HSD_NAV_VECT]= hsd_page_path.."nav_vect_page.lua",
	[id_pagesubset.HSD_NAV_MAN]= hsd_page_path.."nav_man_page.lua",
	[id_pagesubset.HSD_TEST]= hsd_page_path.."test_page.lua",
	[id_pagesubset.HSD_TID]= hsd_page_path.."tid_page.lua",
}

pages = {
    [id_Page.PAGE_HSD_OFF] = {id_pagesubset.HSD_OFF},
    
    [id_Page.PAGE_HSD_NAV_TACAN] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_NAV_BASE, id_pagesubset.HSD_NAV_TACAN},
    [id_Page.PAGE_HSD_NAV_DEST] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_NAV_BASE, id_pagesubset.HSD_NAV_DEST},
    [id_Page.PAGE_HSD_NAV_VECT] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_NAV_BASE, id_pagesubset.HSD_NAV_VECT},
    [id_Page.PAGE_HSD_NAV_MAN] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_NAV_BASE, id_pagesubset.HSD_NAV_MAN},
    
    [id_Page.PAGE_HSD_NAV_AWL_PCD] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_NAV_BASE, id_pagesubset.HSD_NAV_TACAN},
    
    [id_Page.PAGE_HSD_TID_REPEAT] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_TID},
    
   
    [id_Page.PAGE_HSD_TEST] = {id_pagesubset.HSD_OFF, id_pagesubset.HSD_TEST},
    
}

-- init page
init_pageID = id_Page.PAGE_HSD_OFF

-- page mode
function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

HSD_MODE_OFF = 0
HSD_MODE_NAV = 1
HSD_MODE_TID = 2
HSD_MODE_TEST = 3

HSD_MODE_NAV_TACAN = 0
HSD_MODE_NAV_DEST = 1
HSD_MODE_NAV_VECT = 2
HSD_MODE_NAV_MAN = 3
HSD_MODE_NAV_AWL_PCD = 4

pages_by_mode = {}
clear_mode_table(pages_by_mode, 4, 4, 0)

pages_by_mode[HSD_MODE_OFF][0][0][0]   = id_Page.PAGE_HSD_OFF

pages_by_mode[HSD_MODE_NAV][HSD_MODE_NAV_TACAN][0][0]   = id_Page.PAGE_HSD_NAV_TACAN
pages_by_mode[HSD_MODE_NAV][HSD_MODE_NAV_DEST][0][0]   = id_Page.PAGE_HSD_NAV_DEST
pages_by_mode[HSD_MODE_NAV][HSD_MODE_NAV_VECT][0][0]   = id_Page.PAGE_HSD_NAV_VECT
pages_by_mode[HSD_MODE_NAV][HSD_MODE_NAV_MAN][0][0]   = id_Page.PAGE_HSD_NAV_MAN
pages_by_mode[HSD_MODE_NAV][HSD_MODE_NAV_AWL_PCD][0][0]   = id_Page.PAGE_HSD_NAV_AWL_PCD

pages_by_mode[HSD_MODE_TID][0][0][0]   = id_Page.PAGE_TID_REPEAT
pages_by_mode[HSD_MODE_TEST][0][0][0]   = id_Page.PAGE_HSD_TEST


--
try_find_assigned_viewport("F14_HSD")
