
-- Mount Model Files
mount_vfs_model_path (current_mod_path.."/Shapes/Navy")

-- Mount Textures
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/HarborTug")
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/SA_Orca")
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Leeds_Castle")
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/santa_fe")
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/hms_invincible")
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Leander")

mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Tilde")
--Load Units
--dofile(current_mod_path .. '/Entries/Navy/sensors.lua')
dofile(current_mod_path .. '/Entries/Navy/unit.lua')
