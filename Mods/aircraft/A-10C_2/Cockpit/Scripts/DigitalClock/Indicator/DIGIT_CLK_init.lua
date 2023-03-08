dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON

-------PAGE IDs-------
id_Page =
{
	PAGE_OFF		= 0,
	PAGE_MAIN		= 1
}

id_pagesubset =
{
	MAIN			= 0
}

page_subsets = {}
page_subsets[id_pagesubset.MAIN]	= LockOn_Options.script_path.."DigitalClock/Indicator/DIGIT_CLK_page.lua"

----------------------
pages = {}

pages[id_Page.PAGE_OFF]		= {}
pages[id_Page.PAGE_MAIN]	= {id_pagesubset.MAIN}

init_pageID		= id_Page.PAGE_OFF
use_parser		= false

--- master modes
A10C_DIGIT_CLK_OFF		   = 0 
A10C_DIGIT_CLK_MAIN        = 1 

------------------------------------
pages_by_mode                 = {}
clear_mode_table(pages_by_mode, 1, 0, 0)

function get_page_by_mode(master,L2,L3,L4)
	return get_page_by_mode_global(pages_by_mode,init_pageID,master,L2,L3,L4)
end

pages_by_mode[A10C_DIGIT_CLK_OFF][0][0][0]			  = id_Page.PAGE_OFF
pages_by_mode[A10C_DIGIT_CLK_MAIN][0][0][0]			  = id_Page.PAGE_MAIN
