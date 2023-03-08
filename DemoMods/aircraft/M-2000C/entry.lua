 declare_plugin("M-2000C by RAZBAM Sims",
	{
		installed 	 = true, -- if false that will be place holder , or advertising
		dirName	  	 = current_mod_path,
		
		
		version		 = "2.0.0 Beta",
		state		 = "sale",
		info		 = _("The M-2000C is a French multirole, single-engine fourth-generation jet fighter. It was designed in the late 1970s as a lightweight fighter based on previous delta winged aircraft for the French Air Force (Armee de l'Air). The M-2000 evolved into a multirole aircraft with several variants developed. Over 600 aircraft were built and it has been in service with nine nations."),
		linkBuy =
		{
			ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/m2000c/",
		},
		
		Skins	=
		{
			{
				name	= _("M-2000C"),
				dir		= "Skins/1"
			},
		},
	}
)
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
