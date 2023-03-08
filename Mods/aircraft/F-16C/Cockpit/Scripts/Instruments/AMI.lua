device_timer_dt		= 0.2

IAS_k1	= 3.0
IAS_k2	= 0.8

Mach_k1	= 3.0
Mach_k2	= 0.8

error_IAS_k		= 1.0
error_Mach_k	= 1.0

--
MIN = 0.0
MAX = 850 -- knots
IAS_pointer = {valmin = MIN, valmax = MAX, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = MIN, valmax = MAX, bias = 0.3}}}

MAX_IAS_pointer = {valmin = MIN, valmax = MAX, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = MIN, valmax = MAX, bias = 0.3}}}

-- in Mach
MIN = 0.5
MAX = 2.2
Mach_pointer = {valmin = MIN, valmax = MAX, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = MIN, valmax = MAX, bias = 0.002}}}

setIAS_K	= 0.2		-- 5 turns of knob for 0-850

need_to_be_closed = true -- close lua state after initialization 