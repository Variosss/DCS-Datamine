dofile(LockOn_Options.common_script_path.."devices_defs.lua")

purposes 	 	 = {100}
indicator_type 	 = indicator_types.COMMON

-------PAGE IDs-------
id_Page =
{
	BLANK = 0,
	MAIN = 1,
	PSEUDO_WPT_PAGE = 2,
}

id_pagesubset =
{
	COMMON   = 0,
	PSEUDO_WPT_SUBSET = 1,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."MapDisplay/MapDisplay_page.lua"
page_subsets[id_pagesubset.PSEUDO_WPT_SUBSET] = LockOn_Options.script_path.."MapDisplay/MapDisplay_template_wpt.lua"
  	
----------------------
pages = {}
pages[id_Page.BLANK] = {}
pages[id_Page.MAIN] = {id_pagesubset.COMMON}

init_pageID = id_Page.MAIN

local function tablelen(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

MAP_DISP_FMT_LEV1 = 
{
	BLANK = 0,
	MAIN = 1,
}

MAP_DISP_FMT_LEV2 = 
{
	NONE = 0,
}

MAP_DISP_FMT_LEV3 = 
{
	NONE = 0,
}

MAP_DISP_FMT_LEV4 = 
{
	NONE = 0,
}

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(MAP_DISP_FMT_LEV1), tablelen(MAP_DISP_FMT_LEV2), tablelen(MAP_DISP_FMT_LEV3), tablelen(MAP_DISP_FMT_LEV4))

pages_by_mode[MAP_DISP_FMT_LEV1.BLANK]		[MAP_DISP_FMT_LEV2.NONE]				[MAP_DISP_FMT_LEV3.NONE]	[MAP_DISP_FMT_LEV4.NONE]	= id_Page.BLANK
pages_by_mode[MAP_DISP_FMT_LEV1.MAIN]		[MAP_DISP_FMT_LEV2.NONE]				[MAP_DISP_FMT_LEV3.NONE]	[MAP_DISP_FMT_LEV4.NONE]	= id_Page.MAIN


function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

multipleSymbolsIDs = 
{
	WPT = 0,
}

multipleSymbols = {}
multipleSymbols[multipleSymbolsIDs.WPT] 			= "waypoint"


function getMultipleSymbolByID(id)
	local name = ""
	if multipleSymbols[id] == nil then
		return name
	else
		return multipleSymbols[id]
	end
end

templates = {}
templates["WPT"] = id_pagesubset.PSEUDO_WPT_SUBSET

function get_template(name)
	if templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end
