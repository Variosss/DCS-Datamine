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
SOUND_SW1_FULL	= counter()
SOUND_SW1_FULL_OFF = counter()
SOUND_SW2		= counter()
SOUND_SW3_OPEN	= counter()
SOUND_SW3_CLOSE	= counter()
SOUND_SW4_ON	= counter()
SOUND_SW4_OFF	= counter()
SOUND_SW5_ON	= counter()
SOUND_SW5_OFF	= counter()
SOUND_SW6		= counter()
SOUND_SW7_UP	= counter()
SOUND_SW7_DOWN	= counter()
SOUND_SW8_UP	= counter()
SOUND_SW8_DOWN	= counter()
SOUND_SW9_1		= counter()
SOUND_SW9_2		= counter()
SOUND_SW9_3		= counter()

SOUND_CLOCK_SW13_ON		= counter()
SOUND_CLOCK_SW13_OFF	= counter()
SOUND_CLOCK_SW14_ON		= counter()
SOUND_CLOCK_SW14_OFF	= counter()
SOUND_CLOCK_SW15		= counter()
SOUND_CLOCK_SW16		= counter()
SOUND_SW17				= counter()
SOUND_SW18_ON			= counter()
SOUND_SW18_OFF			= counter()
SOUND_SW19_PULL			= counter()
SOUND_SW19_PUSH			= counter()
SOUND_SW20_ON			= counter()
SOUND_SW20_OFF			= counter()
SOUND_SW21				= counter()
SOUND_SW21_OFF			= counter()
SOUND_TRIM_ON			= counter()
SOUND_TRIM_OFF			= counter()