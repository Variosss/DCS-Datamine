theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['version']	= __DCS_VERSION__;
    ['state']		 = "sale",

	['Skins'] = 
	{
		{
			name = _("Persian Gulf"),
			dir  = "Theme",
		};
	};

	['description'] = _([[The Persian Gulf Map for DCS World focuses on the Strait of Hormuz, which is the strategic choke point between the oil-rich Persian Gulf and the rest of the world. Flanked by Iran to the North and western-supported UAE and Oman to the south, this has been one of the world's most dangerous flash points for decades. It was the location of Operation Praying Mantis in 1988 in which the US Navy sank several Iranian naval vessels.]]);
	['linkBuy'] =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/terrains/persiangulf_terrain/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
} -- end of theatre

local self_ID = "PersianGulf";
declare_plugin(self_ID, theatre);
plugin_done()

