local indicator = GetSelf()
hud_repeater = indicator:getRepeater()

local log = require("log")

HUD_ID				= "Main"
GLASS_LEVEL			= 10
MIL_PER_PIXEL_RATIO	= 100.0 / 275.0
ALPHA_BLEND			= true
HUD_MAIN			= true
HUD_SCALE			= 1.0
collimated			= true
use_mipfilter		= true

if hud_repeater then
	HUD_MAIN		= false
	HUD_SCALE		= 0.66
	collimated		= false
	
	if hud_repeater == "L" then
		GLASS_LEVEL		= 14
		HUD_ID 			= "Front Left"
	elseif hud_repeater == "R" then
		GLASS_LEVEL		= 18
		HUD_ID 			= "Front Right"
	elseif hud_repeater == "C" then
		GLASS_LEVEL		= 22
		HUD_ID 			= "Front Center"
	end
end

--log.info(string.format("HUD GLASS LEVEL:: HUD %s, HUD GLASS LEVEL %f, HUD_SCALE %f", HUD_ID, GLASS_LEVEL, HUD_SCALE))