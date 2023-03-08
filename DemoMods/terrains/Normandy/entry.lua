theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['version']	= __DCS_VERSION__;
    ['state']		 = "sale",

	['Skins'] = 
	{
		{
			name = _("Normandy"),
			dir  = "Theme",
		};
	};

	['description'] = _([[The DCS: Normandy 1944 Map is centered on the World War II battlefield of Normandy, France and is specifically created to depict the period after the D-Day landings and the establishment of several allied airfields in Normandy to support the beachhead breakout in late June 1944. The map measures 267 x 348 kilometers and includes airfields in both Normandy and southern England. The map includes the famous D-Day landing beaches and the "Atlantic Wall", rolling bocage fields of Normandy, large cities like Caen and Rouen, ports of Cherbourg and Le Havre, and 30 airfields. The map also includes multiple seasons and more detail and accuracy than any previous DCS World map by utilizing new map technologies.]]);
	['linkBuy'] =
    {
        ED      = "https://www.digitalcombatsimulator.com/ru/shop/special_offers/normandy_and_wwii_assets_pack_bundle/",
        --STEAM   = "http://store.steampowered.com/app/223750",
    },
} -- end of theatre

local self_ID = "Normandy";
declare_plugin(self_ID, theatre);
plugin_done()
