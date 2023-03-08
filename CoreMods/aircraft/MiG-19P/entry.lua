declare_plugin("MiG-19P AI by RAZBAM",
{
	installed 	 	  = true, -- if false that will be place holder , or advertising
	dirName	  	 	  = current_mod_path,
	version		 	  = __DCS_VERSION__,
	state		 	  = "installed",
	info		 	  = _("MiG-19P"),
	encyclopedia_path = current_mod_path..'/Encyclopedia'
})

---------------------------------------------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path	(current_mod_path.."/Liveries")
mount_vfs_texture_path	(current_mod_path.."/Textures")
mount_vfs_texture_path	(current_mod_path.."/Textures/MiG-19P")
---------------------------------------------------------------------------------------
dofile(current_mod_path..'/MiG-19P.lua')
---------------------------------------------------------------------------------------
plugin_done()