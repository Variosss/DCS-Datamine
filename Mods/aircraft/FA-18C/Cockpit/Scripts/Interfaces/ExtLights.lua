night_start_time = 19.0 -- in hours
night_end_time = 7.0

NightConditionBySunZenithAngle = true
SolarElevationAngle = 5.0

ElecCnsParamsPositionLts		= {40, true, -1, -1, 115}			-- position
ElecLampParamsPositionLts		= {brightnessMinVal = 0.55}

ElecCnsParamsFormationLts		= {40, true, -1, -1, 115}			-- formation
ElecLampParamsFormationLts		= {brightnessMinVal = 0.55}

ElecCnsParamsStrobeLts			= {40, true, -1, -1, 115}			-- strobe
ElecLampParamsStrobeLts			= {brightnessMinVal = 0.75}

ElecCnsParamsTaxiLts			= {40, true, -1, -1, 115}			-- strobe
ElecLampParamsTaxiLts			= {brightnessMinVal = 0.75}

ElecConsumerParamsLightActuator			= {1, true, -1, -1, 115}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()