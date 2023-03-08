ptrsBias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}} -- radians

pointers     = {isLagElement = true, T1 = 0.4, bias = ptrsBias}
headingScale = pointers

bearing = {isLagElement = true, T1 = 0.3, bias = ptrsBias}

warnFlags = {valmin = 0, valmax = 1, dvalue = 11}
rngUnavailFlag = {valmin = 0, valmax = 1, dvalue = 16}

rangeCounter = {isLagElement = true, valmin = 0, valmax = 1999, T1 = 4, bias = {{valmin = 0, valmax = 1999, bias = 0.1}}}
deviationBars = {isLagElement = true, valmin = -1, valmax = 1, T1 = 0.2, bias = {{valmin = -1, valmax = 1, bias = 0.02}}}


need_to_be_closed = true -- close lua state after initialization 