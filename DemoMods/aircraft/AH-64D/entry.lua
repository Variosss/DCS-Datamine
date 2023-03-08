local self_ID = "AH-64D BLK.II"

declare_plugin(self_ID,
{
	installed		= true,
	dirName			= current_mod_path,
	displayName		= _("AH-64D BLK.II"),
	shortName		= "AH-64D",
	version			= __DCS_VERSION__.." WIP",
	state			= "sale",
	developerName	= _("Eagle Dynamics"),
	info			= _("The AH-64D has served as the backbone of the    U.S. Army attack helicopter force since 2003. Based on the AH-64A, the “Delta” version is a tandem-crewed helicopter with the pilot in the back seat and the co-pilot/gunner (CP/G) in the front. Armed with a 30mm Chain Gun under the nose, Hellfire missiles and 2.75” rockets on the stub wings, the AH-64D proved its mettle in Iraq and Afghanistan against a wide array of threats."),
	
	linkBuy =
	{
		ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/ah-64d/",
		STEAM   = "http://store.steampowered.com/app/223750",
	},
	
	Skins =
	{
		{
			name	= "AH-64D",
			dir		= "Skins/1"
		},
	},

})

----------------------------------------------------------------------------------------
plugin_done()-- finish declaration , clear temporal data
