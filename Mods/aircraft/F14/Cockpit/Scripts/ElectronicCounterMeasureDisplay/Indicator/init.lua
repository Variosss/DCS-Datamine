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

local ecmd_page_path = LockOn_Options.script_path.."Scripts/ElectronicCounterMeasureDisplay/Indicator/"

id_Page = {
    PAGE_ECMD_OFF = 0,
    PAGE_ECMD_NAV_TACAN = 1,
    PAGE_ECMD_NAV_DEST = 2,
    PAGE_ECMD_NAV_VECT = 3,
    PAGE_ECMD_NAV_MAN = 4,
    PAGE_ECMD_NAV_AWL_PCD = 5,
    PAGE_ECMD_TID_REPEAT = 6,
    PAGE_ECMD_TEST = 7,
}

id_pagesubset = {
    ECMD_OFF = 0,
    ECMD_NAV_BASE = 1,
    ECMD_NAV_TACAN = 2,
    ECMD_NAV_DEST = 3,
    ECMD_NAV_VECT = 4,
    ECMD_NAV_MAN = 5,
    ECMD_TEST = 6,
}
    
page_subsets = {
	[id_pagesubset.ECMD_OFF]		= ecmd_page_path.."base_page.lua",
	[id_pagesubset.ECMD_NAV_BASE]= ecmd_page_path.."nav_base_page.lua",
	[id_pagesubset.ECMD_NAV_TACAN]= ecmd_page_path.."nav_tacan_page.lua",
	[id_pagesubset.ECMD_NAV_DEST]= ecmd_page_path.."nav_dest_page.lua",
	[id_pagesubset.ECMD_NAV_VECT]= ecmd_page_path.."nav_vect_page.lua",
	[id_pagesubset.ECMD_NAV_MAN]= ecmd_page_path.."nav_man_page.lua",
	[id_pagesubset.ECMD_TEST]= ecmd_page_path.."test_page.lua",
}

pages = {
    [id_Page.PAGE_ECMD_OFF] = {id_pagesubset.ECMD_OFF},
    
    [id_Page.PAGE_ECMD_NAV_TACAN] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_NAV_BASE, id_pagesubset.ECMD_NAV_TACAN},
    [id_Page.PAGE_ECMD_NAV_DEST] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_NAV_BASE, id_pagesubset.ECMD_NAV_DEST},
    [id_Page.PAGE_ECMD_NAV_VECT] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_NAV_BASE, id_pagesubset.ECMD_NAV_VECT},
    [id_Page.PAGE_ECMD_NAV_MAN] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_NAV_BASE, id_pagesubset.ECMD_NAV_MAN},
    
    [id_Page.PAGE_ECMD_NAV_AWL_PCD] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_NAV_BASE, id_pagesubset.ECMD_NAV_TACAN},
    
    [id_Page.PAGE_ECMD_TID_REPEAT] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_TEST},
    
    [id_Page.PAGE_ECMD_TEST] = {id_pagesubset.ECMD_OFF, id_pagesubset.ECMD_TEST},
    
}

-- init page
init_pageID = id_Page.PAGE_ECMD_OFF

-- page mode
function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

ECMD_MODE_OFF = 0
ECMD_MODE_NAV = 1
ECMD_MODE_TID = 2
ECMD_MODE_ECM = 3
ECMD_MODE_TEST = 4

ECMD_MODE_NAV_TACAN = 0
ECMD_MODE_NAV_DEST = 1
ECMD_MODE_NAV_VECT = 2
ECMD_MODE_NAV_MAN = 3
ECMD_MODE_NAV_AWL_PCD = 4

pages_by_mode = {}
clear_mode_table(pages_by_mode, 4, 4, 0)

pages_by_mode[ECMD_MODE_OFF][0][0][0]   = id_Page.PAGE_ECMD_OFF

pages_by_mode[ECMD_MODE_NAV][ECMD_MODE_NAV_TACAN][0][0]   = id_Page.PAGE_ECMD_NAV_TACAN
pages_by_mode[ECMD_MODE_NAV][ECMD_MODE_NAV_DEST][0][0]   = id_Page.PAGE_ECMD_NAV_DEST
pages_by_mode[ECMD_MODE_NAV][ECMD_MODE_NAV_VECT][0][0]   = id_Page.PAGE_ECMD_NAV_VECT
pages_by_mode[ECMD_MODE_NAV][ECMD_MODE_NAV_MAN][0][0]   = id_Page.PAGE_ECMD_NAV_MAN
pages_by_mode[ECMD_MODE_NAV][ECMD_MODE_NAV_AWL_PCD][0][0]   = id_Page.PAGE_ECMD_NAV_AWL_PCD

pages_by_mode[ECMD_MODE_TID][0][0][0]   = id_Page.PAGE_TID_REPEAT
pages_by_mode[ECMD_MODE_TEST][0][0][0]   = id_Page.PAGE_ECMD_TEST


--
try_find_assigned_viewport("F14_ECMD")
