local self_ID = "SA342 AI by Polychop-Simulations"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
version		 = "2.7",
state		 = "installed",
info		 = _("SA342 AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia'
})

---------------------------------------------------------
dofile(current_mod_path..'/SA342.lua')
---------------------------------------------------------

plugin_done()