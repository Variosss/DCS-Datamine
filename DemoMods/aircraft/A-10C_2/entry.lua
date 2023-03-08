declare_plugin("A-10C II Warthog by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _('DCS: A-10C II Tank Killer is a PC simulation of the U.S. premier Close Air Support attack aircraft. Tank Killer brings the most realistic PC simulation of the A-10C regarding flight dynamics, avionics, sensors, and weapon systems. You also have the option to play Tank Killer in "Game" mode for a casual game experience. Fly missions against and with a wide array of air, land, and sea forces. Create your own missions and campaigns with the included Mission and Campaign Editors and fly with and against friends online using the included online game browser.'),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/tank_killer/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("A-10C II"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
