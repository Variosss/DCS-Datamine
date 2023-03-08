
pitch = {isLagElement = true, valmin = -math.rad(90.0), valmax = math.rad(90.0), T1 = 0.1, wmax = math.rad(80.0), bias = {{valmin = -math.rad(90.0), valmax = math.rad(90.0), bias = math.rad(0.3)}}}
bank = {isLagElement = true, valmin = 0.0, valmax = math.rad(360.0), T1 = 0.1, bias = {{valmin = 0.0, valmax = math.rad(360.0), bias = math.rad(0.3)}}}
warnFlags = {valmin = 0, valmax = 1, dvalue = 11}

deviationBarsBias = {{valmin = -1, valmax = 1, bias = 0.01}}

local steeringBarsT1 = 0.15 --0.2
bankDeviationBar = {isLagElement = true, valmin = -0.4, valmax = 1, T1 = steeringBarsT1, bias = deviationBarsBias}
pitchDeviationBar = {isLagElement = true, valmin = -1, valmax = 0.5, T1 = steeringBarsT1, bias = deviationBarsBias}
glideslopeDeviationBar = {isLagElement = true, valmin = -1, valmax = 1, T1 = 0.15, bias = deviationBarsBias}

turnNeedle = {isLagElement = true, valmin = -math.rad(3.0), valmax = math.rad(3.0), T1 = 0.1, bias = {{valmin = -math.rad(3.0), valmax = math.rad(3.0), bias = 0.001}}}

slipBall = {dt = 0.015, tubeLen = 0.0582, tubeSector = math.rad(30)}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
