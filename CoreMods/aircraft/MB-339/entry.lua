declare_plugin("MB-339A/PAN AI by IndiaFoxtEcho",
{
    installed 	 	  = true, -- if false that will be place holder , or advertising
    dirName	  	      = current_mod_path,
    displayName       = _("MB-339"),

    fileMenuName      = _("MB-339"),
    state		 	  = "installed",
    developerName	  = "IndiaFoxtEcho Visual Simulations",
    version		 	  = __DCS_VERSION__,
    info		      = _("The Aermacchi MB-339 is a single-engine two-seat jet trainer and light attack aircraft produced by the Italian manufacturer Aermacchi, today Leonardo S.P.A.. ."),
    encyclopedia_path = current_mod_path..'/Encyclopedia',
})

--mounting 3d model paths and texture paths 
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_texture_path  (current_mod_path.."/Textures/339A-EXT-TEX.zip")
mount_vfs_texture_path  (current_mod_path.."/Textures/339A-LOADOUT.zip")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
---------------------------------------------------------
dofile(current_mod_path..'/Weapons/Gunpods.lua')
dofile(current_mod_path..'/Weapons/Pods.lua')
dofile(current_mod_path..'/Weapons/TanksAndSmokes.lua')
dofile(current_mod_path.."/Effects/MB339_overwingVapor.lua")
---------------------------------------------------------
dofile(current_mod_path..'/MB-339A.lua')
dofile(current_mod_path..'/MB-339APAN.lua')
dofile(current_mod_path..'/UnitPayloads/MB-339A.lua')
dofile(current_mod_path..'/UnitPayloads/MB-339APAN.lua')

plugin_done()