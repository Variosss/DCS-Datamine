-- Engines Indicators

RPM_Pointer = {valmin = 0, valmax = 110, T1 = 0.033, T2 = 0.105, wmax = 0, bias = {{valmin = 0, valmax = 110, bias = 0.1}}}
EGT_Pointer = {valmin = 0, valmax = 1200, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 1200, bias = 0.5}}}
APU_EGT_Pointer = {valmin = 0, valmax = 900, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 900, bias = 0.5}}}
engineModeCentralPointer = {valmin = 5.45, valmax = 9.02, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = 5.45, valmax = 9.02, bias = 0.005}}}
engineModePointer = {valmin = 5, valmax = 10, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = 5, valmax = 10, bias = 0.005}}}
-- Oil pressure and temperature indicators group
oilIndicatorGroup = {valmin = 0, valmax = 1, T1 = 0.65, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 1, bias = 0.005}}}
engineBreak = {valmin = 0, valmax = 1, dvalue = 3}
