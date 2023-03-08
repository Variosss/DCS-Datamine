-- Engines Indicators
-- RPM
RPM_needle_Bias = {{valmin = 0.0, valmax = 7200, bias = 0.1}}
RPM_needle = {isLagElement = true, valmin = 0.0, valmax = 7200, T1 = 0.2, bias = RPM_needle_Bias,
	angles = {{val = valmin, angle = math.rad(160)}, {val = valmax, angle = math.rad(-165)}},
	momentCoeff = 0.0009}

Gas_needle_Bias = {{valmin = 0.0, valmax = 101.5, bias = 0.1}}	
Gas_needle = {isLagElement = true, valmin = 0.0, valmax = 101.5, T1 = 0.2, bias = Gas_needle_Bias,
	angles = {{val = valmin, angle = math.rad(0)}, {val = valmax, angle = math.rad(-270)}},
	momentCoeff = 0.0009}	

Exhaust_needle_Bias = {{valmin = 0.0, valmax = 1000, bias = 0.1}}
Exhaust_needle = {isLagElement = true, valmin = 0.0, valmax = 1000, T1 = 0.2, bias = Exhaust_needle_Bias,
	angles = {{val = valmin, angle = math.rad(290)}, {val = valmax, angle = math.rad(10)}},
	momentCoeff = 0.0009}

-- Temperature
EngineTemperature_needle_Bias = {{valmin = -70.0, valmax = 150, bias = 0.5}}
EngineTemperature_needle = {isLagElement = true, valmin = -70.0, valmax = 150, T1 = 0.2, bias = EngineTemperature_needle_Bias,
	angles = {{val = valmin, angle = math.rad(80)}, {val = valmax, angle = math.rad(20)}},
	momentCoeff = 0.0009}

OilIndicatorGroup_Bias = {{valmin = -3.0, valmax = 100, bias = 0.005}}
EngineOil = {isLagElement = true, valmin = -3.0, valmax = 100, T1 = 0.2, bias = OilIndicatorGroup_Bias,
	angles = {{val = valmin, angle = math.rad(280)}, {val = valmax, angle = math.rad(45)}},
	momentCoeff = 0.0009}
	
TransmOil = {isLagElement = true, valmin = -3.0, valmax = 100, T1 = 0.2, bias = OilIndicatorGroup_Bias,
	angles = {{val = valmin, angle = math.rad(210)}, {val = valmax, angle = math.rad(-60)}},
	momentCoeff = 0.0009}	


EngineTorqPSI_needle_Bias = {{valmin = -3.0, valmax = 100, bias = 0.5}}
EngineTorqPSI_needle = {isLagElement = true, valmin = -3.0, valmax = 100, T1 = 0.2, bias = EngineTorqPSI_needle_Bias,
	angles = {{val = valmin, angle = math.rad(210)}, {val = valmax, angle = math.rad(-60)}},
	momentCoeff = 0.0009}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()