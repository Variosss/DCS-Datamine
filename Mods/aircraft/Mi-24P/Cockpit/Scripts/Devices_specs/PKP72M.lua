
pitch = {isLagElement = true, valmin = -math.rad(90.0), valmax = math.rad(90.0), T1 = 0.1, wmax = math.rad(90.0), bias = {{valmin = -math.rad(90.0), valmax = math.rad(90.0), bias = math.rad(0.03)}}}
bank = {isLagElement = true, valmin = -math.rad(180.0), valmax = math.rad(180.0), T1 = 0.1, bias = {{valmin = -math.rad(180.0), valmax = math.rad(180.0), bias = math.rad(0.3)}}}
Flag = {valmin = 0, valmax = 1, dvalue = 11}
GaugeLimited	= {isLagElement = true, valmin = 0.0, valmax = 1.0, T1 = 1.2, bias = {{valmin = 0.0, valmax = 1.0, bias = 0.02}}}

ElecConsumerParams = {1.0, true, -1, -1, 28.0}

constTestPitchValue = math.rad(15.0)
constTestRollValue = math.rad(15.0)
testBlenkerFailure = 1.0
constTestAltitudeDeviation = 1.0
const_max_altitude = 60.0

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
