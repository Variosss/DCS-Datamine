dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

power 				= 10.0			--Watts
presets = {}

if get_aircraft_mission_data ~= nil then
	local  radio_from_mission = get_aircraft_mission_data("Radio")
	local  radio_1 = radio_from_mission[1]
	if radio_1 then
		for i = 1,20 do
		    presets[i] = (radio_1.channels[i] or 131 ) * 1e6
		end
	end
else
	presets[1]  = 131 * 1e6 --MHz
	presets[2]  = 121 * 1e6 --MHz
	presets[3]  = 141 * 1e6 --MHz
	presets[4]  = 131 * 1e6 --MHz
end


GUI = {
	displayName = _('R-828'),
	AM = true,
	FM = false,
}

GUI.channels = presets

--settings 
squelch = true
volume	=	0.5
channel = 0

max_search_time = 5.0

need_to_be_closed = true