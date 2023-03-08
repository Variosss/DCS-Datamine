local gettext = require("i_18n")
_ = gettext.translate

terrainVersion	= get_terrain_related_data("edterrainVersion") or 4.0
theatre			= get_terrain_related_data("name")
local caucasus	= theatre == "Caucasus"

is_caucasus = 0

if theatre == "Caucasus" then
	is_caucasus = 1
elseif theatre == "Nevada" then
	is_caucasus = 2
elseif theatre == "Normandy" then
	is_caucasus = 3
elseif theatre == "Persian Gulf" then
	is_caucasus = 4
end

need_to_be_closed = true
