declare_plugin("TechWeaponPack",
{
installed 	 	  = true,
state		 	  = "installed",
developerName	  = "Eagle Dynamics",
version		 	  = __DCS_VERSION__,
encyclopedia_path = current_mod_path..'/Encyclopedia',		 
})


DEUTSCHLAND = {"Germany","Third Reich"}
AXIS = {"Germany", "Third Reich", "Japan", "Italian Social Republic", "Finland", "Hungary", "Romania", "Bulgaria"}
ALIES = {"Australia", "Belgium", "Canada", "Czech Republic", "France", "Italia", "Poland", "The Netherlands", "UK", "USA", "USSR", "Yugoslavia"}

mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")
-------------------------------------------------------------
mount_vfs_texture_path	(current_mod_path ..  "/Textures/S_75_Launcher")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/S_75_Rocket")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/SNR_75")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/hy_launcher")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/mys-m1")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/rapier_fsa_launcher_radar")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/rapier_fsa_optical_tracker_unit")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/rapier_fsa_missile")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/land_rover_101_fc")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/land_rover_109_s3")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/SeaCat")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/SeaDart")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/oil_platform")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/boxcartrinity")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/container_20ft")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/container_40ft")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/es44ah")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/tankcartrinity")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/wellcarnsc")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/scud")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/scud_crashed")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/R-17")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/Gunners_WWII")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/M4_Sherman")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Pz_IV_H")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Bedford_MWD")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Blitz_36-6700A")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/flak18_36_37_41")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Sd_Kfz_251")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/M2A1_HalfTrack")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Bofors40")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/ZSU_57_2")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/T-72B3")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/BTR82A")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/btr-80")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Handy_Wind")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/S-60_Artillery")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Seawise_Giant")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/generator_5i57")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/atz5")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/aa8")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Chieftain_mk3")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Leopard-2A5")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Leopard-2")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/leopard-2a4")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/leopard-2a4_trs")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/La_Combattante_II")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Firtina_T155")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/VAB_Mephisto")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/HOT-3")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/rls_19j6")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/TZ-22")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/ATZ60")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/atz60_crashed")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/S_75_Zil")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/S-200")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/NASAMS_Command_Post")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/NASAMS_Missile_Launcher")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/NASAMS_Radar_MPQ64F1")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/ewr_fps117")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/ewr_fps117radar_dome")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/ewr_fps117radar_shelter")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/RD-75")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/tt70")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/tt70_HL_weapons")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/ttHl")

mount_vfs_texture_path	(current_mod_path ..  "/Textures/KS-19")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Son-9")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/BDK_775_Textures")
-------------------------------------------------------------

dofile(current_mod_path .."/Database/db_sensors.lua")
dofile(current_mod_path .."/Database/Weapons/ammunition.lua")
dofile(current_mod_path .."/Database/Weapons/automaticgun.lua")
dofile(current_mod_path .."/Database/Weapons/cannon.lua")

dofile(current_mod_path .."/Database/Weapons/ammunition_missiles.lua")
dofile(current_mod_path .."/Database/Weapons/missile.lua")
dofile(current_mod_path .."/Database/Weapons/torpedoes.lua")

dofile(current_mod_path .."/Database/db_units_cars.lua")
dofile(current_mod_path .."/Database/db_units_ships.lua")
dofile(current_mod_path .."/Database/db_ground_objects.lua")

---------------------------------------------------------
plugin_done()