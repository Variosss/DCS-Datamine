--[[
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
indicator_type 		 = indicator_types.COMMON
purposes 	 		 = {render_purpose.HUD_ONLY_VIEW,render_purpose.SCREENSPACE_INSIDE_COCKPIT}
-------PAGE IDs-------
id_Page =
{
	MAIN = 0,
}

id_pagesubset =
{
	COMMON   = 0,
    TEMPLATE = 1,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] 		= LockOn_Options.script_path.."TRIGGERSYSTEM/base_page.lua"
page_subsets[id_pagesubset.TEMPLATE]    = LockOn_Options.script_path.."TRIGGERSYSTEM/element_template.lua"

pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON}


init_pageID     = id_Page.MAIN



specific_element_id =
{
	HIGHLIGHT	      = 0 ,
}

specific_element_names = {
		[specific_element_id.HIGHLIGHT]       ="highlight"
}

templates = {}
templates["HUD_PAGE"]  = id_pagesubset.TEMPLATE

function get_template(name)
	if  templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end
--]]

