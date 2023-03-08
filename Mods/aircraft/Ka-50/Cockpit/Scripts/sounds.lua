--[[
sounds ids 0 ... n
]]

local count = -1
local function counter()
	count = count + 1
	return count
end
SOUND_SW1		= counter()
SOUND_SW1_OFF	= counter()
SOUND_SW2		= counter()
SOUND_SW3_OPEN	= counter()
SOUND_SW3_CLOSE	= counter()
SOUND_SW4_UP	= counter()
SOUND_SW4_DOWN	= counter()
SOUND_SW5		= counter()
SOUND_SW6		= counter()
SOUND_SW7_ON	= counter()
SOUND_SW7_OFF	= counter()
SOUND_SW8_ON	= counter()
SOUND_SW8_OFF	= counter()
SOUND_SW9_ON	= counter()
SOUND_SW9_OFF	= counter()
SOUND_SW9_ROTATE_1	= counter()
SOUND_SW9_ROTATE_2	= counter()
SOUND_SW10_ON	= counter()
SOUND_SW10_OFF	= counter()