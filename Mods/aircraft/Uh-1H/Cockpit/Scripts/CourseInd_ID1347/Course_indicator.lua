-- Course indicator ID-1347

device_timer_dt = 0.05

course_bias	= {{math.rad(0.0), math.rad(360.0), math.rad(1.0)}} -- radians



course_K1			= 1.1
course_K2			= 0.3

course_Bias = {{valmin = math.rad(0.0), valmax = math.rad(360.0), bias = 0.5}}
course = {isLagElement = true, T1 = 0.3, bias = ptrsBias}

DeviationBars_Bias = {{valmin = -1.0, valmax = 1.0, bias = 0.001}}
DeviationBars = {isLagElement = true, valmin = -1.0, valmax = 1.0, T1 = 0.2, bias = DeviationBars_Bias}

warn_flag_d_value			= 11.0
warn_flag_value_min			= 0.0
warn_flag_value_max			= 1.0

need_to_be_closed = true -- lua_state  will be closed in post_initialize()