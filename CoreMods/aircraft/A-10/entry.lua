declare_plugin("A-10 Warthog",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/A-10")
mount_vfs_texture_path  (current_mod_path.."/Textures/A10C_II")
---------------------------------------------------------
dofile(current_mod_path..'/A-10A.lua')
dofile(current_mod_path..'/A-10C.lua')
dofile(current_mod_path..'/A-10C_2.lua')
---------------------------------------------------------
plugin_done()	