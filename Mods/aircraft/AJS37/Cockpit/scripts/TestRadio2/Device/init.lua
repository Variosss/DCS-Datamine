dofile(LockOn_Options.common_script_path..'Radio.lua')
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

local gettext = require("i_18n")
_ = gettext.translate

power 				= 10.0			--Watts

presets = {}
if get_aircraft_mission_data ~= nil then
	local  radio_from_mission = get_aircraft_mission_data("Radio")
	local  uhf_radio = radio_from_mission[1]
	if uhf_radio then
		for i = 1,47 do
			presets[i] = (uhf_radio.channels[i] or 225 ) * 1e6
		end
	end
end

GUI = {
	displayName = _('AM Radio'),
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