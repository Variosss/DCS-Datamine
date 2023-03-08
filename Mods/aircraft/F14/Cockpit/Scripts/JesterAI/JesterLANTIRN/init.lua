dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

indicator_type = indicator_types.HELMET
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-------PAGE IDs-------
id_Page =
{
	MAIN = 0,
}

id_pagesubset =
{
	COMMON   = 0,
}

page_subsets = {}
page_subsets[id_pagesubset.COMMON] = LockOn_Options.script_path.."Scripts/JesterAI/JesterLANTIRN/JesterLANTIRN_Page.lua"
  	
----------------------
pages = {}
pages[id_Page.MAIN] = { id_pagesubset.COMMON }
init_pageID     = id_Page.MAIN
