dofile(LockOn_Options.common_script_path..'Radio.lua')

min_search_range = 600 --feet
max_search_range = 2400 --feet

min_working_working = 3100 --feet

device_timer_dt = 1.0

ElecConsumerParams = {0.5, true, 18, 20}
ElecConsumerParamsLight = {0.5, true}
ElecLampParamsLight = {brightnessMinVal = 0.56}

need_to_be_closed = true -- close lua state after initialization
