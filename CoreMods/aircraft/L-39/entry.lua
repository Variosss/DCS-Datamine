declare_plugin("L-39C/ZA by Eagle Dynamics",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
info		 	  = _("A Czech-made two-seater visual and instrument flight rules trainer. It is also for light combat use against air and ground targets."),
encyclopedia_path = current_mod_path..'/Encyclopedia',
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/L-39_C")
mount_vfs_texture_path  (current_mod_path.."/Textures/L-39_ZA")
---------------------------------------------------------
dofile(current_mod_path..'/L-39C.lua')
dofile(current_mod_path..'/L-39ZA.lua')
---------------------------------------------------------
plugin_done()