need_to_be_closed = true -- lua_state  will be closed in post_initialize()

dcVoltmeter = {isLagElement = true, valmin = 0, valmax = 30, T1 = 0.2, wmax = 0, bias = {{valmin = 0, valmax = 30, bias = 0.01}}}
acVoltmeter = {isLagElement = true, valmin = 0, valmax = 250, T1 = 0.2, wmax = 0, bias = {{valmin = 0, valmax = 250, bias = 0.5}}}
leftBattAmmeter = {isLagElement = true, valmin = -40, valmax = 400, T1 = 0.2, wmax = 0, bias = {{valmin = -40, valmax = 400, bias = 0.5}}}
rightBattAmmeter = {isLagElement = true, valmin = -40, valmax = 400, T1 = 0.2, wmax = 0, bias = {{valmin = -40, valmax = 400, bias = 0.5}}}
dcGenAmmeter = {isLagElement = true, valmin = -40, valmax = 400, T1 = 0.2, wmax = 0, bias = {{valmin = -40, valmax = 400, bias = 0.5}}}
leftGenAmmeter = {isLagElement = true, valmin = 0, valmax = 150, T1 = 0.2, wmax = 0, bias = {{valmin = 0, valmax = 150, bias = 0.1}}}
rightGenAmmeter = {isLagElement = true, valmin = 0, valmax = 150, T1 = 0.2, wmax = 0, bias = {{valmin = 0, valmax = 150, bias = 0.1}}}
