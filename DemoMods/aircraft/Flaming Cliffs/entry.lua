declare_plugin("Flaming Cliffs by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("Flaming Cliffs 3 (FC3) is the continuation of the Flaming Cliffs series that features the F-15C, A-10A, Su-27, Su-33, MiG-29A, MiG-29S, Su-25T, and Su-25. Each aircraft provides an easy learning curve for new players and focuses on a broad range of aircraft rather than a detailed single aircraft. This 3rd version of Flaming Cliffs offers a new F-15C cockpit, improved flight dynamics, expanded combat area, new AI units, improved AI, a new F-15C campaign and a dozen single missions, and countless improvements to the series."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_flaming_cliffs_3/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	= 
	{
		{
			name	= _("FC3"),
			dir		= "Skins/1"
		},
	},
})
----------------------------------------------------------------------------------------
plugin_done()
