--[[
sounds ids 0 ... n
]]

local count = -1
local function counter()
	count = count + 1
	return count
end


SOUND_DATACARTRIDGE = counter()
SOUND_FLIPSWITCH_01_DN = counter()
SOUND_FLIPSWITCH_01_UP = counter()
SOUND_VALJARE_01 = counter()
SOUND_VALJARE_02 = counter()
SOUND_VALJARE_03 = counter()
SOUND_BUTTON_DOWN = counter()
SOUND_BUTTON_DOWN_DONE = counter()
SOUND_BUTTON_FULL = counter()
SOUND_EJECTION_ARM = counter()
SOUND_EJECTION_DISARM = counter()
SOUND_AFK_HANDLE = counter()
SOUND_GEAR_HANDLE = counter()
SOUND_FLIPCOVER = counter()
SOUND_HUDTOGGLE = counter()
SOUND_CANOPY = counter()
SOUND_OXYGEN = counter()