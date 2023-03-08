dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON

-------PAGE IDs-------
id_Page =
{
	PAGE_OFF    = 0,
	PAGE_MAIN   = 1
}

id_pagesubset =
{
	MAIN = 0
}

page_subsets = {}
page_subsets[id_pagesubset.MAIN] = LockOn_Options.script_path.."UHF_ARC_51\\AN_ARC51_main_page.lua"
  	
----------------------
pages = {}
pages[id_Page.PAGE_MAIN] = {id_pagesubset.MAIN}

init_pageID			= id_Page.PAGE_MAIN
use_parser			= false
