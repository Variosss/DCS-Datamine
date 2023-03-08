local id_subset =
{
	MAIN	= 1
}

--local PFLD_PagesPath = LockOn_Options.script_path.."Displays/PFLD/indicator/"

-- construct subsets
page_subsets = {}
page_subsets[id_subset.MAIN]	= PFLD_PagesPath.."PFLD.lua"

-- list of pages

id_Page =
{
	OFF		= 0,
	MAIN	= 1,
}

init_pageID	= id_Page.MAIN

-- construct pages
pages = {}
pages[id_Page.OFF]		= {}
pages[id_Page.MAIN]		= {id_subset.MAIN}

--
pages_by_mode = {}
clear_mode_table(pages_by_mode, 2, 1, 1, 1)

--
pages_by_mode[0][0][0][0]	= id_Page.OFF
pages_by_mode[1][0][0][0]	= id_Page.MAIN

--
function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end
