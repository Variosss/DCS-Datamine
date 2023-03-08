 declare_plugin("AV-8B N/A by RAZBAM Sims",
	{
		installed 	 = true, -- if false that will be place holder , or advertising
		dirName	  	 = current_mod_path,
		
		displayName = _("AV-8B N/A"),
		version		 = "Dev",
		state		 = "sale",
		info		 = _("The AV-8B Harrier II Night Attack is a single-engine ground-attack aircraft that constitutes the second generation of the Harrier Jump Jet family. Capable of vertical or short takeoff and landing (V/STOL), the aircraft was designed in the late 1970s as an Anglo-American development of the British Hawker Siddeley Harrier, the first operational V/STOL aircraft. Named after a bird of prey, it is primarily employed on light attack or multi-role missions, ranging from close air support of ground troops to armed reconnaissance."),
		linkBuy =
		{
			ED      = "http://www.digitalcombatsimulator.com/",
		},
		
		Skins	=
		{
			{
				name	= _("AV8BNA"),
				dir		= "Skins/1"
			},
		},
	}
)
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
