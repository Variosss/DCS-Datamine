device_timer_dt = 0.2

local count = 0
local function counter()
	count = count + 1
	return count
end



count = 0
ENGINE_FIRE_LEFT	= counter()
ENGINE_FIRE_RIGHT	= counter()
APU_FIRE			= counter()
BLEED_AIR_LEFT		= counter()
BLEED_AIR_RIGHT		= counter()
MASTER_CAUTION		= counter()

VoiceAlertsAndTonesDuration_1 = {}
VoiceAlertsAndTonesDuration_1[ENGINE_FIRE_LEFT]		= 4.0
VoiceAlertsAndTonesDuration_1[ENGINE_FIRE_RIGHT]	= 4.0
VoiceAlertsAndTonesDuration_1[APU_FIRE]				= 3.8
VoiceAlertsAndTonesDuration_1[BLEED_AIR_LEFT]		= 3.4
VoiceAlertsAndTonesDuration_1[BLEED_AIR_RIGHT]		= 3.2
VoiceAlertsAndTonesDuration_1[MASTER_CAUTION]		= 0.95


count = 0
ROLL_RIGHT					= counter()
ROLL_LEFT					= counter()
POWER						= counter()
CHECK_GEAR					= counter()
ROLL_OUT					= counter()
PULL_UP						= counter()
AIRSPEED					= counter()
ENGINE_RIGHT				= counter()
ENGINE_LEFT					= counter()
MODE_4_REPLY				= counter()
FLIGHT_CONTROLS				= counter()
FLIGHT_COMPUTER_HOT			= counter()
ALTITUDE					= counter()
BINGO						= counter()
FUEL_LO						= counter()
LOW_ALTITUDE_WARNING_TONE	= counter()

VoiceAlertsAndTonesDuration_2 = {}
VoiceAlertsAndTonesDuration_2[ROLL_RIGHT]					= 1.8
VoiceAlertsAndTonesDuration_2[ROLL_LEFT]					= 1.8
VoiceAlertsAndTonesDuration_2[POWER]						= 1.7
VoiceAlertsAndTonesDuration_2[CHECK_GEAR]					= 1.9
VoiceAlertsAndTonesDuration_2[ROLL_OUT]						= 1.7
VoiceAlertsAndTonesDuration_2[PULL_UP]						= 1.6
VoiceAlertsAndTonesDuration_2[AIRSPEED]						= 3.0	-- TODO:
VoiceAlertsAndTonesDuration_2[ENGINE_RIGHT]					= 3.1
VoiceAlertsAndTonesDuration_2[ENGINE_LEFT]					= 3.1
VoiceAlertsAndTonesDuration_2[MODE_4_REPLY]					= 4.3
VoiceAlertsAndTonesDuration_2[FLIGHT_CONTROLS]				= 3.3
VoiceAlertsAndTonesDuration_2[FLIGHT_COMPUTER_HOT]			= 3.7
VoiceAlertsAndTonesDuration_2[ALTITUDE]						= 2.9
VoiceAlertsAndTonesDuration_2[BINGO]						= 2.3
VoiceAlertsAndTonesDuration_2[FUEL_LO]						= 3.4
VoiceAlertsAndTonesDuration_2[LOW_ALTITUDE_WARNING_TONE]	= 2.3





GUI = {

}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()