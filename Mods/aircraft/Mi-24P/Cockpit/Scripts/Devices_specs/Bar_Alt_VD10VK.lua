device_timer_dt		= 0.02

Ft_k1 = 3.0
Ft_k2 = 0.8

-- in meters 
min_altitude  = -10000
max_altitude  = 10000  

-- in mm
min_pressure = 190
max_pressure = 790

altitudePointer = {
	valmin = min_altitude, 
	valmax = max_altitude, 
	T1 = 0.267, T2 = 0.258, wmax = 0, 
	bias = {{valmin = min_altitude, valmax = max_altitude, bias = 1}}}

error_k			= 0.983

need_to_be_closed = true -- close lua state after initialization 