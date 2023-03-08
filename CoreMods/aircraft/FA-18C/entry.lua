declare_plugin("F/A-18C AI",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/FA-18C")
---------------------------------------------------------
dofile(current_mod_path..'/FA-18C.lua')
---------------------------------------------------------
plugin_done()	