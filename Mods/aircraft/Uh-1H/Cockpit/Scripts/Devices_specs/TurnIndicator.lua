-- Timer update time
device_timer_dt = 0.04

--указатель угловой скорости
TurnNeedle = {valmin = -6.0 * math.pi / 180, valmax = 6.0 * math.pi / 180, T1 = 0.556, T2 = 0.211, wmax = 0, bias = {{valmin = -6.0 * math.pi / 180, valmax = 6.0 * math.pi / 180, bias = 0.001}}}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()
