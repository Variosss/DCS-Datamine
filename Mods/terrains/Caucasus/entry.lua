if not USE_TERRAIN4 then
	return
end

theatre =
{
	['developerName']   =   "Eagle Dynamics";
	['state']	= "installed";
	['type']	= "terrain";
	['version']	= "";
	['update_id']	= "CAUCASUS_terrain";

	['Skins'] = 
	{
		{
			name = _("Caucasus"),
			dir  = "Theme",
		};
	};

	['image'] = 'map.png';
	['description'] = _("This region along the eastern Black Sea consists of Russian, Georgian, and Turkish territory. This area includes many airbases, urban areas, lines of communications, and all four seasons.");
	['id'] = "Caucasus";
	['localizedName'] = "Caucasus";
	['creditsFile'] = "credits.txt";
	['nodesMapFile'] = 'MissionGenerator/nodesMap.png';
	['nodesFile'] = 'MissionGenerator/nodes.lua';
	['nodesMapBorders'] = {
		-418619.187500, 113728.156250, 26382.500000, 943187.062500  --minX, minZ, maxX, maxZ
	};
} -- end of theatre

local self_ID = "Caucasus";
declare_plugin(self_ID, theatre);
plugin_done()
