local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.006

error_k	= 1.021

-- in m/s
MIN = 0.0
MAX = 450.0 -- m/s 450 km/h

IAS_pointer = {valmin = -200.0, valmax = 550.0, T1 = 0.133, T2 = 0.129, wmax = 0, bias = {{valmin = -200.0, valmax = 550.0, bias = 0.3}}}

need_to_be_closed = true -- close lua state after initialization 