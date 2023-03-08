device_timer_dt		= 0.2

-- feet!!!
altitudePointer = {valmin = -3281, valmax = 262468, T1 = 0.267, T2 = 0.258, bias = {{valmin = -3281, valmax = 262468, bias = 1}}}
elecModeFlag = {valmin = 0, valmax = 1, dvalue = 10}

error_k			= 0.983

-- replace silence horn button from ELEC_INTERFACE to SYS_CONTROLLER and handling according name
-- remove blink for lamp in systemController 

need_to_be_closed = true -- close lua state after initialization 