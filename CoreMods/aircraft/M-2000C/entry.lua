local self_ID  = "M-2000C AI by RAZBAM Sims"
declare_plugin(self_ID,
{
	installed 	 = true,
	dirName	  	 = current_mod_path,
	version		 = __DCS_VERSION__,
	state		 = "installed",
	info		 = _("M-2000C AI"),
	encyclopedia_path = current_mod_path..'/Encyclopedia',
	binaries     =
	{
		'M2KC_AI',
	},
	load_immediately = true,
})
---------------------------------------------------------------------------------------
mount_vfs_model_path   (current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Textures/M-2000C")

dofile(current_mod_path.."/M-2000C.lua")

plugin_done()-- finish declaration , clear temporal data
