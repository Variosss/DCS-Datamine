device_timer_dt	= 0.05

rpmIndicator			= {valmin = 0.0, valmax = 110.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 0.0, valmax = 110.0, bias = 0.01}}}
nozPosIndicator			= {valmin = 0.0, valmax = 100.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 0.0, valmax = 100.0, bias = 0.5}}}
ftitIndicator			= {valmin = 200.0, valmax = 1200.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 200.0, valmax = 1200.0, bias = 0.5}}}
oilPressureIndicator	= {valmin = 0.0, valmax = 100.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 0.0, valmax = 100.0, bias = 0.5}}}
hydrazinVolumeIndicator	= {valmin = 0.0, valmax = 100.0, T1 = 0.3, T2 = 0.2, wmax = 0.0, bias = {{valmin = 0.0, valmax = 100.0, bias = 0.5}}}


ElecConsumerParams28	= {2.5, true, 21.2, 22.1, 28.0}
ElecConsumerParams115	= {5.0, true, 78.0, 88.0, 115.0}
ElecConsumerParams26	= {5.0, true, 19.8, 20.8, 26.0}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()