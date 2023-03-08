
device_timer_dt = 0.015

mainVolumeGauge         = {valmin = 0, valmax = 90, T1 = 0.9, T2 = 0.224, wmax = 0, bias = {{valmin = 0, valmax = 90, bias = 0.5}}}
fuselageVolumeGauge     = {valmin = 0, valmax = 80, T1 = 0.9, T2 = 0.224, wmax = 0, bias = {{valmin = 0, valmax = 80, bias = 0.5}}}
	
fuelPressureGauge       = {valmin = 0, valmax = 25, T1 = 0.08, T2 = 0.09, wmax = 0,
	bias = {{valmin = 0, valmax = 25, bias = 0.01}},
	angles = {{val = 0, angle = math.rad(180)}, {val = 25, angle = math.rad(360)}},
	momentCoeff = -0.0003}

need_to_be_closed = true -- close lua state after initialization
