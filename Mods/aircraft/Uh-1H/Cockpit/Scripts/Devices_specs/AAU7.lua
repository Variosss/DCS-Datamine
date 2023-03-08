device_timer_dt		= 0.2

Ft_k1 = 3.0
Ft_k2 = 0.8

-- in meters 
min_altitude  = -304.8 -- -1 000ft
max_altitude  = 24384  -- 80 000ft

-- in mm
min_pressure = 28.1 * 25.4 --28.1 inches
max_pressure = 31.0 * 25.4 --31.0 inches

-- meters!!!
altitudePointer = {valmin = -304.8, valmax = 24384, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = -304.8, valmax = 24384, bias = 1}}}

low_alt_flag_d_value	= 10.0

error_k			= 0.983

need_to_be_closed = true -- close lua state after initialization 