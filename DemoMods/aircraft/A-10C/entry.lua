declare_plugin("A-10C Warthog by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The A-10C is the premier attack jet for the U.S. Air Force and combines awesome firepower with advanced sensors and survivability. The 30mm cannon, Maverick missiles, GPS and laser guided bombs, and rockets are just a few of its many weapons. Most every switch, dial and button in the A-10C cockpit is controllable and allows you to operate the aircraft just as a real A-10C pilot would."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_a10c_warthog/",
        STEAM   = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-DCS-A-10C-Warthog/5006541",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-DCS-A-10C-Warthog/5006543/",
    },

Skins	=
	{
		{
			name	= _("A-10C"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
