dofile(LockOn_Options.common_script_path.."devices_defs.lua")
--dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

indicator_type 	 = indicator_types.COMMON

--update_screenspace_diplacement(220/168,true)

page_subsets 	= {LockOn_Options.script_path.."MapDisplay/bake/page.lua"}
pages 			= {{1}}
init_pageID     = 1
