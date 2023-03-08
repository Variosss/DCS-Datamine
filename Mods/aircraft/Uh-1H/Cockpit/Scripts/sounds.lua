--[[
sounds ids 1 ... n
]]
local count = -1
local function counter()
	count = count + 1
	return count
end

SOUND_NOSOUND = -2
SOUND_ROTARY 	= counter()
SOUND_INVERTER	= counter()
