device_timer_dt = 0.02

ptrsBias = {{valmin = math.rad(0.0), valmax = math.rad(360.0), bias = math.rad(1.0)}}
headingScale    = {isLagElement = true, T1 = 0.4, bias = ptrsBias}
bearing 		= {isLagElement = true, T1 = 0.4, bias = ptrsBias}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()