-- Misc indicators

-- Rotor RPM
RPM_Pointer = {valmin = 0, valmax = 110, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 110, bias = 0.1}}}

-- Rotor blades pitch
RotorPitch_Pointer = {valmin = 1, valmax = 15, T1 = 0.167, T2 = 0.149, wmax = 0, bias = {{valmin = 1, valmax = 15, bias = 0.1}}}

atmo_temp_Bias = {{valmin = -50.0, valmax = 70.0, bias = math.rad(0.1)}}
atmo_temp = {isLagElement = true, valmin = -50.0, valmax = 70.0, T1 = 0.2, bias = atmo_temp_Bias,
	angles = {{val = valmin, angle = math.rad(160)}, {val = valmax, angle = math.rad(-160)}},
	momentCoeff = 0.0009}
	
need_to_be_closed = true -- lua_state  will be closed in post_initialize()
