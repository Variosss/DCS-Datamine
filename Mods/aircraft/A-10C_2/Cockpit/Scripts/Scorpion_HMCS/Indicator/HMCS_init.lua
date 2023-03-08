dofile(LockOn_Options.common_script_path.."devices_defs.lua")

--font_HMCS_A10.tga
--Indication_HMCS_A-10C.tga

opacity_sensitive_materials = 
{
	"INDICATION_HMCS",
	"INDICATION_HMCS_WHITE",
	"INDICATION_HMCS_RED",
	"INDICATION_HMCS_YELLOW",
	"INDICATION_HMCS_BLUE",
	"font_HMCS",
	"font_HMCS_BLUE",
	"HMCS_TFOV_GREY",
}

color_sensitive_materials = 
{
	"INDICATION_HMCS",
	"font_HMCS",
}

--day_color    = {0, 255/255, 0, 255/255}
--night_color  = {243/255, 116/255, 13/255, 255/255}

indicator_type = indicator_types.HELMET
purposes 	 = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-------PAGE IDs-------
id_Page =
{
	PAGE_HMCS_OFF					= 0,
	PAGE_HMCS_MAIN					= 1,
}

id_pagesubset =
{
	HMCS_BASE						= 0, -- just symbology display area
	HMCS_COMMON						= 1,
	HMCS_DYNAMIC_SYMBOLS			= 2, -- Waypoints, PPLI, EPRLS reports
}

page_subsets = {}
page_subsets[id_pagesubset.HMCS_BASE] =
	LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_base_page.lua"
page_subsets[id_pagesubset.HMCS_COMMON] =
	LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_common_page.lua"
-- Waypoints, PPLI, EPRLS reports	
page_subsets[id_pagesubset.HMCS_DYNAMIC_SYMBOLS] =
	LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_dynamic_symbols_template.lua"

----------------------
pages = {}

pages[id_Page.PAGE_HMCS_OFF]			= {}
pages[id_Page.PAGE_HMCS_MAIN]			= {id_pagesubset.HMCS_BASE, id_pagesubset.HMCS_COMMON}
	
init_pageID		= id_Page.PAGE_HMCS_OFF
use_parser		= false

-- master modes
A10C_HMCS_OFF				= 0
A10C_HMCS_MAIN				= 1

-- level 2

-- level 3

------------------------------------
pages_by_mode                 = {}
clear_mode_table(pages_by_mode, 9, 15, 4)

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

pages_by_mode[A10C_HMCS_OFF][0][0][0]		  = id_Page.PAGE_HMCS_OFF
pages_by_mode[A10C_HMCS_MAIN][0][0][0]		  = id_Page.PAGE_HMCS_MAIN

local multipleSymbolsIDs =
{
	WAYPOINTS 			= 0,
	DL_SYMBOLS			= 1,
	OCCLUSION_ZONE_PTS	= 2,
}
	
local multipleSymbols = {}
multipleSymbols[multipleSymbolsIDs.WAYPOINTS] 			= "Waypoint"
multipleSymbols[multipleSymbolsIDs.DL_SYMBOLS]			= "DL_symbol"
multipleSymbols[multipleSymbolsIDs.OCCLUSION_ZONE_PTS]	= "Occlusion_Zone_Line"

function getMultipleSymbolByID(id)
	if multipleSymbols[id] == nil then
		return ""
	else
		return multipleSymbols[id]
	end
end

-- NOTE: name is ommitted - all dynamic symbols are loaded from a single page
function get_template(name)
	return id_pagesubset.HMCS_DYNAMIC_SYMBOLS
end
