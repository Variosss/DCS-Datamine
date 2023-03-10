local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt	= 0.05
need_to_be_closed = true -- lua_state  will be closed in post_initialize()

FuelQuantityPointer = {valmin = 0.0, valmax = 80000.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 0.0, valmax = 80000.0, bias = 0.5}}}
TotalQuantity = {isLagElement = true, valmin = 0, valmax = 99999, T1 = 0.237, bias = {{valmin = 0, valmax = 99999, bias = 0.1}}}