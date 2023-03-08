--
local count = 0
local function counter()
	count = count + 1
	return count
end

-- list of subsets
count = -1
local id_subset =
{
	BASE	= counter(),
	FAIL	= counter(),
	MAIN	= counter(),
}


local EHSI_PagesPath = LockOn_Options.script_path.."Displays/EHSI/indicator/Pages/"

-- construct subsets
page_subsets = {}
page_subsets[id_subset.BASE]				= EHSI_PagesPath.."EHSI_Page_base.lua"
page_subsets[id_subset.FAIL]				= EHSI_PagesPath.."EHSI_Page_FAIL.lua"
page_subsets[id_subset.MAIN]				= EHSI_PagesPath.."EHSI_Page_MAIN.lua"


-- list of pages
count = -1
id_Page =
{
	OFF		= counter(),
	FAIL	= counter(),
	MAIN	= counter(),
}

init_pageID	= id_Page.OFF

-- construct pages
pages = {}
pages[id_Page.OFF]					= {}
pages[id_Page.FAIL]					= {id_subset.BASE, id_subset.FAIL}
pages[id_Page.MAIN]					= {id_subset.BASE, id_subset.MAIN}


--
local function tablelen(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end


EHSI_DISP_FMT_LEV1 =
{
	OFF		= 0,
	FAIL	= 1,
	MAIN	= 2,
}

EHSI_DISP_FMT_LEV2 = { NONE = 0 }
EHSI_DISP_FMT_LEV3 = { NONE = 0 }
EHSI_DISP_FMT_LEV4 = { NONE = 0 }


pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(EHSI_DISP_FMT_LEV1), tablelen(EHSI_DISP_FMT_LEV2), tablelen(EHSI_DISP_FMT_LEV3), tablelen(EHSI_DISP_FMT_LEV4))

--
pages_by_mode[EHSI_DISP_FMT_LEV1.OFF]	[EHSI_DISP_FMT_LEV2.NONE][EHSI_DISP_FMT_LEV3.NONE][EHSI_DISP_FMT_LEV4.NONE]	= id_Page.OFF
pages_by_mode[EHSI_DISP_FMT_LEV1.FAIL]	[EHSI_DISP_FMT_LEV2.NONE][EHSI_DISP_FMT_LEV3.NONE][EHSI_DISP_FMT_LEV4.NONE]	= id_Page.FAIL
pages_by_mode[EHSI_DISP_FMT_LEV1.MAIN]	[EHSI_DISP_FMT_LEV2.NONE][EHSI_DISP_FMT_LEV3.NONE][EHSI_DISP_FMT_LEV4.NONE]	= id_Page.MAIN

--
function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end