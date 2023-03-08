declare_plugin("Mirage F1 by Aerges",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version 	 = __DCS_VERSION__ .. " EA",	
state		 = "sale",
info		 = _("The Mirage F1 is a third-generation air superiority fighter and attack aircraft, designed and built in France. It has been exported to around a dozen countries, entering combat in many of them. More than 720 units have been manufactured between 1966 and 1992."),
creditsFile  = "credits.txt",
linkBuy =
    {
        ED      = "http://www.digitalcombatsimulator.com/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("Mirage F1"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
