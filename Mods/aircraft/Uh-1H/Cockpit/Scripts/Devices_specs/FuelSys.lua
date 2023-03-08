quantity_gaugeBias = {{valmin = 0.0, valmax = 1540, bias = 0.5}}
fuel_quantity = {isLagElement = true, valmin = 0.0, valmax = 1540, T1 = 0.2, bias = quantity_gaugeBias,
	angles = {{val = valmin, angle = math.rad(170)}, {val = valmax, angle = math.rad(-170)}},
	momentCoeff = 0.0009}

pressure_gaugeBias = {{valmin = -2.0, valmax = 50, bias = 0.1}}
fuel_pressure = {isLagElement = true, valmin = -2.0, valmax = 50, T1 = 0.2, bias = pressure_gaugeBias,
	angles = {{val = valmin, angle = math.rad(250)}, {val = valmax, angle = math.rad(-70)}},
	momentCoeff = 0.0009}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()