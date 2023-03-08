night_start_time = 19.0 -- in hours
night_end_time = 7.0

ElecConsumerParamsLight		= {1, true, -1, -1, 115}
ElecLampParamsLight			= {brightnessMinVal = 0.75}

ElecConsumerParamsWCILight		= {3.0, true, 6.0, 12.0, 24.0}			-- WCI Lights
ElecLampParamsWCILight			= {brightnessMinVal = 0.5}

dimBrightness	= 0.4

need_to_be_closed = true -- lua_state  will be closed in post_initialize()