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
elseif theatre == "The Channel" then
	is_caucasus = 5
elseif theatre == "Syria" then
	is_caucasus = 6
elseif theatre == "Mariannas Islands" then
	is_caucasus = 7
elseif theatre == "Falklands" then
	is_caucasus = 8
end

TDC_AxisDeadZone = 0.08
TDC_SlewValue = 4.0

--[[
Damage =
{
	{
		Failure = 1,
		Failure_name = "MSC_FAILURE_TOTAL",
		Failure_editor_name = _("Mission Systems Computer Total Failure"),
		Element = 77,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
}
--]]

need_to_be_closed = true
