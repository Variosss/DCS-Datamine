function post_initialize()

end

hydraulicPressurePointer = {valmin = 0, valmax = 4000, T1 = 0.033, T2 = 0.105, bias = {{valmin = 0, valmax = 4000, bias = 10}}}

need_to_be_closed = true -- close lua state after initialization 