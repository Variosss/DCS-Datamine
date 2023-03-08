voltBias = {{valmin = 16.0, valmax = 30.0, bias = 0.1}}
Voltmeter_gauge = {isLagElement = true, valmin = 16.0, valmax = 30.0, T1 = 0.05, bias = voltBias,
	angles = {{val = valmin, angle = math.rad(70)}, {val = valmax, angle = math.rad(-70)}},
	momentCoeff = 0.0009
}

device_timer_dt = 0.02

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
