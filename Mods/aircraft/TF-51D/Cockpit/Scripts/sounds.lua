--[[
sounds ids 0 ... n
]]

local count = -1
local function counter()
	count = count + 1
	return count
end

SOUND_FUEL_SHUTOFF_ON   = counter()
SOUND_FUEL_SHUTOFF_OFF  = counter()
SOUND_RADIO_BTN 		= counter()
