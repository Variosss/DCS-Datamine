declare_plugin("Characters",
{
dirName		        = current_mod_path,
displayName         = _("Characters"),
shortName	        = "Characters",
version		        = __DCS_VERSION__,
state		        = "installed",
developerName       = "Eagle Dynamics",
info		        = localized,
encyclopedia_path   = current_mod_path..'/Encyclopedia',
})

--mount_vfs_liveries_path     (current_mod_path ..  "/Liveries")
mount_vfs_model_path        (current_mod_path ..  "/models")
mount_vfs_texture_path	    (current_mod_path ..  "/Textures")
mount_vfs_animations_path   (current_mod_path ..  "/animations")

plugin_done()
