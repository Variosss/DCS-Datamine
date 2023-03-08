device_timer_dt	= 0.05

CabinPressure = {valmin = 0.0, valmax = 50.0, T1 = 0.9, T2 = 0.316, wmax = 0.0, bias = {{valmin = 0.0, valmax = 50.0, bias = 0.01}}}

ECS_consumerParams = 
{
	5.0, 			-- load DC current ECS, [A]
	true,
	6.0,			-- DC voltage value after which the ECS is off, [V]
	12.0, 			-- DC voltage value after which the ECS is on, [V]
	28.0			-- nominal DC voltage value ECS, [V]
}

-- TemperatureFlowController PTA-36-28T settings:
PTA_36_28T_consumerParams = 
{
	1.5, 			-- load DC current PTA-36-28T, [A]
	true,
	6.0,			-- DC voltage value after which the PTA-36-28T is off, [V]
	12.0, 			-- DC voltage value after which the PTA-36-28T is on, [V]
	27.0			-- nominal DC voltage value PTA-36-28T, [V]
}

-- TemperatureFlowController PTA-32-7T settings:
PTA_32_7T_consumerParams = 
{
	2.0, 			-- load DC current PTA-32-7T, [A]
	true,
	6.0,			-- DC voltage value after which the PTA-32-7T is off, [V]
	12.0, 			-- DC voltage value after which the PTA-32-7T is on, [V]
	27.0			-- nominal DC voltage value PTA-32-7T, [V]
}

local T0 = 273.15				-- Constant to convert degrees Celsius to Kelvin  [273.15 degree]
temprature_auto_min = T0 + 5.0	-- [K]
temprature_auto_max = T0 + 50.0	-- [K]
temperature_auto_range = temprature_auto_max - temprature_auto_min	-- [K]
temperatureAutoCoeff = 0.01		
		
temperature_max_cabin = T0 + 150.0		-- maximum air temperature (150°С) supplied to the pressurized cabin, [K] 
temperature_normal_cabin = T0 + 15.0	-- normal air temperature (20±5°С) in the pressurized cabin, [K]

-- pressure regulator settings:
over_pressure = 0.05 -- over pressure, [kgs/cm2]
cabinExitAirValve_dPMax = 8698.01  -- [Pa]
cabinExitAirValve_dPMin = 8093.06  -- [Pa]
cabinExitAirValve_Phmax = 67060.0 	-- [Pa]
cabinExitAirValve_Phmin = 101325.0  -- [Pa]
cabinExitAirVlv_Coeff = (cabinExitAirValve_dPMax - cabinExitAirValve_dPMin) / (cabinExitAirValve_Phmin - cabinExitAirValve_Phmax)
	
cabinPressureExceedsMax = 37231.68  -- [Pa]

cabinConstP = 75152.85 -- [Pa]
cabinPressureRegulator_dPmax = 35834.8 -- [Pa]
cabinExitAirVlv_dPMax_h = 776.34 -- [Pa]
cabinExitAirVlv_Phmax_h = 18754.0 -- [Pa]
cabinExitAirVlv_Phmin_h = 39318.0	-- [Pa]
cabinExitAirVlv_Coeff_h = cabinExitAirVlv_dPMax_h / (cabinExitAirVlv_Phmin_h - cabinExitAirVlv_Phmax_h) -- [Pa]

CockpitExitAirFlowCoeff = 0.00029
-- sealing system settings:
hoseSealPressureMin = 103221.35 -- [Pa]
hoseSealMaxPressure = 205939.65 -- [Pa] -- complies with the flight manual for the Mi-35  = 2.1 [kgs/cm2]
hoseSeal_air_flow_coeff = 0.000000001

primaryBleedAirNominalPressure = 834265.596 -- [Pa]
secondaryBleedAirNominalDeltaPressure = 930792.194 -- [Pa]
secondaryBleedAirOverpressure = 1034213.55 -- [Pa]

-- Cabin Cooling System	
coolingAirFlowMax = 0.2 -- [kg/s]
coolingAirFlow_dPMax = 103421.35 --[Pa]
coolingAirFlowCoeff = coolingAirFlowMax / coolingAirFlow_dPMax	
cockpitExitAirFlowMax =  0.1 -- [kg/sec]	
cockpitExitAirFlow_dPMax = 344.73 --[Pa]
cockpitExitAirFlowCoeff = cockpitExitAirFlowMax / cockpitExitAirFlow_dPMax

--
arg_values = 
{
	value	= {0.0,	1.0,	2.0,	3.0 },
	arg		= {0.0,	0.05,	0.15,	0.25}
}

need_to_be_closed = true -- close lua state after initialization
