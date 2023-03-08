local self_ID = "SA342 Gazelle by Polychop-Simulations"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
displayName  = _("SA342"),
version		 = "2.7",
registryPath     = "Eagle Dynamics\\SA342",
state		 = "sale",
info		 = _("SA342 Gazelle by Polychop-Simulations"),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/gazelle/",
    },
Skins	= 
	{
		{
			name	= "SA342",
			dir		= "Skins/1"
		},
	},
})
plugin_done()
