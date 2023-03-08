SpotSpeed = 20

night_start_time = 19.0 -- in hours
night_end_time = 7.0

-- params for lamps of group "console"
ElecConsumerParamsConsoleLight     = {2.7, false}
ElecLampParamsConsoleLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "ped"
ElecConsumerParamsPedLight     = {2.5, false}
ElecLampParamsPedLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "sec"
ElecConsumerParamsSecLight     = {1.36, false}
ElecLampParamsSecLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "engine"
ElecConsumerParamsEngineLight     = {15, true}
ElecLampParamsEngineLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "copilot"
ElecConsumerParamsCopilotLight     = {0.34, false}
ElecLampParamsCopilotLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "pilot"
ElecConsumerParamsPilotLight     = {0.34, false}
ElecLampParamsPilotLight     	   = {brightnessMinVal = 0}
-- params for lamps of group "dome green"
ElecConsumerParamsDomeLightGreen     = {1.28, false}
ElecLampParamsDomeLightGreen     	   = {brightnessMinVal = 0}
-- params for lamps of group "dome white"
ElecConsumerParamsDomeLightWhite     = {1.28, false}
ElecLampParamsDomeLightWhite     	   = {brightnessMinVal = 0}

Damage = {{Element = 4, Integrity_Treshold = 0.3}, {Element = 82}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()