device_timer_dt	= 0.015

-- meters per second!!!
valmax = 30.48
valmin = -valmax
variometerPointer = {valmin = valmin, valmax = valmax, T1 = 0.24, T2 = 0.14, wmax = 0,
	bias = {{valmin = valmin, valmax = valmax, bias = 0.01}},
	angles = {{val = valmin, angle = math.rad(258)}, {val = valmax, angle = math.rad(-78)}},
	momentCoeff = 0.0009}

need_to_be_closed = true -- close lua state after initialization