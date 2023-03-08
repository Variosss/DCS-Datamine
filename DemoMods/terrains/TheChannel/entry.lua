theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['version']	= __DCS_VERSION__;
    ['state']		 = "sale",

	['Skins'] = 
	{
		{
			name = _("The Channel"),
			dir  = "Theme",
		};
	};

	['description'] = _([[Separating England from the Third Reich in World War II, the English Channel provided a barrier that the axis could not breach. The Channel map provides a detailed and accurate representation of southeastern England and the adjacent region across the Channel in mainland Europe. It encompasses all of the historical airfields, urban areas, roads and rails, ports and other features that make it the perfect setting for the World War II air war in Europe between the late 1930s and 1944.]]);
	['linkBuy'] =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/terrains/the_channel_terrain/",
        STEAM   = "http://store.steampowered.com/app/1120301",
    },
} -- end of theatre

local self_ID = "TheChannel";
declare_plugin(self_ID, theatre);
plugin_done()

