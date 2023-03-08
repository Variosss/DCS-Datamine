--[[
sounds ids 1 ... n
]]
local count = -1
local function counter()
	count = count + 1
	return count
end

SOUND_NOSOUND   = -2

SOUND_SW1		= counter()
SOUND_SW1_OFF	= counter()
SOUND_SW2		= counter()
SOUND_SW3		= counter()
SOUND_SW3_OFF	= counter()
SOUND_SW4_ON	= counter()
SOUND_SW4_OFF	= counter()
SOUND_SW5_OPEN	= counter()
SOUND_SW5_CLOSE	= counter()
SOUND_SW6		= counter()
SOUND_SW7_DOWN	= counter()
SOUND_SW7_UP	= counter()
SOUND_SW8_OPEN	= counter()
SOUND_SW8_CLOSE	= counter()
SOUND_SW9		= counter()
SOUND_SW10_DOWN	= counter()
SOUND_SW10_UP	= counter()
SOUND_SW11_DOWN	= counter()
SOUND_SW11_UP	= counter()