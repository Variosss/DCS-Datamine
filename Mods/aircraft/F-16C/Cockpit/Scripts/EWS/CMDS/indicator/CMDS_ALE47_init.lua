dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON

opacity_sensitive_materials = 
{
	"font_CMDS"
}

-------PAGE IDs-------
id_Page =
{
	PAGE_OFF    = 0,
	PAGE_MAIN   = 1
}

id_pagesubset =
{
	MAIN		= 0
}

page_subsets = {}
page_subsets[id_pagesubset.MAIN]	= LockOn_Options.script_path.."EWS/CMDS/indicator/CMDS_ALE47_MAIN_page.lua"
  	
----------------------
pages = {}
pages[id_Page.PAGE_OFF]		= {}
pages[id_Page.PAGE_MAIN]	= {id_pagesubset.MAIN}

init_pageID			= id_Page.PAGE_OFF

--- master modes
CMDS_ALE47_OFF		= 0 
CMDS_ALE47_MAIN		= 1 

pages_by_mode                 = {}
clear_mode_table(pages_by_mode, 2, 0, 0)

function get_page_by_mode(master,L2,L3,L4)
	return get_page_by_mode_global(pages_by_mode,init_pageID,master,L2,L3,L4)
end

pages_by_mode[CMDS_ALE47_OFF]	[0]	[0]	[0]	= id_Page.PAGE_OFF
pages_by_mode[CMDS_ALE47_MAIN]	[0]	[0]	[0]	= id_Page.PAGE_MAIN

use_parser					= false
dynamically_update_geometry	= false
