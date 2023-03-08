declare_plugin("MiG-15bis AI by Eagle Dynamics",
{
installed 	 	  = true, -- if false that will be place holder , or advertising
dirName	  	 	  = current_mod_path,
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
info		 	  = _("The swept wing jet fighter first generation from the Mikoyan-Gurevich design bureau. Seen in numbers over North Korea, its maneuverability and powerful cannons made it a force to be reckoned with."),
encyclopedia_path = current_mod_path..'/Encyclopedia'
})
--mounting 3d model paths and texture paths 
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/MiG-15bis")
---------------------------------------------------------
dofile(current_mod_path..'/MiG-15bis.lua')
---------------------------------------------------------
plugin_done()