local self_ID = "AJS37 AI by Heatblur Simulations"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	  	 = current_mod_path,
version		 = __DCS_VERSION__,		 
state		 = "installed",
info		 = _("AJS37 AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
-- binaries     =
-- {
  -- 'AJS37-AI',
-- },
})

mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries") 
mount_vfs_texture_path(current_mod_path.."/Textures")

---------------------------------------------------------
dofile(current_mod_path..'/Entry/AJS37.lua')
dofile(current_mod_path.."/Entry/Weapons.lua")
dofile(current_mod_path..'/Entry/Sensors.lua')
dofile(current_mod_path.."/Entry/HBFARP.lua")
---------------------------------------------------------
plugin_done()