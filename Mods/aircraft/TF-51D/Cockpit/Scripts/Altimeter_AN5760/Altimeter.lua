device_timer_dt		= 0.2

-- meters!!!
altitudePointer = {valmin = -304.8, valmax = 15240, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = -304.8, valmax = 15240, bias = 1}}}

-- in mm
min_pressure = 28.1 * 25.4 --28.1 inches
max_pressure = 31.0 * 25.4 --31.0 inches

need_to_be_closed = true -- close lua state after initialization 