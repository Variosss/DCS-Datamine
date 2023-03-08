dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type = indicator_types.COMMON
purposes = {render_purpose.GENERAL}

--local __USE_SCREENSPACE = true
-------------------------------------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then
    indicator_type    = indicator_types.COMMON
    purposes          = {render_purpose.SCREENSPACE_INSIDE_COCKPIT,render_purpose.HUD_ONLY_VIEW}
    screenspace_scale = 4;
end
-------------------------------------------------------------------------------------------

local uhf_page_path = LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/Main/"

id_pagesubset = {
    UHF_FREQ_OFF = 0,
    UHF_FREQ_ON = 1,
}
    
page_subsets = {
	[id_pagesubset.UHF_FREQ_OFF] = uhf_page_path.."base_page.lua",
	[id_pagesubset.UHF_FREQ_ON]  = uhf_page_path.."freq_disp.lua",
}

pages = {
    {id_pagesubset.UHF_FREQ_OFF, id_pagesubset.UHF_FREQ_ON},
}


--[[
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
pages_by_mode[ECMD_MODE_ECM][0][0][0]   = id_Page.PAGE_ECMD_ECM
pages_by_mode[ECMD_MODE_TEST][0][0][0]   = id_Page.PAGE_ECMD_TEST
]]

--
try_find_assigned_viewport("F14_UHF_ARC159")
