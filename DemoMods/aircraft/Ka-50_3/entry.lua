declare_plugin("Ka-50 Black Shark 3 by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _('The Ka-50 is a Russian single seat attack helicopter with unique counter-rotating rotors. The Black Shark 3 has added a Missile Warning System and an Air-to-Air "Igla" missiles, which will make it possible to combat with subsonic aircraft. In addition, a physical model of the Inertial Navigation System has been added, with its inherent features.'),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/black_shark_3/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("Ka-50 III"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
