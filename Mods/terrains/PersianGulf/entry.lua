if not USE_TERRAIN4 then
	return
end

theatre =
{
	['developerName'] = "";
	['state'] = "installed";
	['type'] = "terrain";
	['version'] = "";
	['update_id'] = "PERSIANGULF_terrain";

	['Skins'] = 
	{
		{
			name = _("Persian Gulf"),
			dir  = "Theme",
		};
	};

	['image'] = 'map.png';
	['description'] = _("The Persian Gulf Map for DCS World focuses on the Strait of Hormuz, which is the strategic choke point between the oil-rich Persian Gulf and the rest of the world. Flanked by Iran to the North and western-supported UAE and Oman to the south, this has been one of the world\'s most dangerous flash points for decades. It was the location of Operation Praying Mantis in 1988 in which the US Navy sank several Iranian naval vessels.");
	['id'] = "PersianGulf";

	['localizedName'] = "Persian Gulf";
	['creditsFile'] = "credits.txt";
	['nodesMapFile'] = "MissionGenerator/nodesMap.png";
	['nodesFile'] = "MissionGenerator/nodes.lua";
} -- end of theatre

dofile(current_mod_path .. '/' .. 'MissionGenerator/nodesMap.lua')

local self_ID = "PersianGulf";
declare_plugin(self_ID, theatre);
plugin_done()
