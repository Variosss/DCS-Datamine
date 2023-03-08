dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON


purposes 	 = {render_purpose.HUD_ONLY_VIEW,
                render_purpose.SCREENSPACE_INSIDE_COCKPIT,
                render_purpose.SCREENSPACE_OUTSIDE_COCKPIT}
screenspace_scale    = 4;

-------PAGE IDs-------
id_Page =
{
	MAIN = 0,
}

id_pagesubset =
{
	COMMON   = 0,
    TEMPLATE_HUD = 1,
    TEMPLATE_HSD = 2,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."ARCADE\\ARCADE_base_page.lua"
  	
----------------------
pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON}


init_pageID     = id_Page.MAIN


-----------------------------------------------------------------------------------------------------------
page_subsets[id_pagesubset.TEMPLATE_HUD]            = LockOn_Options.script_path.."ARCADE\\arcade_template_hud.lua"
page_subsets[id_pagesubset.TEMPLATE_HSD]            = LockOn_Options.script_path.."ARCADE\\arcade_template_hsd.lua"

-----------------------------------------------------------------------------------------------------------

specific_element_id =
{
		TARGET_AIRBORNE   = 0 ,               
        TARGET_GROUND     = 1 ,   
        TARGET_MISSION    = 2 ,  
        TARGET_CURRENT    = 3 ,
        MLWS_CONTACT      = 4 , 
		TARGET_AIRDEFENSE = 5 ,
        AIRFIELD          = 6
}

specific_element_names = {}
specific_element_names[specific_element_id.TARGET_AIRBORNE]       ="target_airborne"
specific_element_names[specific_element_id.TARGET_GROUND]         ="target_ground"
specific_element_names[specific_element_id.TARGET_MISSION]        ="target_mission"
specific_element_names[specific_element_id.TARGET_CURRENT]        ="target_current"
specific_element_names[specific_element_id.MLWS_CONTACT]          ="mlws_contact"
specific_element_names[specific_element_id.TARGET_AIRDEFENSE]	  ="target_air_defense"
specific_element_names[specific_element_id.AIRFIELD]              ="airfield"

templates = {}
templates["HUD_PAGE"]  = id_pagesubset.TEMPLATE_HUD
templates["HSD_PAGE"]  = id_pagesubset.TEMPLATE_HSD


function get_template(name)
	if  templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end

function get_specific_element_name_by_id(id)
	local name = ""
	if      specific_element_names[id] == nil then
		return name
	else
		return specific_element_names[id]
	end
end

