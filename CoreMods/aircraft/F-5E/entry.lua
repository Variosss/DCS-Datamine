declare_plugin("F-5E/E-3 by Belsimtek",{
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
info		 	  = _("A lightweight, supersonic fighter-bomber second generation. Armed with two 20mm cannons with 560 rounds, rockets, bombs and close combat Air-To-Air missiles."),
encyclopedia_path = current_mod_path..'/Encyclopedia'
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/f-5e_tiger_II_textures")
mount_vfs_texture_path  (current_mod_path.."/Textures/f-5e3_tiger_II_textures")
---------------------------------------------------------
dofile(current_mod_path..'/F-5E.lua')
dofile(current_mod_path..'/F-5E-3.lua')
---------------------------------------------------------
plugin_done()