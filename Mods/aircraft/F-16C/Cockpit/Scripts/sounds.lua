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
SOUND_SW3		= counter()
SOUND_SW3_OFF	= counter()
SOUND_SW4_ON	= counter()
SOUND_SW4_OFF	= counter()
SOUND_SW5_ON	= counter()
SOUND_SW5_OFF	= counter()
SOUND_SW6_OPEN	= counter()
SOUND_SW6_CLOSE	= counter()
SOUND_SW7		= counter()
SOUND_SW8_UP	= counter()
SOUND_SW8_DOWN	= counter()
SOUND_SW9_UP	= counter()
SOUND_SW9_DOWN	= counter()
SOUND_SW10_UP	= counter()
SOUND_SW10_DOWN	= counter()
SOUND_SW11_UP	= counter()
SOUND_SW11_DOWN	= counter()
SOUND_SW12_ON	= counter()
SOUND_SW12_OFF	= counter()