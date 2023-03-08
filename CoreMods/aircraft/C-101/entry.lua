declare_plugin("C-101 Aviojet by AvioDev",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("C-101"),
version 	 = __DCS_VERSION__,
state		 = "installed",
info		 = _("The CASA C-101 Aviojet is a low-wing single engine jet-powered advanced trainer and light attack aircraft. It remains in service in the Spanish Air Force and some other countries; it is also flown by the Patrulla Aguila aerobatics team. The module features two variants (C-101EB and C-101CC), with their respective cockpits and systems modelled to exacting detail. Feel like a real pilot operating these aircraft just like their real-world counterparts."),
encyclopedia_path = current_mod_path..'/Encyclopedia',
binaries     = {'C101Core',},
})

mount_vfs_model_path (current_mod_path.."/Shapes")
mount_vfs_texture_path (current_mod_path.."/Textures/C-101.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/C-101-WEAPONS.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/pilot_c-101.zip")
---------------------------------------------------------
dofile(current_mod_path.."/Weapons.lua")
---------------------------------------------------------
dofile(current_mod_path..'/C-101.lua')
dofile(current_mod_path..'/C-101CC.lua')
dofile(current_mod_path..'/UnitPayloads/C-101CC.lua')
dofile(current_mod_path..'/UnitPayloads/C-101EB.lua')

plugin_done()
