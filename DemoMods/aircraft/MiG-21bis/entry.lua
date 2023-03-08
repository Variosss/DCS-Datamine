--/N/ Sep 2015
--/M/ Dec 2015

local self_ID = "MiG-21Bis by Magnitude 3 LLC"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
displayName  = _("MiG-21Bis"),
version		 = "buy",
state		 = "sale",
info		 = _("Initially designed in the late 1950s, the MiG-21 is today one of the most iconic tactical fighter/interceptor aircraft. It has participated in several local wars and conflicts and is still seeing widespread use in original or upgraded versions. Well known for its simplicity and durability, it was the aircraft of choice for many pilots and a highly respected opponent during the early jet era."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/mig21bis/",
		STEAM 	= "https://store.steampowered.com/app/316964/DCS_MiG21Bis/",
    },
Skins	= 
	{
		{
			name	= "MiG-21Bis",
			dir		= "Skins/1"
		},
	},
})
plugin_done()
