-- HSI (PNP-72-16)

heading_failure_thresold_on		= math.rad(60.0) -- radians
heading_failure_thresold_off	= math.rad(50.0) -- radians

ptrsBias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}} -- radians

pointers     = {isLagElement = true, T1 = 0.4, bias = ptrsBias}
headingScale = pointers
-- meters
rangeCounter = {isLagElement = true, valmin = 0, valmax = 999000, T1 = 4, bias = {{valmin = 0, valmax = 25000, bias = 500}, {valmin = 25000, valmax = 999000, bias = 1500}}}

warnFlags    = {valmin = 0, valmax = 1, dvalue = 11}
rngCrsUnavail = {valmin = 0, valmax = 1, dvalue = 16}

deviationBars = {isLagElement = true, valmin = -1, valmax = 1, T1 = 0.2, bias = {{valmin = -1, valmax = 1, bias = 0.02}}}

knob = pointers
knobK = 7

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
