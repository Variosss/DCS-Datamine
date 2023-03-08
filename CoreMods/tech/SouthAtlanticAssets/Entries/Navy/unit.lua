--Load Naval Units
----- Shapes --------------------------------------------------
mount_vfs_model_path	(current_mod_path.."/Shapes/")

----- Textures ---------------------------------------------------
mount_vfs_texture_path  (current_mod_path.."/Textures/");
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Leander/leander.zip");
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/HarborTug/HarborTug.zip");
mount_vfs_liveries_path (current_mod_path.."/Liveries");

local navy_path = '/Entries/Navy/'

dofile(current_mod_path .. navy_path ..'Launchers.lua')
dofile(current_mod_path .. navy_path ..'CastleClass_01.lua')
dofile(current_mod_path .. navy_path ..'HarborTug.lua')
dofile(current_mod_path .. navy_path ..'HMS_Invincible.lua')
dofile(current_mod_path .. navy_path ..'achilles.lua')
dofile(current_mod_path .. navy_path ..'andromeda.lua')
dofile(current_mod_path .. navy_path ..'ariadne.lua')
dofile(current_mod_path .. navy_path ..'condell.lua')
dofile(current_mod_path .. navy_path ..'lynch.lua')
dofile(current_mod_path .. navy_path ..'Tilde.lua')
dofile(current_mod_path .. navy_path ..'santafe.lua')

