night_start_time = 19.0 -- in hours
night_end_time = 7.0

ElecConsumerParamsGearExtLights			= {3.0, true, 2.0, 3.0, 28.0}
ElecLampParamsGearExtLights				= {brightnessMinVal = 0.5}

ElecConsumerParamsTaxiLight				= {1.0, true, 2.0, 3.0, 28.0}
ElecLampParamsTaxiLight					= {brightnessMinVal = 0.5}

ElecConsumerParamsNavLights				= {3.0, true, 2.0, 3.0, 28.0}
ElecLampParamsNavLights					= {brightnessMinVal = 0.5}

ElecConsumerParamsFormationLights		= {5.0, true, 2.0, 3.0, 28.0}
ElecLampParamsFormationLights			= {brightnessMinVal = 0.5}

ElecConsumerParamsTipLights				= {40.0, true, -1, -1, 115.0}
ElecLampParamsTipLights					= {brightnessMinVal = 0.5}

ElecConsumerParamsStrobeLight			= {1.0, true, 2.0, 3.0, 28.0}
ElecLampParamsStrobeLight				= {brightnessMinVal = 0.5}

ElecConsumerParamsSpotLight				= {1.0, true, 2.0, 3.0, 28.0}
ElecLampParamsSpotLight					= {brightnessMinVal = 0.5}

ElecConsumerParamsSpotConsumer			= {1.0, true, 2.0, 3.0, 28.0}

--ElecConsumerParamsLight					= {1.0, true, 2.0, 3.0, 28.0}
--ElecLampParamsLight						= {brightnessMinVal = 0.5}

-- rotation speed for Head Lights (deg/sec)
HeadLightsRotationSpeed		= 24.0/180.0		-- 120 deg by 5 sec
HeadLightsRetractionSpeed	= 24.0/360.0;		-- 120 deg by 5 sec
StrobeRotationSpeed = 126.0/180.0;		--  [deg/sec]
need_to_be_closed = true -- lua_state  will be closed in post_initialize()