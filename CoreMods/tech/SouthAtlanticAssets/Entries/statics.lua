--Mount Models
mount_vfs_model_path (current_mod_path .. '/Shapes/Static')

--Mount Textures
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Single_Pad")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/WindTurbine")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Stanley_LightHouse")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Small_LightHouse")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Cat_345L")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/TowerCrane_01")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Orca")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Billboards")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/skiramp_01")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/Nodding_Donkey")
mount_vfs_texture_path  (current_mod_path.."/Textures/Static/L118")
--Load Units
dofile(current_mod_path .. '/Entries/Static/unit.lua')