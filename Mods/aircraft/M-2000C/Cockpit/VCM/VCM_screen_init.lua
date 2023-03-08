dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")


purposes 	 = {render_purpose.GENERAL}
--collimator_default_distance_factor = {1,0,0}
--update_screenspace_diplacement(1.0, false)	
page_subsets = {  LockOn_Options.script_path.."VCM/VCM_screen.lua"}
pages 			= {{1}}
init_pageID     = 1

brightness_sensitive_materials = {"vcm_baked_image" }