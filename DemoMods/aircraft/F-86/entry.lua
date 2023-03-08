local self_ID = "F-86F Sabre by Belsimtek"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
version		 = __DCS_VERSION__,		 
state		 = "sale",
info		 = _("The North American F-86 Sabre was a transonic jet fighter aircraft. Produced by North American Aviation, the Sabre is best known as the United States' first swept wing fighter which could counter the similarly-winged Soviet MiG-15 in high-speed dogfights over the skies of the Korean War."),

Skins	= 
	{
		{
			name	= _("F-86F"),
			dir		= "Skins/1"
		},
	},

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/sabre/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
})

plugin_done()-- finish declaration , clear temporal data
