dofile(LockOn_Options.script_path.."command_defs.lua")

function post_initialize()

end

RPM_pointer = {valmin = 0, valmax = 100, T1 = 0.033, T2 = 0.105, bias = {{valmin = 0, valmax = 100, bias = 0.1}}}
engineTemperature = {valmin = 0, valmax = 1200, T1 = 0.225, T2 = 0.158, bias = {{valmin = 0, valmax = 1200, bias = 0.5}}}
oilPressure = {valmin = 0, valmax = 100, T1 = 0.033, T2 = 0.105, bias = {{valmin = 0, valmax = 100, bias = 0.1}}}
APU_RPM = {valmin = 0, valmax = 120, T1 = 0.033, T2 = 0.105, bias = {{valmin = 0, valmax = 120, bias = 0.1}}}
APU_Temperature = {valmin = 0, valmax = 1000, T1 = 0.9, T2 = 0.316, bias = {{valmin = 0, valmax = 1000, bias = 0.5}}}
fuelFlow = {valmin = 0, valmax = 5000, T1 = 0.033, T2 = 0.105, bias = {{valmin = 0, valmax = 5000, bias = 0.1}}}
warnFlag = {valmin = 0, valmax = 1, dvalue = 11}

need_to_be_closed = true -- close lua state after initialization 