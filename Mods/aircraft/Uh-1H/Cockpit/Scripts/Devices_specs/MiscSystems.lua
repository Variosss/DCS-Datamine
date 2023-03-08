-- Misc indicators

-- Rotor RPM
RotorRPM_needle_Bias = {{valmin = 0.0, valmax = 360.0, bias = math.rad(0.1)}}
RotorRPM_needle = {isLagElement = true, valmin = 0.0, valmax = 360.0, T1 = 0.2, bias = RotorRPM_needle_Bias,
	angles = {{val = valmin, angle = math.rad(160)}, {val = valmax, angle = math.rad(-160)}},
	momentCoeff = 0.0009}
	
RamTemp_needle_Bias = {{valmin = -70.0, valmax = 50.0, bias = math.rad(0.1)}}
RAM_Temp_needle = {isLagElement = true, valmin = -70.0, valmax = 50.0, T1 = 0.2, bias = RamTemp_needle_Bias,
	angles = {{val = valmin, angle = math.rad(160)}, {val = valmax, angle = math.rad(-160)}},
	momentCoeff = 0.0009}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()
