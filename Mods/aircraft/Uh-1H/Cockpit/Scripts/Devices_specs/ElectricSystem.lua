voltBias = {{valmin = 0.0, valmax = 250, bias = 0.1}}
VoltageGroup = {isLagElement = true, valmin = 0.0, valmax = 250, T1 = 0.2, bias = voltBias,
	angles = {{val = valmin, angle = math.rad(70)}, {val = valmax, angle = math.rad(-70)}},
	momentCoeff = 0.0009}


currBias = {{valmin = -1.5, valmax = 12.5, bias = 0.5}}
CurrentGroup = {isLagElement = true, valmin = -1.5, valmax = 12.5, T1 = 0.2, bias = currBias,
	angles = {{val = valmin, angle = math.rad(70)}, {val = valmax, angle = math.rad(-70)}},
	momentCoeff = 0.0009}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
