declare_plugin("F-16C bl.50 AI",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/F16C_bl50")
mount_vfs_texture_path  (current_mod_path.."/Textures/F16C_bl50_HAF")
mount_vfs_texture_path  (current_mod_path.."/Textures/F16C_bl50_IAF")
---------------------------------------------------------
dofile(current_mod_path..'/F-16C.lua')
---------------------------------------------------------
plugin_done()	