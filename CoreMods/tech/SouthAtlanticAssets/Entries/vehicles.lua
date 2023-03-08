--Mount Models
mount_vfs_model_path (current_mod_path .. '/Shapes/Vehicles')

--Mount Textures
mount_vfs_texture_path  (current_mod_path.."/Textures/Vehicles")

--Load Units
dofile(current_mod_path .. '/Entries/Vehicles/unit.lua')
