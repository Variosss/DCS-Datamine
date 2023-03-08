declare_plugin("Ka-50 Black Shark by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The Ka-50 is a Russian attack helicopter of exceptional design and capability. Featuring its unique counter-rotating rotors, the Black Shark also employs a variety of guided missiles, rockets, and bombs. As the only operational single seat attack helicopter, the Black Shark has features such as an ejection seat and avionics that assist the single pilot workload. "),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_black_shark_2/",
        STEAM   = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-DCS-Black-Shark-2/5006544",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-DCS-Black-Shark-2/5006545/",
    },

Skins	=
	{
		{
			name	= _("Ka-50"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
