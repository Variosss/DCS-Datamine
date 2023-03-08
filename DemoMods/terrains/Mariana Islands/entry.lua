theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['version']	= __DCS_VERSION__;
    ['state']		 = "sale",

	['Skins'] = 
	{
		{
			name = _("Mariana Islands"),
			dir  = "Theme",
		};
	};

	['description'] = _([[The Marianas map is centered on major Air Force and Navy US bases in the North Pacific. It streched to 1000 km from North to South and from East to West. While there are not much land in the area it contains all main inhabitat islands of the Marianas archipelago (Guam, Saipan, Tinian and Rota) with many military assets on them. The map is well suited for both realistic naval missions over the Philippine Sea and fictional online battles between islands. The map is made with all the latest DCS technologies and may have increased hardware requirements.]]);
	['linkBuy'] =
    {
        --ED      = "https://www.digitalcombatsimulator.com/en/shop/terrains/the_channel_terrain/",
        --STEAM   = "http://store.steampowered.com/app/1120301",
    },
} -- end of theatre

local self_ID = "MarianaIslands";
declare_plugin(self_ID, theatre);
plugin_done()

