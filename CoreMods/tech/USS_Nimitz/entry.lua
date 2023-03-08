declare_plugin("USS_Nimitz",
{
dirName		  = current_mod_path,
displayName   = _("USS Nimitz class carrier"),
shortName	  =   "CVN742",
version		  =   __DCS_VERSION__,
state		  =   "installed",
developerName =   "Eagle Dynamics",
info		  =    localized,
encyclopedia_path = current_mod_path..'/Encyclopedia',
})

mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")
mount_vfs_texture_path	(current_mod_path ..  "/Textures")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/AS32-P25")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/AS32-31A")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/AS32-32A")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/AS32-36A")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/USS_Nimitz")
mount_vfs_texture_path  (current_mod_path ..  "/TexturesArchives/Arleigh_Burke")

mount_vfs_animations_path   (current_mod_path ..  "/animations/animations")
mount_vfs_liveries_path     (current_mod_path ..  "/animations/liveries")
mount_vfs_model_path        (current_mod_path ..  "/animations/models")
mount_vfs_texture_path	    (current_mod_path ..  "/animations/textures")

dofile(current_mod_path .."/Database/db_ships.lua")
dofile(current_mod_path .."/Database/db_ground_objects.lua")

plugin_done()
