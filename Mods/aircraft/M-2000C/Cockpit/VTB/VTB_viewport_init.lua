dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

purposes 	 = {100}

indicator_type = indicator_types.COMMON
collimator_default_distance_factor = {1,0,0}
update_screenspace_diplacement(1.0, false)	
try_find_assigned_viewport("RIGHT_MFCD")
page_subsets = {  LockOn_Options.script_path.."VTB/VTB_viewport.lua"}
pages 			= {{1}}
init_pageID     = 1

--brightness_sensitive_materials = {"vtb_baked_image" }
