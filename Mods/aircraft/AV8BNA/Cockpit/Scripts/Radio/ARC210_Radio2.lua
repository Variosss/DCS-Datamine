dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

presets = {}
if get_aircraft_mission_data ~= nil then
  local  radio_from_mission = get_aircraft_mission_data("Radio")
  local  uvhf_radio = radio_from_mission[2]
  if uvhf_radio then
   for i = 1,26 do
       presets[i] = (uvhf_radio.channels[i] or 131 ) * 1e6
   end
  end
end

need_to_be_closed = true