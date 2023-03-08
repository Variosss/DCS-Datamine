declare_plugin("AircraftWeaponPack",
{
installed 	 	  = true, -- if false that will be place holder , or advertising
state		 	  = "installed",
developerName	  = "Eagle Dynamics",
version		 	  = __DCS_VERSION__,		 
})

--mounting 3d model paths and texture paths 
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_texture_path  (current_mod_path.."/Textures/AircraftWeaponPack")
mount_vfs_texture_path  (current_mod_path.."/Textures/MatraWeaponPack")
mount_vfs_texture_path  (current_mod_path.."/Textures/MatraR530Ext")
mount_vfs_texture_path  (current_mod_path.."/Textures/TelsonLaunchers")
mount_vfs_texture_path  (current_mod_path.."/Textures/9k121")
mount_vfs_texture_path  (current_mod_path.."/Textures/vikhr")
---------------------------------------------------------
dofile(current_mod_path..'/common_definitions.lua')
dofile(current_mod_path..'/aim9_family.lua')
dofile(current_mod_path..'/aim7_family.lua')
dofile(current_mod_path..'/aim120_family.lua')
dofile(current_mod_path..'/agm65_family.lua')
dofile(current_mod_path..'/FFAR.lua')
dofile(current_mod_path..'/KABs.lua')
dofile(current_mod_path..'/paveway.lua')
dofile(current_mod_path..'/JDAM.lua')
dofile(current_mod_path..'/cluster_bombs.lua')
dofile(current_mod_path..'/cruise_missiles.lua')
dofile(current_mod_path..'/HOT.lua')
dofile(current_mod_path..'/glide_bombs.lua')
dofile(current_mod_path..'/common_bombs.lua')
dofile(current_mod_path..'/rockets.lua')
dofile(current_mod_path..'/anti-radiation missiles.lua')
dofile(current_mod_path..'/tactical_decoys.lua')
dofile(current_mod_path..'/AA_Missiles.lua')
dofile(current_mod_path..'/AS_Missiles.lua')
dofile(current_mod_path..'/Datalink.lua')
dofile(current_mod_path..'/targeting_pods.lua')
dofile(current_mod_path..'/FuelTanks.lua')
dofile(current_mod_path..'/pods.lua')
dofile(current_mod_path..'/Matra_A2A.lua')
dofile(current_mod_path..'/gunpods.lua')
---------------------------------------------------------
plugin_done()