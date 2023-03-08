declare_plugin("RailwayObjectsPack",
{
installed 	 	  = true,
state		 	  = "installed",
developerName	  = "Eagle Dynamics",
version		 	  = __DCS_VERSION__,		 
})


mount_vfs_model_path    (current_mod_path ..  "/Shapes")
-------------------------------------------------------------
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Railroad_trains_texture")
-------------------------------------------------------------

dofile(current_mod_path .."/Database/db_units_cars.lua")
---------------------------------------------------------
plugin_done()