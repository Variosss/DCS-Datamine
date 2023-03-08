declare_plugin("AH-64D BLK.II AI",
{
	version		= __DCS_VERSION__,
	state		= "installed",
})

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/AH-64D")
mount_vfs_texture_path  (current_mod_path.."/Textures")
---------------------------------------------------------
dofile(current_mod_path..'/AH-64D.lua')
---------------------------------------------------------
plugin_done()