    declare_plugin("C-101 Aviojet",
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,


version = __DCS_VERSION__,
state		 = "sale",
info		 = _("The CASA C-101 Aviojet is a low-wing single engine jet-powered advanced trainer and light attack aircraft. It remains in service in the Spanish Air Force and some other countries; it is also flown by the Patrulla Aguila aerobatics team. The module features two variants (C-101EB and C-101CC), with their respective cockpits and systems modelled to exacting detail. Feel like a real pilot operating these aircraft just like their real-world counterparts."),
creditsFile  = "credits.txt",
linkBuy =
    {
        ED      = "http://www.digitalcombatsimulator.com/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("C-101EB"),
			dir		= "Themes"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
