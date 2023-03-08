declare_plugin("Hawk T.1A AI by VEAO Simulations",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
version		 = "2.5.3 Beta",		 
state		 = "installed",
info		 = _("Hawk AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
})
---------------------------------------------------------
dofile(current_mod_path..'/Hawk.lua')
---------------------------------------------------------
plugin_done()