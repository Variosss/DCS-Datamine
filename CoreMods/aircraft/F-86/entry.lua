declare_plugin("F-86F Sabre AI by Eagle Dynamics",
{
installed 	 	  = true, -- if false that will be place holder , or advertising
dirName	  	 	  = current_mod_path,
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
info		 	  = _("A 1950s US fighter first generation. It’s swept wing, single engine jet was the most important aircraft of the Korean War and often tangled over the infamous “MiG Alley”."),
encyclopedia_path = current_mod_path..'/Encyclopedia',
})
--mounting 3d model paths and texture paths 
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/f-86f")
---------------------------------------------------------
dofile(current_mod_path..'/F-86.lua')
---------------------------------------------------------
plugin_done()