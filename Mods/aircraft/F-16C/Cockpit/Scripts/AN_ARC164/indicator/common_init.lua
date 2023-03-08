dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON

-------PAGE IDs-------
id_Page =
{
	PAGE_OFF			= 0,
	PAGE_PRESET_CHANNEL	= 1,
	PAGE_FREQ_STATUS	= 2,
	PAGE_CHANNEL_MAP	= 3,
}

id_pagesubset =
{
	PRESET_CHANNEL	= 0,
	FREQ_STATUS		= 1,
	CHANNEL_MAP		= 2,
}

page_subsets = {}
page_subsets[id_pagesubset.PRESET_CHANNEL]	= LockOn_Options.script_path.."AN_ARC164/indicator/PRESET_CHANNEL_page.lua"
page_subsets[id_pagesubset.FREQ_STATUS]		= LockOn_Options.script_path.."AN_ARC164/indicator/FREQ_STATUS_page.lua"
page_subsets[id_pagesubset.CHANNEL_MAP]		= LockOn_Options.script_path.."AN_ARC164/indicator/CHANNEL_MAP_page.lua"

----------------------
pages = {}
pages[id_Page.PAGE_OFF]	= {}
pages[id_Page.PAGE_PRESET_CHANNEL]	= {id_pagesubset.PRESET_CHANNEL}
pages[id_Page.PAGE_FREQ_STATUS]		= {id_pagesubset.FREQ_STATUS}
pages[id_Page.PAGE_CHANNEL_MAP]		= {id_pagesubset.CHANNEL_MAP}

init_pageID		= id_Page.PAGE_OFF
use_parser		= false


------------------------------------
pages_by_mode = {}
clear_mode_table(pages_by_mode, 1, 3, 0)

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

pages_by_mode[0][0][0][0]	= id_Page.PAGE_OFF
pages_by_mode[1][0][0][0]	= id_Page.PAGE_PRESET_CHANNEL
pages_by_mode[1][1][0][0]	= id_Page.PAGE_FREQ_STATUS
pages_by_mode[1][2][0][0]	= id_Page.PAGE_CHANNEL_MAP
