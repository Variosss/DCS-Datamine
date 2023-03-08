-- Timer update time
device_timer_dt = 0.04

pitch = {isLagElement = true, valmin = -math.rad(90.0), valmax = math.rad(90.0), T1 = 0.1, wmax = math.rad(90.0), bias = {{valmin = -math.rad(90.0), valmax = math.rad(90.0), bias = math.rad(0.3)}}}
bank = {isLagElement = true, valmin = 0.0, valmax = math.rad(360.0), T1 = 0.1, bias = {{valmin = 0.0, valmax = math.rad(360.0), bias = math.rad(0.3)}}}
slipBall = {dt = 0.015, tubeLen = 0.0582, tubeSector = math.rad(30)}

ADI_Flag = {valmin = 0, valmax = 1, dvalue = 11}

ADI_Bar = {isLagElement = true, valmin = -1, valmax = 1, T1 = 0.1, wmax = 20, bias = {{valmin = -1, valmax = 1, bias = 0.005}}}
TurnRate = {isLagElement = true, valmin = -3, valmax = 3, T1 = 0.1, wmax = 20, bias = {{valmin = -3, valmax = 3, bias = 0.005}}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
