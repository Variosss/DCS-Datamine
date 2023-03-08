-- Engines Indicators
APU_Pressure = {valmin = 0, valmax = 8, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 8, bias = 0.02}}}

RPM_Pointer = {valmin = 0, valmax = 110, T1 = 0.033, T2 = 0.105, wmax = 0, bias = {{valmin = 0, valmax = 110, bias = 0.1}}}
EGT_Pointer = {valmin = 0, valmax = 1200, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 1200, bias = 0.5}}}
APU_EGT_Pointer = {valmin = 0, valmax = 900, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 900, bias = 0.5}}}
APU_Pressure_Pointer = {valmin = 0, valmax = 50, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 50, bias = 0.005}}}
engineModePointer = {valmin = 0, valmax = 1, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 1, bias = 0.005}}}
pressureIndicatorGroup = {valmin = 0, valmax = 8, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 8, bias = 0.005}}}
oilIndicatorGroup = {valmin = -60, valmax = 150, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = -60, valmax = 150, bias = 0.005}}}

currBias = {{valmin = 0.0, valmax = 400, bias = 1.0}}
CurrentGroup = {isLagElement = true, valmin = 0.0, valmax = 400, T1 = 0.2, bias = currBias,
	angles = {{val = valmin, angle = math.rad(70)}, {val = valmax, angle = math.rad(-70)}},
	momentCoeff = 0.0009}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()





