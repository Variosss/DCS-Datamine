local self_ID = "Mi-8MTV2 Hip by Belsimtek"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

version		 = __DCS_VERSION__.." beta",
state		 = "sale",
info		 = _("Mi-8MTV2 offers you an opportunity to pilot the most widely produced twin-engine helicopter in the world, the Russian Mi-8 'Hip', in the most authentic model of this helicopter ever made for the PC. Over 12,000 of these machines have been produced in a wide variety of models flown in over 20 operator nations."),

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_mi8mtv2_magnificent_eight/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
    
Skins	=
	{
		{
			name	= _("Mi-8MTV2"),
			dir		= "Skins/1"
		},
	},

})

plugin_done()
