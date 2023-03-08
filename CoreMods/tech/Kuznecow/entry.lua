local self_ID   =   "TAVKR 1143 High Detail"
local localized = _("TAVKR 1143 High Detail")
declare_plugin(self_ID,
{
dirName		  = current_mod_path,
displayName   = localized,
shortName	  =   "HD1143",
version		  =   __DCS_VERSION__,
state		  =   "installed",
developerName =   "Eagle Dynamics",
info		  =    localized
})

mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")
mount_vfs_texture_path	(current_mod_path ..  "/Textures")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/TUG_3913")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Kuznecow")

dofile(current_mod_path .."/Database/db_units_ships.lua")

plugin_done()
