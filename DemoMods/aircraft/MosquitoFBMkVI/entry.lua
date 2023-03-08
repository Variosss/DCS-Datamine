self_ID = "DH.98 Mosquito FB Mk. VI by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("Mosquito FB Mk. VI"),

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("One of the most revolutionary and effective combat aircraft of WWII, the British de Havilland Mosquito was in service with the Royal Air Force (RAF) from 1940 to 1961. A brilliant and innovative design, the ‘Mossie’ left a bright and lasting mark in the history of aviation."),


linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/ru/shop/modules/mosquito/",
        STEAM   = "https://store.steampowered.com/app/1724230/DCS_Mosquito_FB_VI/",
    },

Skins	= 
	{
		{
			name	= _("Mosquito FB Mk. VI"),
			dir		= "Skins/1"
		},
	},

})

plugin_done()
