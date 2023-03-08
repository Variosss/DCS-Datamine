theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['version']	= __DCS_VERSION__;
    ['state']		 = "sale",

	['Skins'] = 
	{
		{
			name = _("Nevada"),
			dir  = "Theme",
		};
	};

	['description'] = _("The Nevada Test and Training Range (NTTR) has the largest contiguous air and ground space available for peacetime military operations in the free world. The NTTR land area includes simulated air defense systems, mock airbases, and several target ranges. The NTTR was also used for nuclear testing. Today, it is home to RED FLAG and other military exercises that include countries from around the world. The NTTR map for DCS World 2 includes Nellis AFB, Creech AFB, and the infamous Groom Lake AFB (aka Area 51). This map also includes the city of Las Vegas, McCarran International Airport, and Hoover Dam.");
	['linkBuy'] =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/terrains/nttr_terrain/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
} -- end of theatre

local self_ID = "Nevada";
declare_plugin(self_ID, theatre);
plugin_done()
