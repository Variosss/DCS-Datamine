local self_ID = "MiG-15bis by Belsimtek"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
version		 = __DCS_VERSION__,		 
state		 = "sale",
info		 = _("MiG-15bis is a swept wing jet fighter, developed in Mikoyan-Gurevich design bureau. It is arguably one of the best fighters of early 50's. One of the most widely produced jet fighters ever made, it became the symbol of Soviet aviation. It was primary intended to be air superiority fighter with limited attack airplane capabilities. It has a powerful armament: two 23-mm and one 37-mm cannons."),

Skins	= 
	{
		{
			name	= _("MiG-15bis"),
			dir		= "Skins/1"
		},
	},

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/mig15bis/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
})

plugin_done()-- finish declaration , clear temporal data
