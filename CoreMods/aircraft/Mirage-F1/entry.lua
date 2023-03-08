declare_plugin("Mirage F1 Assets by Aerges",
{
installed 	 		= true, -- if false that will be place holder , or advertising
dirName	  	 		= current_mod_path,
displayName  		= _("Mirage F1"),
version 	 		= __DCS_VERSION__ .. " EA",		 
state		 		= "installed",
info		 		= _("The Mirage F1 is a third-generation air superiority fighter and attack aircraft, designed and built in France. It has been exported to around a dozen countries, entering combat in many of them. More than 720 units have been manufactured between 1966 and 1992."),
encyclopedia_path 	= current_mod_path..'/Encyclopedia',
binaries     		= {'MirageF1Core',},
})
mount_vfs_model_path(current_mod_path.."/Shapes/Mirage-F1")
mount_vfs_model_path(current_mod_path.."/Shapes/Mirage-F1B")
mount_vfs_model_path(current_mod_path.."/Shapes/Mirage-F1common")
mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_texture_path (current_mod_path.."/Textures/Mirage-F1_common.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/Mirage-F1_common_fuse.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/Mirage-F1_common_tail.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/Mirage-F1_common_wings.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/Weapons.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/miragef1_pilot.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/Mirage-F1_RoughMet.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/miragef1_damaged.zip")

-- Weapons definitions
dofile(current_mod_path.."/Weapons.lua")

-- Common aircraft definitions
dofile(current_mod_path..'/Mirage-F1.lua')

-- Single-seater definitions
dofile(current_mod_path..'/Mirage-F1C.lua')
-- Versions below inherit Mirage F1C definition and override specific parts of it
dofile(current_mod_path..'/Mirage-F1CE.lua')
dofile(current_mod_path..'/Mirage-F1EE.lua')
dofile(current_mod_path..'/Mirage-F1M-EE.lua')
dofile(current_mod_path..'/Mirage-F1M-CE.lua')
dofile(current_mod_path..'/Mirage-F1C-200.lua')
dofile(current_mod_path..'/Mirage-F1EH.lua')
dofile(current_mod_path..'/Mirage-F1CH.lua')
dofile(current_mod_path..'/Mirage-F1JA.lua')
dofile(current_mod_path..'/Mirage-F1CG.lua')
dofile(current_mod_path..'/Mirage-F1CZ.lua')
dofile(current_mod_path..'/Mirage-F1CJ.lua')
dofile(current_mod_path..'/Mirage-F1CK.lua')
dofile(current_mod_path..'/Mirage-F1EQ.lua')
dofile(current_mod_path..'/Mirage-F1ED.lua')
dofile(current_mod_path..'/Mirage-F1EDA.lua')
dofile(current_mod_path..'/Mirage-F1CR.lua')
dofile(current_mod_path..'/Mirage-F1CT.lua')

-- Two-seater definitions
dofile(current_mod_path..'/Mirage-F1B.lua')
-- Versions below inherit Mirage F1B definition and override specific parts of it
dofile(current_mod_path..'/Mirage-F1BE.lua')
dofile(current_mod_path..'/Mirage-F1BQ.lua')
dofile(current_mod_path..'/Mirage-F1BD.lua')
dofile(current_mod_path..'/Mirage-F1DDA.lua')

plugin_done()
