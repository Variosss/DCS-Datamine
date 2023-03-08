--/N/ 08. Aug 2014. rev may 2020
--/M/ 02. Dec 2015.

local self_ID = "MiG-21Bis AI by Magnitude 3 LLC"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
version		 = "trunk",--__DCS_VERSION__,
state		 = "installed",
info		 = _("MiG-21bis AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
binaries     = { 'MiG21_AI' },
})

--mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path(current_mod_path.."/Textures")
mount_vfs_texture_path(current_mod_path.."/Textures/MiG-21Bis")
mount_vfs_texture_path(current_mod_path.."/Textures/MiG-21Bis_Base")
mount_vfs_texture_path(current_mod_path.."/Textures/MiG-21Bis_Pilot")
mount_vfs_texture_path(current_mod_path.."/Textures/MiG-21Bis_TacNumbers")
mount_vfs_texture_path(current_mod_path.."/Textures/MiG-21Bis_Weapons")

---------------------------------------------------------
dofile(current_mod_path.."/Entry/Aw")
dofile(current_mod_path.."/Entry/MiG-21bis.lua")
---------------------------------------------------------

plugin_done()