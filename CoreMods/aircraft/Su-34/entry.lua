declare_plugin("Su-34 AI",{
developerName	  = "Eagle Dynamics",
state		 	  = "installed",
version		 	  = __DCS_VERSION__,
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")  -- empty at the moment 
mount_vfs_texture_path  (current_mod_path.."/Textures/Su-34")
---------------------------------------------------------
dofile(current_mod_path..'/Su-34.lua')
---------------------------------------------------------
plugin_done()