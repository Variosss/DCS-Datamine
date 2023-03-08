-- Gyromagnetic compass set AN/ASN-43
-- Indicator (ID-998/ASN)

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.012

heading_and_needles_Bias = {{valmin = math.rad(0.0), valmax = math.rad(360.0), bias = math.rad(1.0)}}
heading_and_needles = {isLagElement = true, valmin = math.rad(0.0), valmax = math.rad(360.0), T1 = 0.2, bias = heading_and_needles_Bias}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()