night_start_time = 19.0 -- in hours
night_end_time = 7.0

ElecConsumerParamsFormationLight		= {40, true, -1, -1, 115}			-- cockpit
ElecLampParamsFormationLight			= {brightnessMinVal = 0.75}

ElecConsumerParamsFormationTipLight		= {40, true, -1, -1, 115}			-- tips
ElecLampParamsFormationTipLight			= {brightnessMinVal = 0.75}

ElecConsumerParamsPosLightAuxTop		= {40, true, -1, -1, 115}			-- wings
ElecLampParamsPosLightAuxTop			= {brightnessMinVal = 0.75}

ElecConsumerParamsPosLightAuxBottom		= {40, true, -1, -1, 115}			-- wings
ElecLampParamsPosLightAuxBottom			= {brightnessMinVal = 0.75}

ElecConsumerParamsBeaconLight			= {100.0, true, 40.0, 60.0, 115.0}		-- beacon
ElecLampParamsBeaconLight				= {brightnessMinVal = 0.8}

ElecConsumerParamsPosLightTail			= {40, true, -1, -1, 115}			-- tail
ElecLampParamsPosLightTail				= {brightnessMinVal = 0.75}

ElecConsumerParamsPosLightPrimary		= {40, true, -1, -1, 115}			-- inlet
ElecLampParamsPosLightPrimary			= {brightnessMinVal = 0.75}

ElecConsumerParamsLandingLight			= {1, true, -1, -1, 115}		-- landing
ElecLampParamsLandingLight				= {brightnessMinVal = 0.0}

ElecConsumerParamsFuselageLight			= {40, true, -1, -1, 115}			-- under fuselage
ElecLampParamsFuselageLight				= {brightnessMinVal = 0.0}

ElecConsumerParamsLightActuator			= {1, true, -1, -1, 115}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()