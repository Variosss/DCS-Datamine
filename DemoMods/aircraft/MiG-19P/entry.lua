 declare_plugin("MiG-19P by RAZBAM",
	{
		installed 	 = true, -- if false that will be place holder , or advertising
		dirName	  	 = current_mod_path,
		
		displayName		= _("MiG-19P"),
		version			= "Dev 2.5.x",
		state			= "sale",
		info			= _("The Mikoyan-Gurevich MiG-19 (Russian: Микоян и Гуревич МиГ-19; NATO reporting name: Farmer) is a Soviet second-generation, single-seat, twin jet-engined fighter aircraft. It was the first Soviet production aircraft capable of supersonic speeds in level flight. A comparable U.S. 'Century Series' fighter was the North American F-100 Super Sabre, although the MiG-19 would primarily oppose the more modern McDonnell Douglas F-4 Phantom II and Republic F-105 Thunderchief over North Vietnam."),
		linkBuy =
		{
			ED			= "https://www.digitalcombatsimulator.com/en/shop/modules/farmer/",
		},
		
		Skins	=
		{
			{
				name	= _("MiG-19P"),
				dir		= "Skins/1"
			},
		},
	}
)
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
