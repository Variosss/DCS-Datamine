dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type 			= indicator_types.COMMON
used_render_mask 		= LockOn_Options.script_path.."../IndicationTextures/SHKVAL_MASK.bmp"

purposes = {100}
-------PAGE IDs-------
id_Page =
{
	PAGE_NULL = 0,
	PAGE_OFF  = 1,
	PAGE_TEST = 2,
	PAGE_MAIN = 3
}

id_pagesubset =
{
	COMMON  = 0,
	MAIN    = 1,
	TEST    = 2,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."SHKVAL\\SHKVAL_base_page.lua"
page_subsets[id_pagesubset.MAIN]   = LockOn_Options.script_path.."SHKVAL\\SHKVAL_page.lua"
page_subsets[id_pagesubset.TEST]   = LockOn_Options.script_path.."SHKVAL\\SHKVAL_page_test.lua"
  	
----------------------
pages = {}
pages[id_Page.PAGE_MAIN] = { id_pagesubset.COMMON, id_pagesubset.MAIN}
pages[id_Page.PAGE_TEST] = { id_pagesubset.COMMON, id_pagesubset.TEST}

init_pageID     = id_Page.PAGE_MAIN
test_pageID     = id_Page.PAGE_TEST

always_show_ground = false
--use_parser      = false
