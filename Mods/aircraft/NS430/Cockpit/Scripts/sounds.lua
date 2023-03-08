-- [[ Sounds IDs 0 ... n ]]
local count = _LAST_CLICK_SOUND_
local function counter()
    count = count + 1
    return count
end

SOUND_NOSOUND       = -2
SOUND_DEFAULT       = -1

VOLUME				= counter()
SOUND_BUTTON_ON     = counter()
SOUND_BUTTON_OFF    = counter()
SOUND_BTN_PUSH_ON   = counter()
SOUND_BTN_PUSH_OFF  = counter()
ROTATION			= counter()
SOUND_BUTTON_COM	= counter()
SOUND_BUTTON_VLOC	= counter()
--ROTATION_2			= counter()
--ROTATION_3			= counter()