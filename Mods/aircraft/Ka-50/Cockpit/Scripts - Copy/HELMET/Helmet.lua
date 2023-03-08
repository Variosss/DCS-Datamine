dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.HELMET
purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

-------PAGE IDs-------
id_Page =
{
	PAGE   = 0
}

id_pagesubset =
{
	COMMON			= 0
}

opacity_sensitive_materials = 
{
	"INDICATION_HELMET_KA50"
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON]			= LockOn_Options.script_path.."HELMET/HELMET_page.lua"
----------------------
pages = {}
pages[id_Page.PAGE] = {id_pagesubset.COMMON}

init_pageID		= id_Page.PAGE
use_parser		= false
