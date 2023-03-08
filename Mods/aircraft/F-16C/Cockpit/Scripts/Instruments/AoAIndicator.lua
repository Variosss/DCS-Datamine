device_timer_dt		= 0.015

valmax = 50.0
valmin = -valmax
tape = {valmin = valmin, valmax = valmax, T1 = 0.14, T2 = 0.08, wmax = 0,
	bias = {{valmin = valmin, valmax = valmax, bias = 0.0003}}}

need_to_be_closed = true -- close lua state after initialization 