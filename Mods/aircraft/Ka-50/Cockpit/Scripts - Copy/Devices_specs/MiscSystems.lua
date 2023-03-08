-- Misc indicators

rotorRPM = {valmin = 0, valmax = 110, T1 = 0.167, T2 = 0.149, wmax = 0, bias = {{valmin = 0, valmax = 110, bias = 0.1}}}
rotorBladesPitch = {valmin = 1, valmax = 15, T1 = 0.167, T2 = 0.149, wmax = 0, bias = {{valmin = 1, valmax = 15, bias = 0.1}}}
ambientTemperatureIndicator = {isLagElement = true, valmin = -60, valmax = 50, T1 = 1, bias = {{valmin = -60, valmax = 50, bias = 1}}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
