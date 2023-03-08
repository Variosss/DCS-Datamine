if not USE_TERRAIN4 then
	return
end

theatre =
{
	['developerName'] = "Ugra-Media";
	['state'] = "installed";
	['type'] = "terrain";
	['version'] = "";
	['update_id'] = "SYRIA_terrain";

	['Skins'] = 
	{
		{
			name = _("Syria"),
			dir  = "Theme",
		};
	};

	['image'] = 'map.png';
	['description'] = _("The Syria map is 640 km north to south and 1160 km east to west, giving a total map area of 421,600 sq km. The map includes all of Lebanon, western Syria, northern Israel and Jordan, and southern Turkey. The map is divided between coastal areas of the eastern Mediterranean Sea, and coastal mountain ranges, and desert interior. The Syria map is a varied map that provides a wealth of historic and \"what if\" scenarios that will continue to expand during the early access period to also include Cyprus.");
	['id'] = "Syria";

	['localizedName'] = "Syria";
	['creditsFile'] = "credits.txt";
	['nodesMapFile'] = "MissionGenerator/nodesMap.png";
	['nodesFile'] = "MissionGenerator/nodes.lua";
} -- end of theatre

dofile(current_mod_path .. '/' .. 'MissionGenerator/nodesMap.lua')

local self_ID = "Syria";
declare_plugin(self_ID, theatre);
plugin_done()
