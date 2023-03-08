declare_plugin("Ka-50 Black Shark",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/Ka-50_general")
mount_vfs_texture_path  (current_mod_path.."/Textures/Ka-50_3")
mount_vfs_texture_path  (current_mod_path.."/Textures/PU_9S846_STRELEC")
---------------------------------------------------------
dofile(current_mod_path..'/Ka-50.lua')
dofile(current_mod_path..'/Ka-50_3.lua')
---------------------------------------------------------
plugin_done()