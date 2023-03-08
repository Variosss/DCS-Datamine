declare_plugin("Mi-24P by Eagle Dynamics",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("Mi-24P is the iconic, recognizable, and venerable helicopter which scores the highest number of combat involvements in various conflicts. Fast and reliable, it allows you to engage small-sized mobile and stationary ground targets with dumb and guided weapons, as well as destroy other enemy aircraft. Perform CAS missions, escort convoys, counteract enemy helicopters using a powerful double-barreled 30-mm cannon, air bombs, various guided and unguided missiles. Typically this helicopter is capable to destroy 4-6 armored targets per mission."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/hind/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("Mi-24P"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
