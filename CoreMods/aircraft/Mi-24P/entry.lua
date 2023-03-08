declare_plugin("Mi-24P AI by Eagle Dynamics",
{
installed 	 	  = false, -- if false that will be place holder , or advertising
dirName	  	 	  = current_mod_path,
version		 	  = __DCS_VERSION__,		 
state		 	  = "installed",
info		 	  = _("Mi-24P AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia'
})
---------------------------------------------------------
dofile(current_mod_path..'/Mi-24P.lua')
---------------------------------------------------------
plugin_done()